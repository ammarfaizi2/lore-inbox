Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVDFUFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVDFUFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVDFUFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:05:51 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:63381 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262308AbVDFUDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:03:19 -0400
Subject: [patch 1/1] uml: quick fix syscall table [urgent]
To: stable@kernel.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 06 Apr 2005 20:38:00 +0200
Message-Id: <20050406183802.48AF7C5D4E@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: <stable@kernel.org>

I'm resending this for inclusion in the -stable tree. I've deleted whitespace
cleanups, and hope this can be merged. I've been asked to split the former
patch, I don't know if I must split again this one, even because I don't want
to split this correct patch into multiple non-correct ones by mistake.

Uml 2.6.11 does not compile with gcc 2.95.4 because some entries are
duplicated, and that GCC does not accept this (unlike gcc 3). Plus various
other bugs in the syscall table definitions, resulting in probable wrong
syscall entries:

  *) 223 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 it's a
  valid syscall (thus a duplicated one).

  *) __NR_vserver must be only once with sys_ni_syscall, and not multiple
  times with different values!

  *) syscalls duplicated in SUBARCHs and in common files (thus assigning twice
  to the same array entry and causing the GCC 2.95.4 failure mentioned above):
  sys_utimes, which is common, and sys_fadvise64_64, sys_statfs64,
  sys_fstatfs64, which exist only on i386.

  *) syscalls duplicated in each SUBARCH, to put in common files:
  sys_remap_file_pages, sys_utimes, sys_fadvise64

  *) 285 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 the range
  does not arrive to that point.

  *) on x86_64, the macro name is __NR_kexec_load and not __NR_sys_kexec_load.
  Use the correct name in either case.

Note: as you can see, part of the syscall table definition in UML is
arch-independent (with everywhere defined syscalls), and part is
arch-dependant. This has created confusion (some syscalls are listed in both
places, some in the wrong one, some are wrong on one arch or another).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/include/sysdep-i386/syscalls.h   |   12 +++++-----
 clean-linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/syscalls.h |    5 ----
 clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c          |   11 +++------
 3 files changed, 10 insertions(+), 18 deletions(-)

diff -puN arch/um/include/sysdep-i386/syscalls.h~uml-quick-fix-syscall-table-for-stable arch/um/include/sysdep-i386/syscalls.h
--- clean-linux-2.6.11/arch/um/include/sysdep-i386/syscalls.h~uml-quick-fix-syscall-table-for-stable	2005-04-05 16:56:57.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/include/sysdep-i386/syscalls.h	2005-04-05 16:56:57.000000000 +0200
@@ -23,6 +23,9 @@ extern long sys_mmap2(unsigned long addr
 		      unsigned long prot, unsigned long flags,
 		      unsigned long fd, unsigned long pgoff);
 
+/* On i386 they choose a meaningless naming.*/
+#define __NR_kexec_load __NR_sys_kexec_load
+
 #define ARCH_SYSCALLS \
 	[ __NR_waitpid ] = (syscall_handler_t *) sys_waitpid, \
 	[ __NR_break ] = (syscall_handler_t *) sys_ni_syscall, \
@@ -101,15 +104,12 @@ extern long sys_mmap2(unsigned long addr
 	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
 	[ 251 ] = (syscall_handler_t *) sys_ni_syscall, \
-        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
-        
+	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
+
 /* 222 doesn't yet have a name in include/asm-i386/unistd.h */
 
-#define LAST_ARCH_SYSCALL __NR_vserver
+#define LAST_ARCH_SYSCALL 285
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN arch/um/include/sysdep-x86_64/syscalls.h~uml-quick-fix-syscall-table-for-stable arch/um/include/sysdep-x86_64/syscalls.h
--- clean-linux-2.6.11/arch/um/include/sysdep-x86_64/syscalls.h~uml-quick-fix-syscall-table-for-stable	2005-04-05 16:56:57.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/syscalls.h	2005-04-05 16:56:57.000000000 +0200
@@ -71,12 +71,7 @@ extern syscall_handler_t sys_arch_prctl;
 	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
 	[ __NR_semtimedop ] = (syscall_handler_t *) sys_semtimedop, \
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
-	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ 251 ] = (syscall_handler_t *) sys_ni_syscall,
 
 #define LAST_ARCH_SYSCALL 251
diff -puN arch/um/kernel/sys_call_table.c~uml-quick-fix-syscall-table-for-stable arch/um/kernel/sys_call_table.c
--- clean-linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-quick-fix-syscall-table-for-stable	2005-04-05 16:56:57.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-04-05 16:56:57.000000000 +0200
@@ -48,7 +48,6 @@ extern syscall_handler_t sys_vfork;
 extern syscall_handler_t old_select;
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_rt_sigsuspend;
-extern syscall_handler_t sys_vserver;
 extern syscall_handler_t sys_mbind;
 extern syscall_handler_t sys_get_mempolicy;
 extern syscall_handler_t sys_set_mempolicy;
@@ -242,6 +241,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_epoll_create ] = (syscall_handler_t *) sys_epoll_create,
 	[ __NR_epoll_ctl ] = (syscall_handler_t *) sys_epoll_ctl,
 	[ __NR_epoll_wait ] = (syscall_handler_t *) sys_epoll_wait,
+	[ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages,
         [ __NR_set_tid_address ] = (syscall_handler_t *) sys_set_tid_address,
 	[ __NR_timer_create ] = (syscall_handler_t *) sys_timer_create,
 	[ __NR_timer_settime ] = (syscall_handler_t *) sys_timer_settime,
@@ -252,12 +252,10 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_clock_gettime ] = (syscall_handler_t *) sys_clock_gettime,
 	[ __NR_clock_getres ] = (syscall_handler_t *) sys_clock_getres,
 	[ __NR_clock_nanosleep ] = (syscall_handler_t *) sys_clock_nanosleep,
-	[ __NR_statfs64 ] = (syscall_handler_t *) sys_statfs64,
-	[ __NR_fstatfs64 ] = (syscall_handler_t *) sys_fstatfs64,
 	[ __NR_tgkill ] = (syscall_handler_t *) sys_tgkill,
 	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes,
-	[ __NR_fadvise64_64 ] = (syscall_handler_t *) sys_fadvise64_64,
-	[ __NR_vserver ] = (syscall_handler_t *) sys_vserver,
+	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64,
+	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_mbind ] = (syscall_handler_t *) sys_mbind,
 	[ __NR_get_mempolicy ] = (syscall_handler_t *) sys_get_mempolicy,
 	[ __NR_set_mempolicy ] = (syscall_handler_t *) sys_set_mempolicy,
@@ -267,9 +265,8 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
-	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
_
