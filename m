Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTD1F37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 01:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTD1F37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 01:29:59 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:54496 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263467AbTD1F35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 01:29:57 -0400
Message-Id: <200304280546.h3S5kWBq028443@pasta.boston.redhat.com>
To: David Mosberger-Tang <davidm@hpl.hp.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.68 fixes for semtimedop() ia32-compat handling on ia64
Date: Mon, 28 Apr 2003 01:46:32 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David.  Here are two fixes for the ia32-compatibility mode handling
for the new semtimedop() system call for the ia64 architecture.

The first problem was that treatment of user-mode calls to semtimedop()
with a NULL 4th (struct timespec *) parameter was inconsistent with the
behavior of the same executable on i386 and also with a natively compiled
ia64 binary.  A NULL 4th arg to semtimedop() should result in no timeout
being used (like a straight semop() call) rather than in an EFAULT error.

The second problem was that a legitimate semtimedop() with a timeout was
also resulting in an EFAULT because the fetch of the internal timespec
strucure by sys_semtimedop() from semtimedop32()'s kernel stack was
treated as an invalid user-data reference.  This requires temporarily
switching the addressing limit with set_fs(), further requiring that
appropriate parameter checking by performed prior to the switch.

The const qualifier was removed from the (struct compat_timespec *) arg
to semtimedop32() so that the call to get_compat_timespec() wouldn't
generate a compilation warning.

Cheers.  -ernie



diff -urpN linux-2.5.68/arch/ia64/ia32/sys_ia32.c{.orig,}
--- linux-2.5.68/arch/ia64/ia32/sys_ia32.c.orig	2003-04-19 22:50:02.000000000 -0400
+++ linux-2.5.68/arch/ia64/ia32/sys_ia32.c	2003-04-28 01:12:41.000000000 -0400
@@ -1648,19 +1648,35 @@ shmctl32 (int first, int second, void *u
 	return err;
 }
 
+extern int sem_ctls[];
+#define sc_semopm	(sem_ctls[2])
+
 static long
-semtimedop32(int semid, struct sembuf *tsems, int nsems,
-	     const struct compat_timespec *timeout32)
+semtimedop32(int semid, struct sembuf *tsops, int nsops,
+	     struct compat_timespec *timeout32)
 {
 	struct timespec t;
-	if (get_user (t.tv_sec, &timeout32->tv_sec) ||
-	    get_user (t.tv_nsec, &timeout32->tv_nsec))
+	mm_segment_t oldfs;
+	long ret;
+
+	/* parameter checking precedence should mirror sys_semtimedop() */
+	if (nsops < 1 || semid < 0)
+		return -EINVAL;
+	if (nsops > sc_semopm)
+		return -E2BIG;
+	if (!access_ok(VERIFY_READ, tsops, nsops * sizeof(struct sembuf)) ||
+	    get_compat_timespec(&t, timeout32))
 		return -EFAULT;
-	return sys_semtimedop(semid, tsems, nsems, &t);
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_semtimedop(semid, tsops, nsops, &t);
+	set_fs(oldfs);
+	return ret;
 }
 
 asmlinkage long
-sys32_ipc (u32 call, int first, int second, int third, u32 ptr, u32 fifth)
+sys32_ipc(u32 call, int first, int second, int third, u32 ptr, u32 fifth)
 {
 	int version;
 
@@ -1668,12 +1684,15 @@ sys32_ipc (u32 call, int first, int seco
 	call &= 0xffff;
 
 	switch (call) {
+	      case SEMTIMEDOP:
+		if (fifth)
+			return semtimedop32(first, (struct sembuf *)AA(ptr),
+				second, (struct compat_timespec *)AA(fifth));
+		/* else fall through for normal semop() */
 	      case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		return sys_semtimedop(first, (struct sembuf *)AA(ptr), second, NULL);
-	      case SEMTIMEDOP:
-		return semtimedop32(first, (struct sembuf *)AA(ptr), second,
-				    (const struct compat_timespec *)AA(fifth));
+		return sys_semtimedop(first, (struct sembuf *)AA(ptr), second,
+				      NULL);
 	      case SEMGET:
 		return sys_semget(first, second, third);
 	      case SEMCTL:
