Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVFGSbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVFGSbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVFGSbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:31:48 -0400
Received: from serv01.siteground.net ([70.85.91.68]:44996 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261812AbVFGSbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:31:18 -0400
Date: Tue, 7 Jun 2005 11:30:03 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Move some more structures into "mostly_readonly"
Message-ID: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move syscall table, timer_hpet and the boot_cpu_data into the "mostly_readonly" section.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/entry.S	2005-06-07 11:15:43.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/entry.S	2005-06-07 11:26:36.000000000 -0700
@@ -680,6 +680,8 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+.section .data.mostly_readonly,"a"
 #include "syscall_table.S"
 
 syscall_table_size=(.-sys_call_table)
+.previous
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/setup.c	2005-06-07 11:15:43.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/setup.c	2005-06-07 11:27:48.000000000 -0700
@@ -82,7 +82,8 @@ EXPORT_SYMBOL(efi_enabled);
 /* cpu data as detected by the assembly code in head.S */
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
-struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+struct cpuinfo_x86 boot_cpu_data __cacheline_aligned_mostly_readonly
+		= { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/syscall_table.S
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/syscall_table.S	2005-06-07 11:15:43.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/syscall_table.S	2005-06-07 11:26:36.000000000 -0700
@@ -1,4 +1,3 @@
-.data
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
 	.long sys_exit
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/timers/timer_hpet.c	2005-06-07 11:15:43.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c	2005-06-07 11:26:36.000000000 -0700
@@ -180,7 +180,7 @@ static int __init init_hpet(char* overri
 /************************************************************/
 
 /* tsc timer_opts struct */
-static struct timer_opts timer_hpet = {
+static struct timer_opts timer_hpet __cacheline_aligned_mostly_readonly = {
 	.name = 		"hpet",
 	.mark_offset =		mark_offset_hpet,
 	.get_offset =		get_offset_hpet,
