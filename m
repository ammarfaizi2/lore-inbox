Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUGNCdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUGNCdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 22:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267299AbUGNCdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 22:33:09 -0400
Received: from lists.us.dell.com ([143.166.224.162]:46973 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267298AbUGNCdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 22:33:02 -0400
Date: Tue, 13 Jul 2004 21:32:33 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Balazic <david.balazic@hermes.si>, Dave Jones <davej@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040714023233.GA15328@lists.us.dell.com>
References: <600B91D5E4B8D211A58C00902724252C035F1D0C@piramida.hermes.si> <20040713221623.GA10480@lists.us.dell.com> <40F463B0.1010706@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <40F463B0.1010706@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2004 at 06:35:28PM -0400, Jeff Garzik wrote:
> Can you attach the patch, or switch mailers?
> 
> The patch is word-wrapped and otherwise munged :(

That was sent with mutt-1.4.1-3 on a RHEL3 system...

Attached this time.
-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="30sec_delay.patch"

===== arch/i386/boot/edd.S 1.2 vs edited =====
--- 1.2/arch/i386/boot/edd.S	2004-06-29 09:44:48 -05:00
+++ edited/arch/i386/boot/edd.S	2004-07-13 16:48:50 -05:00
@@ -12,13 +12,31 @@
 #include <linux/edd.h>
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-# Read the first sector of each BIOS disk device and store the 4-byte signature
 edd_mbr_sig_start:
+	xor	%ebx, %ebx
+	xor	%edx, %edx
 	movb	$0, (EDD_MBR_SIG_NR_BUF)	# zero value at EDD_MBR_SIG_NR_BUF
+       	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
 	movb	$0x80, %dl			# from device 80
-	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
+
 edd_mbr_sig_read:
-	movl	$0xFFFFFFFF, %eax
+# Do int13 fn15 first, as BIOS should know if a disk is present or not.
+# This avoids long (>30s) delays waiting for the READ_SECTORS to a non-present disk.
+	xor	%eax, %eax
+	xor	%ecx, %ecx
+       	movb	$GETDISKTYPE, %ah		# Function 15
+	pushw	%dx				# which stomps on dx
+	stc					# work around buggy BIOSes
+    	int	$0x13				# make the call
+	sti					# work around buggy BIOSes
+	popw	%dx				# so get back dx
+	jc	edd_mbr_sig_done		# no more BIOS devices
+	cmpb	$HARDDRIVEPRESENT, %ah		# is hard drive present?
+	jne	edd_mbr_sig_done		# no more BIOS devices
+
+# Read the first sector of each BIOS disk device and store the 4-byte signature
+	xor	%ecx, %ecx
+    	movl	$0xFFFFFFFF, %eax
 	movl	%eax, (%bx)			# assume failure
 	pushw	%bx
 	movb	$READ_SECTORS, %ah
===== include/linux/edd.h 1.11 vs edited =====
--- 1.11/include/linux/edd.h	2004-06-29 09:44:48 -05:00
+++ edited/include/linux/edd.h	2004-07-13 16:05:14 -05:00
@@ -49,6 +49,9 @@
 #define EDD_MBR_SIG_MAX 16        /* max number of signatures to store */
 #define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at EDD_MBR_SIG_BUF
 				     in boot_params - treat this as 1 byte  */
+#define GETDISKTYPE 0x15          /* int13 AH=0x15 is Get Disk Type command */
+#define HARDDRIVEPRESENT 0x03     /* int13 AH=15 return code in AH */
+
 #ifndef __ASSEMBLY__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)

--envbJBWh7q8WU6mo--
