Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269948AbRHJQkJ>; Fri, 10 Aug 2001 12:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269949AbRHJQj7>; Fri, 10 Aug 2001 12:39:59 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:64015 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S269948AbRHJQjl>; Fri, 10 Aug 2001 12:39:41 -0400
Date: Fri, 10 Aug 2001 17:18:25 +0100 (BST)
From: Peter Denison <peterd@pnd-pc.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] DEPCA Network card module unload Oops
Message-ID: <Pine.LNX.4.33.0108101706100.11963-100000@pnd-pc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
	The DEPCA/DE100 etc network card driver oopses on unload if
compiled as a module and if CONFIG_NETLINK & CONFIG_RTNETLINK are
defined. This patch fixes the problem.

Detail:
	On network adapter unload, unregister_netdev() calls down the
notifier chain, announcing the unload. If RTNETLINK is compiled in, then
one of the notifications is rtnetlink_event(), eventually calling
rtnetlink_fill_ifinfo(), which does a dev->get_stats(dev). If the stats
call to the driver uses private info, then the call to unregister_netdev()
must happen before the private data is freed. I haven't checked any other
network drivers for this, but it may be worth doing.

Patch:

--- drivers/net/depca.c.old	Sun Jul 15 16:43:58 2001
+++ drivers/net/depca.c	Wed Aug  8 21:06:45 2001
@@ -2060,6 +2060,8 @@
 cleanup_module(void)
 {
   struct depca_private *lp = thisDepca.priv;
+
+  unregister_netdev(&thisDepca);
   if (lp) {
     iounmap(lp->sh_mem);
 #ifdef CONFIG_MCA
@@ -2071,7 +2073,6 @@
   }
   thisDepca.irq=0;

-  unregister_netdev(&thisDepca);
   release_region(thisDepca.base_addr, DEPCA_TOTAL_SIZE);
 }
 #endif /* MODULE */

-- 
Peter Denison <peterd@pnd-pc.demon.co.uk>
Linux Driver for Promise DC4030VL cards.
See http://www.pnd-pc.demon.co.uk/promise/promise.html for details

