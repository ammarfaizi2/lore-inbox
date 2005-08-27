Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVH0K3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVH0K3d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbVH0K3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 06:29:33 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:10462 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S1030358AbVH0K3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 06:29:32 -0400
Message-ID: <4310408A.6010701@engr.orst.edu>
Date: Sat, 27 Aug 2005 03:29:30 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050729)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Radeonfb acpi vgapost
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E2E23AF4DEC8C1460954E95"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E2E23AF4DEC8C1460954E95
Content-Type: multipart/mixed;
 boundary="------------050509070308030900070503"

This is a multi-part message in MIME format.
--------------050509070308030900070503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here is a cleaned up version of the patch to repost radeon cards when
resuming from acpi s3 suspend.  I've been sitting on it for a while
hoping that I might be able to gain some insight in how to use the d2
state instead of this repost as ppc does.  On my x86 laptop with a
radeon 9000 resuming from d2 does manage to turn on the card/display,
but it becomes horridly scrambled. But right now I don't have the time
or the skill to actually get any futher than that.

And btw, posting the card still causes the system to wait for a key
press.  I don't know if that is solvable with the current post method.
Getting the existing d2 suspend/resume stuff to work might be the only
way to clear that up.
-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University


--------------050509070308030900070503
Content-Type: text/x-patch;
 name="radeonfb-vgapost.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb-vgapost.patch"

Index: linux-2.6.13-rc3/arch/i386/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/i386/kernel/acpi/sleep.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/i386/kernel/acpi/sleep.c	2005-07-29 19:03:56.000000000 -0700
@@ -5,6 +5,7 @@
  *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
  */
 
+#include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/dmi.h>
@@ -56,6 +57,34 @@
 	zap_low_mappings();
 }
 
+/*
+ * acpi_vgapost
+ */
+
+extern void do_vgapost_lowlevel (unsigned long);
+
+void acpi_vgapost (unsigned long slot)
+{
+	unsigned long flags, saved_video_flags = acpi_video_flags;
+	
+	acpi_video_flags = (slot & 0xffff) << 16 | 1;
+	
+	/* Map low memory and copy information */
+	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
+	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
+	acpi_copy_wakeup_routine(acpi_wakeup_address);
+	
+	/* Tunnel thru real mode */
+	local_irq_save(flags);
+	do_vgapost_lowlevel(acpi_wakeup_address);
+	local_irq_restore(flags);
+	
+	/* Restore mapping etc */
+	zap_low_mappings();
+	acpi_video_flags = saved_video_flags;
+}
+EXPORT_SYMBOL (acpi_vgapost);
+
 /**
  * acpi_reserve_bootmem - do _very_ early ACPI initialisation
  *
Index: linux-2.6.13-rc3/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux-2.6.13-rc3.orig/arch/i386/kernel/acpi/wakeup.S	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/i386/kernel/acpi/wakeup.S	2005-07-29 19:03:56.000000000 -0700
@@ -171,6 +171,32 @@
 
 _setbad: jmp setbad
 
+#
+#	Real mode switch - verbatim from reboot.c
+#
+go_real:
+	movl	%cr0, %eax
+	andl	$0x00000011, %eax
+	orl	$0x60000000, %eax
+	movl	%eax, %cr0
+	movl	%eax, %cr3
+	movl	%cr0, %ebx
+	andl	$0x60000000, %ebx
+	jz	1f
+	wbinvd
+1:	andb	$0x10, %al
+	movl	%eax, %cr0
+go_real_jmp:		.byte	0xea
+go_real_jmp_off:	.word	0x0000
+go_real_jmp_seg:	.word	0x0000
+#
+# 	Real mode descriptor table
+#
+		.align	8
+go_real_desc:	.quad	0x0000000000000000
+go_real_cseg:	.quad	0x00009a000000ffff
+go_real_dseg:	.quad	0x000092000000ffff
+
 	.code32
 	ALIGN
 
@@ -310,6 +336,59 @@
 	call acpi_enter_sleep_state_s4bios
 	ret
 
+ENTRY(do_vgapost_lowlevel)
+	# Convert target offset to physical address
+	movl	%eax, %ecx
+	subl	$__PAGE_OFFSET, %ecx
+	# Fixup GDT pointer
+	movl	%ecx, %edx
+	addl	$go_real_desc - wakeup_start, %edx
+	movl	%edx, go_real_gdt + 2
+	# Fixup 16-bit CS descriptor
+	movl	%ecx, %edx
+	movw	%dx, go_real_cseg - wakeup_start + 2 (%eax)
+	shrl	$16, %edx
+	movb	%dl, go_real_cseg - wakeup_start + 4 (%eax)
+	movb	%dh, go_real_cseg - wakeup_start + 7 (%eax)
+	# Fixup 16-bit jump
+	movl	%ecx, %edx
+	shrl	$4, %edx
+	movw	%dx, go_real_jmp_seg - wakeup_start (%eax)
+	# Save state and registers
+	call	save_processor_state
+	call	save_registers
+	# Reload page table with low mapping
+	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
+	movl	%eax, %cr3
+	# Load IDTR and GDTR for real mode
+	lidt	go_real_idt
+	lgdt	go_real_gdt
+	# Load DS & al
+	movl	$0x0010, %eax
+	movl	%eax, %ss
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %fs
+	movl	%eax, %gs
+	# Load CS
+	call	$0x0008, $(go_real - wakeup_start)
+	# Phony return code
+	call	restore_registers
+	call	restore_processor_state
+	ret
+	
+	.align	4
+	.word	0
+go_real_idt:
+	.word	0x3ff
+	.long	0
+	
+	.align	4
+	.word	0
+go_real_gdt:
+	.word	3*8-1
+	.long	0
+
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
Index: linux-2.6.13-rc3/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/video/aty/radeon_pm.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/video/aty/radeon_pm.c	2005-07-29 19:03:56.000000000 -0700
@@ -2403,6 +2403,15 @@
 
 #endif /* CONFIG_PPC_OF */
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_X86)
+extern void acpi_vgapost (unsigned long slot);
+
+static void radeon_reinitialize_vgapost(struct radeonfb_info *rinfo)
+{
+	acpi_vgapost (rinfo->pdev->devfn);
+}
+#endif
+
 static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
 	u16 pwr_cmd;
@@ -2657,6 +2666,8 @@
 		 */
 		else if (rinfo->pm_mode & radeon_pm_d2)
 			radeon_set_suspend(rinfo, 0);
+		if (rinfo->pm_mode & radeon_pm_post && rinfo->reinit_func != NULL)
+			rinfo->reinit_func(rinfo);
 
 		rinfo->asleep = 0;
 	} else
@@ -2777,6 +2788,13 @@
 #endif
 	}
 #endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
+
+#if defined(CONFIG_ACPI) && defined(CONFIG_X86)
+	if (rinfo->is_mobility && rinfo->pm_reg) {
+		rinfo->reinit_func = radeon_reinitialize_vgapost;
+		rinfo->pm_mode |= radeon_pm_post;
+	}
+#endif
 }
 
 void radeonfb_pm_exit(struct radeonfb_info *rinfo)
Index: linux-2.6.13-rc3/drivers/video/aty/radeonfb.h
===================================================================
--- linux-2.6.13-rc3.orig/drivers/video/aty/radeonfb.h	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/video/aty/radeonfb.h	2005-07-29 19:03:56.000000000 -0700
@@ -271,6 +271,7 @@
 	radeon_pm_none	= 0,		/* Nothing supported */
 	radeon_pm_d2	= 0x00000001,	/* Can do D2 state */
 	radeon_pm_off	= 0x00000002,	/* Can resume from D3 cold */
+	radeon_pm_post	= 0x00000004,	/* Resume with vgapost */
 };
 
 struct radeonfb_info {


--------------050509070308030900070503--

--------------enig6E2E23AF4DEC8C1460954E95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDEECKiP+LossGzjARAoKQAJsE/IyaR8Eynn1tQ/9cmxHampCn5wCgyuMU
Wdk6mFwDdX1YS92HRO9UDxU=
=7TH4
-----END PGP SIGNATURE-----

--------------enig6E2E23AF4DEC8C1460954E95--
