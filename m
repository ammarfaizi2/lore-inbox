Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTEEXbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTEEXbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:31:34 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:57381 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261506AbTEEXbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:31:31 -0400
Message-Id: <200305052344.h45NiqEG015482@pasta.boston.redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.69 problem with semtimedop() on s390 architecture
Date: Mon, 05 May 2003 19:44:52 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Martin.  It's been discovered that semtimedop() doesn't work for
the s390 architecture because there is no parameter "fifth" passed from
assembly language to the kernel C functions sys_ipc() and sys32_ipc(),
which I understand is due to only 5 regs (r2-r6) being committed to
function parameters (and "fifth" is actually the 6th parameter).

Since the parameter "third" (in r5) is available for use in handling
the SEMTIMEDOP case of "call" (in r2), would it be appropriate to use
that for the "timeout" parameter of the new semtimedop() system call?

It is declared as (unsigned long) in sys_ipc(), and as (int) in the
31-bit-compatibility mode handler sys32_ipc(), so it seems suitable
to hold a user-mode pointer in both cases.

Please let us know your decision on this semtimedop() system call
interface issue so that the appropriate s390 glibc wrapper can be
implemented.  If you decide to adopt the suggestion above, please
feel free to utilize the patch below, which fixes the native handling
in sys_s390.c and implements the compat-mode stuff in compat_linux.c.

(Note that the successful building with CONFIG_S390_SUPPORT and
CONFIG_COMPAT enabled requires a definition for __kernel_old_dev_t
to be added in include/asm-s390/posix_types.h, and probably some
s390 driver build fixes as well.)

Cheers.  -ernie



--- linux-2.5.69/arch/s390/kernel/compat_linux.c.orig	2003-05-04 19:53:37.000000000 -0400
+++ linux-2.5.69/arch/s390/kernel/compat_linux.c	2003-05-05 17:43:16.000000000 -0400
@@ -379,6 +379,34 @@ struct shmid64_ds32 {
  *
  * This is really horribly ugly.
  */
+
+extern int sem_ctls[];
+#define sc_semopm	(sem_ctls[2])
+
+static long
+do_sys32_semtimedop(int semid, struct sembuf *tsops, int nsops,
+	     struct compat_timespec *timeout32)
+{
+	struct timespec t;
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
+		return -EFAULT;
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_semtimedop(semid, tsops, nsops, &t);
+	set_fs(oldfs);
+	return ret;
+}
+
 #define IPCOP_MASK(__x)	(1UL << (__x))
 static int do_sys32_semctl(int first, int second, int third, void *uptr)
 {
@@ -763,7 +791,7 @@ out:
 	return err;
 }
 
-asmlinkage int sys32_ipc (u32 call, int first, int second, int third, u32 ptr, u32 fifth)
+asmlinkage int sys32_ipc(u32 call, int first, int second, int third, u32 ptr)
 {
 	int version, err;
 
@@ -775,9 +803,18 @@ asmlinkage int sys32_ipc (u32 call, int 
 
 	if (call <= SEMCTL)
 		switch (call) {
+		case SEMTIMEDOP:
+			if (third) {
+				err = do_sys32_semtimedop(first,
+					(struct sembuf *)AA(ptr), second,
+					(struct compat_timespec *)A(third));
+				goto out;
+			}
+			/* else fall through for normal semop() */
 		case SEMOP:
 			/* struct sembuf is the same on 32 and 64bit :)) */
-			err = sys_semop (first, (struct sembuf *)AA(ptr), second);
+			err = sys_semtimedop(first, (struct sembuf *)AA(ptr),
+					     second, NULL);
 			goto out;
 		case SEMGET:
 			err = sys_semget (first, second, third);
--- linux-2.5.69/arch/s390/kernel/sys_s390.c.orig	2003-05-04 19:53:13.000000000 -0400
+++ linux-2.5.69/arch/s390/kernel/sys_s390.c	2003-05-05 17:24:23.000000000 -0400
@@ -183,20 +183,19 @@ arch_get_unmapped_area(struct file *filp
  *
  * This is really horribly ugly.
  */
-asmlinkage __SYS_RETTYPE sys_ipc (uint call, int first, int second, 
-				  unsigned long third, void *ptr,
-				  unsigned long fifth)
+asmlinkage __SYS_RETTYPE sys_ipc(uint call, int first, int second, 
+				 unsigned long third, void *ptr)
 {
         struct ipc_kludge tmp;
 	int ret;
 
         switch (call) {
         case SEMOP:
-		return sys_semtimedop (first, (struct sembuf *) ptr, second,
-				       NULL);
+		return sys_semtimedop(first, (struct sembuf *)ptr, second,
+				      NULL);
 	case SEMTIMEDOP:
-		return sys_semtimedop(first, (struct sembuf *) ptr, second,
-				      (const struct timespec *) fifth);
+		return sys_semtimedop(first, (struct sembuf *)ptr, second,
+				      (const struct timespec *)third);
         case SEMGET:
                 return sys_semget (first, second, third);
         case SEMCTL: {
