Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUG1MRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUG1MRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUG1MR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:17:29 -0400
Received: from guardian.hermes.si ([193.77.5.150]:47882 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S266891AbUG1MRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:17:21 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF0901F6@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>
Cc: Dave Jones <davej@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: RE: Weird:  30 sec delay during early boot
Date: Wed, 28 Jul 2004 14:16:19 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same delay as before.

I built 2.6.8-rc1 first, then patched and issued a "make bzImage";
maybe it did not copile all the new stuff ?


> ----------
> From: 	Matt Domsch[SMTP:Matt_Domsch@dell.com]
> Sent: 	14. julij 2004 0:16
> To: 	David Balazic
> Cc: 	Dave Jones; Andries Brouwer; Jeff Garzik; Pavel Machek; Linux
> Kernel; Andi Kleen; Andrew Morton
> Subject: 	Re: Weird:  30 sec delay during early boot
> 
> David, Jeff, would you mind trying the patch below on your systems
> which exhibit the long delays in the EDD real-mode code?
> 
> This does a few things:
> 1) it uses an int13 fn15 "Get Disk Type" command prior to doing the
> fn02 "Read Sectors" command, to try to determine if there is a disk
> present or not before reading its signature.
> 
> 2) A few registers are more fully zeroed out, in case the BIOS cared
> about things it shouldn't have.
> 
> Crossing my fingers that the delays are gone...
> -Matt
> 
> -- 
> Matt Domsch
> Sr. Software Engineer, Lead Engineer
> Dell Linux Solutions linux.dell.com & www.dell.com/linux
> Linux on Dell mailing lists @ http://lists.us.dell.com
> 
> ===== arch/i386/boot/edd.S 1.2 vs edited =====
> --- 1.2/arch/i386/boot/edd.S	2004-06-29 09:44:48 -05:00
> +++ edited/arch/i386/boot/edd.S	2004-07-13 16:48:50 -05:00
> @@ -12,13 +12,31 @@
>  #include <linux/edd.h>
>  
>  #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
> -# Read the first sector of each BIOS disk device and store the 4-byte
> signature
>  edd_mbr_sig_start:
> +	xor	%ebx, %ebx
> +	xor	%edx, %edx
>  	movb	$0, (EDD_MBR_SIG_NR_BUF)	# zero value at
> EDD_MBR_SIG_NR_BUF
> +       	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr
> in bx
>  	movb	$0x80, %dl			# from device 80
> -	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
> +
>  edd_mbr_sig_read:
> -	movl	$0xFFFFFFFF, %eax
> +# Do int13 fn15 first, as BIOS should know if a disk is present or not.
> +# This avoids long (>30s) delays waiting for the READ_SECTORS to a
> non-present disk.
> +	xor	%eax, %eax
> +	xor	%ecx, %ecx
> +       	movb	$GETDISKTYPE, %ah		# Function 15
> +	pushw	%dx				# which stomps on dx
> +	stc					# work around buggy BIOSes
> +    	int	$0x13				# make the call
> +	sti					# work around buggy BIOSes
> +	popw	%dx				# so get back dx
> +	jc	edd_mbr_sig_done		# no more BIOS devices
> +	cmpb	$HARDDRIVEPRESENT, %ah		# is hard drive present?
> +	jne	edd_mbr_sig_done		# no more BIOS devices
> +
> +# Read the first sector of each BIOS disk device and store the 4-byte
> signature
> +	xor	%ecx, %ecx
> +    	movl	$0xFFFFFFFF, %eax
>  	movl	%eax, (%bx)			# assume failure
>  	pushw	%bx
>  	movb	$READ_SECTORS, %ah
> ===== include/linux/edd.h 1.11 vs edited =====
> --- 1.11/include/linux/edd.h	2004-06-29 09:44:48 -05:00
> +++ edited/include/linux/edd.h	2004-07-13 16:05:14 -05:00
> @@ -49,6 +49,9 @@
>  #define EDD_MBR_SIG_MAX 16        /* max number of signatures to store */
>  #define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at
> EDD_MBR_SIG_BUF
>  				     in boot_params - treat this as 1 byte
> */
> +#define GETDISKTYPE 0x15          /* int13 AH=0x15 is Get Disk Type
> command */
> +#define HARDDRIVEPRESENT 0x03     /* int13 AH=15 return code in AH */
> +
>  #ifndef __ASSEMBLY__
>  
>  #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
> 
