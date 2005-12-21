Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVLURbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVLURbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 12:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVLURbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 12:31:23 -0500
Received: from smtp.nextra.cz ([195.70.130.4]:18451 "EHLO smtp.nextra.cz")
	by vger.kernel.org with ESMTP id S1751142AbVLURbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 12:31:23 -0500
Message-ID: <43A9913D.4070004@nextra.cz>
Date: Wed, 21 Dec 2005 18:30:37 +0100
From: Zdenek Pavlas <pavlas@nextra.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
Cc: uclibc@uclibc.org, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] misc: Make *[ug]id16 support optional
References: <11.282480653@selenic.com> <20051116180140.GO31287@waste.org> <43A82764.8050305@nextra.cz> <200512201050.05278.rob@landley.net>
In-Reply-To: <200512201050.05278.rob@landley.net>
Content-Type: multipart/mixed;
 boundary="------------070304050203060504010703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070304050203060504010703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rob Landley wrote:

> They've been fixing that.  Working with linux-tiny is definitely something 
> uClibc is interested in.  When you say "patches like this", do you have a 
> complete list or is there something we could grep for?

I've made linux-tiny + uClibc + busybox to work with following patch.
Very lightly tested, not sure it's correct or complete, but at least
stuff like 'su', 'chown' etc started to work.

-- 
Zdenek Pavlas
Application Developer
NEXTRA Czech Republic s.r.o.  http://www.nextra.cz

--------------070304050203060504010703
Content-Type: text/plain;
 name="uClibc-no-ugid16.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uClibc-no-ugid16.patch"

--- uClibc-0.9.28/libc/sysdeps/linux/common/chown.c
+++ uclibc/libc/sysdeps/linux/common/chown.c
@@ -10,16 +10,11 @@
 #include "syscalls.h"
 #include <unistd.h>
 
-#define __NR___syscall_chown __NR_chown
+#define __NR___syscall_chown __NR_chown32
 static inline _syscall3(int, __syscall_chown, const char *, path,
 		__kernel_uid_t, owner, __kernel_gid_t, group);
 
 int chown(const char *path, uid_t owner, gid_t group)
 {
-	if (((owner + 1) > (uid_t) ((__kernel_uid_t) - 1U))
-		|| ((group + 1) > (gid_t) ((__kernel_gid_t) - 1U))) {
-		__set_errno(EINVAL);
-		return -1;
-	}
 	return (__syscall_chown(path, owner, group));
 }
--- uClibc-0.9.28/libc/sysdeps/linux/common/fchown.c
+++ uclibc/libc/sysdeps/linux/common/fchown.c
@@ -10,16 +10,11 @@
 #include "syscalls.h"
 #include <unistd.h>
 
-#define __NR___syscall_fchown __NR_fchown
+#define __NR___syscall_fchown __NR_fchown32
 static inline _syscall3(int, __syscall_fchown, int, fd,
 		__kernel_uid_t, owner, __kernel_gid_t, group);
 
 int fchown(int fd, uid_t owner, gid_t group)
 {
-	if (((owner + 1) > (uid_t) ((__kernel_uid_t) - 1U))
-		|| ((group + 1) > (gid_t) ((__kernel_gid_t) - 1U))) {
-		__set_errno(EINVAL);
-		return -1;
-	}
 	return (__syscall_fchown(fd, owner, group));
 }
--- uClibc-0.9.28/libc/sysdeps/linux/common/getegid.c
+++ uclibc/libc/sysdeps/linux/common/getegid.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 
 #ifdef	__NR_getegid
-#define __NR___syscall_getegid __NR_getegid
+#define __NR___syscall_getegid __NR_getegid32
 static inline _syscall0(int, __syscall_getegid);
 gid_t getegid(void)
 {
--- uClibc-0.9.28/libc/sysdeps/linux/common/geteuid.c
+++ uclibc/libc/sysdeps/linux/common/geteuid.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 
 #ifdef	__NR_geteuid
-#define __NR___syscall_geteuid __NR_geteuid
+#define __NR___syscall_geteuid __NR_geteuid32
 static inline _syscall0(int, __syscall_geteuid);
 uid_t geteuid(void)
 {
--- uClibc-0.9.28/libc/sysdeps/linux/common/getgid.c
+++ uclibc/libc/sysdeps/linux/common/getgid.c
@@ -10,7 +10,7 @@
 #include "syscalls.h"
 #include <unistd.h>
 
-#define __NR___syscall_getgid __NR_getgid
+#define __NR___syscall_getgid __NR_getgid32
 #if defined (__alpha__)
 #define __NR_getgid     __NR_getxgid
 #endif
--- uClibc-0.9.28/libc/sysdeps/linux/common/getuid.c
+++ uclibc/libc/sysdeps/linux/common/getuid.c
@@ -13,7 +13,7 @@
 #if defined (__alpha__)
 #define __NR_getuid     __NR_getxuid
 #endif
-#define __NR___syscall_getuid __NR_getuid
+#define __NR___syscall_getuid __NR_getuid32
 
 static inline _syscall0(int, __syscall_getuid);
 
--- uClibc-0.9.28/libc/sysdeps/linux/common/lchown.c
+++ uclibc/libc/sysdeps/linux/common/lchown.c
@@ -10,16 +10,11 @@
 #include "syscalls.h"
 #include <unistd.h>
 
-#define __NR___syscall_lchown __NR_lchown
+#define __NR___syscall_lchown __NR_lchown32
 static inline _syscall3(int, __syscall_lchown, const char *, path,
 		__kernel_uid_t, owner, __kernel_gid_t, group);
 
 int lchown(const char *path, uid_t owner, gid_t group)
 {
-	if (((owner + 1) > (uid_t) ((__kernel_uid_t) - 1U))
-		|| ((group + 1) > (gid_t) ((__kernel_gid_t) - 1U))) {
-		__set_errno(EINVAL);
-		return -1;
-	}
 	return __syscall_lchown(path, owner, group);
 }
--- uClibc-0.9.28/libc/sysdeps/linux/common/setegid.c
+++ uclibc/libc/sysdeps/linux/common/setegid.c
@@ -10,12 +10,6 @@
 {
     int result;
 
-    if (gid == (gid_t) ~0)
-    {
-	__set_errno (EINVAL);
-	return -1;
-    }
-
 #ifdef __NR_setresgid
     result = setresgid(-1, gid, -1);
     if (result == -1 && errno == ENOSYS)
--- uClibc-0.9.28/libc/sysdeps/linux/common/seteuid.c
+++ uclibc/libc/sysdeps/linux/common/seteuid.c
@@ -10,12 +10,6 @@
 {
     int result;
 
-    if (uid == (uid_t) ~0)
-    {
-	__set_errno (EINVAL);
-	return -1;
-    }
-
 #ifdef __NR_setresuid
     result = setresuid(-1, uid, -1);
     if (result == -1 && errno == ENOSYS)
--- uClibc-0.9.28/libc/sysdeps/linux/common/setgid.c
+++ uclibc/libc/sysdeps/linux/common/setgid.c
@@ -10,14 +10,10 @@
 #include "syscalls.h"
 #include <unistd.h>
 
-#define __NR___syscall_setgid __NR_setgid
+#define __NR___syscall_setgid __NR_setgid32
 static inline _syscall1(int, __syscall_setgid, __kernel_gid_t, gid);
 
 int setgid(gid_t gid)
 {
-	if (gid == (gid_t) ~ 0 || gid != (gid_t) ((__kernel_gid_t) gid)) {
-		__set_errno(EINVAL);
-		return -1;
-	}
 	return (__syscall_setgid(gid));
 }
--- uClibc-0.9.28/libc/sysdeps/linux/common/setgroups.c
+++ uclibc/libc/sysdeps/linux/common/setgroups.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 #include <grp.h>
 
-#define __NR___syscall_setgroups __NR_setgroups
+#define __NR___syscall_setgroups __NR_setgroups32
 static inline _syscall2(int, __syscall_setgroups,
 		size_t, size, const __kernel_gid_t *, list);
 
--- uClibc-0.9.28/libc/sysdeps/linux/common/setuid.c
+++ uclibc/libc/sysdeps/linux/common/setuid.c
@@ -10,14 +10,10 @@
 #include "syscalls.h"
 #include <unistd.h>
 
-#define __NR___syscall_setuid __NR_setuid
+#define __NR___syscall_setuid __NR_setuid32
 static inline _syscall1(int, __syscall_setuid, __kernel_uid_t, uid);
 
 int setuid(uid_t uid)
 {
-	if (uid == (uid_t) ~ 0 || uid != (uid_t) ((__kernel_uid_t) uid)) {
-		__set_errno(EINVAL);
-		return -1;
-	}
 	return (__syscall_setuid(uid));
 }

--------------070304050203060504010703--
