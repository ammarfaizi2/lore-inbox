Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUJDFvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUJDFvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 01:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUJDFvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 01:51:53 -0400
Received: from netmail8.mail.umd.edu ([128.8.30.201]:24708 "EHLO mail.umd.edu")
	by vger.kernel.org with ESMTP id S268445AbUJDFvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 01:51:22 -0400
Subject: [PATCH] RadeonFB ACPI S3 patch fixed to not break S4. 2.6.8.1,
	2.6.7
From: Steve M <stevenm@umd.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-/osu1btsAaLbkcD/fnj0"
Date: Mon, 04 Oct 2004 01:43:02 -0400
Message-Id: <1096868582.10456.9.camel@stevenm-laptop.student.umd.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/osu1btsAaLbkcD/fnj0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This applies to the patch written by Ole Rohne, ole.rohne_AT_cern.ch
This applies to Radeon Mobility cards (mine is M9000 but it could work
for others) on certain laptops that don't reinitialize the video BIOS
upon resume (Mine is a Dell Insipron 600m but there are others).

This patch reinitializes the Radeon BIOS upon resume from an ACPI sleep
state other than S4.

The original patch reinitialized the video bios from any ACPI resume,
but this broke suspending to S4. The machine would begin to suspend,
then the display would go dark and the system would become unresponsive.

I added an if statement to the part that patches radeon_pm.c so that it
would NOT try to reinitialize the video BIOS if the machine is entering
S4. This worked.

Given how much aggrivation this has given me, I figure submitting the
new patch would be nice.



-- 
Steve M <stevenm@umd.edu>

--=-/osu1btsAaLbkcD/fnj0
Content-Disposition: attachment; filename=README
Content-Type: text/x-readme; name=README; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stepan Moskovchenko
stevenm@umd.edu

This applies to the patch written by Ole Rohne, ole.rohne_AT_cern.ch
This applies to Radeon Mobility cards (mine is M9000 but it could work for others) on certain laptops that don't reinitialize the video BIOS upon resume (Mine is a Dell Insipron 600m but there are others).

This modified patch reinitializes the Radeon BIOS upon resume from an ACPI sleep state other than S4, fixing the garbage screen that laptops get upon resume from S4.

--=-/osu1btsAaLbkcD/fnj0
Content-Disposition: attachment; filename=patch-radeonfb
Content-Type: text/x-patch; name=patch-radeonfb; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff -ru -X dontdiff linux-2.6.7/arch/i386/kernel/acpi/sleep.c linux-2.6.7-p2120/arch/i386/kernel/acpi/sleep.c
--- linux-2.6.7/arch/i386/kernel/acpi/sleep.c	2004-07-06 21:48:04.000000000 +0200
+++ linux-2.6.7-p2120/arch/i386/kernel/acpi/sleep.c	2004-07-19 10:53:48.000000000 +0200
@@ -5,6 +5,7 @@
  *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
  */
 
+#include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <asm/smp.h>
@@ -63,6 +64,31 @@
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
+  unsigned long flags, saved_video_flags = acpi_video_flags;
+  acpi_video_flags = (slot & 0xffff) << 16 | 1;
+  /* Map low memory and copy information */
+  init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
+  memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
+  acpi_copy_wakeup_routine(acpi_wakeup_address);
+  /* Tunnel thru real mode */
+  local_irq_save(flags);
+  do_vgapost_lowlevel(acpi_wakeup_address);
+  local_irq_restore(flags);
+  /* Restore mapping etc */
+  zap_low_mappings();
+  acpi_video_flags = saved_video_flags;
+}
+
+EXPORT_SYMBOL (acpi_vgapost);
+
 /**
  * acpi_reserve_bootmem - do _very_ early ACPI initialisation
  *
diff -ru -X dontdiff linux-2.6.7/arch/i386/kernel/acpi/wakeup.S linux-2.6.7-p2120/arch/i386/kernel/acpi/wakeup.S
--- linux-2.6.7/arch/i386/kernel/acpi/wakeup.S	2004-07-05 19:37:21.000000000 +0200
+++ linux-2.6.7-p2120/arch/i386/kernel/acpi/wakeup.S	2004-07-19 11:02:30.000000000 +0200
@@ -43,6 +43,7 @@
 
 	testl	$1, video_flags - wakeup_code
 	jz	1f
+	movw	video_flags - wakeup_code + 2, %ax
 	lcall   $0xc000,$3
 	movw	%cs, %ax
 	movw	%ax, %ds					# Bios might have played with that
@@ -159,6 +160,32 @@
 
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
 
@@ -284,6 +311,59 @@
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
diff -ru -X dontdiff linux-2.6.7/drivers/video/aty/radeon_pm.c linux-2.6.7-p2120/drivers/video/aty/radeon_pm.c
--- linux-2.6.7/drivers/video/aty/radeon_pm.c	2004-07-19 10:56:15.000000000 +0200
+++ linux-2.6.7-p2120/drivers/video/aty/radeon_pm.c	2004-07-19 10:56:34.000000000 +0200
@@ -897,6 +897,14 @@
 	if (pdev->dev.power_state == 0)
 		return 0;
+
+	if (pdev->dev.power_state != 4)
+	{ 
+		pci_restore_state (pdev, pdev->saved_config_space);
+
+		acpi_vgapost (pdev->devfn);
+
+	}

 	acquire_console_sem();
 
 	/* Wakeup chip */

--=-/osu1btsAaLbkcD/fnj0--

