Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318114AbSGWPvp>; Tue, 23 Jul 2002 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSGWPvo>; Tue, 23 Jul 2002 11:51:44 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:49865 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S318114AbSGWPvl>; Tue, 23 Jul 2002 11:51:41 -0400
Message-Id: <200207231554.g6NFsgW107212@d06relay02.portsmouth.uk.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] 2.5.27: s390 fixes.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Mail-Copies-To: arndb@de.ibm.com
Date: Tue, 23 Jul 2002 19:48:09 +0200
References: <200207221950.45748.schwidefsky@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updated patch part 3/6:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.2 -> 1.683.1.3
#	include/asm-s390x/unistd.h	1.7     -> 1.8    
#	arch/s390/kernel/entry.S	1.14    -> 1.15   
#	arch/s390x/kernel/entry.S	1.13    -> 1.14   
#	arch/s390/kernel/ptrace.c	1.8     -> 1.9    
#	include/asm-s390/unistd.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/23	arnd@bergmann-dalldorf.de	1.683.1.3
# add sys_security system call
# --------------------------------------------
#
diff -Nru a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
--- a/arch/s390/kernel/entry.S	Tue Jul 23 18:53:45 2002
+++ b/arch/s390/kernel/entry.S	Tue Jul 23 18:53:45 2002
@@ -581,7 +581,8 @@
 	.long  sys_futex
 	.long  sys_sched_setaffinity
 	.long  sys_sched_getaffinity	 /* 240 */
-	.rept  255-240
+	.long  sys_security
+	.rept  255-241
 	.long  sys_ni_syscall
 	.endr
 
diff -Nru a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
--- a/arch/s390/kernel/ptrace.c	Tue Jul 23 18:53:45 2002
+++ b/arch/s390/kernel/ptrace.c	Tue Jul 23 18:53:45 2002
@@ -227,6 +227,9 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
+		ret = security_ops->ptrace(current->parent, current);
+		if (ret)
+			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
 		ret = 0;
diff -Nru a/arch/s390x/kernel/entry.S b/arch/s390x/kernel/entry.S
--- a/arch/s390x/kernel/entry.S	Tue Jul 23 18:53:45 2002
+++ b/arch/s390x/kernel/entry.S	Tue Jul 23 18:53:45 2002
@@ -612,7 +612,8 @@
 	.long  SYSCALL(sys_futex,sys32_futex_wrapper)
 	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper)
-        .rept  255-240
+	.long  SYSCALL(sys_security, sys_ni_syscall)
+        .rept  255-241
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.endr
 
diff -Nru a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
--- a/include/asm-s390/unistd.h	Tue Jul 23 18:53:45 2002
+++ b/include/asm-s390/unistd.h	Tue Jul 23 18:53:45 2002
@@ -231,6 +231,7 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
+#define __NR_security		241	/* syscall for security modules */
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
diff -Nru a/include/asm-s390x/unistd.h b/include/asm-s390x/unistd.h
--- a/include/asm-s390x/unistd.h	Tue Jul 23 18:53:45 2002
+++ b/include/asm-s390x/unistd.h	Tue Jul 23 18:53:45 2002
@@ -198,6 +198,7 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
+#define __NR_security		241	/* syscall for security modules */
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
