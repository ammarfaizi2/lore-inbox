Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTGASbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTGASbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:31:44 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:58038 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S263258AbTGASbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:31:31 -0400
Date: Tue, 1 Jul 2003 20:44:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/6): semtimedop.
Message-ID: <20030701184447.GB12212@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix SEMTIMEDOP operation in sys_ipc. Patch by Ernie Petrides.

diffstat:
 arch/s390/kernel/compat_linux.c |   67 ++++++++++++++++++++++++++++++++++------
 arch/s390/kernel/sys_s390.c     |    7 +---
 2 files changed, 61 insertions(+), 13 deletions(-)

diff -urN linux-2.5/arch/s390/kernel/compat_linux.c linux-2.5-s390/arch/s390/kernel/compat_linux.c
--- linux-2.5/arch/s390/kernel/compat_linux.c	Tue Jul  1 20:48:08 2003
+++ linux-2.5-s390/arch/s390/kernel/compat_linux.c	Tue Jul  1 20:48:24 2003
@@ -373,12 +373,45 @@
 	unsigned int		__unused5;
 };
 
-                                                        
-/*
- * sys32_ipc() is the de-multiplexer for the SysV IPC calls in 32bit emulation..
- *
- * This is really horribly ugly.
- */
+extern int sem_ctls[];
+#define sc_semopm	(sem_ctls[2])
+#define SEMOPM_FAST	64  /* ~ 372 bytes on stack */
+
+static long
+do_sys32_semtimedop (int semid, struct sembuf *tsops, int nsops,
+		     struct compat_timespec *timeout32)
+{
+	struct sembuf *sops, fast_sops[SEMOPM_FAST];
+	struct timespec t;
+	mm_segment_t oldfs;
+	long ret;
+
+	/* parameter checking precedence should mirror sys_semtimedop() */
+	if (nsops < 1 || semid < 0)
+		return -EINVAL;
+	if (nsops > sc_semopm)
+		return -E2BIG;
+	if (nsops <= SEMOPM_FAST)
+		sops = fast_sops;
+	else {
+		sops = kmalloc(nsops * sizeof(*sops), GFP_KERNEL);
+		if (sops == NULL)
+			return -ENOMEM;
+	}
+	if (copy_from_user(sops, tsops, nsops * sizeof(*tsops)) ||
+	    get_compat_timespec(&t, timeout32))
+		ret = -EFAULT;
+	else {
+		oldfs = get_fs();
+		set_fs(KERNEL_DS);
+		ret = sys_semtimedop(semid, sops, nsops, &t);
+		set_fs(oldfs);
+	}
+	if (sops != fast_sops)
+		kfree(sops);
+	return ret;
+}
+
 #define IPCOP_MASK(__x)	(1UL << (__x))
 static int do_sys32_semctl(int first, int second, int third, void *uptr)
 {
@@ -763,7 +796,12 @@
 	return err;
 }
 
-asmlinkage int sys32_ipc (u32 call, int first, int second, int third, u32 ptr, u32 fifth)
+/*
+ * sys32_ipc() is the de-multiplexer for the SysV IPC calls in 32bit emulation.
+ *
+ * This is really horribly ugly.
+ */
+asmlinkage int sys32_ipc (u32 call, int first, int second, int third, u32 ptr)
 {
 	int version, err;
 
@@ -773,11 +811,22 @@
 	if(version)
 		return -EINVAL;
 
-	if (call <= SEMCTL)
+	if (call <= SEMTIMEDOP)
 		switch (call) {
+		case SEMTIMEDOP:
+			if (third) {
+				err = do_sys32_semtimedop(first,
+					(struct sembuf *)AA(ptr),
+					second,
+					(struct compat_timespec *)
+						AA((u32)third));
+				goto out;
+			}
+			/* else fall through for normal semop() */
 		case SEMOP:
 			/* struct sembuf is the same on 32 and 64bit :)) */
-			err = sys_semop (first, (struct sembuf *)AA(ptr), second);
+			err = sys_semtimedop (first, (struct sembuf *)AA(ptr),
+					      second, NULL);
 			goto out;
 		case SEMGET:
 			err = sys_semget (first, second, third);
diff -urN linux-2.5/arch/s390/kernel/sys_s390.c linux-2.5-s390/arch/s390/kernel/sys_s390.c
--- linux-2.5/arch/s390/kernel/sys_s390.c	Sun Jun 22 20:32:42 2003
+++ linux-2.5-s390/arch/s390/kernel/sys_s390.c	Tue Jul  1 20:48:24 2003
@@ -184,8 +184,7 @@
  * This is really horribly ugly.
  */
 asmlinkage __SYS_RETTYPE sys_ipc (uint call, int first, int second, 
-				  unsigned long third, void *ptr,
-				  unsigned long fifth)
+				  unsigned long third, void *ptr)
 {
         struct ipc_kludge tmp;
 	int ret;
@@ -195,8 +194,8 @@
 		return sys_semtimedop (first, (struct sembuf *) ptr, second,
 				       NULL);
 	case SEMTIMEDOP:
-		return sys_semtimedop(first, (struct sembuf *) ptr, second,
-				      (const struct timespec *) fifth);
+		return sys_semtimedop (first, (struct sembuf *) ptr, second,
+				       (const struct timespec *) third);
         case SEMGET:
                 return sys_semget (first, second, third);
         case SEMCTL: {
