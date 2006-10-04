Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030743AbWJDR7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030743AbWJDR7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030746AbWJDR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:59:15 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:41973 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030740AbWJDR6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:58:51 -0400
Date: Wed, 4 Oct 2006 19:58:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Wire up sys_getcpu system call.
Message-ID: <20061004175852.GE26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Wire up sys_getcpu system call.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    7 +++++++
 arch/s390/kernel/syscalls.S       |    2 ++
 include/asm-s390/unistd.h         |    4 +++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2006-10-04 19:53:48.000000000 +0200
@@ -1658,3 +1658,10 @@ compat_sys_vmsplice_wrapper:
 	llgfr	%r4,%r4			# unsigned int
 	llgfr	%r5,%r5			# unsigned int
 	jg	compat_sys_vmsplice
+
+	.globl	sys_getcpu_wrapper
+sys_getcpu_wrapper:
+	llgtr	%r2,%r2			# unsigned *
+	llgtr	%r3,%r3			# unsigned *
+	llgtr	%r4,%r4			# struct getcpu_cache *
+	jg	sys_tee
diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2006-10-04 19:53:48.000000000 +0200
@@ -318,3 +318,5 @@ SYSCALL(sys_splice,sys_splice,sys_splice
 SYSCALL(sys_sync_file_range,sys_sync_file_range,sys_sync_file_range_wrapper)
 SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
+NI_SYSCALL							/* 310 sys_move_pages */
+SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2006-10-04 19:53:37.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/unistd.h	2006-10-04 19:53:48.000000000 +0200
@@ -247,8 +247,10 @@
 #define __NR_sync_file_range	307
 #define __NR_tee		308
 #define __NR_vmsplice		309
+/* Number 310 is reserved for new sys_move_pages */
+#define __NR_getcpu		311
 
-#define NR_syscalls 310
+#define NR_syscalls 312
 
 /* 
  * There are some system calls that are not present on 64 bit, some
