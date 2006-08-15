Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWHORyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWHORyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWHORyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:54:49 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63381 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030373AbWHORys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:54:48 -0400
Date: Tue, 15 Aug 2006 19:54:47 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] add some unlikely() to fs/select.c
Message-ID: <20060815175447.GA8068@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add unlikely() to various core select() and poll() functions.


Since these functions show up as X server related during profiling
(which is quite obvious), I thought that adding some unlikely()
shouldn't hurt...

I also moved some error code setting into error path (please yell if
I shouldn't do that).

Compile-tested and run-tested on 2.6.18-rc4-mm1.


Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.18-rc4-mm1.orig/fs/select.c	2006-08-22 21:13:24.000000000 +0200
+++ linux-2.6.18-rc4-mm1/fs/select.c	2006-08-23 19:28:46.000000000 +0200
@@ -104,7 +104,7 @@
 		struct poll_table_page *new_table;
 
 		new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
-		if (!new_table) {
+		if (unlikely(!new_table)) {
 			p->error = -ENOMEM;
 			__set_current_state(TASK_RUNNING);
 			return NULL;
@@ -317,9 +317,10 @@
 	/* Allocate small arguments on the stack to save memory and be faster */
 	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
 
-	ret = -EINVAL;
-	if (n < 0)
+	if (unlikely(n < 0)) {
+		ret = -EINVAL;
 		goto out_nofds;
+	}
 
 	/* max_fdset can increase, so grab it once to avoid race */
 	rcu_read_lock();
@@ -338,10 +339,11 @@
 	bits = stack_fds;
 	if (size > sizeof(stack_fds) / 6) {
 		/* Not enough space in on-stack array; must use kmalloc */
-		ret = -ENOMEM;
 		bits = kmalloc(6 * size, GFP_KERNEL);
-		if (!bits)
+		if (unlikely(!bits)) {
+			ret = -ENOMEM;
 			goto out_nofds;
+		}
 	}
 	fds.in      = bits;
 	fds.out     = bits +   size;
@@ -363,10 +365,10 @@
 	if (ret < 0)
 		goto out;
 	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			ret = -ERESTARTNOHAND;
 			goto out;
-		ret = 0;
+		}
 	}
 
 	if (set_fd_set(n, inp, fds.res_in) ||
@@ -392,7 +394,7 @@
 		if (copy_from_user(&tv, tvp, sizeof(tv)))
 			return -EFAULT;
 
-		if (tv.tv_sec < 0 || tv.tv_usec < 0)
+		if (unlikely(tv.tv_sec < 0 || tv.tv_usec < 0))
 			return -EINVAL;
 
 		/* Cast to u64 to make GCC stop complaining */
@@ -447,7 +449,7 @@
 		if (copy_from_user(&ts, tsp, sizeof(ts)))
 			return -EFAULT;
 
-		if (ts.tv_sec < 0 || ts.tv_nsec < 0)
+		if (unlikely(ts.tv_sec < 0 || ts.tv_nsec < 0))
 			return -EINVAL;
 
 		/* Cast to u64 to make GCC stop complaining */
@@ -461,7 +463,7 @@
 
 	if (sigmask) {
 		/* XXX: Don't preclude handling different sized sigset_t's.  */
-		if (sigsetsize != sizeof(sigset_t))
+		if (unlikely(sigsetsize != sizeof(sigset_t)))
 			return -EINVAL;
 		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
 			return -EFAULT;
@@ -628,7 +630,7 @@
 		if (*timeout < 0) {
 			/* Wait indefinitely */
 			__timeout = MAX_SCHEDULE_TIMEOUT;
-		} else if (unlikely(*timeout >= (s64)MAX_SCHEDULE_TIMEOUT-1)) {
+		} else if (unlikely(*timeout >= (s64)MAX_SCHEDULE_TIMEOUT - 1)) {
 			/*
 			 * Wait for longer than MAX_SCHEDULE_TIMEOUT. Do it in
 			 * a loop
@@ -789,7 +791,7 @@
 
 	if (sigmask) {
 		/* XXX: Don't preclude handling different sized sigset_t's.  */
-		if (sigsetsize != sizeof(sigset_t))
+		if (unlikely(sigsetsize != sizeof(sigset_t)))
 			return -EINVAL;
 		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
 			return -EFAULT;
