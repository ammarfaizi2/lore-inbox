Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbVCQO4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbVCQO4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVCQO4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:56:06 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12246 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S263078AbVCQOzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:55:48 -0500
Date: Thu, 17 Mar 2005 15:55:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/8] s390: system calls.
Message-ID: <20050317145559.GA4807@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/8] s390: system calls.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 system call fixes:
 - Add missing waitid and remap_file_pages system calls to s390.
 - Keep consistent naming scheme xxx_wrapper in compat_wrapper.S.
 - Remove #undef of __NR_getdents64 for 64 bit. The system call is
   present for 64 bit (linux_getdents and linux_getdents64 differ).

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_wrapper.S |   26 ++++++++++++++++++++++----
 arch/s390/kernel/syscalls.S       |    7 ++++---
 include/asm-s390/unistd.h         |    6 +++---
 3 files changed, 29 insertions(+), 10 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2005-03-17 15:35:47.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2005-03-17 15:35:57.000000000 +0100
@@ -1407,8 +1407,8 @@
 	llgtr	%r4,%r4			# struct compat_mq_attr *
 	jg	compat_sys_mq_getsetattr
 
-	.globl	compat_sys_add_key
-compat_sys_add_key:
+	.globl	compat_sys_add_key_wrapper
+compat_sys_add_key_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgtr	%r3,%r3			# const char *
 	llgtr	%r4,%r4			# const void *
@@ -1416,10 +1416,28 @@
 	llgfr	%r6,%r6			# (key_serial_t) u32
 	jg	sys_add_key
 
-	.globl	compat_sys_request_key
-compat_sys_request_key:
+	.globl	compat_sys_request_key_wrapper
+compat_sys_request_key_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgtr	%r3,%r3			# const char *
 	llgtr	%r4,%r4			# const void *
 	llgfr	%r5,%r5			# (key_serial_t) u32
 	jg	sys_request_key
+
+	.globl	sys32_remap_file_pages_wrapper
+sys32_remap_file_pages_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgfr	%r3,%r3			# unsigned long
+	llgfr	%r4,%r4			# unsigned long
+	llgfr	%r5,%r5			# unsigned long
+	llgfr	%r6,%r6			# unsigned long
+	jg	sys_remap_file_pages
+
+	.globl	compat_sys_waitid_wrapper
+compat_sys_waitid_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# pid_t
+	llgtr	%r4,%r4			# siginfo_emu31_t *
+	lgfr	%r5,%r5			# int
+	llgtr	%r6,%r6			# struct rusage_emu31 *
+	jg	compat_sys_waitid
diff -urN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2005-03-17 15:35:47.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2005-03-17 15:35:57.000000000 +0100
@@ -275,7 +275,7 @@
 SYSCALL(s390_fadvise64_64,sys_ni_syscall,sys32_fadvise64_64_wrapper)
 SYSCALL(sys_statfs64,sys_statfs64,compat_sys_statfs64_wrapper)
 SYSCALL(sys_fstatfs64,sys_fstatfs64,compat_sys_fstatfs64_wrapper)
-NI_SYSCALL							/* 267 new sys_remap_file_pages */
+SYSCALL(sys_remap_file_pages,sys_remap_file_pages,sys32_remap_file_pages_wrapper)
 NI_SYSCALL							/* 268 sys_mbind */
 NI_SYSCALL							/* 269 sys_get_mempolicy */
 NI_SYSCALL							/* 270 sys_set_mempolicy */
@@ -286,6 +286,7 @@
 SYSCALL(sys_mq_notify,sys_mq_notify,compat_sys_mq_notify_wrapper) /* 275 */
 SYSCALL(sys_mq_getsetattr,sys_mq_getsetattr,compat_sys_mq_getsetattr_wrapper)
 NI_SYSCALL							/* reserved for kexec */
-SYSCALL(sys_add_key,sys_add_key,compat_sys_add_key)
-SYSCALL(sys_request_key,sys_request_key,compat_sys_request_key)
+SYSCALL(sys_add_key,sys_add_key,compat_sys_add_key_wrapper)
+SYSCALL(sys_request_key,sys_request_key,compat_sys_request_key_wrapper)
 SYSCALL(sys_keyctl,sys_keyctl,compat_sys_keyctl)		/* 280 */
+SYSCALL(sys_waitid,sys_waitid,compat_sys_waitid_wrapper)
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2005-03-17 15:35:53.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/unistd.h	2005-03-17 15:35:57.000000000 +0100
@@ -259,7 +259,7 @@
 #define __NR_fadvise64_64	264
 #define __NR_statfs64		265
 #define __NR_fstatfs64		266
-/* Number 267 is reserved for new sys_remap_file_pages */
+#define __NR_remap_file_pages	267
 /* Number 268 is reserved for new sys_mbind */
 /* Number 269 is reserved for new sys_get_mempolicy */
 /* Number 270 is reserved for new sys_set_mempolicy */
@@ -273,8 +273,9 @@
 #define __NR_add_key		278
 #define __NR_request_key	279
 #define __NR_keyctl		280
+#define __NR_waitid		281
 
-#define NR_syscalls 281
+#define NR_syscalls 282
 
 /* 
  * There are some system calls that are not present on 64 bit, some
@@ -333,7 +334,6 @@
 #undef  __NR_setgid32
 #undef  __NR_setfsuid32
 #undef  __NR_setfsgid32
-#undef  __NR_getdents64
 #undef  __NR_fcntl64
 #undef  __NR_sendfile64
 #undef  __NR_fadvise64_64
