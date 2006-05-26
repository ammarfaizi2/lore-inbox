Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWEZWqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWEZWqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWEZWqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:46:44 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:27333
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751641AbWEZWqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:46:43 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] hw_random core: block read, if !O_NONBLOCK
Date: Sat, 27 May 2006 00:45:48 +0200
User-Agent: KMail/1.9.1
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605270045.48642.mb@bu3sch.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply this to -mm. It might also be desireable
to queue the whole hw_random rewrite for 2.6.18 after this
fix is merged.

--

Block reads to /dev/hwrng if O_NONBLOCK is not set.
This restores the old behavior, to not break userland (rngd).

Thanks to Valdis.Kletnieks@vt.edu for pointing out the issue.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

Index: hwrng.fixes/drivers/char/hw_random/core.c
===================================================================
--- hwrng.fixes.orig/drivers/char/hw_random/core.c	2006-05-16 21:52:47.000000000 +0200
+++ hwrng.fixes/drivers/char/hw_random/core.c	2006-05-27 00:39:08.000000000 +0200
@@ -125,7 +125,7 @@
 		mutex_unlock(&rng_mutex);
 
 		err = -EAGAIN;
-		if (!bytes_read)
+		if (!bytes_read && (filp->f_flags & O_NONBLOCK))
 			goto out;
 
 		err = -EFAULT;
@@ -138,6 +138,9 @@
 			data >>= 8;
 		}
 
+		if (need_resched())
+			schedule_timeout_interruptible(1);
+		err = -ERESTARTSYS;
 		if (signal_pending(current))
 			goto out;
 	}
