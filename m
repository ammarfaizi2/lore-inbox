Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263908AbUDOOIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbUDOOIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:08:34 -0400
Received: from [217.157.19.70] ([217.157.19.70]:27655 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S263908AbUDOOIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:08:31 -0400
Date: Thu, 15 Apr 2004 15:08:28 +0100 (BST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <medley@lists.infowares.com>,
       <linux-hotplug-devel@lists.sourceforge.net>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] [DRAFT] [udev PATCH] First attempt at vendor RAID support
 in 2.6
In-Reply-To: <407DD631.5020308@gmx.net>
Message-ID: <Pine.LNX.4.40.0404151458450.30892-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carl-Daniel,

On Thu, 15 Apr 2004, Carl-Daniel Hailfinger wrote:

> What I need:
> - People looking at the *_sb_helper functions to tell me if there is more
> magic I can check for
> - Criticism of coding style/ missing abstraction
> - People checking the numerous FIXMEs
> - More data about Medley/Highpoint vendor superblocks (can I check for
> bogus values?)
> - Help with sorting out who owns which copyrights

I'm on holiday in New York right now so I don't have time to give you a
complete breakdown. But I can give you a couple of comments on Medley RAID
and get back to you when I return next week.

First: It should not be called "SIL", "SII", or "Silicon Image" RAID in
the parts of the code exposed to the user. This is because other vendors
than Silicon Image use the Medley RAID specification (such as the CMD680R
SATA controller and others). When refering specifically to Silicon Image,
SII is the correct abbreviation, not "SIL".

You are asking for more magic to detect Medley RAID. The probe function
for Medley in my patch (medley_probe_drive()) first calls
medley_get_metadata() which uses the checksum to determine if it is a
Medley superblock. In my version, it also checks the PCI vendor ID/product
ID against that stored in the Medley superblock. This is consistent with
how the Medley BIOS verifies a valid Medley superblock and you should rely
on this for automatic detection. But since users might want to move the
RAID set to a different controller, e.g. if their on-board controller
breaks down, there should be an option to force detection to bypass the
PCI ID verification.

After you have a correct checksum there are several other things you can
check for, which I do in my medley_probe_drive() after obtaining the
superblock:

- Check raid_type, it should be 0 for striped sets (RAID0) - I will get
you the values for RAID1 and RAID1+0 when I return from NY.

- Check major_ver, it should be 1 or 2 (other major versions may have a
different superblock and can not be supported).

- Check that the chunk_size looks reasonable, that there is more than 1
drive in the set (drives_per_striped_set), and that the drive_number is
within the range 0-(drives_per_striped_set-1).

If you do all these checks and still come out with a valid candidate, it's
probably safe to assume that the drive belongs to a set if all the disks
are present.

I'll have a closer look when I return home.

// Thomas









>
> A few words about my implementation:
> The hasraidmagic bitfield in struct harddisk is probably a misnomer. If a
> bit is set it means that we found a superblock of the corresponding type
> and the disk can not be accessed as a plain disk (i.e. we need to setup
> something).
> raiddetect is a patch against udev-023 and should compile cleanly against
> klibc and glibc.
> Executing "raiddetect" will show nearly all info gathered about the block
> devices present in the system, whereas "raiddetect -s" should give you
> only a list of devices currently suspected to be part of an ATARAID array.
>
>
> Regards,
> Carl-Daniel
> --
> http://www.hailfinger.org/
>

