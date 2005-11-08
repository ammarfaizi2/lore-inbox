Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965321AbVKHE0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965321AbVKHE0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbVKHE0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:26:00 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:53522 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965321AbVKHEZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:25:55 -0500
Date: Mon, 7 Nov 2005 20:25:53 -0800
Message-Id: <200511080425.jA84PrSo009878@zach-dev.vmware.com>
Subject: [PATCH 7/21] i386 Losing fs gs to bios
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:25:53.0976 (UTC) FILETIME=[81EA4B80:01C5E41C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered an even more subtle problem; the PnP BIOS code is saving
the %fs and %gs segments in inline assembler, yet it also uses the same
hack for patching in a fake real mode selector for the BIOS data area.
Note that the protected mode selector 0x40 overlaps the user TLS area in
the GDT; this means that badly timed PnP BIOS calls could come in, save
%fs, come back, and restore %fs -- to point to the fake real mode selector
in the GDT.  This selector will remain cached despite the GDT update until
the next task context switch, and could very well be responsible for
causing random crashes and corruption in user space programs which make
use of it (notably, Wine).

Rather than leave a half effort, I wrote an encapsulation function that
saves and restores GDT state properly before attempting to call a
potentially buggy BIOS.  Note that saving and restoring %fs and %gs must
be done after restoring the fake real mode GDT entry (0x40 >> 3), since
they could possibly be referencing that segment.  Also note that %cs, %ss,
%ds, and %es need not be messed with, since in kernel mode, they never
can point to a user TLS segment.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-04 16:54:51.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 00:28:10.000000000 -0800
@@ -158,6 +158,32 @@ static inline unsigned long get_desc_bas
 	return base;
 }
 
+struct bios_segment_save {
+	struct desc_struct save_desc_40;
+	struct desc_struct *gdt;
+	unsigned short saved_fs;
+	unsigned short saved_gs;
+};
+
+static inline void prepare_bios_segments(struct bios_segment_save *save_area)
+{
+	int cpu = get_cpu();
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
+	save_area->gdt = gdt;
+	savesegment(fs, save_area->saved_fs);
+	savesegment(gs, save_area->saved_gs);
+	save_area->save_desc_40 = gdt[GDT_ENTRY_BAD_BIOS];
+	gdt[GDT_ENTRY_BAD_BIOS] = gdt[GDT_ENTRY_BAD_BIOS_CACHE];
+}
+
+static inline void restore_bios_segments(struct bios_segment_save *save_area)
+{
+	save_area->gdt[GDT_ENTRY_BAD_BIOS] = save_area->save_desc_40;
+	loadsegment(fs, save_area->saved_fs);
+	loadsegment(gs, save_area->saved_gs);
+	put_cpu();
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 17:42:39.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-05 00:28:10.000000000 -0800
@@ -87,8 +87,7 @@ static inline u16 call_pnp_bios(u16 func
 {
 	unsigned long flags;
 	u16 status;
-	struct desc_struct save_desc_40;
-	int cpu;
+	struct bios_segment_save save_area;
 
 	/*
 	 * PnP BIOSes are generally not terribly re-entrant.
@@ -97,10 +96,8 @@ static inline u16 call_pnp_bios(u16 func
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
-	cpu = get_cpu();
-	save_desc_40 = per_cpu(cpu_gdt_table,cpu)[0x40 / 8];
-	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = 
-		per_cpu(cpu_gdt_table,cpu)[GDT_ENTRY_BAD_BIOS_CACHE];
+	/* Save %fs, %gs and TLS segment which fakes real mode selector 0x40 */
+	prepare_bios_segments(&save_area);
 
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
@@ -117,15 +114,11 @@ static inline u16 call_pnp_bios(u16 func
 		"pushl %%esi\n\t"
 		"pushl %%ds\n\t"
 		"pushl %%es\n\t"
-		"pushl %%fs\n\t"
-		"pushl %%gs\n\t"
 		"pushfl\n\t"
 		"movl %%esp, pnp_bios_fault_esp\n\t"
 		"movl $1f, pnp_bios_fault_eip\n\t"
 		"lcall %5,%6\n\t"
 		"1:popfl\n\t"
-		"popl %%gs\n\t"
-		"popl %%fs\n\t"
 		"popl %%es\n\t"
 		"popl %%ds\n\t"
 	        "popl %%esi\n\t"
@@ -142,8 +135,8 @@ static inline u16 call_pnp_bios(u16 func
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 
-	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = save_desc_40;
-	put_cpu();
+	/* Restore GDT segments and unpin the CPU */
+	restore_bios_segments(&save_area);
 
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
 	if(pnp_bios_is_utter_crap)
Index: linux-2.6.14-zach-work/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/apm.c	2005-11-04 16:54:51.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/apm.c	2005-11-05 00:28:08.000000000 -0800
@@ -544,19 +544,6 @@ static inline void apm_restore_cpus(cpum
 	else \
 		local_irq_disable();
 
-#ifdef APM_ZERO_SEGS
-#	define APM_DECL_SEGS \
-		unsigned int saved_fs; unsigned int saved_gs;
-#	define APM_DO_SAVE_SEGS \
-		savesegment(fs, saved_fs); savesegment(gs, saved_gs)
-#	define APM_DO_RESTORE_SEGS \
-		loadsegment(fs, saved_fs); loadsegment(gs, saved_gs)
-#else
-#	define APM_DECL_SEGS
-#	define APM_DO_SAVE_SEGS
-#	define APM_DO_RESTORE_SEGS
-#endif
-
 /**
  *	apm_bios_call	-	Make an APM BIOS 32bit call
  *	@func: APM function to execute
@@ -580,28 +567,18 @@ static inline void apm_restore_cpus(cpum
 static u8 apm_bios_call(u32 func, u32 ebx_in, u32 ecx_in,
 	u32 *eax, u32 *ebx, u32 *ecx, u32 *edx, u32 *esi)
 {
-	APM_DECL_SEGS
-	unsigned long		flags;
-	cpumask_t		cpus;
-	int			cpu;
-	struct desc_struct	save_desc_40;
-	struct desc_struct	*gdt;
+	unsigned long			flags;
+	cpumask_t			cpus;
+	struct bios_segment_save	save_area;
 
 	cpus = apm_save_cpus();
 	
-	cpu = get_cpu();
-	gdt = get_cpu_gdt_table(cpu);
-	save_desc_40 = gdt[0x40 / 8];
-	gdt[0x40 / 8] = gdt[GDT_ENTRY_BAD_BIOS_CACHE];
-
+	prepare_bios_segments(&save_area);
 	local_save_flags(flags);
 	APM_DO_CLI;
-	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
-	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	gdt[0x40 / 8] = save_desc_40;
-	put_cpu();
+	restore_bios_segments(&save_area);
 	apm_restore_cpus(cpus);
 	
 	return *eax & 0xff;
@@ -623,29 +600,19 @@ static u8 apm_bios_call(u32 func, u32 eb
 
 static u8 apm_bios_call_simple(u32 func, u32 ebx_in, u32 ecx_in, u32 *eax)
 {
-	u8			error;
-	APM_DECL_SEGS
-	unsigned long		flags;
-	cpumask_t		cpus;
-	int			cpu;
-	struct desc_struct	save_desc_40;
-	struct desc_struct	*gdt;
+	u8				error;
+	unsigned long			flags;
+	cpumask_t			cpus;
+	struct bios_segment_save	save_area;
 
 	cpus = apm_save_cpus();
 	
-	cpu = get_cpu();
-	gdt = get_cpu_gdt_table(cpu);
-	save_desc_40 = gdt[0x40 / 8];
-	gdt[0x40 / 8] = gdt[GDT_ENTRY_BAD_BIOS_CACHE];
-
+	prepare_bios_segments(&save_area);
 	local_save_flags(flags);
 	APM_DO_CLI;
-	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
-	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	gdt[0x40 / 8] = save_desc_40;
-	put_cpu();
+	restore_bios_segments(&save_area);
 	apm_restore_cpus(cpus);
 	return error;
 }
