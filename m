Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUJDWA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUJDWA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUJDV5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:57:15 -0400
Received: from lists.us.dell.com ([143.166.224.162]:55532 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S268529AbUJDVsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:48:25 -0400
Date: Mon, 4 Oct 2004 16:48:04 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, jgarzik@pobox.com,
       david.balazic@hermes.si
Subject: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
Message-ID: <20041004214803.GC2989@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some controller BIOSes have problems with the legacy int13 fn02 READ
SECTORS command.  int13 fn42 EXTENDED READ is used in preference by
most boot loaders today, so lets use that.  If EXTENDED READ fails or
isn't supported, fall back to READ SECTORS.

This hopefully resolves the three reports of BIOSes which would either
long-pause (30+ seconds) or hang completely on the legacy READ SECTORS
command.

This also adds CONFIG_EDD_SKIP_MBR to eliminate reading the MBR on
each BIOS-presented disk, in case there are further problems in this
area.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- linux-2.6.9-rc3-mm2/include/linux/edd.h	Sat Aug 14 00:36:12 2004
+++ linux-2.5-edd/include/linux/edd.h	Mon Oct  4 15:20:54 2004
@@ -37,14 +37,18 @@
 #define EDDEXTSIZE 8		/* change these if you muck with the structures */
 #define EDDPARMSIZE 74
 #define CHECKEXTENSIONSPRESENT 0x41
+#define EXTENDEDREAD 0x42
 #define GETDEVICEPARAMETERS 0x48
 #define LEGACYGETDEVICEPARAMETERS 0x08
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
+#define FIXEDDISKSUBSET 0x0001
+#define GET_DEVICE_PARAMETERS_SUPPORTED 0x0007
 
 
 #define READ_SECTORS 0x02         /* int13 AH=0x02 is READ_SECTORS command */
 #define EDD_MBR_SIG_OFFSET 0x1B8  /* offset of signature in the MBR */
+#define EDD_DEV_ADDR_PACKET_LEN 0x10  /* for int13 fn42 */
 #define EDD_MBR_SIG_BUF    0x290  /* addr in boot params */
 #define EDD_MBR_SIG_MAX 16        /* max number of signatures to store */
 #define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at EDD_MBR_SIG_BUF
--- linux-2.6.9-rc3-mm2/drivers/firmware/Kconfig	Mon Oct  4 15:18:12 2004
+++ linux-2.5-edd/drivers/firmware/Kconfig	Mon Oct  4 15:20:08 2004
@@ -18,6 +18,17 @@ config EDD
           obscure configurations. Most disk controller BIOS vendors do
           not yet implement this feature.
 
+config EDD_SKIP_MBR
+	bool "EDD: Skip Master Boot Record read"
+	depends on EDD
+        default n
+	help
+	  Most controller BIOSs properly implement real-mode legacy
+	  READ SECTORS commands.  A few don't.
+
+	  If your controller hangs during the kernel's real-mode
+	  startup routine, say Y here.
+
 config EFI_VARS
 	tristate "EFI Variable Support via sysfs"
 	depends on EFI
--- linux-2.6.9-rc3-mm2/arch/i386/boot/edd.S	2004-10-04 15:47:20.000000000 -0500
+++ linux-2.5-edd/arch/i386/boot/edd.S	2004-10-04 15:45:37.000000000 -0500
@@ -7,20 +7,66 @@
  *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003, June 2004
  * legacy CHS retreival by Patrick J. LoPresti <patl@users.sourceforge.net>
  *      March 2004
+ * Use EXTENDED READ calls if possible, Matt Domsch, October 2004
  */
 
 #include <linux/edd.h>
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-# Read the first sector of each BIOS disk device and store the 4-byte signature
-edd_mbr_sig_start:
 	movb	$0, (EDD_MBR_SIG_NR_BUF)	# zero value at EDD_MBR_SIG_NR_BUF
+#ifndef(CONFIG_EDD_SKIP_MBR)
+	xorl	%edx, %edx
 	movb	$0x80, %dl			# from device 80
-	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
-edd_mbr_sig_read:
-	movl	$0xFFFFFFFF, %eax
-	movl	%eax, (%bx)			# assume failure
-	pushw	%bx
+
+edd_mbr_check_ext:
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl	%ecx, %ecx
+	movb	$CHECKEXTENSIONSPRESENT, %ah    # Function 41
+	movw	$EDDMAGIC1, %bx			# magic
+	pushw	%dx		                # work around buggy BIOSes
+	stc					# work around buggy BIOSes
+	int	$0x13				# make the call
+	sti					# work around buggy BIOSes
+	popw	%dx
+	jc	edd_start			# no more BIOS devices
+	cmpw	$EDDMAGIC2, %bx			# is magic right?
+	jne	edd_mbr_sig_next		# nope, next...
+	testw	$FIXEDDISKSUBSET, %cx		# EXTENDED READ supported?
+	jz	edd_mbr_read_sectors		# nope, use READ SECTORS
+
+edd_mbr_extended_read:
+# Fill out the device address packet here, make the fn42 call
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl	%ecx, %ecx
+	subw	$EDD_DEV_ADDR_PACKET_LEN, %sp	# put packet on stack
+	pushw	%si
+	movw	%sp, %si
+	movl	$0,   (%si)                      # zero out packet
+	movl	$0,  4(%si)
+	movl	$0,  8(%si)
+	movl	$0, 12(%si)
+	movb	$EDD_DEV_ADDR_PACKET_LEN, (%si) # length of packet
+	movb	$1, 2(%si)			# move 1 sector
+	movw	$EDDBUF, 4(%si)			# into EDDBUF
+	movw	%ds, 6(%si)			# EDDBUF seg is ds
+	movb	$EXTENDEDREAD, %ah
+	pushw	%dx		                # work around buggy BIOSes
+	stc					# work around buggy BIOSes
+	int	$0x13
+	sti					# work around buggy BIOSes
+	popw	%dx
+	popw	%si
+	addw	$EDD_DEV_ADDR_PACKET_LEN, %sp	# remove packet from stack
+	jnc   edd_mbr_store_sig
+	# otherwise, fall through to the legacy read function
+
+edd_mbr_read_sectors:
+# Read the first sector of each BIOS disk device and store the 4-byte signature
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl	%ecx, %ecx
 	movb	$READ_SECTORS, %ah
 	movb	$1, %al				# read 1 sector
 	movb	$0, %dh				# at head 0
@@ -28,23 +74,31 @@ edd_mbr_sig_read:
 	pushw	%es
 	pushw	%ds
 	popw	%es
-    	movw	$EDDBUF, %bx			# disk's data goes into EDDBUF
-	pushw	%dx             # work around buggy BIOSes
-	stc                     # work around buggy BIOSes
+	movw	$EDDBUF, %bx			# disk's data goes into EDDBUF
+	pushw	%dx		                # work around buggy BIOSes
+	stc					# work around buggy BIOSes
 	int	$0x13
-	sti                     # work around buggy BIOSes
+	sti					# work around buggy BIOSes
 	popw	%dx
 	popw	%es
-	popw	%bx
 	jc	edd_mbr_sig_done		# on failure, we're done.
+
+edd_mbr_store_sig:
+	xorl	%ebx, %ebx			# clear ebx
+	movb	%dl, %bl			# copy drive number to ebx
+	sub	$0x80, %bl			# subtract 80h from drive number
+	shlw	$2, %bx				# multiply by 4
+	addw	$EDD_MBR_SIG_BUF, %bx		# add to sig_buf
+						# bx now points to the right sig slot
 	movl	(EDDBUF+EDD_MBR_SIG_OFFSET), %eax # read sig out of the MBR
 	movl	%eax, (%bx)			# store success
 	incb	(EDD_MBR_SIG_NR_BUF)		# note that we stored something
+edd_mbr_sig_next:
 	incb	%dl				# increment to next device
-	addw	$4, %bx				# increment sig buffer ptr
 	cmpb	$EDD_MBR_SIG_MAX, (EDD_MBR_SIG_NR_BUF)	# Out of space?
-	jb	edd_mbr_sig_read		# keep looping
+	jb	edd_mbr_check_ext		# keep looping
 edd_mbr_sig_done:
+#endif
 
 # Do the BIOS Enhanced Disk Drive calls
 # This consists of two calls:
@@ -77,12 +131,35 @@ edd_start:
 	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
 						# kept just before that
 	movb	$0, (EDDNR)			# zero value at EDDNR
+	xorl	%edx, %edx
 	movb	$0x80, %dl			# BIOS device 0x80
 
 edd_check_ext:
+	pushw	%di				# zero out this edd_info block
+	pushw	%es
+	movw	%ds, %ax
+	movw	%ax, %es
+	movw	%si, %ax
+	subw	$EDDEXTSIZE, %ax
+	movw	%ax, %di
+	movl	$EDDEXTSIZE+EDDPARMSIZE, %ecx
+	xorl	%eax, %eax
+	cld
+	rep
+	stosb
+	popw	%es
+	popw	%di
+
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl	%ecx, %ecx
 	movb	$CHECKEXTENSIONSPRESENT, %ah    # Function 41
 	movw	$EDDMAGIC1, %bx			# magic
+	pushw	%dx		                # work around buggy BIOSes
+	stc					# work around buggy BIOSes
 	int	$0x13				# make the call
+	sti					# work around buggy BIOSes
+	popw	%dx
 	jc	edd_done			# no more BIOS devices
 
 	cmpw	$EDDMAGIC2, %bx			# is magic right?
@@ -93,25 +170,38 @@ edd_check_ext:
 	movw	%cx, %ds:-6(%si)		# store extensions
 	incb	(EDDNR)				# note that we stored something
 
+     	testw	$GET_DEVICE_PARAMETERS_SUPPORTED, %cx
+	jz	edd_get_legacy_chs	# nope, skip fn48
+
 edd_get_device_params:
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl	%ecx, %ecx
 	movw	$EDDPARMSIZE, %ds:(%si)		# put size
-	movw	$0x0, %ds:2(%si)		# work around buggy BIOSes
 	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
+	pushw	%dx		                # work around buggy BIOSes
+	stc					# work around buggy BIOSes
 	int	$0x13				# make the call
+	sti					# work around buggy BIOSes
+	popw	%dx
 						# Don't check for fail return
 						# it doesn't matter.
 edd_get_legacy_chs:
-	xorw    %ax, %ax
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl	%ecx, %ecx
 	movw    %ax, %ds:-4(%si)
 	movw    %ax, %ds:-2(%si)
-        # Ralf Brown's Interrupt List says to set ES:DI to
+	# Ralf Brown's Interrupt List says to set ES:DI to
 	# 0000h:0000h "to guard against BIOS bugs"
-	pushw   %es
+     	pushw   %es
 	movw    %ax, %es
 	movw    %ax, %di
 	pushw   %dx                             # legacy call clobbers %dl
 	movb    $LEGACYGETDEVICEPARAMETERS, %ah # Function 08
+	stc					# work around buggy BIOSes
 	int     $0x13                           # make the call
+	sti					# work around buggy BIOSes
 	jc      edd_legacy_done                 # failed
 	movb    %cl, %al                        # Low 6 bits are max
 	andb    $0x3F, %al                      #   sector number

