Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUBWUiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUBWUiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:38:16 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:59038 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261956AbUBWUfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:35:01 -0500
Date: Mon, 23 Feb 2004 21:33:16 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: Linus Torvalds <torvalds@osdl.org>
cc: piggin@cyberone.com.au, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix shmat
In-Reply-To: <Pine.LNX.4.58.0402231035280.3005@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0402232127250.13421-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Feb 2004, Linus Torvalds wrote:
>
> Please. Maybe it might even be worth-while renaming it to "do_sys_shmat()"
> to make it clear that it's not a "sys_xxx()" at all.
>

Below is a patch that renames sys_shmat to do_shmat. Additionally, I've
replaced the cond_syscall with a conditional inline function.

It touches all archs - only i386 is tested.
The patch is against 2.6.3-bk5 (latest slapshot)

--
	Manfred
<<<<
diff -ur 2.6/arch/alpha/kernel/osf_sys.c build-2.6/arch/alpha/kernel/osf_sys.c
--- 2.6/arch/alpha/kernel/osf_sys.c	2004-01-09 07:59:02.000000000 +0100
+++ build-2.6/arch/alpha/kernel/osf_sys.c	2004-02-23 20:51:48.000000000 +0100
@@ -464,7 +464,7 @@
 	unsigned long raddr;
 	long err;

-	err = sys_shmat(shmid, shmaddr, shmflg, &raddr);
+	err = do_shmat(shmid, shmaddr, shmflg, &raddr);

 	/*
 	 * This works because all user-level addresses are
diff -ur 2.6/arch/arm/kernel/sys_arm.c build-2.6/arch/arm/kernel/sys_arm.c
--- 2.6/arch/arm/kernel/sys_arm.c	2004-01-09 07:59:10.000000000 +0100
+++ build-2.6/arch/arm/kernel/sys_arm.c	2004-02-23 20:53:02.000000000 +0100
@@ -210,7 +210,7 @@
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = sys_shmat (first, (char *) ptr, second, &raddr);
+			ret = do_shmat (first, (char *) ptr, second, &raddr);
 			if (ret)
 				return ret;
 			return put_user (raddr, (ulong *) third);
@@ -218,7 +218,7 @@
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
-			return sys_shmat (first, (char *) ptr,
+			return do_shmat (first, (char *) ptr,
 					  second, (ulong *) third);
 		}
 	case SHMDT:
diff -ur 2.6/arch/arm26/kernel/sys_arm.c build-2.6/arch/arm26/kernel/sys_arm.c
--- 2.6/arch/arm26/kernel/sys_arm.c	2004-01-09 07:59:44.000000000 +0100
+++ build-2.6/arch/arm26/kernel/sys_arm.c	2004-02-23 20:44:18.000000000 +0100
@@ -211,7 +211,7 @@
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = sys_shmat (first, (char *) ptr, second, &raddr);
+			ret = do_shmat (first, (char *) ptr, second, &raddr);
 			if (ret)
 				return ret;
 			return put_user (raddr, (ulong *) third);
@@ -219,7 +219,7 @@
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
-			return sys_shmat (first, (char *) ptr,
+			return do_shmat (first, (char *) ptr,
 					  second, (ulong *) third);
 		}
 	case SHMDT:
diff -ur 2.6/arch/cris/kernel/sys_cris.c build-2.6/arch/cris/kernel/sys_cris.c
--- 2.6/arch/cris/kernel/sys_cris.c	2004-01-09 07:59:04.000000000 +0100
+++ build-2.6/arch/cris/kernel/sys_cris.c	2004-02-23 20:43:21.000000000 +0100
@@ -155,7 +155,7 @@

 	case SHMAT: {
                 ulong raddr;
-                ret = sys_shmat (first, (char __user *) ptr, second, &raddr);
+                ret = do_shmat (first, (char __user *) ptr, second, &raddr);
                 if (ret)
                         return ret;
                 return put_user (raddr, (ulong __user *) third);
diff -ur 2.6/arch/h8300/kernel/sys_h8300.c build-2.6/arch/h8300/kernel/sys_h8300.c
--- 2.6/arch/h8300/kernel/sys_h8300.c	2004-01-09 07:59:56.000000000 +0100
+++ build-2.6/arch/h8300/kernel/sys_h8300.c	2004-02-23 20:53:28.000000000 +0100
@@ -240,7 +240,7 @@
 			switch (version) {
 			default: {
 				ulong raddr;
-				ret = sys_shmat (first, (char *) ptr,
+				ret = do_shmat (first, (char *) ptr,
 						 second, &raddr);
 				if (ret)
 					return ret;
diff -ur 2.6/arch/i386/kernel/sys_i386.c build-2.6/arch/i386/kernel/sys_i386.c
--- 2.6/arch/i386/kernel/sys_i386.c	2004-01-09 08:00:04.000000000 +0100
+++ build-2.6/arch/i386/kernel/sys_i386.c	2004-02-23 20:39:47.000000000 +0100
@@ -186,7 +186,7 @@
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = sys_shmat (first, (char __user *) ptr, second, &raddr);
+			ret = do_shmat (first, (char __user *) ptr, second, &raddr);
 			if (ret)
 				return ret;
 			return put_user (raddr, (ulong __user *) third);
@@ -195,7 +195,7 @@
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
 			/* The "(ulong *) third" is valid _only_ because of the kernel segment thing */
-			return sys_shmat (first, (char __user *) ptr, second, (ulong *) third);
+			return do_shmat (first, (char __user *) ptr, second, (ulong *) third);
 		}
 	case SHMDT:
 		return sys_shmdt ((char __user *)ptr);
diff -ur 2.6/arch/ia64/ia32/sys_ia32.c build-2.6/arch/ia64/ia32/sys_ia32.c
--- 2.6/arch/ia64/ia32/sys_ia32.c	2004-02-23 20:37:01.000000000 +0100
+++ build-2.6/arch/ia64/ia32/sys_ia32.c	2004-02-23 20:51:44.000000000 +0100
@@ -1447,7 +1447,7 @@

 	if (version == 1)
 		return -EINVAL;	/* iBCS2 emulator entry point: unsupported */
-	err = sys_shmat(first, uptr, second, &raddr);
+	err = do_shmat(first, uptr, second, &raddr);
 	if (err)
 		return err;
 	return put_user(raddr, uaddr);
diff -ur 2.6/arch/ia64/kernel/sys_ia64.c build-2.6/arch/ia64/kernel/sys_ia64.c
--- 2.6/arch/ia64/kernel/sys_ia64.c	2004-01-09 07:59:44.000000000 +0100
+++ build-2.6/arch/ia64/kernel/sys_ia64.c	2004-02-23 20:51:25.000000000 +0100
@@ -98,7 +98,7 @@
 	unsigned long raddr;
 	int retval;

-	retval = sys_shmat(shmid, shmaddr, shmflg, &raddr);
+	retval = do_shmat(shmid, shmaddr, shmflg, &raddr);
 	if (retval < 0)
 		return retval;

diff -ur 2.6/arch/m68k/kernel/sys_m68k.c build-2.6/arch/m68k/kernel/sys_m68k.c
--- 2.6/arch/m68k/kernel/sys_m68k.c	2004-01-09 07:59:10.000000000 +0100
+++ build-2.6/arch/m68k/kernel/sys_m68k.c	2004-02-23 20:44:39.000000000 +0100
@@ -241,7 +241,7 @@
 			switch (version) {
 			default: {
 				ulong raddr;
-				ret = sys_shmat (first, (char *) ptr,
+				ret = do_shmat (first, (char *) ptr,
 						 second, &raddr);
 				if (ret)
 					return ret;
diff -ur 2.6/arch/mips/kernel/linux32.c build-2.6/arch/mips/kernel/linux32.c
--- 2.6/arch/mips/kernel/linux32.c	2004-02-23 20:37:03.000000000 +0100
+++ build-2.6/arch/mips/kernel/linux32.c	2004-02-23 20:41:21.000000000 +0100
@@ -1460,7 +1460,7 @@

 	if (version == 1)
 		return err;
-	err = sys_shmat (first, uptr, second, &raddr);
+	err = do_shmat (first, uptr, second, &raddr);
 	if (err)
 		return err;
 	err = put_user (raddr, uaddr);
diff -ur 2.6/arch/mips/kernel/syscall.c build-2.6/arch/mips/kernel/syscall.c
--- 2.6/arch/mips/kernel/syscall.c	2004-02-23 20:37:03.000000000 +0100
+++ build-2.6/arch/mips/kernel/syscall.c	2004-02-23 20:41:50.000000000 +0100
@@ -342,7 +342,7 @@
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = sys_shmat (first, (char *) ptr, second, &raddr);
+			ret = do_shmat (first, (char *) ptr, second, &raddr);
 			if (ret)
 				return ret;
 			return put_user (raddr, (ulong *) third);
@@ -350,7 +350,7 @@
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
-			return sys_shmat (first, (char *) ptr, second, (ulong *) third);
+			return do_shmat (first, (char *) ptr, second, (ulong *) third);
 		}
 	case SHMDT:
 		return sys_shmdt ((char *)ptr);
diff -ur 2.6/arch/mips/kernel/sysirix.c build-2.6/arch/mips/kernel/sysirix.c
--- 2.6/arch/mips/kernel/sysirix.c	2004-02-23 20:37:03.000000000 +0100
+++ build-2.6/arch/mips/kernel/sysirix.c	2004-02-23 20:42:51.000000000 +0100
@@ -968,7 +968,7 @@
 {
 	switch (opcode) {
 	case 0:
-		return sys_shmat((int) arg0, (char *)arg1, (int) arg2,
+		return do_shmat((int) arg0, (char *)arg1, (int) arg2,
 				 (unsigned long *) arg3);
 	case 1:
 		return sys_shmctl((int)arg0, (int)arg1, (struct shmid_ds *)arg2);
diff -ur 2.6/arch/parisc/kernel/sys_parisc.c build-2.6/arch/parisc/kernel/sys_parisc.c
--- 2.6/arch/parisc/kernel/sys_parisc.c	2004-02-23 20:24:13.000000000 +0100
+++ build-2.6/arch/parisc/kernel/sys_parisc.c	2004-02-23 20:53:14.000000000 +0100
@@ -173,7 +173,7 @@
 	unsigned long raddr;
 	int r;

-	r = sys_shmat(shmid, shmaddr, shmflag, &raddr);
+	r = do_shmat(shmid, shmaddr, shmflag, &raddr);
 	if (r < 0)
 		return r;
 	return raddr;
diff -ur 2.6/arch/ppc/kernel/syscalls.c build-2.6/arch/ppc/kernel/syscalls.c
--- 2.6/arch/ppc/kernel/syscalls.c	2004-02-23 20:23:30.000000000 +0100
+++ build-2.6/arch/ppc/kernel/syscalls.c	2004-02-23 20:40:51.000000000 +0100
@@ -119,7 +119,7 @@
 		if ((ret = verify_area(VERIFY_WRITE, (ulong __user *) third,
 				       sizeof(ulong))))
 			break;
-		ret = sys_shmat (first, (char __user *) ptr, second, &raddr);
+		ret = do_shmat (first, (char __user *) ptr, second, &raddr);
 		if (ret)
 			break;
 		ret = put_user (raddr, (ulong __user *) third);
diff -ur 2.6/arch/ppc64/kernel/syscalls.c build-2.6/arch/ppc64/kernel/syscalls.c
--- 2.6/arch/ppc64/kernel/syscalls.c	2004-02-23 20:23:31.000000000 +0100
+++ build-2.6/arch/ppc64/kernel/syscalls.c	2004-02-23 20:52:24.000000000 +0100
@@ -122,7 +122,7 @@
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = sys_shmat (first, (char *) ptr, second, &raddr);
+			ret = do_shmat (first, (char *) ptr, second, &raddr);
 			if (ret)
 				break;
 			ret = put_user (raddr, (ulong *) third);
@@ -132,7 +132,7 @@
 			ret = -EINVAL;
 			if (!segment_eq(get_fs(), get_ds()))
 				break;
-			ret = sys_shmat (first, (char *) ptr, second,
+			ret = do_shmat (first, (char *) ptr, second,
 					 (ulong *) third);
 			break;
 		}
diff -ur 2.6/arch/ppc64/kernel/sys_ppc32.c build-2.6/arch/ppc64/kernel/sys_ppc32.c
--- 2.6/arch/ppc64/kernel/sys_ppc32.c	2004-02-23 20:24:17.000000000 +0100
+++ build-2.6/arch/ppc64/kernel/sys_ppc32.c	2004-02-23 20:52:50.000000000 +0100
@@ -1649,7 +1649,7 @@

 	if (version == 1)
 		return err;
-	err = sys_shmat(first, uptr, second, &raddr);
+	err = do_shmat(first, uptr, second, &raddr);
 	if (err)
 		return err;
 	err = put_user(raddr, uaddr);
diff -ur 2.6/arch/s390/kernel/compat_linux.c build-2.6/arch/s390/kernel/compat_linux.c
--- 2.6/arch/s390/kernel/compat_linux.c	2004-02-23 20:37:05.000000000 +0100
+++ build-2.6/arch/s390/kernel/compat_linux.c	2004-02-23 20:55:06.000000000 +0100
@@ -721,7 +721,7 @@

 	if (version == 1)
 		goto out;
-	err = sys_shmat (first, uptr, second, &raddr);
+	err = do_shmat (first, uptr, second, &raddr);
 	if (err)
 		goto out;
 	err = put_user (raddr, uaddr);
diff -ur 2.6/arch/s390/kernel/sys_s390.c build-2.6/arch/s390/kernel/sys_s390.c
--- 2.6/arch/s390/kernel/sys_s390.c	2004-02-23 20:23:31.000000000 +0100
+++ build-2.6/arch/s390/kernel/sys_s390.c	2004-02-23 20:55:02.000000000 +0100
@@ -225,7 +225,7 @@

 	case SHMAT: {
 		ulong raddr;
-		ret = sys_shmat (first, (char *) ptr, second, &raddr);
+		ret = do_shmat (first, (char *) ptr, second, &raddr);
 		if (ret)
 			return ret;
 		return put_user (raddr, (ulong *) third);
diff -ur 2.6/arch/sh/kernel/sys_sh.c build-2.6/arch/sh/kernel/sys_sh.c
--- 2.6/arch/sh/kernel/sys_sh.c	2004-02-23 20:23:31.000000000 +0100
+++ build-2.6/arch/sh/kernel/sys_sh.c	2004-02-23 20:43:44.000000000 +0100
@@ -200,7 +200,7 @@
 			switch (version) {
 			default: {
 				ulong raddr;
-				ret = sys_shmat (first, (char __user *) ptr,
+				ret = do_shmat (first, (char __user *) ptr,
 						 second, &raddr);
 				if (ret)
 					return ret;
@@ -209,7 +209,7 @@
 			case 1:	/* iBCS2 emulator entry point */
 				if (!segment_eq(get_fs(), get_ds()))
 					return -EINVAL;
-				return sys_shmat (first, (char __user *) ptr,
+				return do_shmat (first, (char __user *) ptr,
 						  second, (ulong *) third);
 			}
 		case SHMDT:
diff -ur 2.6/arch/sparc/kernel/sys_sparc.c build-2.6/arch/sparc/kernel/sys_sparc.c
--- 2.6/arch/sparc/kernel/sys_sparc.c	2004-01-09 07:59:26.000000000 +0100
+++ build-2.6/arch/sparc/kernel/sys_sparc.c	2004-02-23 20:39:03.000000000 +0100
@@ -185,7 +185,7 @@
 			switch (version) {
 			case 0: default: {
 				ulong raddr;
-				err = sys_shmat (first, (char __user *) ptr, second, &raddr);
+				err = do_shmat (first, (char __user *) ptr, second, &raddr);
 				if (err)
 					goto out;
 				err = -EFAULT;
@@ -195,7 +195,7 @@
 				goto out;
 				}
 			case 1:	/* iBCS2 emulator entry point */
-				err = sys_shmat (first, (char __user *) ptr, second, (ulong __user *) third);
+				err = do_shmat (first, (char __user *) ptr, second, (ulong __user *) third);
 				goto out;
 			}
 		case SHMDT:
diff -ur 2.6/arch/sparc/kernel/sys_sunos.c build-2.6/arch/sparc/kernel/sys_sunos.c
--- 2.6/arch/sparc/kernel/sys_sunos.c	2004-01-09 07:59:26.000000000 +0100
+++ build-2.6/arch/sparc/kernel/sys_sunos.c	2004-02-23 20:39:21.000000000 +0100
@@ -1006,8 +1006,8 @@

 	switch(op) {
 	case 0:
-		/* sys_shmat(): attach a shared memory area */
-		rval = sys_shmat((int)arg1,(char *)arg2,(int)arg3,&raddr);
+		/* do_shmat(): attach a shared memory area */
+		rval = do_shmat((int)arg1,(char *)arg2,(int)arg3,&raddr);
 		if(!rval)
 			rval = (int) raddr;
 		break;
diff -ur 2.6/arch/sparc64/kernel/sys_sparc32.c build-2.6/arch/sparc64/kernel/sys_sparc32.c
--- 2.6/arch/sparc64/kernel/sys_sparc32.c	2004-02-23 20:37:06.000000000 +0100
+++ build-2.6/arch/sparc64/kernel/sys_sparc32.c	2004-02-23 20:40:35.000000000 +0100
@@ -642,7 +642,7 @@

 	if (version == 1)
 		goto out;
-	err = sys_shmat (first, uptr, second, &raddr);
+	err = do_shmat (first, uptr, second, &raddr);
 	if (err)
 		goto out;
 	err = put_user (raddr, uaddr);
diff -ur 2.6/arch/sparc64/kernel/sys_sparc.c build-2.6/arch/sparc64/kernel/sys_sparc.c
--- 2.6/arch/sparc64/kernel/sys_sparc.c	2004-01-09 07:59:43.000000000 +0100
+++ build-2.6/arch/sparc64/kernel/sys_sparc.c	2004-02-23 20:40:04.000000000 +0100
@@ -254,7 +254,7 @@
 		switch (call) {
 		case SHMAT: {
 			ulong raddr;
-			err = sys_shmat (first, (char *) ptr, second, &raddr);
+			err = do_shmat (first, (char *) ptr, second, &raddr);
 			if (!err) {
 				if (put_user(raddr, (ulong __user *) third))
 					err = -EFAULT;
diff -ur 2.6/arch/sparc64/kernel/sys_sunos32.c build-2.6/arch/sparc64/kernel/sys_sunos32.c
--- 2.6/arch/sparc64/kernel/sys_sunos32.c	2004-01-09 07:59:45.000000000 +0100
+++ build-2.6/arch/sparc64/kernel/sys_sunos32.c	2004-02-23 20:40:22.000000000 +0100
@@ -1139,8 +1139,8 @@

 	switch(op) {
 	case 0:
-		/* sys_shmat(): attach a shared memory area */
-		rval = sys_shmat((int)arg1,(char *)A(arg2),(int)arg3,&raddr);
+		/* do_shmat(): attach a shared memory area */
+		rval = do_shmat((int)arg1,(char *)A(arg2),(int)arg3,&raddr);
 		if(!rval)
 			rval = (int) raddr;
 		break;
diff -ur 2.6/arch/um/kernel/syscall_kern.c build-2.6/arch/um/kernel/syscall_kern.c
--- 2.6/arch/um/kernel/syscall_kern.c	2004-01-09 07:59:47.000000000 +0100
+++ build-2.6/arch/um/kernel/syscall_kern.c	2004-02-23 20:41:07.000000000 +0100
@@ -235,7 +235,7 @@
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = sys_shmat (first, (char *) ptr, second, &raddr);
+			ret = do_shmat (first, (char *) ptr, second, &raddr);
 			if (ret)
 				return ret;
 			return put_user (raddr, (ulong *) third);
@@ -243,7 +243,7 @@
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
-			return sys_shmat (first, (char *) ptr, second, (ulong *) third);
+			return do_shmat (first, (char *) ptr, second, (ulong *) third);
 		}
 	case SHMDT:
 		return sys_shmdt ((char *)ptr);
diff -ur 2.6/arch/v850/kernel/syscalls.c build-2.6/arch/v850/kernel/syscalls.c
--- 2.6/arch/v850/kernel/syscalls.c	2004-01-09 07:59:45.000000000 +0100
+++ build-2.6/arch/v850/kernel/syscalls.c	2004-02-23 20:54:38.000000000 +0100
@@ -106,7 +106,7 @@
 			if ((ret = verify_area(VERIFY_WRITE, (ulong*) third,
 					       sizeof(ulong))))
 				break;
-			ret = sys_shmat (first, (char *) ptr, second, &raddr);
+			ret = do_shmat (first, (char *) ptr, second, &raddr);
 			if (ret)
 				break;
 			ret = put_user (raddr, (ulong *) third);
@@ -115,7 +115,7 @@
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				break;
-			ret = sys_shmat (first, (char *) ptr, second,
+			ret = do_shmat (first, (char *) ptr, second,
 					 (ulong *) third);
 			break;
 		}
diff -ur 2.6/arch/x86_64/ia32/ipc32.c build-2.6/arch/x86_64/ia32/ipc32.c
--- 2.6/arch/x86_64/ia32/ipc32.c	2004-01-09 07:59:27.000000000 +0100
+++ build-2.6/arch/x86_64/ia32/ipc32.c	2004-02-23 20:54:55.000000000 +0100
@@ -457,7 +457,7 @@

 	if (version == 1)
 		return -EINVAL;	/* iBCS2 emulator entry point: unsupported */
-	err = sys_shmat(first, uptr, second, &raddr);
+	err = do_shmat(first, uptr, second, &raddr);
 	if (err)
 		return err;
 	return put_user(raddr, uaddr);
diff -ur 2.6/arch/x86_64/kernel/sys_x86_64.c build-2.6/arch/x86_64/kernel/sys_x86_64.c
--- 2.6/arch/x86_64/kernel/sys_x86_64.c	2004-02-23 20:24:17.000000000 +0100
+++ build-2.6/arch/x86_64/kernel/sys_x86_64.c	2004-02-23 20:54:48.000000000 +0100
@@ -155,7 +155,7 @@
 asmlinkage long wrap_sys_shmat(int shmid, char *shmaddr, int shmflg)
 {
 	unsigned long raddr;
-	return sys_shmat(shmid,shmaddr,shmflg,&raddr) ?: (long)raddr;
+	return do_shmat(shmid,shmaddr,shmflg,&raddr) ?: (long)raddr;
 }

 asmlinkage long sys_time64(long * tloc)
diff -ur 2.6/include/linux/shm.h build-2.6/include/linux/shm.h
--- 2.6/include/linux/shm.h	2004-01-09 07:59:48.000000000 +0100
+++ build-2.6/include/linux/shm.h	2004-02-23 20:56:01.000000000 +0100
@@ -90,7 +90,14 @@
 #define SHM_LOCKED      02000   /* segment will not be swapped */
 #define SHM_HUGETLB     04000   /* segment will use huge TLB pages */

-long sys_shmat (int shmid, char __user *shmaddr, int shmflg, unsigned long *addr);
+#ifdef CONFIG_SYSVIPC
+long do_shmat (int shmid, char __user *shmaddr, int shmflg, unsigned long *addr);
+#else
+inline long do_shmat (int shmid, char __user *shmaddr, int shmflg, unsigned long *addr)
+{
+	return -ENOSYS;
+}
+#endif
 asmlinkage long sys_shmget (key_t key, size_t size, int flag);
 asmlinkage long sys_shmdt (char __user *shmaddr);
 asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds __user *buf);
Only in build-2.6/ipc: .Makefile.swp
diff -ur 2.6/ipc/shm.c build-2.6/ipc/shm.c
--- 2.6/ipc/shm.c	2004-02-23 20:37:26.000000000 +0100
+++ build-2.6/ipc/shm.c	2004-02-23 20:38:09.000000000 +0100
@@ -635,7 +635,7 @@
  * "raddr" thing points to kernel space, and there has to be a wrapper around
  * this.
  */
-asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
+long do_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
 {
 	struct shmid_kernel *shp;
 	unsigned long addr;
diff -ur 2.6/kernel/sys.c build-2.6/kernel/sys.c
--- 2.6/kernel/sys.c	2004-02-23 20:37:27.000000000 +0100
+++ build-2.6/kernel/sys.c	2004-02-23 20:46:54.000000000 +0100
@@ -258,7 +258,6 @@
 cond_syscall(sys_msgrcv)
 cond_syscall(sys_msgctl)
 cond_syscall(sys_shmget)
-cond_syscall(sys_shmat)
 cond_syscall(sys_shmdt)
 cond_syscall(sys_shmctl)


