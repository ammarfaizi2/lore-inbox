Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbULUA4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbULUA4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbULUA4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:56:14 -0500
Received: from waste.org ([216.27.176.166]:38856 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261275AbULUAzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:55:50 -0500
Date: Mon, 20 Dec 2004 16:55:21 -0800
From: Matt Mackall <mpm@selenic.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Mark Broadbent <markb@wetlettuce.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041221005521.GD5974@waste.org>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com> <20041216211024.GK2767@waste.org> <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com> <20041217215752.GP2767@waste.org> <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com> <20041220211419.GC5974@waste.org> <20041221002218.GA1487@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221002218.GA1487@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 01:22:18AM +0100, Francois Romieu wrote:
> Matt Mackall <mpm@selenic.com> :
> > On Mon, Dec 20, 2004 at 09:42:08AM -0000, Mark Broadbent wrote:
> > > 
> > > Exactly the same happens, I still get a 'NMI Watchdog detected LOCKUP'
> > > with the r8169 device using the above patch on top of 2.6.10-rc3-bk10.
> > 
> > Ok, that suggests a problem localized to netpoll itself. Do you have
> > spinlock debugging turned on by any chance? 
> 
> Any chance of:
> 1 dev_queue_xmit
> 2 dev->xmit_lock taken
> 3 interruption
> 4 printk
> 5 netconsole write
> 6 dev->xmit_lock again
> 7 lockup
> 
> ?
> 
> This is probably the silly question of the day.

Maybe, but the answer isn't obvious to me at the moment as I haven't
been thinking about such stuff enough lately. Silly response of the
day:

Mark, can you try this (again completely untested, but at least
compiles) patch? I'm afraid I don't have a proper test rig to
reproduce this at the moment. This will attempt to grab the lock, and
if it fails, will check for recursion. Then it will try to print a
message on the local console, temporarily disabling netconsole to
allow the printk to get through..

Index: l/net/core/netpoll.c
===================================================================
--- l.orig/net/core/netpoll.c	2004-11-04 10:53:23.388610000 -0800
+++ l/net/core/netpoll.c	2004-12-20 16:45:40.212709000 -0800
@@ -31,6 +31,8 @@
 #define MAX_SKBS 32
 #define MAX_UDP_CHUNK 1460
 
+static int netpoll_kill;
+
 static spinlock_t skb_list_lock = SPIN_LOCK_UNLOCKED;
 static int nr_skbs;
 static struct sk_buff *skbs;
@@ -183,13 +185,24 @@
 	int status;
 
 repeat:
-	if(!np || !np->dev || !netif_running(np->dev)) {
+	if(!np || !np->dev || !netif_running(np->dev) || netpoll_kill) {
 		__kfree_skb(skb);
 		return;
 	}
 
-	spin_lock(&np->dev->xmit_lock);
-	np->dev->xmit_lock_owner = smp_processor_id();
+	if(spin_trylock(&np->dev->xmit_lock))
+		np->dev->xmit_lock_owner = smp_processor_id();
+	else {
+		if(np->dev->xmit_lock_owner == smp_processor_id()) {
+			netpoll_kill = 1;
+			__kfree_skb(skb);
+			printk("Tried to recursively get dev->xmit_lock");
+			netpoll_kill = 0;
+			return;
+		}
+		spin_lock(&np->dev->xmit_lock);
+
+	}
 
 	/*
 	 * network drivers do not expect to be called if the queue is


-- 
Mathematics is the supreme nostalgia of our time.
