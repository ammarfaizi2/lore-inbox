Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUGGHlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUGGHlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 03:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUGGHlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 03:41:22 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:5557 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S264948AbUGGHlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 03:41:03 -0400
Subject: Re: Fw: EDD enhanchement patch
From: Frediano Ziglio <freddyz77@tin.it>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0407062248040.19141-100000@humbolt.us.dell.com>
References: <Pine.LNX.4.44.0407062248040.19141-100000@humbolt.us.dell.com>
Content-Type: text/plain
Message-Id: <1089186082.3458.76.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Jul 2004 09:41:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il mer, 2004-07-07 alle 06:45, Matt Domsch ha scritto:
> > Date: Tue, 06 Jul 2004 18:53:28 +0200
> > From: Frediano Ziglio <freddyz77@tin.it>
> > 
> > This patch add support for DTPE data in EDD and mbr_signature. This
> > patch do not solve fdisk problems but can help these programs to compute
> > correct head count.
> 
> Thanks Frediano.  I don't think this is quite ready to include yet,
> but I'm not philosophically opposed to it, so let's work it out.
> 
> First, I want to understand what information in the DPTE you need.  I
> assume byte offset 4, bit 6 (LBA enable), and bytes 10-11 bit 3 (CHS
> translation enabled) and bit 4 (LBA translation enabled), yes?  How
> are you expecting tools like fdisk to use this information?
> 

My idea it's base/control port and flags. In this way you are able to
say that disk it's a slave ide. Just issue a command like

$ cat /proc/ioports | grep ide
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03f6-03f6 : ide0
  f000-f007 : ide0
  f008-f00f : ide1
And you know which ide controller it's connected your disk.

> Second, your timing is unfortunate, as the patch won't apply given the
> mbr_signature capture routines I submitted and were committed to BK in
> the past week.  It'll have to be reworked against BK-current.
> 

:(
I think this it's the right place to download the patch
http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/

> Now, for the patch:
> 
> diff -U10 -r linux-2.6.7.orig/arch/i386/boot/edd.S linux-2.6.7/arch/i386/boot/edd.S
> +++ linux-2.6.7/arch/i386/boot/edd.S	2004-07-06 17:07:02.000000000 +0200
>  #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
> -# Read the first sector of device 80h and store the 4-byte signature
> -	movl	$0xFFFFFFFF, %eax
> -	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
> -	movb	$READ_SECTORS, %ah
> -	movb	$1, %al				# read 1 sector
> -	movb	$0x80, %dl			# from device 80
> -	movb	$0, %dh				# at head 0
> -	movw	$1, %cx				# cylinder 0, sector 0
> -	pushw	%es
> -	pushw	%ds
> -	popw	%es
> -	movw	$EDDBUF, %bx
> -	pushw   %dx             # work around buggy BIOSes
> -	stc                     # work around buggy BIOSes
> -	int     $0x13
> -	sti                     # work around buggy BIOSes
> -	popw    %dx
> -	jc	disk_sig_done
> -	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
> -	movl	%eax, (DISK80_SIG_BUFFER)	# store success
> -disk_sig_done:
> -	popw	%es
> 
> You whack obtaining the mbr_signature for the disk here, it'll come
> back later...  OK.
> 
> -	movb	%dl, %ds:-8(%si)		# store device number
> -	movb	%ah, %ds:-7(%si)		# store version
> -	movw	%cx, %ds:-6(%si)		# store extensions
> +	movb	%dl, %ds:-12(%si)		# store device number
> +	movb	%ah, %ds:-11(%si)		# store version
> +	movw	%cx, %ds:-10(%si)		# store extensions
> 
> Just at different offsets now, OK.
> 
> -	movw	$EDDPARMSIZE, %ds:(%si)		# put size
> +	movw	$EDDPARMSIZE-16, %ds:(%si)		# put size
> 
> OK, though I dislike the magic value 16 there, would prefer a #define.
> 

You are right. Perhaps it's better to define
- DPTE structure (dtpe_info)
- DPTESIZE (used in asm and C code)
- put dpte_info as a member of edd_info

> 
> +	# copy EDD 2.0 informations
> +	pushw	%ds
> +	pushw	%es
> +	pushw	%ds
> +	popw	%es
> +	pushw	%si
> +	leaw	EDD2_OFFSET(%si), %di
> +	ldsw	%ds:0x1a(%si), %si
> +	movw	$8, %cx
> +	rep
> +	movsw
> +	popw	%si
> +	popw	%es
> +	popw	%ds
> 
> This looks like it's copying 16 bytes, the whole DPTE, right?
> 

Yes.

> -	movw    %ax, %ds:-4(%si)
> -	movw    %ax, %ds:-2(%si)
> +	movw    %ax, %ds:-8(%si)
> +	movw    %ax, %ds:-6(%si)
> 
> OK.
> 
> -	movb	%al, %ds:-1(%si)                # Record max sect
> -	movb    %dh, %ds:-2(%si)                # Record max head number
> +	movb	%al, %ds:-5(%si)                # Record max sect
> +	movb    %dh, %ds:-6(%si)                # Record max head number
> 
> OK.
> 
> -	movw    %ax, %ds:-4(%si)
> +	movw    %ax, %ds:-8(%si)
> 
> OK.
>  
> -	movw	%si, %ax			# increment si
> -	addw	$EDDPARMSIZE+EDDEXTSIZE, %ax
> -	movw	%ax, %si

Here would be

addw	$EDDPARMSIZE+EDDEXTSIZE+DPTESIZE, %ax

> +
> +# Read the first sector of device and store the 4-byte signature
> +	movl	$0xFFFFFFFF, %eax
> +	movl	%eax, %ds:-4(%si)		# assume failure
> +	movb	$READ_SECTORS, %ah
> +	movb	$1, %al				# read 1 sector
> +	movb	$0, %dh				# at head 0
> +	movw	$1, %cx				# cylinder 0, sector 0
> +	pushw	%es
> +	pushw	%ss
> +	popw	%es
> +	subw	$0x200, %sp
> +	movw	%sp, %bx
> 
> Ahh, using the stack rather than empty_zero_page to read the sector
> into.  That's clever.  How large is the stack though?
> 

I don't know but usually it's some Kb.. I didn't know how large was
empty_zero_page...

> +	pushw	%bx
> +	pushw   %dx             # work around buggy BIOSes
> +	stc                     # work around buggy BIOSes
> +	int     $0x13
> +	sti                     # work around buggy BIOSes
> +	popw    %dx
> +	popw	%bx
> +	jc	disk_sig_done
> +	movl	MBR_SIG_OFFSET(%bx), %eax
> +	movl	%eax, %ds:-4(%si)		# store success
> +disk_sig_done:
> +	addw	$0x200, %sp
> +	popw	%es
> +
> +
> +	addw	$EDDPARMSIZE+EDDEXTSIZE, %si	# increment si
> 
> 
> The only problem I have with the above is that you're limited by the
> space in empty_zero_page set aside for the edd info structures, which
> is presently 6, though with your additions, I think should drop to 5.  My
> latest in BK keeps mbr_signatures for the first 16 devices.
> 
> diff -U10 -r linux-2.6.7.orig/Documentation/i386/zero-page.txt linux-2.6.7/Documentation/i386/zero-page.txt
> --- linux-2.6.7.orig/Documentation/i386/zero-page.txt	2004-06-01 11:49:45.000000000 +0200
> +++ linux-2.6.7/Documentation/i386/zero-page.txt	2004-06-05 12:57:44.000000000 +0200
> @@ -65,14 +65,13 @@
>  0x211	char		loadflags:
>  			bit0 = 1: kernel is loaded high (bzImage)
>  			bit7 = 1: Heap and pointer (see below) set by boot
>  				  loader.
>  0x212	unsigned short	(setup.S)
>  0x214	unsigned long	KERNEL_START, where the loader started the kernel
>  0x218	unsigned long	INITRD_START, address of loaded ramdisk image
>  0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
>  0x220	4 bytes		(setup.S)
>  0x224	unsigned short	setup.S heap end pointer
> -0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
> +0x2cc	4 bytes		unused (old DISK80_SIG_BUFFER, setup.S)
> 
> I think we can just remove the note if it's not used anymore.
> 
>  0x2d0 - 0x600		E820MAP
> -0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
> -0x600 - 0x7eb		EDDBUF (setup.S) for edd data
> +0x600 - 0x863		EDDBUF (setup.S) for edd data
> 
> I believe the empty_zero_page ends at 0x7ff.  If I'm right, then we
> need to reduce the number of devices probed by one such that we don't
> overflow this space.
> 

:( quite short... Another way to reduce space it's to use dynamic sizes.
Must BIOS did not fill all edd_device_params but just some bytes...

>  static ssize_t
>  edd_show_raw_data(struct edd_device *edev, char *buf)
>  {
>  	struct edd_info *info;
> -	ssize_t len = sizeof (info->params);
> +	ssize_t len = sizeof (info->params) - 16;
> 
> Again, the magic 16.  Let's fix up the structure such that its members
> are rightly sized, and use those lengths.
> 
> -	if (len > (sizeof(info->params)))
> -		len = sizeof(info->params);
> +	if (len > (sizeof(info->params)-16))
> +		len = sizeof(info->params)-16;
> 
> ditto
>  
> +static ssize_t
> +edd_show_dpte(struct edd_device *edev, char *buf)
> +{
> +	struct edd_info *info;
> +	if (!edev)
> +		return -EINVAL;
> +	info = edd_dev_get_info(edev);
> +	if (!info || !buf)
> +		return -EINVAL;
> +
> +	memcpy(buf, &info->params.port_base, 16);
> +	return 16;
> +}
> 
> Ok, this'll get gregkh's attention.  I was lazy with
> edd_show_raw_data() returning raw data like this, and *not* using the
> sysfs binary blob interface.  Rather than add another nonconformant
> use, let's fix both of these to use this, and name it "raw_dpte"
> instead.
> 

Ok.

> +	
> +	/* EDD 2.0 infos */
> +	u16 port_base;
> +	u16 port_command;
> +	u8 drive_flags;
> +	u8 proprietary_informations;
> +	u8 irq;
> +	u8 multi_sector_count;
> +	u8 dma_control;
> +	u8 programmed_io;
> +	u16 drive_options;
> +	u16 reserved5;
> +	u8 extension_level;
> +	u8 edd2_checksum;
>  } __attribute__ ((packed));
> 
> The DPTE data needs to be in its own struct, not in edd_device_params
> (which is only fn48 data), then tacked into the end of struct edd_info.
> 

Ok

> I'm out this week on vacation, and the next few weeks are busy with
> OLS coming.  If you care to rework this against current BK, leaving
> the mbr_signature list in its new place so we can keep 16 rather than
> 5 (I think those will be more useful than EDD in the near future given how
> poor nearly all the BIOS implementations of EDD are still), then we
> can review on the list again.
> 
> Thanks,
> Matt

There are different level of EDD. EDD 1.0 is supported by most BIOSes.
I don't understand why using DOS my BIOS seems to return correctly DPTE
info while running Linux DPTE are not filled...

freddy77


