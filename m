Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUGGEqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUGGEqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 00:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUGGEqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 00:46:00 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:17581 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S264903AbUGGEpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 00:45:50 -0400
X-Ironport-AV: i="3.81R,152,1083560400"; 
   d="scan'208"; a="42490602:sNHT25284796"
Date: Tue, 6 Jul 2004 23:45:50 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: Frediano Ziglio <freddyz77@tin.it>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: Fw: EDD enhanchement patch
In-Reply-To: <20040706171234.4b0462e1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407062248040.19141-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 06 Jul 2004 18:53:28 +0200
> From: Frediano Ziglio <freddyz77@tin.it>
> 
> This patch add support for DTPE data in EDD and mbr_signature. This
> patch do not solve fdisk problems but can help these programs to compute
> correct head count.

Thanks Frediano.  I don't think this is quite ready to include yet,
but I'm not philosophically opposed to it, so let's work it out.

First, I want to understand what information in the DPTE you need.  I
assume byte offset 4, bit 6 (LBA enable), and bytes 10-11 bit 3 (CHS
translation enabled) and bit 4 (LBA translation enabled), yes?  How
are you expecting tools like fdisk to use this information?

Second, your timing is unfortunate, as the patch won't apply given the
mbr_signature capture routines I submitted and were committed to BK in
the past week.  It'll have to be reworked against BK-current.

Now, for the patch:

diff -U10 -r linux-2.6.7.orig/arch/i386/boot/edd.S linux-2.6.7/arch/i386/boot/edd.S
+++ linux-2.6.7/arch/i386/boot/edd.S	2004-07-06 17:07:02.000000000 +0200
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-# Read the first sector of device 80h and store the 4-byte signature
-	movl	$0xFFFFFFFF, %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
-	movb	$READ_SECTORS, %ah
-	movb	$1, %al				# read 1 sector
-	movb	$0x80, %dl			# from device 80
-	movb	$0, %dh				# at head 0
-	movw	$1, %cx				# cylinder 0, sector 0
-	pushw	%es
-	pushw	%ds
-	popw	%es
-	movw	$EDDBUF, %bx
-	pushw   %dx             # work around buggy BIOSes
-	stc                     # work around buggy BIOSes
-	int     $0x13
-	sti                     # work around buggy BIOSes
-	popw    %dx
-	jc	disk_sig_done
-	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# store success
-disk_sig_done:
-	popw	%es

You whack obtaining the mbr_signature for the disk here, it'll come
back later...  OK.

-	movb	%dl, %ds:-8(%si)		# store device number
-	movb	%ah, %ds:-7(%si)		# store version
-	movw	%cx, %ds:-6(%si)		# store extensions
+	movb	%dl, %ds:-12(%si)		# store device number
+	movb	%ah, %ds:-11(%si)		# store version
+	movw	%cx, %ds:-10(%si)		# store extensions

Just at different offsets now, OK.

-	movw	$EDDPARMSIZE, %ds:(%si)		# put size
+	movw	$EDDPARMSIZE-16, %ds:(%si)		# put size

OK, though I dislike the magic value 16 there, would prefer a #define.


+	# copy EDD 2.0 informations
+	pushw	%ds
+	pushw	%es
+	pushw	%ds
+	popw	%es
+	pushw	%si
+	leaw	EDD2_OFFSET(%si), %di
+	ldsw	%ds:0x1a(%si), %si
+	movw	$8, %cx
+	rep
+	movsw
+	popw	%si
+	popw	%es
+	popw	%ds

This looks like it's copying 16 bytes, the whole DPTE, right?

-	movw    %ax, %ds:-4(%si)
-	movw    %ax, %ds:-2(%si)
+	movw    %ax, %ds:-8(%si)
+	movw    %ax, %ds:-6(%si)

OK.

-	movb	%al, %ds:-1(%si)                # Record max sect
-	movb    %dh, %ds:-2(%si)                # Record max head number
+	movb	%al, %ds:-5(%si)                # Record max sect
+	movb    %dh, %ds:-6(%si)                # Record max head number

OK.

-	movw    %ax, %ds:-4(%si)
+	movw    %ax, %ds:-8(%si)

OK.
 
-	movw	%si, %ax			# increment si
-	addw	$EDDPARMSIZE+EDDEXTSIZE, %ax
-	movw	%ax, %si
+
+# Read the first sector of device and store the 4-byte signature
+	movl	$0xFFFFFFFF, %eax
+	movl	%eax, %ds:-4(%si)		# assume failure
+	movb	$READ_SECTORS, %ah
+	movb	$1, %al				# read 1 sector
+	movb	$0, %dh				# at head 0
+	movw	$1, %cx				# cylinder 0, sector 0
+	pushw	%es
+	pushw	%ss
+	popw	%es
+	subw	$0x200, %sp
+	movw	%sp, %bx

Ahh, using the stack rather than empty_zero_page to read the sector
into.  That's clever.  How large is the stack though?

+	pushw	%bx
+	pushw   %dx             # work around buggy BIOSes
+	stc                     # work around buggy BIOSes
+	int     $0x13
+	sti                     # work around buggy BIOSes
+	popw    %dx
+	popw	%bx
+	jc	disk_sig_done
+	movl	MBR_SIG_OFFSET(%bx), %eax
+	movl	%eax, %ds:-4(%si)		# store success
+disk_sig_done:
+	addw	$0x200, %sp
+	popw	%es
+
+
+	addw	$EDDPARMSIZE+EDDEXTSIZE, %si	# increment si


The only problem I have with the above is that you're limited by the
space in empty_zero_page set aside for the edd info structures, which
is presently 6, though with your additions, I think should drop to 5.  My
latest in BK keeps mbr_signatures for the first 16 devices.

diff -U10 -r linux-2.6.7.orig/Documentation/i386/zero-page.txt linux-2.6.7/Documentation/i386/zero-page.txt
--- linux-2.6.7.orig/Documentation/i386/zero-page.txt	2004-06-01 11:49:45.000000000 +0200
+++ linux-2.6.7/Documentation/i386/zero-page.txt	2004-06-05 12:57:44.000000000 +0200
@@ -65,14 +65,13 @@
 0x211	char		loadflags:
 			bit0 = 1: kernel is loaded high (bzImage)
 			bit7 = 1: Heap and pointer (see below) set by boot
 				  loader.
 0x212	unsigned short	(setup.S)
 0x214	unsigned long	KERNEL_START, where the loader started the kernel
 0x218	unsigned long	INITRD_START, address of loaded ramdisk image
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
-0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
+0x2cc	4 bytes		unused (old DISK80_SIG_BUFFER, setup.S)

I think we can just remove the note if it's not used anymore.

 0x2d0 - 0x600		E820MAP
-0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
-0x600 - 0x7eb		EDDBUF (setup.S) for edd data
+0x600 - 0x863		EDDBUF (setup.S) for edd data

I believe the empty_zero_page ends at 0x7ff.  If I'm right, then we
need to reduce the number of devices probed by one such that we don't
overflow this space.

 static ssize_t
 edd_show_raw_data(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info;
-	ssize_t len = sizeof (info->params);
+	ssize_t len = sizeof (info->params) - 16;

Again, the magic 16.  Let's fix up the structure such that its members
are rightly sized, and use those lengths.

-	if (len > (sizeof(info->params)))
-		len = sizeof(info->params);
+	if (len > (sizeof(info->params)-16))
+		len = sizeof(info->params)-16;

ditto
 
+static ssize_t
+edd_show_dpte(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
+		return -EINVAL;
+
+	memcpy(buf, &info->params.port_base, 16);
+	return 16;
+}

Ok, this'll get gregkh's attention.  I was lazy with
edd_show_raw_data() returning raw data like this, and *not* using the
sysfs binary blob interface.  Rather than add another nonconformant
use, let's fix both of these to use this, and name it "raw_dpte"
instead.

+	
+	/* EDD 2.0 infos */
+	u16 port_base;
+	u16 port_command;
+	u8 drive_flags;
+	u8 proprietary_informations;
+	u8 irq;
+	u8 multi_sector_count;
+	u8 dma_control;
+	u8 programmed_io;
+	u16 drive_options;
+	u16 reserved5;
+	u8 extension_level;
+	u8 edd2_checksum;
 } __attribute__ ((packed));

The DPTE data needs to be in its own struct, not in edd_device_params
(which is only fn48 data), then tacked into the end of struct edd_info.

I'm out this week on vacation, and the next few weeks are busy with
OLS coming.  If you care to rework this against current BK, leaving
the mbr_signature list in its new place so we can keep 16 rather than
5 (I think those will be more useful than EDD in the near future given how
poor nearly all the BIOS implementations of EDD are still), then we
can review on the list again.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

