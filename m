Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbULUMli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbULUMli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbULUMlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:41:37 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:5816 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261747AbULUMlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:41:00 -0500
Date: Tue, 21 Dec 2004 13:37:27 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Mark Broadbent <markb@wetlettuce.com>
Cc: mpm@selenic.com, romieu@fr.zoreil.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041221123727.GA13606@electric-eye.fr.zoreil.com>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com> <20041216211024.GK2767@waste.org> <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com> <20041217215752.GP2767@waste.org> <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com> <20041220211419.GC5974@waste.org> <20041221002218.GA1487@electric-eye.fr.zoreil.com> <20041221005521.GD5974@waste.org> <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Broadbent <markb@wetlettuce.com> :
[...]
> OK, patch applied and spinlock debugging enabled.  Testing with eth1
> (r1869) doesn'tyield any additional messages, just the standard
> 'NMI Watchdog detected lockup'.

Does the modified version below trigger _exactly_ the same hang ?

--- net/core/netpoll.c	2004-12-21 13:09:51.000000000 +0100
+++ net/core/netpoll.c	2004-12-21 13:27:01.000000000 +0100
@@ -31,6 +31,8 @@
 #define MAX_SKBS 32
 #define MAX_UDP_CHUNK 1460
 
+static int netpoll_kill;
+
 static spinlock_t skb_list_lock = SPIN_LOCK_UNLOCKED;
 static int nr_skbs;
 static struct sk_buff *skbs;
@@ -184,11 +186,21 @@ void netpoll_send_skb(struct netpoll *np
 
 repeat:
 	if(!np || !np->dev || !netif_running(np->dev)) {
+too_bad:
 		__kfree_skb(skb);
 		return;
 	}
 
-	spin_lock(&np->dev->xmit_lock);
+	if (!spin_trylock(&np->dev->xmit_lock)) {
+		netpoll_kill = 1;
+		goto too_bad;
+	}
+
+	if (netpoll_kill) {
+		if (net_ratelimit())
+			printk(KERN_ERR "netconsole raced");
+		netpoll_kill = 0;
+	}
 	np->dev->xmit_lock_owner = smp_processor_id();
 
 	/*
