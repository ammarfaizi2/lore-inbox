Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTJNNiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 09:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTJNNiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 09:38:16 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.36.232]:8389 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S262458AbTJNNiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 09:38:14 -0400
Date: Tue, 14 Oct 2003 08:38:09 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the boot disk
Message-ID: <20031014133804.GC15295@iguana.domsch.com>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel@vger.kernel.org
References: <20031014104508.GA5820@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014104508.GA5820@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 05:45:08AM -0500, Andries Brouwer wrote:
>    On Fri, Oct 10, 2003 at 09:05:47AM -0500, Matt Domsch wrote:
> 
>    >   There are 4 bytes in the MSDOS master boot record, at offset 0x228,
>    >   which may contain a per-system-unique signature.
> 
>    You mean 0x1b8.

Yes, my mistake, that is indeed what I meant.

I'm really glad to see recent grub and lilo versions preserve
0x1b8-0x1bb, that's necessary.

>    > This is useful in the case where the BIOS is not EDD3.0 compliant,
>    > thus doesn't provide the PCI bus/dev/fn and IDE/SCSI location of the
>    > boot disk, yet you need to know which disk is the boot disk.
> 
>    An old idea to distinguish disks is to store an md5sum of the first
>    sector.  That would partly remove the dependence on one particular boot sector
>    format.

Indeed, that's a decent idea, but I'd have to put md5sum into
real-mode assembly then? :-(

>    Can you remind me why you want to retrieve the boot disk?

Fair question.  Consider the case of automated factory install of a
new system.  One may configure the system to have multiple disk
controllers and multiple disks on them, attached in just about any
way.  One common configuration our customers like is to have two disks
attached to one controller on which to put the OS, then maybe 8 more
disks on a second SCSI backplane going to two channels of another
controller on which they want to build their database files.

Right now, there's no good way to determine programatically from
within Linux which disk controller and disk the BIOS will decide is
the boot device.  The system BIOS can be configured to say "boot to
the first disk on the first SCSI controller" for example, or if the
user instead wanted to boot to one of the 9 other drives, they could
configure that also.  So, people have choice in what their boot disk
is, but Linux doesn't know what that choice is.  All it knows is some
driver modules get loaded, in some (predetermined?) order, and sees
disks with names /dev/[hs]d[a-z] in some order that depends on driver
load order, driver PCI device lists, and PCI bus scan order (forward
or reverse).  Where should the installer put grub or lilo and your /
partition?  With 10 disks and no mechanism to know which one BIOS will
use as the boot disk, you've got a 10% chance of getting it right, and
until you try to boot into Linux after the install is complete, you
don't know if you got it right.  That doesn't cut it in the factory.

>    (Maybe we booted from ethernet or CDROM or USB device..)

For our factory process, ethernet is a distinct possibility, CD-ROM
and USB aren't - no human intervention allowed.  But you raise a good
point.

For ethernet, int13 device 80h is still your primary hard disk, the
one you would expect to boot from if not doing PXE.
For CD-ROM, int13 device 80h is still your primary hard disk, CD-ROM is
device FFh.

For USB storage, I don't know what int13 device 80h will be.  I'll
have to go play with that and see what our BIOSs do.  Hopefully, if
your BIOS is smart enough to let you boot to a USB hard drive, it will
have a mechanism to let you get/set the BIOS boot order
programatically from within Linux - Dell BIOSs allow such I know, or
it will have EDD3.0 capability.  That, combined with userspace smarts
to implement installation policy, e.g. if you booted to a USB device,
but want to install to the primary hard drive, here's how to determine
when you're in that situation and how to deal with it.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
