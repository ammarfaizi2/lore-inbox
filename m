Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVGaK7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVGaK7c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVGaK7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:59:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58328 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261689AbVGaK73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:59:29 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.11-rc5 and 2.6.12: cannot transmit anything
Date: Sun, 31 Jul 2005 13:59:12 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A8K7CP8Z+l4cUEC"
Message-Id: <200507311359.13071.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_A8K7CP8Z+l4cUEC
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 25 July 2005 08:17, Denis Vlasenko wrote:
> I reported earlied that around linux-2.6.11-rc5 my home box sometimes
> does not want to send anything over ethernet. That report is repeated below
> sig.
> 
> I finally managed to nail down where this happens.
> I instrumented sch_generic.c to trace what happens with packets
> to be sent over interface named "if". 
> 
> On 'good' boot, I see   
> 
> 2005-07-12_17:26:29.72158 kern.info: qdisc_restart: start
> 2005-07-12_17:26:29.72164 kern.info: qdisc_restart: skb!=NULL
> 2005-07-12_17:26:29.72166 kern.info: qdisc_restart: if !netif_queue_stopped...
> 2005-07-12_17:26:29.72167 kern.info: qdisc_restart: ...hard_start_xmit
> 
> in the log, on 'bad' one only "qdisc_restart: start".

On Monday 25 July 2005 08:28, David S. Miller wrote:
> Probably your link is never coming up.  We won't send packets
> over the wire unless the device is in the link-up state.
> 
> However, if ->dequeue() is returning NULL, there really aren't
> any packets in the device queue to be sent.
> 
> If you want, add more tracing to pfifo_fast_dequeue() since
> that's almost certainly which queueing discipline is hooked
> up to your VIA Rhine device as it's the default.

I have move info.

kernel log of "ping 1.1.4.1 -i 0.01" when everything is good:
...
2005-07-30_22:30:35.00559 kern.info: pfifo_fast_enqueue returns 0
2005-07-30_22:30:35.00563 kern.info: qdisc_restart: start
2005-07-30_22:30:35.00568 kern.info: pfifo_fast_dequeue returns a skb
2005-07-30_22:30:35.00570 kern.info: qdisc_restart: skb!=NULL
2005-07-30_22:30:35.00571 kern.info: qdisc_restart: start
2005-07-30_22:30:35.00573 kern.info: pfifo_fast_dequeue returns NULL
2005-07-30_22:30:35.01458 kern.info: pfifo_fast_enqueue returns 0
2005-07-30_22:30:35.01460 kern.info: qdisc_restart: start
2005-07-30_22:30:35.01462 kern.info: pfifo_fast_dequeue returns a skb
2005-07-30_22:30:35.01463 kern.info: qdisc_restart: skb!=NULL
2005-07-30_22:30:35.01468 kern.info: qdisc_restart: start
2005-07-30_22:30:35.01470 kern.info: pfifo_fast_dequeue returns NULL
2005-07-30_22:30:35.02358 kern.info: pfifo_fast_enqueue returns 0
2005-07-30_22:30:35.02360 kern.info: qdisc_restart: start
...

Kernel log when 'no tx syndrome' is in effect:

2005-07-30_21:28:25.15338 kern.info: qdisc_restart: start
2005-07-30_21:28:25.16438 kern.info: qdisc_restart: start
2005-07-30_21:28:25.17538 kern.info: qdisc_restart: start
2005-07-30_21:28:25.18638 kern.info: qdisc_restart: start
2005-07-30_21:28:25.19738 kern.info: qdisc_restart: start
2005-07-30_21:28:25.20837 kern.info: qdisc_restart: start
2005-07-30_21:28:25.21937 kern.info: qdisc_restart: start
2005-07-30_21:28:25.23037 kern.info: qdisc_restart: start
2005-07-30_21:28:25.24137 kern.info: qdisc_restart: start
2005-07-30_21:28:25.25237 kern.info: qdisc_restart: start
2005-07-30_21:28:25.26337 kern.info: qdisc_restart: start
2005-07-30_21:28:25.27436 kern.info: qdisc_restart: start
2005-07-30_21:28:25.28536 kern.info: qdisc_restart: start

I instrumented sch_generic.c as follows:

int qdisc_restart(struct net_device *dev)
{
        struct Qdisc *q = dev->qdisc;
        struct sk_buff *skb;
int track = (dev->name[0]=='i' && dev->name[1]=='f' && dev->name[2]=='\0');

if(track) { printk("qdisc_restart: start\n"); }
        /* Dequeue packet */
        if ((skb = q->dequeue(q)) != NULL) {
if(track) { printk("qdisc_restart: skb!=NULL\n"); }
...

static struct sk_buff *
pfifo_fast_dequeue(struct Qdisc* qdisc)
{
        int prio;
        struct sk_buff_head *list = qdisc_priv(qdisc);
        struct sk_buff *skb;

        for (prio = 0; prio < 3; prio++, list++) {
                skb = __skb_dequeue(list);
                if (skb) {
                        qdisc->q.qlen--;
printk("pfifo_fast_dequeue returns a skb\n");
                        return skb;
                }
        }
printk("pfifo_fast_dequeue returns NULL\n");
        return NULL;
}

Since I don't see "pfifo_fast_dequeue returns..." messages,
it looks like interface "if" doesn't use pfifo_fast qdisc... ?!
I positively sure I do not use any shaping on that box,
and all interfaces ought to use default qdisc. Strange.

Will collect "ip l" output when it will happen next time.

Instrumented source file is attached.
--
vda

--Boundary-00=_A8K7CP8Z+l4cUEC
Content-Type: application/x-bzip2;
  name="sch_generic.c.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="sch_generic.c.bz2"

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

--Boundary-00=_A8K7CP8Z+l4cUEC--

