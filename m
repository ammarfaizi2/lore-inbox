Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUDUOqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUDUOqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUDUOqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:46:45 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:23450 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263032AbUDUOqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:46:03 -0400
Date: Wed, 21 Apr 2004 16:45:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/9): core s390.
Message-ID: <20040421144549.GB2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core s390.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Fix race in do_call_softirq in regard to kernel preemption.
 - Fix typo in compat mq system call wrappers.
 - Add s390 to Kconfig for AUDITSYSCALL.
 - Redefine TASK_SIZE to TASK31_SIZE for compilation of binfmt_elf32.
 - Use correct error value for sys32_ipc when called with an invalid number.
 - New default configuration.

diffstat:
 arch/s390/defconfig               |   46 ++++++++-----------
 arch/s390/kernel/binfmt_elf32.c   |    2 
 arch/s390/kernel/compat_linux.c   |   88 +++++++++++++++-----------------------
 arch/s390/kernel/compat_wrapper.S |    2 
 arch/s390/kernel/entry.S          |    6 +-
 arch/s390/kernel/entry64.S        |    6 +-
 init/Kconfig                      |    2 
 7 files changed, 66 insertions(+), 86 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Wed Apr 21 16:29:15 2004
+++ linux-2.6-s390/arch/s390/defconfig	Wed Apr 21 16:29:35 2004
@@ -18,8 +18,10 @@
 #
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_HOTPLUG=y
 CONFIG_IKCONFIG=y
@@ -31,6 +33,7 @@
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
@@ -231,8 +234,6 @@
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
 # CONFIG_IPV6_TUNNEL is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
 # CONFIG_NETFILTER is not set
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
@@ -242,7 +243,9 @@
 #
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
@@ -286,6 +289,11 @@
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 CONFIG_BONDING=m
@@ -305,20 +313,16 @@
 #
 # Ethernet (10000 Mbit)
 #
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Token Ring devices
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_TR is not set
 
 #
-# Token Ring devices
+# Wireless LAN (non-hamradio)
 #
-# CONFIG_TR is not set
-# CONFIG_SHAPER is not set
-# CONFIG_NETCONSOLE is not set
+# CONFIG_NET_RADIO is not set
 
 #
 # Wan interfaces
@@ -341,23 +345,10 @@
 # CONFIG_QETH_IPV6 is not set
 # CONFIG_QETH_PERF_STATS is not set
 CONFIG_CCWGROUP=y
-
-#
-# Amateur Radio support
-#
-# CONFIG_HAMRADIO is not set
-
-#
-# IrDA (infrared) support
-#
-# CONFIG_IRDA is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # File systems
@@ -397,6 +388,7 @@
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
 # CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
diff -urN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	Wed Apr 21 16:29:15 2004
+++ linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c	Wed Apr 21 16:29:35 2004
@@ -33,6 +33,8 @@
 #define NUM_ACRS      16    
 
 #define TASK31_SIZE		(0x80000000UL)
+#undef TASK_SIZE
+#define TASK_SIZE TASK31_SIZE
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Sun Apr  4 05:37:42 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Wed Apr 21 16:29:35 2004
@@ -297,64 +297,46 @@
  */
 asmlinkage long sys32_ipc(u32 call, int first, int second, int third, u32 ptr)
 {
-	if(call >> 16) /* hack for backward compatibility */
+	if (call >> 16)		/* hack for backward compatibility */
 		return -EINVAL;
 
 	call &= 0xffff;
 
-	if (call <= SEMTIMEDOP)
-		switch (call) {
-		case SEMTIMEDOP:
-			if (third)
-				return compat_sys_semtimedop(first,
-						compat_ptr(ptr), second,
-						compat_ptr(third));
-			/* else fall through for normal semop() */
-		case SEMOP:
-			/* struct sembuf is the same on 32 and 64bit :)) */
-			return sys_semtimedop (first, compat_ptr(ptr),
-					      second, NULL);
-		case SEMGET:
-			return sys_semget (first, second, third);
-		case SEMCTL:
-			return compat_sys_semctl (first, second, third,
-						 compat_ptr(ptr));
-		default:
-			return -EINVAL;
-		};
-	if (call <= MSGCTL) 
-		switch (call) {
-		case MSGSND:
-			return compat_sys_msgsnd (first, second, third,
-						compat_ptr(ptr));
-		case MSGRCV:
-			return compat_sys_msgrcv (first, second, 0, third,
-					       0, compat_ptr(ptr));
-		case MSGGET:
-			return sys_msgget ((key_t) first, second);
-		case MSGCTL:
-			return compat_sys_msgctl (first, second,
-						compat_ptr(ptr));
-		default:
-			return -EINVAL;
-		}
-	if (call <= SHMCTL) 
-		switch (call) {
-		case SHMAT:
-			return compat_sys_shmat (first, second, third,
-						0, compat_ptr(ptr));
-		case SHMDT: 
-			return sys_shmdt(compat_ptr(ptr));
-		case SHMGET:
-			return sys_shmget(first, second, third);
-		case SHMCTL:
-			return compat_sys_shmctl(first, second,
-						compat_ptr(ptr));
-		default:
-			return -EINVAL;
-		}
+	switch (call) {
+	case SEMTIMEDOP:
+		return compat_sys_semtimedop(first, compat_ptr(ptr),
+					     second, compat_ptr(third));
+	case SEMOP:
+		/* struct sembuf is the same on 32 and 64bit :)) */
+		return sys_semtimedop(first, compat_ptr(ptr),
+				      second, NULL);
+	case SEMGET:
+		return sys_semget(first, second, third);
+	case SEMCTL:
+		return compat_sys_semctl(first, second, third,
+					 compat_ptr(ptr));
+	case MSGSND:
+		return compat_sys_msgsnd(first, second, third,
+					 compat_ptr(ptr));
+	case MSGRCV:
+		return compat_sys_msgrcv(first, second, 0, third,
+					 0, compat_ptr(ptr));
+	case MSGGET:
+		return sys_msgget((key_t) first, second);
+	case MSGCTL:
+		return compat_sys_msgctl(first, second, compat_ptr(ptr));
+	case SHMAT:
+		return compat_sys_shmat(first, second, third,
+					0, compat_ptr(ptr));
+	case SHMDT:
+		return sys_shmdt(compat_ptr(ptr));
+	case SHMGET:
+		return sys_shmget(first, second, third);
+	case SHMCTL:
+		return compat_sys_shmctl(first, second, compat_ptr(ptr));
+	}
 
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 asmlinkage long sys32_truncate64(const char * path, unsigned long high, unsigned long low)
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-s390/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	Wed Apr 21 16:29:15 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_wrapper.S	Wed Apr 21 16:29:35 2004
@@ -1361,7 +1361,7 @@
 	llgtr	%r5,%r5			# struct compat_mq_attr *
 	jg	compat_sys_mq_open
 
-	.globl	sys_mq_unlink_wrapper
+	.globl	sys32_mq_unlink_wrapper
 sys32_mq_unlink_wrapper:
 	llgtr	%r2,%r2			# const char *
 	jg	sys_mq_unlink
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Wed Apr 21 16:29:15 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Wed Apr 21 16:29:35 2004
@@ -198,7 +198,8 @@
  */
 	.global do_call_softirq
 do_call_softirq:
-	stm	%r12,%r15,24(%r15)
+	stnsm	24(%r15),0xfc
+	stm	%r12,%r15,28(%r15)
 	lr	%r12,%r15
         basr    %r13,0
 do_call_base:
@@ -211,7 +212,8 @@
         st	%r12,0(%r15)	# store backchain
 	l	%r1,.Ldo_softirq-do_call_base(%r13)
 	basr	%r14,%r1
-	lm	%r12,%r15,24(%r12)
+	lm	%r12,%r15,28(%r12)
+	ssm	24(%r15)
 	br	%r14
 	
 __critical_start:
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Wed Apr 21 16:29:15 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Wed Apr 21 16:29:35 2004
@@ -186,7 +186,8 @@
  */
 	.global do_call_softirq
 do_call_softirq:
-	stmg	%r12,%r15,48(%r15)
+	stnsm	48(%r15),0xfc
+	stmg	%r12,%r15,56(%r15)
 	lgr	%r12,%r15
 	lg	%r0,__LC_ASYNC_STACK
 	slgr    %r0,%r15
@@ -196,7 +197,8 @@
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	stg	%r12,0(%r15)		# store back chain
 	brasl	%r14,do_softirq
-	lmg	%r12,%r15,48(%r12)
+	lmg	%r12,%r15,56(%r12)
+	ssm	48(%r15)
 	br	%r14
 
 __critical_start:
diff -urN linux-2.6/init/Kconfig linux-2.6-s390/init/Kconfig
--- linux-2.6/init/Kconfig	Wed Apr 21 16:29:19 2004
+++ linux-2.6-s390/init/Kconfig	Wed Apr 21 16:29:35 2004
@@ -149,7 +149,7 @@
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC64)
+	depends on AUDIT && (X86 || PPC64 || ARCH_S390)
 	default y if SECURITY_SELINUX
 	default n
 	help
