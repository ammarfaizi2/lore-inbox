Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbUKPRqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbUKPRqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUKPRqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:46:50 -0500
Received: from smtp7.dti.ne.jp ([202.216.228.42]:31881 "EHLO smtp7.dti.ne.jp")
	by vger.kernel.org with ESMTP id S262069AbUKPRqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:46:04 -0500
Message-ID: <004701c4cc04$2fcbaff0$2000a8c0@TPHIROIT>
From: "Hiroshi Itoh" <hiroit@mcn.ne.jp>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, <csapuntz@stanford.edu>,
       <linux-kernel@vger.kernel.org>, "Nickolai Zeldovich" <kolya@MIT.EDU>
References: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com> <Pine.LNX.4.58L.0411161237020.17411@blysk.ds.pg.gda.pl>
Subject: Re: [patch] Fix GDT re-load on ACPI resume
Date: Wed, 17 Nov 2004 02:46:20 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0044_01C4CC4F.9EBBD890"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0044_01C4CC4F.9EBBD890
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi, Maciej-san

> What is the "gdt body must be addressable from real mode" requirement
>about?  GDT is addressed by the CPU using a linear address as obtained
>from GDTR (bypassing segmentation, for obvious reasons) and is accessible
>regardless of its placement within the 32-bit linear address space in all
>CPU modes.  As its a linear address it only undergoes translation at the
>page level, if enabled.  The same applies to IDT.

I believe this patch is required because the original gdt is not addressable
via the low mapping page table (set by acpi_save_state_mem and used for wakeup
code), not the GDTR's linear address size reason.

cc:Shaohua and Len

wakeup_gdt2.patch should be slightestly modified to wakeup_gdt_2.6.10.patch
because %edx is conflict with msr's patch in 2.6.10-rc2 or later.

thanks
-Hiro

------=_NextPart_000_0044_01C4CC4F.9EBBD890
Content-Type: application/octet-stream;
	name="wakeup_gdt_2.6.10.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="wakeup_gdt_2.6.10.patch"

--- a/arch/i386/kernel/acpi/sleep.c	2004-11-04 04:54:41.000000000 +0900=0A=
+++ b/arch/i386/kernel/acpi/sleep.c	2004-11-04 05:20:34.864501960 +0900=0A=
@@ -17,7 +17,7 @@=0A=
 =0A=
 extern void zap_low_mappings(void);=0A=
 =0A=
-extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));=0A=
+extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned =
long,unsigned long));=0A=
 =0A=
 static void init_low_mapping(pgd_t *pgd, int pgd_limit)=0A=
 {=0A=
@@ -41,7 +41,8 @@=0A=
 		return 1;=0A=
 	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);=0A=
 	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - =
&wakeup_start);=0A=
-	acpi_copy_wakeup_routine(acpi_wakeup_address);=0A=
+	acpi_copy_wakeup_routine(acpi_wakeup_address,=0A=
+				 virt_to_phys((void *)acpi_wakeup_address));=0A=
 =0A=
 	return 0;=0A=
 }=0A=
--- a/arch/i386/kernel/acpi/wakeup.S	2004-11-04 04:54:41.000000000 +0900=0A=
+++ b/arch/i386/kernel/acpi/wakeup.S	2004-11-04 05:23:46.490370400 +0900=0A=
@@ -100,6 +100,7 @@=0A=
 real_efer_save_restore:	.long 0=0A=
 real_save_efer_edx: 	.long 0=0A=
 real_save_efer_eax: 	.long 0=0A=
+real_gdt_table: .fill GDT_ENTRIES, 8, 0=0A=
 =0A=
 bogus_real_magic:=0A=
 	movw	$0x0e00 + 'B', %fs:(0x12)=0A=
@@ -224,6 +225,7 @@=0A=
 #=0A=
 # Parameters:=0A=
 # %eax:	place to copy wakeup routine to=0A=
+# %edx: the second argument (physical address)=0A=
 #=0A=
 # Returned address is location of code in low memory (past data and =
stack)=0A=
 #=0A=
@@ -234,6 +236,9 @@=0A=
 	sldt	saved_ldt=0A=
 	str	saved_tss=0A=
 =0A=
+	# save wakeup_start physical address in edx=0A=
+	pushl   %edx=0A=
+=0A=
 	movl	nx_enabled, %edx=0A=
 	movl	%edx, real_efer_save_restore - wakeup_start (%eax)=0A=
 	testl	$1, real_efer_save_restore - wakeup_start (%eax)=0A=
@@ -256,6 +261,17 @@=0A=
 	movl	%edx, real_save_cr0 - wakeup_start (%eax)=0A=
 	sgdt    real_save_gdt - wakeup_start (%eax)=0A=
 =0A=
+	# gdt body must be addressable from real mode by=0A=
+	# copying it to the lower mem=0A=
+	popl	%edx=0A=
+	lea     real_gdt_table - wakeup_start (%edx), %edx=0A=
+	movl    %edx, real_save_gdt + 2 - wakeup_start (%eax)=0A=
+	xor     %ecx, %ecx=0A=
+	movw    saved_gdt, %cx=0A=
+	movl    saved_gdt + 2, %esi=0A=
+	lea     real_gdt_table - wakeup_start (%eax), %edi=0A=
+	rep movsb=0A=
+=0A=
 	movl	saved_videomode, %edx=0A=
 	movl	%edx, video_mode - wakeup_start (%eax)=0A=
 	movl	acpi_video_flags, %edx=0A=

------=_NextPart_000_0044_01C4CC4F.9EBBD890--

