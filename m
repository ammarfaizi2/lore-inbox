Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTLSS5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 13:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTLSS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 13:57:13 -0500
Received: from smtp4.us.dell.com ([143.166.148.135]:4485 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP id S263522AbTLSS5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 13:57:11 -0500
Date: Fri, 19 Dec 2003 12:57:06 -0600 (CST)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: linux-kernel@vger.kernel.org
Subject: [RFC] 2.6.0 EDD enhancements
Message-ID: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For review and comment, three changesets against 2.6.0 at:

	bk pull http://mdomsch.bkbits.net/linux-2.5-edd

This will update the following files:

 Documentation/i386/zero-page.txt |    4 -
 arch/i386/boot/setup.S           |   21 ++++++
 arch/i386/kernel/edd.c           |  128 ++++++++++++++++++++++++++++++++++-----
 arch/i386/kernel/i386_ksyms.c    |    6 -
 arch/i386/kernel/setup.c         |    7 ++
 include/asm-i386/edd.h           |    6 +
 include/asm-i386/setup.h         |    1 
 7 files changed, 149 insertions, 24 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (03/12/18 1.1532.1.3)
   EDD: add sysfs symlinks for IDE devices
   
   Devices reporting as type "ATA" to the EDD 3.0 BIOS calls
   now get symlinks pointing from the int13_dev8x device
   to the IDE disk device in sysfs.
   
   EDD 3.0 maps all IDE devices on a single PCI device with a single
   device value; there's no concept of multiple channels,
   primary/secondary devices on a channel.  This may not be equivalent,
   but edd.c currently matches only based on ide_drive_t.lun ==
   EDD device value.  This should perhaps be taken up with
   the T13 committee, as their spec seems incomplete in this regard.

<Matt_Domsch@dell.com> (03/12/18 1.1532.1.2)
   EDD: enable symlinks to SCSI devices
   
   Symlinks from /sys/firmware/edd/int13_dev8x/disc to the appropriate
   SCSI discs were added a year ago, but disabled because the
   scsi_bus list contained non-'scsi_device's at that time, which
   could have lead to an improper pointer following.    The SCSI
   mid-layer has rectified this, so this code can be re-enabled
   in edd.c once again.

<Matt_Domsch@dell.com> (03/12/18 1.1532.1.1)
   EDD: read disk80 MBR signature, export through edd module
   
   There are 4 bytes in the MSDOS master boot record, at offset 0x1b8,
   which may contain a per-system-unique signature.  By first writing a
   unique signature to each disk in the system, then rebooting, and then
   reading the MBR to get the signature for the boot disk (int13 dev
   80h), userspace may use it to compare against disks it knows as named
   /dev/[hs]d[a-z], and thus determine which disk is the BIOS boot disk,
   thus where the /boot, / and boot loaders should be placed.
     
   This is useful in the case where the BIOS is not EDD3.0 compliant,
   thus doesn't provide the PCI bus/dev/fn and IDE/SCSI location of the
   boot disk, yet you need to know which disk is the boot disk.  It's
   most useful in OS installers.
      
   This patch retrieves the signature from the disk in setup.S, stores it
   in a space reserved in the empty_zero_page, copies it somewhere safe
   in setup.c, and exports it via
   /sys/firmware/edd/int13_disk80/mbr_signature in edd.c.  Code is
   covered under CONFIG_EDD=[ym].


Patches will follow.  Feedback welcome.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

