Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312020AbSCQNJE>; Sun, 17 Mar 2002 08:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312021AbSCQNIx>; Sun, 17 Mar 2002 08:08:53 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:43788 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S312020AbSCQNIk>;
	Sun, 17 Mar 2002 08:08:40 -0500
Message-ID: <3C948C97.719B9FF0@yahoo.com>
Date: Sun, 17 Mar 2002 07:51:19 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] no verify_write when CONFIG_WP_WORKS_OK=y
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 
> Note that the i386 has _long_ been a "stepchild", though: because of the
> lack of WP, the kernel simply doesn't do threaded MM correctly on a 386.

That reminds me of a patch to gut verify_write when CONFIG_X86_WP_WORKS_OK=y.
Saves a few bytes.  Patch is against 2.5.7pre2.

We could bin the whole thing and stop exporting it, but there may be users 
who try to load binary only modules that were built for 386 and hence expect 
verify_write to be exported regardless of CPU type the kernel was built for.

Paul.


--- ../linux/arch/i386/mm/fault.c	Sun Mar 17 07:14:09 2002
+++ arch/i386/mm/fault.c	Sun Mar 17 07:02:21 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1995  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -29,6 +30,9 @@
 
 extern int console_loglevel;
 
+#ifdef CONFIG_X86_WP_WORKS_OK
+int __verify_write(const void * addr, unsigned long size) {return 1;}
+#else
 /*
  * Ugly, ugly, but the goto's result in better assembly..
  */
@@ -93,6 +97,7 @@
 	}
 	goto bad_area;
 }
+#endif
 
 extern spinlock_t timerlist_lock;
 

