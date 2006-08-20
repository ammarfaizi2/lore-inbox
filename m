Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWHTMGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWHTMGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 08:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHTMGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 08:06:15 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:3556 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750741AbWHTMGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 08:06:15 -0400
Date: Sun, 20 Aug 2006 20:30:16 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] uninline ioprio_best()
Message-ID: <20060820163016.GA4152@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saves 376 bytes (5 callers) for me.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/include/linux/ioprio.h~4_best	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc4/include/linux/ioprio.h	2006-08-20 20:17:37.000000000 +0400
@@ -59,27 +59,6 @@ static inline int task_nice_ioprio(struc
 /*
  * For inheritance, return the highest of the two given priorities
  */
-static inline int ioprio_best(unsigned short aprio, unsigned short bprio)
-{
-	unsigned short aclass = IOPRIO_PRIO_CLASS(aprio);
-	unsigned short bclass = IOPRIO_PRIO_CLASS(bprio);
-
-	if (!ioprio_valid(aprio))
-		return bprio;
-	if (!ioprio_valid(bprio))
-		return aprio;
-
-	if (aclass == IOPRIO_CLASS_NONE)
-		aclass = IOPRIO_CLASS_BE;
-	if (bclass == IOPRIO_CLASS_NONE)
-		bclass = IOPRIO_CLASS_BE;
-
-	if (aclass == bclass)
-		return min(aprio, bprio);
-	if (aclass > bclass)
-		return bprio;
-	else
-		return aprio;
-}
+extern int ioprio_best(unsigned short aprio, unsigned short bprio);
 
 #endif
--- 2.6.18-rc4/fs/ioprio.c~4_best	2006-08-20 19:57:14.000000000 +0400
+++ 2.6.18-rc4/fs/ioprio.c	2006-08-20 20:16:39.000000000 +0400
@@ -140,6 +140,29 @@ out:
 	return ret;
 }
 
+int ioprio_best(unsigned short aprio, unsigned short bprio)
+{
+	unsigned short aclass = IOPRIO_PRIO_CLASS(aprio);
+	unsigned short bclass = IOPRIO_PRIO_CLASS(bprio);
+
+	if (!ioprio_valid(aprio))
+		return bprio;
+	if (!ioprio_valid(bprio))
+		return aprio;
+
+	if (aclass == IOPRIO_CLASS_NONE)
+		aclass = IOPRIO_CLASS_BE;
+	if (bclass == IOPRIO_CLASS_NONE)
+		bclass = IOPRIO_CLASS_BE;
+
+	if (aclass == bclass)
+		return min(aprio, bprio);
+	if (aclass > bclass)
+		return bprio;
+	else
+		return aprio;
+}
+
 asmlinkage long sys_ioprio_get(int which, int who)
 {
 	struct task_struct *g, *p;

