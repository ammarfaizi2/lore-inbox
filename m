Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263075AbSJBN7L>; Wed, 2 Oct 2002 09:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbSJBN7L>; Wed, 2 Oct 2002 09:59:11 -0400
Received: from web13107.mail.yahoo.com ([216.136.174.152]:5897 "HELO
	web13107.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263075AbSJBN7J>; Wed, 2 Oct 2002 09:59:09 -0400
Message-ID: <20021002140236.53405.qmail@web13107.mail.yahoo.com>
Date: Wed, 2 Oct 2002 15:02:35 +0100 (BST)
From: =?iso-8859-1?q?will=20fitzgerald?= <linux_learning@yahoo.co.uk>
Subject: this code does not get called in dev.c so do we need it?
To: linux-kernel@vger.kernel.org
Cc: linux-c-programming@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

this code excerpt from net_rx_action in dev.c does not
get executed at all. is there any need for it? what
does it do?

i inserted printk's in it just about everywhere.
i have a test network set up, A talks to C via router
B
(kernel 2.4.14)
justificattion:
i've pinged C from A, I've pinged eth0 on B from
A,I've pinged eth1 on B from A and i've pinged A from
router B and in no instance was any of the following
code executed.

whats CONFIG_NET_FASTROUTE supposed to do?

the only part that does get executed are the lines:
"skb->h.raw = skb->nh.raw = skb->data;
		{struct packet_type *ptype, *pt_prev;
		 unsigned short type = skb->protocol;
                  pt_prev = NULL;" just after the
CONFIG_NET_FASTROUTE section of code.

#ifdef CONFIG_NET_FASTROUTE
		if (skb->pkt_type == PACKET_FASTROUTE) {
			netdev_rx_stat[this_cpu].fastroute_deferred_out++;
			dev_queue_xmit(skb);
			dev_put(rx_dev);
			continue;
		}
#endif
		skb->h.raw = skb->nh.raw = skb->data;
		{

			struct packet_type *ptype, *pt_prev;
			unsigned short type = skb->protocol;

			pt_prev = NULL;
			for (ptype = ptype_all; ptype; ptype = ptype->next)
{
				if (!ptype->dev || ptype->dev == skb->dev) {
					if (pt_prev) {
						if (!pt_prev->data) {
							deliver_to_old_ones(pt_prev, skb, 0);
						} else {
							atomic_inc(&skb->users);
							pt_prev->func(skb,
								      skb->dev,
								      pt_prev);
						}
					}
					pt_prev = ptype;
				}
			}

#ifdef CONFIG_NET_DIVERT
			if (skb->dev->divert && skb->dev->divert->divert)
				handle_diverter(skb);
#endif /* CONFIG_NET_DIVERT */

			
#if defined(CONFIG_BRIDGE) ||
defined(CONFIG_BRIDGE_MODULE)
			if (skb->dev->br_port != NULL &&
			    br_handle_frame_hook != NULL) {
				handle_bridge(skb, pt_prev);
				dev_put(rx_dev);
				continue;
			}
#endif

if i'm wrong let me know,
thanks.

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
