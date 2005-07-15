Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbVGOHDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbVGOHDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 03:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbVGOHDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 03:03:05 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:34787 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263227AbVGOHDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 03:03:03 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Date: Fri, 15 Jul 2005 10:02:33 +0300
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>, David Miller <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507151002.33424.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I reported earlied that around linux-2.6.11-rc5 my home box sometimes
does not want to send anything over ethetnet. That report is repeated below
sig.

I finally managed to nail down where this happens.
I instrumented sch_generic.c to trace what happens with packets
to be sent over interface named "if".

On 'good' boot, I see

2005-07-12_17:26:29.72158 kern.info: qdisc_restart: start
2005-07-12_17:26:29.72164 kern.info: qdisc_restart: skb!=NULL
2005-07-12_17:26:29.72166 kern.info: qdisc_restart: if !netif_queue_stopped...
2005-07-12_17:26:29.72167 kern.info: qdisc_restart: ...hard_start_xmit

in the log, on 'bad' one only "qdisc_restart: start".

Below is first report and instrumented part of sch_generic.c.
--
vda

============================================
Subject: linux-2.6.11-rc5: mysterious loss of tx

My home box has onboard via-rhine NIC.

Several days ago my father called me and said that
it does not send anything (tcpdump shows only rx'ed pkts
despite pings being attempted etc). I did not investigate
then.

Yesterday I've seen it myself. I bumped up ethtool msglvl.
Looks like via-rhine's hard_start_xmit was not called at all
from network core code! (I did not see debug printks from
rhine's hard_stat_xmit routine)

Whatever I tried (ifconfig down/up, reinit IP config from scratch),
nothing helped. No tx whatsoever was attempted by kernel, it seems.

Reboot 'fixed' things.

It hever happened on the same hardware before I switched to rc5.
==============================================
int qdisc_restart(struct net_device *dev)
{
	struct Qdisc *q = dev->qdisc;
	struct sk_buff *skb;
int track = (dev->name[0]=='i' && dev->name[1]=='f' && dev->name[2]=='\0');

//'via rhine bug':
//I see ONLY "qdisc_restart: start",
//but not any of below msgs.
//On 'good' boots, it looks like this:
//...
//2005-07-12_17:26:29.72158 kern.info: qdisc_restart: start
//2005-07-12_17:26:29.72164 kern.info: qdisc_restart: skb!=NULL
//2005-07-12_17:26:29.72166 kern.info: qdisc_restart: if !netif_queue_stopped...
//2005-07-12_17:26:29.72167 kern.info: qdisc_restart: ...hard_start_xmit
//...
if(track) { printk("qdisc_restart: start\n"); }
	/* Dequeue packet */
	if ((skb = q->dequeue(q)) != NULL) {
if(track) { printk("qdisc_restart: skb!=NULL\n"); }
		unsigned nolock = (dev->features & NETIF_F_LLTX);
		/*
		 * When the driver has LLTX set it does its own locking
		 * in start_xmit. No need to add additional overhead by
		 * locking again. These checks are worth it because
		 * even uncongested locks can be quite expensive.
		 * The driver can do trylock like here too, in case
		 * of lock congestion it should return -1 and the packet
		 * will be requeued.
		 */
		if (!nolock) {
			if (!spin_trylock(&dev->xmit_lock)) {
			collision:
if(track) { printk("qdisc_restart: collision\n"); }
				/* So, someone grabbed the driver. */

				/* It may be transient configuration error,
				   when hard_start_xmit() recurses. We detect
				   it by checking xmit owner and drop the
				   packet when deadloop is detected.
				*/
				if (dev->xmit_lock_owner == smp_processor_id()) {
					kfree_skb(skb);
					if (net_ratelimit())
						printk(KERN_DEBUG "Dead loop on netdevice %s, fix it urgently!\n", dev->name);
					return -1;
				}
				__get_cpu_var(netdev_rx_stat).cpu_collision++;
				goto requeue;
			}
			/* Remember that the driver is grabbed by us. */
			dev->xmit_lock_owner = smp_processor_id();
		}

		{
			/* And release queue */
			spin_unlock(&dev->queue_lock);

//vda
if(track) { printk("qdisc_restart: if !netif_queue_stopped...\n"); }
			if (!netif_queue_stopped(dev)) {
				int ret;
				if (netdev_nit)
					dev_queue_xmit_nit(skb, dev);
if(track) { printk("qdisc_restart: ...hard_start_xmit\n"); }
				ret = dev->hard_start_xmit(skb, dev);
				if (ret == NETDEV_TX_OK) {
					if (!nolock) {
						dev->xmit_lock_owner = -1;
						spin_unlock(&dev->xmit_lock);
					}
					spin_lock(&dev->queue_lock);
					return -1;
				}
				if (ret == NETDEV_TX_LOCKED && nolock) {
					spin_lock(&dev->queue_lock);
					goto collision; 
				}
			}

			/* NETDEV_TX_BUSY - we need to requeue */
			/* Release the driver */
			if (!nolock) { 
				dev->xmit_lock_owner = -1;
				spin_unlock(&dev->xmit_lock);
			}
			spin_lock(&dev->queue_lock);
			q = dev->qdisc;
		}

		/* Device kicked us out :(
		   This is possible in three cases:

		   0. driver is locked
		   1. fastroute is enabled
		   2. device cannot determine busy state
		      before start of transmission (f.e. dialout)
		   3. device is buggy (ppp)
		 */

requeue:
		q->ops->requeue(skb, q);
		netif_schedule(dev);
		return 1;
	}
	BUG_ON((int) q->q.qlen < 0);
	return q->q.qlen;
}

