Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTGKPXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTGKPXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:23:21 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:61446 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263355AbTGKPXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:23:15 -0400
Date: Sat, 12 Jul 2003 01:37:44 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jim Keniston <jkenisto@us.ibm.com>
cc: LKML <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Randy Dunlap <rddunlap@osdl.org>, <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
In-Reply-To: <3F0DB9A5.23723BE1@us.ibm.com>
Message-ID: <Mutt.LNX.4.44.0307120135120.21806-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Jim Keniston wrote:

> James Morris wrote:
> > 
> > On Tue, 8 Jul 2003, Jim Keniston wrote:
> > 
> > +       kerror_nl = netlink_kernel_create(NETLINK_KERROR, kerror_netlink_rcv);
> > +       if (kerror_nl == NULL)
> > +               panic("kerror_init: cannot initialize kerror_nl\n");
> > 
> > You can simply use NULL instead of passing the dummy kerror_netlink_rcv
> > function.
> 
> That begs the question: do we trust that nobody but the kernel will send
> packets to a NETLINK_KERROR socket?  Ordinary users can't, but any root
> application can.  Without kerror_netlink_rcv(), such packets don't get
> dequeued.

Indeed, the kernel socket buffer fills up.

I think this needs to be addressed in the netlink code, per the patch 
below.

Comments?


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -NurX dontdiff linux-2.5.75.orig/net/netlink/af_netlink.c linux-2.5.75.w1/net/netlink/af_netlink.c
--- linux-2.5.75.orig/net/netlink/af_netlink.c	2003-06-26 12:43:45.000000000 +1000
+++ linux-2.5.75.w1/net/netlink/af_netlink.c	2003-07-12 01:23:49.708254261 +1000
@@ -430,6 +430,10 @@
 		goto no_dst;
 	nlk = nlk_sk(sk);
 
+	/* Don't bother queuing skb if kernel socket has no input function */
+        if (nlk->pid == 0 && !nlk->data_ready)
+        	goto no_dst;
+
 #ifdef NL_EMULATE_DEV
 	if (nlk->handler) {
 		skb_orphan(skb);

