Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbSLLWVG>; Thu, 12 Dec 2002 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbSLLWUN>; Thu, 12 Dec 2002 17:20:13 -0500
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:50564 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S267543AbSLLWUK>;
	Thu, 12 Dec 2002 17:20:10 -0500
Date: Thu, 12 Dec 2002 17:27:46 -0500
Message-Id: <200212122227.gBCMRkT10652@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: "Marco d'Itri" <md@Linux.IT>, julie.n.fleischer@intel.com,
       linux-kernel@vger.kernel.org,
       " Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: 2.5.51 nanosleep fails
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Marco, Julie, Everyone,

It really is broken.  I just didn't try enough combinations.

Thanks Julie, the test suite really helps.

The problem is that nanosleep didn't check for the NULL pointer
case and always tries to copy out the remaining time.  The attached
patch will fix this problem.

Jim Houston - Concurrent Computer Corp.

--- linux-2.5.51.orig/kernel/timer.c	Thu Dec 12 17:08:30 2002
+++ linux-2.5.51.new/kernel/timer.c	Thu Dec 12 16:59:10 2002
@@ -1040,7 +1040,7 @@
 		jiffies_to_timespec(expire, &t);
 
 		ret = -ERESTART_RESTARTBLOCK;
-		if (copy_to_user(rmtp, &t, sizeof(t)))
+		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
 			ret = -EFAULT;
 		/* The 'restart' block is already filled in */
 	}
@@ -1067,7 +1067,7 @@
 	if (expire) {
 		struct restart_block *restart;
 		jiffies_to_timespec(expire, &t);
-		if (copy_to_user(rmtp, &t, sizeof(t)))
+		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
 			return -EFAULT;
 
 		restart = &current_thread_info()->restart_block;
