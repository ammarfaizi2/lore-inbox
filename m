Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVGJW1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVGJW1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGJWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 18:24:48 -0400
Received: from smtp1.oregonstate.edu ([128.193.0.11]:52697 "EHLO
	smtp1.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262137AbVGJWXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 18:23:46 -0400
Message-ID: <42D19FEE.1040306@engr.orst.edu>
Date: Sun, 10 Jul 2005 15:23:42 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][help?] Radeonfb acpi resume
References: <42D19EE1.90809@engr.orst.edu>
In-Reply-To: <42D19EE1.90809@engr.orst.edu>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig14C3632418C3CED1630E2480"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14C3632418C3CED1630E2480
Content-Type: multipart/mixed;
 boundary="------------070509070200020809070805"

This is a multi-part message in MIME format.
--------------070509070200020809070805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Aww crap, thunderbird screwed up the white space...

A usable version of the patch is attached, or here is a link:
http://dev.gentoo.org/~marineam/files/patch-radeonfb-2.6.12

Micheal Marineau wrote:
> 
> 
> diff -ru linux-2.6.12.orig/arch/i386/kernel/acpi/sleep.c
> linux-2.6.12/arch/i386/kernel/acpi/sleep.c
> --- linux-2.6.12.orig/arch/i386/kernel/acpi/sleep.c	2005-06-17
> 12:48:29.000000000 -0700
> +++ linux-2.6.12/arch/i386/kernel/acpi/sleep.c	2005-07-03
> 18:01:34.000000000 -0700
> @@ -5,6 +5,7 @@
>   *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
>   */
> 
> +#include <linux/module.h>
>  #include <linux/acpi.h>
>  #include <linux/bootmem.h>
>  #include <asm/smp.h>
> @@ -55,6 +56,31 @@
>  	zap_low_mappings();
>  }
> 
> +/*
> + * acpi_vgapost
> + */
> +
> +extern void do_vgapost_lowlevel (unsigned long);
> +
> +void acpi_vgapost (unsigned long slot)
> +{
> +  unsigned long flags, saved_video_flags = acpi_video_flags;
> +  acpi_video_flags = (slot & 0xffff) << 16 | 1;
> +  /* Map low memory and copy information */
> +  init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
> +  memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end -
> &wakeup_start);
> +  acpi_copy_wakeup_routine(acpi_wakeup_address);
> +  /* Tunnel thru real mode */
> +  local_irq_save(flags);
> +  do_vgapost_lowlevel(acpi_wakeup_address);
> +  local_irq_restore(flags);
> +  /* Restore mapping etc */
> +  zap_low_mappings();
> +  acpi_video_flags = saved_video_flags;
> +}
> +
> +EXPORT_SYMBOL (acpi_vgapost);
> +
>  /**
>   * acpi_reserve_bootmem - do _very_ early ACPI initialisation
>   *
> diff -ru linux-2.6.12.orig/arch/i386/kernel/acpi/wakeup.S
> linux-2.6.12/arch/i386/kernel/acpi/wakeup.S
> --- linux-2.6.12.orig/arch/i386/kernel/acpi/wakeup.S	2005-06-17
> 12:48:29.000000000 -0700
> +++ linux-2.6.12/arch/i386/kernel/acpi/wakeup.S	2005-07-03
> 18:01:34.000000000 -0700
> @@ -170,6 +170,32 @@
> 
>  _setbad: jmp setbad
> 
> +#
> +#	Real mode switch - verbatim from reboot.c
> +#
> +go_real:
> +	movl	%cr0, %eax
> +	andl	$0x00000011, %eax
> +	orl	$0x60000000, %eax
> +	movl	%eax, %cr0
> +	movl	%eax, %cr3
> +	movl	%cr0, %ebx
> +	andl	$0x60000000, %ebx
> +	jz	1f
> +	wbinvd
> +1:	andb	$0x10, %al
> +	movl	%eax, %cr0
> +go_real_jmp:		.byte	0xea
> +go_real_jmp_off:	.word	0x0000
> +go_real_jmp_seg:	.word	0x0000
> +#
> +# 	Real mode descriptor table
> +#
> +		.align	8
> +go_real_desc:	.quad	0x0000000000000000
> +go_real_cseg:	.quad	0x00009a000000ffff
> +go_real_dseg:	.quad	0x000092000000ffff
> +
>  	.code32
>  	ALIGN
> 
> @@ -309,6 +335,59 @@
>  	call acpi_enter_sleep_state_s4bios
>  	ret
> 
> +ENTRY(do_vgapost_lowlevel)
> +	# Convert target offset to physical address
> +	movl	%eax, %ecx
> +	subl	$__PAGE_OFFSET, %ecx
> +	# Fixup GDT pointer
> +	movl	%ecx, %edx
> +	addl	$go_real_desc - wakeup_start, %edx
> +	movl	%edx, go_real_gdt + 2
> +	# Fixup 16-bit CS descriptor
> +	movl	%ecx, %edx
> +	movw	%dx, go_real_cseg - wakeup_start + 2 (%eax)
> +	shrl	$16, %edx
> +	movb	%dl, go_real_cseg - wakeup_start + 4 (%eax)
> +	movb	%dh, go_real_cseg - wakeup_start + 7 (%eax)
> +	# Fixup 16-bit jump
> +	movl	%ecx, %edx
> +	shrl	$4, %edx
> +	movw	%dx, go_real_jmp_seg - wakeup_start (%eax)
> +	# Save state and registers
> +	call	save_processor_state
> +	call	save_registers
> +	# Reload page table with low mapping
> +	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
> +	movl	%eax, %cr3
> +	# Load IDTR and GDTR for real mode
> +	lidt	go_real_idt
> +	lgdt	go_real_gdt
> +	# Load DS & al
> +	movl	$0x0010, %eax
> +	movl	%eax, %ss
> +	movl	%eax, %ds
> +	movl	%eax, %es
> +	movl	%eax, %fs
> +	movl	%eax, %gs
> +	# Load CS
> +	call	$0x0008, $(go_real - wakeup_start)
> +	# Phony return code
> +	call	restore_registers
> +	call	restore_processor_state
> +	ret
> +	
> +	.align	4
> +	.word	0
> +go_real_idt:
> +	.word	0x3ff
> +	.long	0
> +	
> +	.align	4
> +	.word	0
> +go_real_gdt:
> +	.word	3*8-1
> +	.long	0
> +
>  ALIGN
>  # saved registers
>  saved_gdt:	.long	0,0
> diff -ru linux-2.6.12.orig/drivers/video/aty/radeon_pm.c
> linux-2.6.12/drivers/video/aty/radeon_pm.c
> --- linux-2.6.12.orig/drivers/video/aty/radeon_pm.c	2005-06-17
> 12:48:29.000000000 -0700
> +++ linux-2.6.12/drivers/video/aty/radeon_pm.c	2005-07-03
> 19:55:36.000000000 -0700
> @@ -2606,10 +2606,13 @@
> 
>   done:
>  	pdev->dev.power.power_state = state;
> +	pci_save_state (pdev);
> 
>  	return 0;
>  }
> 
> +extern void acpi_vgapost (unsigned long slot);
> +
>  int radeonfb_pci_resume(struct pci_dev *pdev)
>  {
>          struct fb_info *info = pci_get_drvdata(pdev);
> @@ -2619,6 +2622,12 @@
>  	if (pdev->dev.power.power_state == 0)
>  		return 0;
> 
> +	if (pdev->dev.power.power_state != 4)
> +	{
> +		pci_restore_state (pdev);
> +		acpi_vgapost (pdev->devfn);
> +	}
> +
>  	if (rinfo->no_schedule) {
>  		if (try_acquire_console_sem())
>  			return 0;


-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University


--------------070509070200020809070805
Content-Type: text/plain;
 name="patch-radeonfb-2.6.12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-radeonfb-2.6.12"

diff -ru linux-2.6.12.orig/arch/i386/kernel/acpi/sleep.c linux-2.6.12/arch/i386/kernel/acpi/sleep.c
--- linux-2.6.12.orig/arch/i386/kernel/acpi/sleep.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/arch/i386/kernel/acpi/sleep.c	2005-07-03 18:01:34.000000000 -0700
@@ -5,6 +5,7 @@
  *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
  */
 
+#include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <asm/smp.h>
@@ -55,6 +56,31 @@
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
diff -ru linux-2.6.12.orig/arch/i386/kernel/acpi/wakeup.S linux-2.6.12/arch/i386/kernel/acpi/wakeup.S
--- linux-2.6.12.orig/arch/i386/kernel/acpi/wakeup.S	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/arch/i386/kernel/acpi/wakeup.S	2005-07-03 18:01:34.000000000 -0700
@@ -170,6 +170,32 @@
 
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
 
@@ -309,6 +335,59 @@
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
diff -ru linux-2.6.12.orig/drivers/video/aty/radeon_pm.c linux-2.6.12/drivers/video/aty/radeon_pm.c
--- linux-2.6.12.orig/drivers/video/aty/radeon_pm.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/drivers/video/aty/radeon_pm.c	2005-07-03 19:55:36.000000000 -0700
@@ -2606,10 +2606,13 @@
 
  done:
 	pdev->dev.power.power_state = state;
+	pci_save_state (pdev);
 
 	return 0;
 }
 
+extern void acpi_vgapost (unsigned long slot);
+
 int radeonfb_pci_resume(struct pci_dev *pdev)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
@@ -2619,6 +2622,12 @@
 	if (pdev->dev.power.power_state == 0)
 		return 0;
 
+	if (pdev->dev.power.power_state != 4)
+	{ 
+		pci_restore_state (pdev);
+		acpi_vgapost (pdev->devfn);
+	}
+
 	if (rinfo->no_schedule) {
 		if (try_acquire_console_sem())
 			return 0;


--------------070509070200020809070805--

--------------enig14C3632418C3CED1630E2480
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC0Z/uiP+LossGzjARAmroAJ9GizKXRPgjCLvwTpBWp7LaBggi2QCfdVPQ
JmsP5gEDS3DUcRkwks2FrKY=
=fDLb
-----END PGP SIGNATURE-----

--------------enig14C3632418C3CED1630E2480--
