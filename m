Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWCECpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWCECpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWCECpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:45:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750903AbWCECpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:45:02 -0500
Date: Sat, 4 Mar 2006 18:43:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-kernel@vger.kernel.org, "Zach, Yoav" <yoav.zach@intel.com>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 1/1] EFI: Fix gdt load
Message-Id: <20060304184319.7b9ec461.akpm@osdl.org>
In-Reply-To: <4406F0C2.7090002@ed-soft.at>
References: <4406F0C2.7090002@ed-soft.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Hucek <hostmaster@ed-soft.at> wrote:
>
> This patch makes the kernel bootable again on ia32 EFI systems.
>

Argh, thanks.  I'll move the per_cpu() call inside the lock, just in case
we happen to be running preemptibly there.

Zach, Matt: please review, test and ack asap?

diff -puN arch/i386/kernel/efi.c~efi-fix-gdt-load arch/i386/kernel/efi.c
--- devel/arch/i386/kernel/efi.c~efi-fix-gdt-load	2006-03-04 18:40:20.000000000 -0800
+++ devel-akpm/arch/i386/kernel/efi.c	2006-03-04 18:41:50.000000000 -0800
@@ -70,10 +70,13 @@ static void efi_call_phys_prelog(void)
 {
 	unsigned long cr4;
 	unsigned long temp;
+	struct Xgt_desc_struct *cpu_gdt_descr;
 
 	spin_lock(&efi_rt_lock);
 	local_irq_save(efi_rt_eflags);
 
+	cpu_gdt_descr = &per_cpu(cpu_gdt_descr, 0);
+
 	/*
 	 * If I don't have PSE, I should just duplicate two entries in page
 	 * directory. If I have PSE, I just need to duplicate one entry in
@@ -103,18 +106,17 @@ static void efi_call_phys_prelog(void)
 	 */
 	local_flush_tlb();
 
-	per_cpu(cpu_gdt_descr, 0).address =
-				 __pa(per_cpu(cpu_gdt_descr, 0).address);
-	load_gdt((struct Xgt_desc_struct *)__pa(&per_cpu(cpu_gdt_descr, 0)));
+	cpu_gdt_descr->address = __pa(cpu_gdt_descr->address);
+	load_gdt(cpu_gdt_descr);
 }
 
 static void efi_call_phys_epilog(void)
 {
 	unsigned long cr4;
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, 0);
 
-	per_cpu(cpu_gdt_descr, 0).address =
-			(unsigned long)__va(per_cpu(cpu_gdt_descr, 0).address);
-	load_gdt((struct Xgt_desc_struct *)__va(&per_cpu(cpu_gdt_descr, 0)));
+	cpu_gdt_descr->address = __va(cpu_gdt_descr->address);
+	load_gdt(cpu_gdt_descr);
 
 	cr4 = read_cr4();
 
_

