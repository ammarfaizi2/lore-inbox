Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbRLQJ1F>; Mon, 17 Dec 2001 04:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285062AbRLQJ0y>; Mon, 17 Dec 2001 04:26:54 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:40715 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S285060AbRLQJ0h>; Mon, 17 Dec 2001 04:26:37 -0500
Date: Mon, 17 Dec 2001 10:28:45 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
To: Pawel Kot <pkot@linuxnews.pl>
cc: Dag Brattli <dagb@cs.uit.no>, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG()] IrDA in 2.4.16 + preempt
In-Reply-To: <Pine.LNX.4.33.0112141128300.662-100000@urtica.linuxnews.pl>
Message-ID: <Pine.LNX.4.21.0112161338110.444-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jean added to CC]

On Fri, 14 Dec 2001, Pawel Kot wrote:

> I found an annoying problem with irda on 2.4.16.
> When I remove irlan module I get sementation fault:
> root@blurp:~# rmmod irlan
> Dec 14 02:27:35 blurp kernel: kernel BUG at slab.c:1200!
> Dec 14 02:27:35 blurp kernel: invalid operand: 0000
> Dec 14 02:27:35 blurp kernel: CPU:    0
> Dec 14 02:27:35 blurp kernel: EIP:    0010:[kmem_extra_free_checks+81/140] Not tainted
[...]
> Dec 14 02:27:35 blurp kernel: Process rmmod (pid: 110, stackpage=cc045000)
[..]
> Dec 14 02:27:35 blurp kernel: Call Trace:
 [kfree+450/576]
 [netdev_finish_unregister+145/152]
 [unregister_netdevice+451/632]
 [unregister_netdev+16/40]

Seems some inconsistency in the way how the irlan netdev is handled:
having NETIF_F_DYNALLOC set for a netdev which is not allocated as an
independent object doesn't seem to be a good idea to me ;-)

The patch below simply removes NETIF_F_DYNALLOC just before calling
unregister_netdev() und should fix the issue. It's untested however,
since I'm unable to reproduce the Oops on UP without preempt (but it
should be there as well, due to ipfrag_time for example). At least it
compiles and doesn't do any harm to me.

IMHO, retiring dynalloc is just some sort of band-aid because I do
believe, using it would be a good idea - but would need some more
changes for irlan.

Btw., I'm not sure about the status of irlan - I'm only using ppp over
ircomm or irnet.

HTH
Martin

-----------------------------

--- linux-2.4.16/net/irda/irlan/irlan_common.c	Fri Oct 12 22:04:30 2001
+++ v2.4.16-md/net/irda/irlan/irlan_common.c	Mon Dec 17 10:01:53 2001
@@ -282,6 +282,18 @@
 	while ((skb = skb_dequeue(&self->client.txq)))
 		dev_kfree_skb(skb);
 
+	/* NETIF_F_DYNALLOC feature was set by irlan_eth_init() and would
+	 * cause the unregister_netdev() to do asynch completion _and_
+	 * kfree self->dev afterwards. Which is really bad because the
+	 * netdevice was not allocated separately but is embedded in
+	 * our control block and therefore gets freed with *self.
+	 * Probably there are better solutions, but simply removing
+	 * the feature before unregister should solve the Oops.
+	 * Note however, this may cause unregister_netdev() to block
+	 * until the refcount decreases to zero - which might take
+	 * some time, say /proc/sys/net/ipv4/ipfrag_time for example.
+	 */
+	self->dev.features &= ~NETIF_F_DYNALLOC;
 	unregister_netdev(&self->dev);
 	
 	self->magic = 0;


