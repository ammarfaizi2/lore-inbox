Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTF0Oxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTF0OxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:53:00 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:9134 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S264465AbTF0Ovl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:51:41 -0400
Date: Fri, 27 Jun 2003 17:04:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (2/7): 31 bit compat.
Message-ID: <20030627150448.GC3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add missing includes to compat_ioctl.c.
- Fix 32 bit emulation of sys_settimeofday.

diffstat:
 arch/s390/kernel/compat_ioctl.c |    3 +++
 arch/s390/kernel/compat_linux.c |   21 +++++++++++++++++----
 include/asm-s390/compat.h       |    1 +
 3 files changed, 21 insertions(+), 4 deletions(-)

diff -urN linux-2.5/arch/s390/kernel/compat_ioctl.c linux-2.5-s390/arch/s390/kernel/compat_ioctl.c
--- linux-2.5/arch/s390/kernel/compat_ioctl.c	Sun Jun 22 20:32:58 2003
+++ linux-2.5-s390/arch/s390/kernel/compat_ioctl.c	Fri Jun 27 16:04:37 2003
@@ -42,12 +42,15 @@
 #include <linux/random.h>
 #include <linux/raw.h>
 #include <linux/route.h>
+#include <linux/rtc.h>
 #include <linux/vt.h>
 #include <linux/watchdog.h>
 
 #include <linux/auto_fs.h>
+#include <linux/auto_fs4.h>
 #include <linux/devfs_fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ncp_fs.h>
 #include <linux/smb_fs.h>
 
 #include <linux/if_bonding.h>
diff -urN linux-2.5/arch/s390/kernel/compat_linux.c linux-2.5-s390/arch/s390/kernel/compat_linux.c
--- linux-2.5/arch/s390/kernel/compat_linux.c	Sun Jun 22 20:33:08 2003
+++ linux-2.5-s390/arch/s390/kernel/compat_linux.c	Fri Jun 27 16:04:37 2003
@@ -2193,7 +2193,6 @@
    sorts of things, like timeval and itimerval.  */
 
 extern struct timezone sys_tz;
-extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
 asmlinkage int sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
@@ -2210,13 +2209,27 @@
 	return 0;
 }
 
+static inline long get_ts32(struct timespec *o, struct compat_timeval *i)
+{
+	long usec;
+
+	if (!access_ok(VERIFY_READ, i, sizeof(*i)))
+		return -EFAULT;
+	if (__get_user(o->tv_sec, &i->tv_sec))
+		return -EFAULT;
+	if (__get_user(usec, &i->tv_usec))
+		return -EFAULT;
+	o->tv_nsec = usec * 1000;
+	return 0;
+}
+
 asmlinkage int sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
-	struct timeval ktv;
+	struct timespec kts;
 	struct timezone ktz;
 
  	if (tv) {
-		if (get_tv32(&ktv, tv))
+		if (get_ts32(&kts, tv))
 			return -EFAULT;
 	}
 	if (tz) {
@@ -2224,7 +2237,7 @@
 			return -EFAULT;
 	}
 
-	return do_sys_settimeofday(tv ? &ktv : NULL, tz ? &ktz : NULL);
+	return do_sys_settimeofday(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
 
 asmlinkage int sys_utimes(char *, struct timeval *);
diff -urN linux-2.5/include/asm-s390/compat.h linux-2.5-s390/include/asm-s390/compat.h
--- linux-2.5/include/asm-s390/compat.h	Sun Jun 22 20:32:34 2003
+++ linux-2.5-s390/include/asm-s390/compat.h	Fri Jun 27 16:04:37 2003
@@ -94,6 +94,7 @@
 	s32		f_ffree;
 	compat_fsid_t	f_fsid;
 	s32		f_namelen;
+	s32		f_frsize;
 	s32		f_spare[6];
 };
 
