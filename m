Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVJHVrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVJHVrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVJHVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 17:47:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63739 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932177AbVJHVrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 17:47:24 -0400
Mime-Version: 1.0 (Apple Message framework v619)
To: Ingo Molnar <mingo@elte.hu>
Message-Id: <1BE252F0-3845-11DA-8153-000A959BB91E@mvista.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2-176987967
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: robust futex patch for 2.6.14-rc3-rt13
From: david singleton <dsingleton@mvista.com>
Date: Sat, 8 Oct 2005 14:47:23 -0700
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-2-176987967
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


Ingo,
     here's a patch for the robust futex changes that match the 
glibc/nptl changes
for robust futexes.  The kernel and glibc now both have robustness and
priority inheritance independent.

	This patch is based off 2.6.14-rc3-rt13.

	The changes remove some duplicate defines from futex.c and glibc and
put all the defines into futex.h.   The defines have also been changed 
a bit
to make the assembler in glibc simpler.

	There is also one fix to futex.c where the first waiter on a futex 
waits instead of returning -EAGAIN.

	The glibc patches can be found at http://source.mvista.com/~dsingleton


glibc-bull-nptl-robustmutexes.patch
glibc-mvl-nptl-priority-inheritance-rf2.patch

David
--Apple-Mail-2-176987967
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="f.diff"
Content-Disposition: attachment;
	filename=f.diff

--- futex/linux-2.6.13.3/include/linux/futex.h	2005-10-08 11:38:24.000000000 -0700
+++ new/linux-2.6.13.3/include/linux/futex.h	2005-10-08 11:37:56.000000000 -0700
@@ -18,10 +18,16 @@
 
 #define FUTEX_ATTR_PRIORITY_QUEUING		0x10000000
 #define FUTEX_ATTR_PRIORITY_INHERITANCE		0x20000000
-#define FUTEX_ATTR_ROBUST			0x40000000
-#define FUTEX_ATTR_PRIORITY_PROTECT		0x80000000
+#define FUTEX_ATTR_PRIORITY_PROTECT		0x40000000
+#define FUTEX_ATTR_ROBUST			0x80000000
 #define FUTEX_ATTR_SHARED			0x01000000
-#define FUTEX_ATTR_MASK				0xf1000000
+#define FUTEX_ATTR_MASK				0xff000000
+
+#define FUTEX_WAITERS                         0x80000000
+#define FUTEX_OWNER_DIED                      0x40000000
+#define FUTEX_NOT_RECOVERABLE                 0x20000000
+#define FUTEX_FLAGS (FUTEX_WAITERS | FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE)
+#define FUTEX_PID                             ~(FUTEX_FLAGS)
 
 #ifdef __KERNEL__
 
--- futex/linux-2.6.13.3/kernel/futex.c	2005-10-08 14:37:58.000000000 -0700
+++ new/linux-2.6.13.3/kernel/futex.c	2005-10-08 14:38:53.000000000 -0700
@@ -853,11 +853,6 @@
  * the futex is not locked.
  */
 
-#define FUTEX_WAITERS		0x80000000
-#define FUTEX_OWNER_DIED	0x40000000
-#define FUTEX_NOT_RECOVERABLE	0x20000000
-#define FUTEX_PID		0x1fffffff
-
 /*
  * Used to track registered robust futexes. Attached to linked list in inodes.
  */
@@ -1179,16 +1174,6 @@
 		goto out_release_sem;
 	}
 
-	/*
-	 * user mode called us because futex had owner and waitflag was
-	 * set. That's not true now, so let user mode try again
-	 */
-	if ((curval & FUTEX_PID) && !(curval & FUTEX_WAITERS)) {
-		ret = -EAGAIN;
-		queue_unlock(&q, bh);
-		goto out_release_sem;
-	}
-
 	/* if owner has died, we don't want to wait */
 	if ((curval & FUTEX_OWNER_DIED)) {
 		ret = -EOWNERDEAD;

--Apple-Mail-2-176987967--

