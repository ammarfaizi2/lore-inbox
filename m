Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVFGWYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVFGWYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVFGWYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:24:22 -0400
Received: from serv01.siteground.net ([70.85.91.68]:12772 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S262012AbVFGWYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:24:14 -0400
Date: Tue, 7 Jun 2005 15:23:01 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Brian Gerst <bgerst@didntduck.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
In-Reply-To: <42A61227.9090402@didntduck.org>
Message-ID: <Pine.LNX.4.62.0506071519470.19659@ScMPusgw>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw> 
 <20050607194123.GA16637@infradead.org>  <Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
 <1118177949.5497.44.camel@laptopd505.fenrus.org> <42A61227.9090402@didntduck.org>
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

On Tue, 7 Jun 2005, Brian Gerst wrote:

> It doesn't really matter.  .rodata isn't actually mapped read-only. Doing so
> would break up the large pages used to map the kernel.

In that case.... here is a patch that moves the table into rodata.

Subject: Move some more structures into "mostly_readonly" and readonly

---

Move syscall timer_hpet and the boot_cpu_data into the "mostly_readonly"
section. And move the syscall table to readonly

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/entry.S	2005-06-07 15:17:15.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/entry.S	2005-06-07 15:18:20.000000000 -0700
@@ -680,6 +680,8 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+.section .ro_data,"a"
 #include "syscall_table.S"
 
 syscall_table_size=(.-sys_call_table)
+.previous
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/setup.c	2005-06-07 15:17:15.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/setup.c	2005-06-07 15:18:51.000000000 -0700
@@ -82,7 +82,8 @@ EXPORT_SYMBOL(efi_enabled);
 /* cpu data as detected by the assembly code in head.S */
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
-struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+struct cpuinfo_x86 boot_cpu_data  __cacheline_aligned_mostly_readonly
+		= { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/syscall_table.S
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/syscall_table.S	2005-06-07 15:17:15.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/syscall_table.S	2005-06-07 15:18:20.000000000 -0700
@@ -1,4 +1,3 @@
-.data
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
 	.long sys_exit
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/timers/timer_hpet.c	2005-06-07 15:17:15.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c	2005-06-07 15:18:20.000000000 -0700
@@ -180,7 +180,7 @@ static int __init init_hpet(char* overri
 /************************************************************/
 
 /* tsc timer_opts struct */
-static struct timer_opts timer_hpet = {
+static struct timer_opts timer_hpet __cacheline_aligned_mostly_readonly = {
 	.name = 		"hpet",
 	.mark_offset =		mark_offset_hpet,
 	.get_offset =		get_offset_hpet,
