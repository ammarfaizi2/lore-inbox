Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263669AbVBCSjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbVBCSjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbVBCSf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:35:29 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:63247 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S263701AbVBCSdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:33:23 -0500
Message-Id: <200502032056.j13KuLRn004424@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade@yahoo.it>
Subject: [PATCH] UML - compile fixes for 2.6.11-rc3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Feb 2005 15:56:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes UML's sys_call_table to delete some entries for system calls
which have not yet made it into mainline from -mm.

I also delete UML's __pud_alloc implementation since the memory.c one is
now enabled.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/kernel/sys_call_table.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/sys_call_table.c	2005-02-03 12:58:08.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/sys_call_table.c	2005-02-03 13:09:23.000000000 -0500
@@ -20,7 +20,7 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif
 
-#define LAST_GENERIC_SYSCALL __NR_vperfctr_read
+#define LAST_GENERIC_SYSCALL __NR_keyctl
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -52,13 +52,7 @@
 extern syscall_handler_t sys_mbind;
 extern syscall_handler_t sys_get_mempolicy;
 extern syscall_handler_t sys_set_mempolicy;
-extern syscall_handler_t sys_sys_kexec_load;
 extern syscall_handler_t sys_sys_setaltroot;
-extern syscall_handler_t sys_vperfctr_open;
-extern syscall_handler_t sys_vperfctr_control;
-extern syscall_handler_t sys_vperfctr_unlink;
-extern syscall_handler_t sys_vperfctr_iresume;
-extern syscall_handler_t sys_vperfctr_read;
 
 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
@@ -273,7 +267,6 @@
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
 #if 0
 	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
@@ -281,11 +274,6 @@
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
-	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
-	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
-	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
-	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
-	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,
 
 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 
Index: linux-2.6.10/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-um/pgtable.h	2005-02-03 12:58:23.000000000 -0500
+++ linux-2.6.10/include/asm-um/pgtable.h	2005-02-03 13:06:13.000000000 -0500
@@ -155,12 +155,6 @@
 #define pud_newpage(x)  (pud_val(x) & _PAGE_NEWPAGE)
 #define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEWPAGE)
 
-static inline pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd,
-					  unsigned long addr)
-{
-	BUG();
-}
-
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
 
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)

