Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTEJAf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 20:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTEJAf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 20:35:28 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:23949 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263623AbTEJAf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 20:35:26 -0400
Date: Sat, 10 May 2003 02:48:03 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make debugging variant of spinlocks a bit more robust
Message-ID: <20030510004803.GB12822@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  While I was trying to hunt down problem with spin_lock_irq
in send_sig_info, I noticed that debugging spinlocks are a bit
unusable.

  Problem is that these spinlocks first print warning, and
then decrement babble. So if lock is used by printk code (like
runqueue lock was), we get nothing, just lockup or double fault...
When we first decrement babble and then printing error message
we can break this unfortunate situation and error message
(5 same error messages...) appear on screen.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux/include/linux/spinlock.h	2003-05-09 04:35:34.000000000 +0200
+++ linux/include/linux/spinlock.h	2003-05-09 22:12:21.000000000 +0200
@@ -79,10 +79,10 @@
 	do { \
 	 	CHECK_LOCK(x); \
 		if ((x)->lock&&(x)->babble) { \
+			(x)->babble--; \
 			printk("%s:%d: spin_lock(%s:%p) already locked by %s/%d\n", \
 					__FILE__,__LINE__, (x)->module, \
 					(x), (x)->owner, (x)->oline); \
-			(x)->babble--; \
 		} \
 		(x)->lock = 1; \
 		(x)->owner = __FILE__; \
@@ -95,10 +95,10 @@
 	({ \
 	 	CHECK_LOCK(x); \
 		if ((x)->lock&&(x)->babble) { \
+			(x)->babble--; \
 			printk("%s:%d: spin_is_locked(%s:%p) already locked by %s/%d\n", \
 					__FILE__,__LINE__, (x)->module, \
 					(x), (x)->owner, (x)->oline); \
-			(x)->babble--; \
 		} \
 		0; \
 	})
@@ -109,10 +109,10 @@
 	({ \
 	 	CHECK_LOCK(x); \
 		if ((x)->lock&&(x)->babble) { \
+			(x)->babble--; \
 			printk("%s:%d: spin_trylock(%s:%p) already locked by %s/%d\n", \
 					__FILE__,__LINE__, (x)->module, \
 					(x), (x)->owner, (x)->oline); \
-			(x)->babble--; \
 		} \
 		(x)->lock = 1; \
 		(x)->owner = __FILE__; \
@@ -124,10 +124,10 @@
 	do { \
 	 	CHECK_LOCK(x); \
 		if ((x)->lock&&(x)->babble) { \
+			(x)->babble--; \
 			printk("%s:%d: spin_unlock_wait(%s:%p) owned by %s/%d\n", \
 					__FILE__,__LINE__, (x)->module, (x), \
 					(x)->owner, (x)->oline); \
-			(x)->babble--; \
 		}\
 	} while (0)
 
@@ -135,9 +135,9 @@
 	do { \
 	 	CHECK_LOCK(x); \
 		if (!(x)->lock&&(x)->babble) { \
+			(x)->babble--; \
 			printk("%s:%d: spin_unlock(%s:%p) not locked\n", \
 					__FILE__,__LINE__, (x)->module, (x));\
-			(x)->babble--; \
 		} \
 		(x)->lock = 0; \
 	} while (0)
