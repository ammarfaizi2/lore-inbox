Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSL2BDf>; Sat, 28 Dec 2002 20:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSL2BDe>; Sat, 28 Dec 2002 20:03:34 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:44437 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265700AbSL2BDe>; Sat, 28 Dec 2002 20:03:34 -0500
Date: Sat, 28 Dec 2002 20:04:21 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.53 : drivers/net/wan/x25_asy.c
Message-ID: <Pine.LNX.4.44.0212282000520.952-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The attached patch swaps the save_flags/cli/restore_flags combo with a 
spinlock.  Please review.

Regards,
Frank

--- linux/drivers/net/wan/x25_asy.c.old	Sat Dec 28 18:49:00 2002
+++ linux/drivers/net/wan/x25_asy.c	Sat Dec 28 18:54:51 2002
@@ -33,6 +33,7 @@
 #include <linux/lapb.h>
 #include <linux/init.h>
 #include "x25_asy.h"
+#include <linux/spinlock.h>
 
 typedef struct x25_ctrl {
 	struct x25_asy	ctrl;		/* X.25 things			*/
@@ -40,6 +41,7 @@
 } x25_asy_ctrl_t;
 
 static x25_asy_ctrl_t	**x25_asy_ctrls = NULL;
+static spinlock_t x25_asy_slock = SPIN_LOCK_UNLOCKED;
 
 int x25_asy_maxdev = SL_NRUNIT;		/* Can be overridden with insmod! */
 
@@ -164,8 +166,7 @@
 		return;
 	}
 
-	save_flags(flags); 
-	cli();
+	spin_lock_irqsave(&x25_asy_slock, flags); 
 
 	oxbuff    = sl->xbuff;
 	sl->xbuff = xbuff;
@@ -195,7 +196,7 @@
 
 	sl->buffsize = len;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&x25_asy_slock, flags);
 
 	if (oxbuff != NULL) 
 		kfree(oxbuff);

