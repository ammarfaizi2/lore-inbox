Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbSK2C3p>; Thu, 28 Nov 2002 21:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSK2C3p>; Thu, 28 Nov 2002 21:29:45 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:62680 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266938AbSK2C3m>;
	Thu, 28 Nov 2002 21:29:42 -0500
Date: Fri, 29 Nov 2002 13:36:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-Id: <20021129133600.18609892.sfr@canb.auug.org.au>
In-Reply-To: <20021127.212638.35873260.davem@redhat.com>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
	<20021128162231.6935e3af.sfr@canb.auug.org.au>
	<20021127.212638.35873260.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed, 27 Nov 2002 21:26:38 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
>
>    From: Stephen Rothwell <sfr@canb.auug.org.au>
>    Date: Thu, 28 Nov 2002 16:22:31 +1100
> 
>    On Wed, 27 Nov 2002 09:18:06 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
>    > May I just suggest doing a
>    > 
>    > 	kernel/compat32.c
>    
>    OK, new version.
> 
> Well, actually I disagree with this.

I agree with you.  Apply the below patch over my previous one to get
what you like.  How do we convince Linus?

Anyone else want to express an opinion ...

> A problem currently, is that when people change VFS stuff up one has
> to pay attention to update all the compat syscall layers as well.
> 
> This often simply does not happen because the compat version is
> "somewhere else" is some other file.
> 
> Now if we put the stuff next to the non-compat stuff, it likely won't
> get missed.

This, of course, is one of the main reasons to do these consolidations.
The other is so that we don't have the same bugs in all our architectures
and then it takes six months to get them fixed (See SIGURG fix ...)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-32bit.1/include/linux/compat32.h 2.5.50-32bit.2/include/linux/compat32.h
--- 2.5.50-32bit.1/include/linux/compat32.h	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/include/linux/compat32.h	2002-11-29 13:29:44.000000000 +1100
@@ -4,6 +4,10 @@
  * These are the type definitions for the 32 compatibility
  * layer on 64 bit architectures.
  */
+#include <linux/config.h>
+
+#ifdef CONFIG_COMPAT32
+
 #include <linux/types.h>
 #include <asm/compat32.h>
 
@@ -12,4 +16,5 @@
 	s32		tv_nsec;
 };
 
+#endif /* CONFIG_COMPAT32 */
 #endif /* _LINUX_COMPAT32_H */
diff -ruN 2.5.50-32bit.1/include/linux/time.h 2.5.50-32bit.2/include/linux/time.h
--- 2.5.50-32bit.1/include/linux/time.h	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/include/linux/time.h	2002-11-29 13:31:11.000000000 +1100
@@ -138,7 +138,6 @@
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern void do_settimeofday(struct timeval *tv);
-extern long do_nanosleep(struct timespec *t);
 #endif
 
 #define FD_SETSIZE		__FD_SETSIZE
diff -ruN 2.5.50-32bit.1/kernel/Makefile 2.5.50-32bit.2/kernel/Makefile
--- 2.5.50-32bit.1/kernel/Makefile	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/kernel/Makefile	2002-11-29 13:28:40.000000000 +1100
@@ -21,7 +21,6 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
-obj-$(CONFIG_COMPAT32) += compat32.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -ruN 2.5.50-32bit.1/kernel/compat32.c 2.5.50-32bit.2/kernel/compat32.c
--- 2.5.50-32bit.1/kernel/compat32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/kernel/compat32.c	1970-01-01 10:00:00.000000000 +1000
@@ -1,40 +0,0 @@
-/*
- *  linux/kernel/compat32.c
- *
- *  Kernel compatibililty routines for e.g. 32 bit syscall support
- *  on 64 bit kernels.
- *
- *  Copyright (C) 2002 Stephen Rothwell, IBM Corporation
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#include <linux/linkage.h>
-#include <linux/compat32.h>
-#include <linux/errno.h>
-#include <linux/time.h>
-
-#include <asm/uaccess.h>
-
-asmlinkage long sys32_nanosleep(struct timespec32 *rqtp,
-		struct timespec32 *rmtp)
-{
-	struct timespec t;
-	struct timespec32 ct;
-	s32 ret;
-
-	if (copy_from_user(&ct, rqtp, sizeof(ct)))
-		return -EFAULT;
-	t.tv_sec = ct.tv_sec;
-	t.tv_nsec = ct.tv_nsec;
-	ret = do_nanosleep(&t);
-	if (rmtp && (ret == -EINTR)) {
-		ct.tv_sec = t.tv_sec;
-		ct.tv_nsec = t.tv_nsec;
-		if (copy_to_user(rmtp, &ct, sizeof(ct)))
-			return -EFAULT;
-	}
-	return ret;
-}
diff -ruN 2.5.50-32bit.1/kernel/timer.c 2.5.50-32bit.2/kernel/timer.c
--- 2.5.50-32bit.1/kernel/timer.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/kernel/timer.c	2002-11-29 13:28:02.000000000 +1100
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/compat32.h>
 
 #include <asm/uaccess.h>
 
@@ -1022,7 +1023,7 @@
 	return current->pid;
 }
 
-long do_nanosleep(struct timespec *t)
+static long do_nanosleep(struct timespec *t)
 {
 	unsigned long expire;
 
@@ -1057,6 +1058,29 @@
 	return ret;
 }
 
+#ifndef CONFIG_COMPAT32
+asmlinkage long sys32_nanosleep(struct timespec32 *rqtp,
+		struct timespec32 *rmtp)
+{
+	struct timespec t;
+	struct timespec32 ct;
+	s32 ret;
+
+	if (copy_from_user(&ct, rqtp, sizeof(ct)))
+		return -EFAULT;
+	t.tv_sec = ct.tv_sec;
+	t.tv_nsec = ct.tv_nsec;
+	ret = do_nanosleep(&t);
+	if (rmtp && (ret == -EINTR)) {
+		ct.tv_sec = t.tv_sec;
+		ct.tv_nsec = t.tv_nsec;
+		if (copy_to_user(rmtp, &ct, sizeof(ct)))
+			return -EFAULT;
+	}
+	return ret;
+}
+#endif /* CONFIG_COMPAT32 */
+
 /*
  * sys_sysinfo - fill in sysinfo struct
  */ 
