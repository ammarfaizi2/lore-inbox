Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbULUXA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbULUXA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbULUXA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:00:57 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50110 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261868AbULUXAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:00:50 -0500
Date: Tue, 21 Dec 2004 23:58:31 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Mark Broadbent <markb@wetlettuce.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041221225831.GA20910@electric-eye.fr.zoreil.com>
References: <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com> <20041220211419.GC5974@waste.org> <20041221002218.GA1487@electric-eye.fr.zoreil.com> <20041221005521.GD5974@waste.org> <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com> <20041221123727.GA13606@electric-eye.fr.zoreil.com> <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com> <20041221204853.GA20869@electric-eye.fr.zoreil.com> <20041221212737.GK5974@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221212737.GK5974@waste.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> :
[...]
> I think it's the promiscuous mode message itself that's the problem

Yes. dev_mc_add takes dev->xmit_lock and the game is over.

Marc, if the patch below happens to work, it should not drop messages
like the previous one (it is an ugly short-term suggestion).

--- net/core/netpoll.c	2004-12-21 13:09:51.000000000 +0100
+++ net/core/netpoll.c	2004-12-21 23:35:25.000000000 +0100
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <asm/unaligned.h>
+#include <net/pkt_sched.h>
 
 /*
  * We maintain a small pool of fully-sized skbs, to make sure the
@@ -184,11 +187,19 @@ void netpoll_send_skb(struct netpoll *np
 
 repeat:
 	if(!np || !np->dev || !netif_running(np->dev)) {
 		__kfree_skb(skb);
 		return;
 	}
 
-	spin_lock(&np->dev->xmit_lock);
+	while (!spin_trylock(&np->dev->xmit_lock)) {
+		if (np->dev->xmit_lock_owner == smp_processor_id()) {
+			struct Qdisc *q = dev->qdisc;
+
+			q->ops->enqueue(skb, q);
+			return;
+		}
+	}
+
 	np->dev->xmit_lock_owner = smp_processor_id();
 
 	/*
