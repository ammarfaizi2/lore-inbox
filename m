Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVF1T1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVF1T1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVF1T1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:27:37 -0400
Received: from graphe.net ([209.204.138.32]:11195 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261185AbVF1T0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:26:48 -0400
Date: Tue, 28 Jun 2005 12:26:43 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
In-Reply-To: <1119984975.3175.41.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0506281224030.1523@graphe.net>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
 <1119984975.3175.41.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Arjan van de Ven wrote:

> I like it.. however I think the 32 bit compat syscall table on x86-64
> deserves the same treatment....

Ok.

---

Place x86_64 and i386 syscall table into the read only section.

Remove the syscall tables from the data section and place them into the 
readonly section (like IA64). Includes the ia32 syscall table on x86_64.

Note that AFS seems to be modifying the syscall table. Is that legit?

Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12-mm2/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/entry.S	2005-06-28 18:34:11.000000000 +0000
+++ linux-2.6.12-mm2/arch/i386/kernel/entry.S	2005-06-28 19:06:42.000000000 +0000
@@ -680,6 +680,7 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+.section .rodata,"a"
 #include "syscall_table.S"
 
 syscall_table_size=(.-sys_call_table)
Index: linux-2.6.12-mm2/arch/i386/kernel/syscall_table.S
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/syscall_table.S	2005-06-28 18:34:11.000000000 +0000
+++ linux-2.6.12-mm2/arch/i386/kernel/syscall_table.S	2005-06-28 19:06:42.000000000 +0000
@@ -1,4 +1,3 @@
-.data
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
 	.long sys_exit
Index: linux-2.6.12-mm2/arch/x86_64/kernel/syscall.c
===================================================================
--- linux-2.6.12-mm2.orig/arch/x86_64/kernel/syscall.c	2005-06-28 18:34:11.000000000 +0000
+++ linux-2.6.12-mm2/arch/x86_64/kernel/syscall.c	2005-06-28 19:06:42.000000000 +0000
@@ -19,7 +19,7 @@ typedef void (*sys_call_ptr_t)(void); 
 
 extern void sys_ni_syscall(void);
 
-sys_call_ptr_t sys_call_table[__NR_syscall_max+1] __cacheline_aligned = { 
+const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = { 
 	/* Smells like a like a compiler bug -- it doesn't work when the & below is removed. */ 
 	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm-x86_64/unistd.h>
Index: linux-2.6.12-mm2/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux-2.6.12-mm2.orig/arch/x86_64/ia32/ia32entry.S	2005-06-28 17:46:31.000000000 +0000
+++ linux-2.6.12-mm2/arch/x86_64/ia32/ia32entry.S	2005-06-28 19:13:20.000000000 +0000
@@ -298,7 +298,7 @@ ENTRY(ia32_ptregs_common)
 	jmp  ia32_sysret	/* misbalances the return cache */
 	CFI_ENDPROC
 
-	.data
+	.section .rodata,"a"
 	.align 8
 	.globl ia32_sys_call_table
 ia32_sys_call_table:
