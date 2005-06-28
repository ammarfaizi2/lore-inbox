Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVF1Srn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVF1Srn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVF1Srm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:47:42 -0400
Received: from graphe.net ([209.204.138.32]:45699 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261174AbVF1Sr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:47:28 -0400
Date: Tue, 28 Jun 2005 11:47:26 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, ak@suse.de
Subject: [PATCH] Read only syscall tables for x86_64 and i386
Message-ID: <Pine.LNX.4.62.0506281141050.959@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Place x86_64 and i386 syscall table into the read only section.

Remove the syscall tables from the data section and place them into the 
readonly section (like IA64).

Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12-mm2/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/entry.S	2005-06-28 17:46:31.000000000 +0000
+++ linux-2.6.12-mm2/arch/i386/kernel/entry.S	2005-06-28 17:47:11.000000000 +0000
@@ -680,6 +680,7 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+.section .rodata,"a"
 #include "syscall_table.S"
 
 syscall_table_size=(.-sys_call_table)
Index: linux-2.6.12-mm2/arch/i386/kernel/syscall_table.S
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/syscall_table.S	2005-06-28 17:46:31.000000000 +0000
+++ linux-2.6.12-mm2/arch/i386/kernel/syscall_table.S	2005-06-28 17:47:11.000000000 +0000
@@ -1,4 +1,3 @@
-.data
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
 	.long sys_exit
Index: linux-2.6.12-mm2/arch/x86_64/kernel/syscall.c
===================================================================
--- linux-2.6.12-mm2.orig/arch/x86_64/kernel/syscall.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12-mm2/arch/x86_64/kernel/syscall.c	2005-06-28 18:22:41.000000000 +0000
@@ -19,7 +19,7 @@ typedef void (*sys_call_ptr_t)(void); 
 
 extern void sys_ni_syscall(void);
 
-sys_call_ptr_t sys_call_table[__NR_syscall_max+1] __cacheline_aligned = { 
+const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = { 
 	/* Smells like a like a compiler bug -- it doesn't work when the & below is removed. */ 
 	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm-x86_64/unistd.h>
