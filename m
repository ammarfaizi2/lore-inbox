Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTLCVgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTLCVgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:36:09 -0500
Received: from users.ccur.com ([208.248.32.211]:43761 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S262072AbTLCVfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:35:55 -0500
Date: Wed, 3 Dec 2003 16:31:53 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Jon Foster <jon@jon-foster.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, 2.6.0-test11] more correct get_compat_timespec interface
Message-ID: <20031203213153.GA28990@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <3FCE30A7.4080600@jon-foster.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE30A7.4080600@jon-foster.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 06:51:19PM +0000, Jon Foster wrote:
>-int put_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
>+int put_compat_timespec(struct timespec *ts, const struct compat_timespec *cts)
> 
> Shouldn't the "const" be on the other argument?

Indeed it should.  Here is the new and improved version, also with '__user' added
at the correct spots.

Regards,
Joe


diff -ura 2.6.0-test11-base/include/linux/compat.h 2.6.0-test11-new/include/linux/compat.h
--- 2.6.0-test11-base/include/linux/compat.h	2003-11-26 15:43:56.000000000 -0500
+++ 2.6.0-test11-new/include/linux/compat.h	2003-12-03 16:04:17.000000000 -0500
@@ -44,8 +44,8 @@
 } compat_sigset_t;
 
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
-extern int get_compat_timespec(struct timespec *, struct compat_timespec *);
-extern int put_compat_timespec(struct timespec *, struct compat_timespec *);
+extern int get_compat_timespec(struct timespec *, const struct compat_timespec __user *);
+extern int put_compat_timespec(const struct timespec *, struct compat_timespec __user *);
 
 struct compat_iovec {
 	compat_uptr_t	iov_base;
diff -ura 2.6.0-test11-base/kernel/compat.c 2.6.0-test11-new/kernel/compat.c
--- 2.6.0-test11-base/kernel/compat.c	2003-11-26 15:44:11.000000000 -0500
+++ 2.6.0-test11-new/kernel/compat.c	2003-12-03 16:04:17.000000000 -0500
@@ -22,14 +22,14 @@
 
 #include <asm/uaccess.h>
 
-int get_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+int get_compat_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
 {
 	return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
 			__get_user(ts->tv_sec, &cts->tv_sec) ||
 			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-int put_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+int put_compat_timespec(const struct timespec *ts, struct compat_timespec __user *cts)
 {
 	return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
 			__put_user(ts->tv_sec, &cts->tv_sec) ||
