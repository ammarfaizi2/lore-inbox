Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTLBWQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 17:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTLBWQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 17:16:34 -0500
Received: from users.ccur.com ([208.248.32.211]:20672 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S264415AbTLBWQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 17:16:31 -0500
Date: Tue, 2 Dec 2003 17:16:20 -0500
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH, 2.6.0-test11] more correct get_compat_timespec interface
Message-ID: <20031202221619.GA27505@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, 
 The API for get_compat_timespec / put_compat_timespec is incorrect, it
forces a caller with const args to (incorrectly) cast.  The posix message
queue patch is one such caller.

Joe



diff -ura 2.6.0-test11-base/include/linux/compat.h 2.6.0-test11-new/include/linux/compat.h
--- 2.6.0-test11-base/include/linux/compat.h	2003-11-26 15:43:56.000000000 -0500
+++ 2.6.0-test11-new/include/linux/compat.h	2003-12-02 15:48:14.000000000 -0500
@@ -44,8 +44,8 @@
 } compat_sigset_t;
 
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
-extern int get_compat_timespec(struct timespec *, struct compat_timespec *);
-extern int put_compat_timespec(struct timespec *, struct compat_timespec *);
+extern int get_compat_timespec(struct timespec *, const struct compat_timespec *);
+extern int put_compat_timespec(struct timespec *, const struct compat_timespec *);
 
 struct compat_iovec {
 	compat_uptr_t	iov_base;
diff -ura 2.6.0-test11-base/kernel/compat.c 2.6.0-test11-new/kernel/compat.c
--- 2.6.0-test11-base/kernel/compat.c	2003-11-26 15:44:11.000000000 -0500
+++ 2.6.0-test11-new/kernel/compat.c	2003-12-02 15:48:14.000000000 -0500
@@ -22,14 +22,14 @@
 
 #include <asm/uaccess.h>
 
-int get_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+int get_compat_timespec(struct timespec *ts, const struct compat_timespec *cts)
 {
 	return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
 			__get_user(ts->tv_sec, &cts->tv_sec) ||
 			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-int put_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+int put_compat_timespec(struct timespec *ts, const struct compat_timespec *cts)
 {
 	return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
 			__put_user(ts->tv_sec, &cts->tv_sec) ||
