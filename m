Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVANAIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVANAIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVAMWBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:01:53 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:47621 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261767AbVAMV6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:33 -0500
Subject: [patch 02/11] uml: fix compilation for missing headers
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:00:51 +0100
Message-Id: <20050113210051.99326AB30@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Readd some needed headers inclusion deleted in
http://linux.bkbits.net:8080/linux-2.5/cset@41e49628dGbOWX-bT9yZII4f19GT6A

If you think it cannot make sense to include both <sys/ptrace.h> and
<linux/ptrace.h> (as userspace process, i.e. host includes), go complaining
with glibc, or follow the linux-abi includes idea.

However, the compilation failure is possibly glibc-version (or better glibc
includes version) related - what I now is that the failure happens on my
system with a glibc 2.3.4 (from Gentoo).

Also, remove some syscalls from the syscall table, since some syscalls were
added which are only inside -mm currently, and this prevents currently
compilation.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/process.c        |    4 ++++
 linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c |   13 +++++++++++++
 2 files changed, 17 insertions(+)

diff -puN arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers arch/um/kernel/process.c
--- linux-2.6.11/arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers	2005-01-13 19:57:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/process.c	2005-01-13 19:59:30.000000000 +0100
@@ -13,6 +13,10 @@
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
+
+/*Userspace header, must be after sys/ptrace.h, and both must be included. */
+#include <linux/ptrace.h>
+
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/unistd.h>
diff -puN arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers arch/um/kernel/sys_call_table.c
--- linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers	2005-01-13 20:48:02.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-01-13 21:17:23.866866296 +0100
@@ -20,7 +20,11 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif
 
+#if 0
 #define LAST_GENERIC_SYSCALL __NR_vperfctr_read
+#else
+#define LAST_GENERIC_SYSCALL __NR_keyctl
+#endif
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -54,11 +58,14 @@ extern syscall_handler_t sys_get_mempoli
 extern syscall_handler_t sys_set_mempolicy;
 extern syscall_handler_t sys_sys_kexec_load;
 extern syscall_handler_t sys_sys_setaltroot;
+
+#if 0
 extern syscall_handler_t sys_vperfctr_open;
 extern syscall_handler_t sys_vperfctr_control;
 extern syscall_handler_t sys_vperfctr_unlink;
 extern syscall_handler_t sys_vperfctr_iresume;
 extern syscall_handler_t sys_vperfctr_read;
+#endif
 
 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
@@ -273,7 +280,10 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
+#if 0
 	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
+#endif
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
 #if 0
 	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
@@ -281,11 +291,14 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
+	/* These syscalls are still in -mm only*/
+#if 0
 	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
 	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
 	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
 	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
 	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,
+#endif
 
 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 
_
