Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265683AbVBDUBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbVBDUBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbVBDUBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:01:45 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:18692 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S266786AbVBDUAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:35 -0500
Subject: [patch 1/8] uml: fix compilation for missing headers [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:40 +0100
Message-Id: <20050204183541.52C972125F@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Readd some needed headers inclusion deleted in
http://linux.bkbits.net:8080/linux-2.5/cset@41e49628dGbOWX-bT9yZII4f19GT6A

If you think it cannot make sense to include both <sys/ptrace.h> and
<linux/ptrace.h> (as userspace process, i.e. host includes), go complaining
with glibc, or follow the linux-abi includes idea.

However, the compilation failure is possibly glibc-version (or better glibc
includes version) related - what I now is that the failure happens on my
system with a glibc 2.3.4 (from Gentoo).

Also, fix the syscall table to both compile and have no empty slot (which
could cause Oopses).

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/process.c        |   15 ++++-----------
 linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c |   16 ++--------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff -puN arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers arch/um/kernel/process.c
--- linux-2.6.11/arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers	2005-02-04 03:28:51.973132912 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/process.c	2005-02-04 03:28:58.254178048 +0100
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
@@ -422,14 +426,3 @@ int can_do_skas(void)
 	return(0);
 }
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers arch/um/kernel/sys_call_table.c
--- linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers	2005-02-04 03:28:51.975132608 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-02-04 03:29:05.565066624 +0100
@@ -267,10 +267,9 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
-#if 0
-	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
-#endif
+	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
@@ -279,14 +278,3 @@ syscall_handler_t *sys_call_table[] = {
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 
 	        (syscall_handler_t *) sys_ni_syscall
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_
