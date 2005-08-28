Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVH1B1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVH1B1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 21:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVH1B1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 21:27:50 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:43949 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S1750743AbVH1B1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 21:27:49 -0400
Message-ID: <43111313.8000800@engr.orst.edu>
Date: Sat, 27 Aug 2005 18:27:47 -0700
From: Michael Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050729)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Generic acpi vgapost
References: <43111298.80507@engr.orst.edu>
In-Reply-To: <43111298.80507@engr.orst.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFC382B997D3237A84E008414"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC382B997D3237A84E008414
Content-Type: multipart/mixed;
 boundary="------------090304000102030406040304"

This is a multi-part message in MIME format.
--------------090304000102030406040304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Generic function to post the video bios.

Based directly on the original patch by Ole Rohne.

Signed-off-by: Michael Marineau <marineam@engr.orst.edu>
-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------090304000102030406040304
Content-Type: text/x-patch;
 name="acpi-vgapost.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-vgapost.patch"

Index: linux-2.6.13-rc7/arch/i386/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.13-rc7.orig/arch/i386/kernel/acpi/sleep.c
+++ linux-2.6.13-rc7/arch/i386/kernel/acpi/sleep.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
  */
 
+#include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/dmi.h>
@@ -56,6 +57,34 @@ void acpi_restore_state_mem (void)
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
Index: linux-2.6.13-rc7/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux-2.6.13-rc7.orig/arch/i386/kernel/acpi/wakeup.S
+++ linux-2.6.13-rc7/arch/i386/kernel/acpi/wakeup.S
@@ -171,6 +171,32 @@ check_vesa:
 
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
 
@@ -310,6 +336,59 @@ ENTRY(do_suspend_lowlevel_s4bios)
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

--------------090304000102030406040304--

--------------enigFC382B997D3237A84E008414
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDERMTiP+LossGzjARAqpuAKCXy1iaphmHJJCsWPzgLC/9XvedgwCcDIYR
ZhwHEst/+JZMidtyWHeEpKI=
=+53f
-----END PGP SIGNATURE-----

--------------enigFC382B997D3237A84E008414--
