Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVARAZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVARAZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVARAZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:25:37 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40599 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261542AbVARAZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:25:06 -0500
Date: Tue, 18 Jan 2005 01:25:00 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 4054] Linux partition table reading
Message-ID: <20050118002446.GA29495@apps.cwi.nl>
References: <20050117094325.0b54606c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117094325.0b54606c.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 17 Jan 2005 03:21:30 -0800
> From: bugme-daemon@osdl.org
> Subject: [Bugme-new] [Bug 4054]
> 
> Problem Description:
> Dane-elec 512MB USB keychain drive (using factory FAT partitions)
> works fine in windows, and on friend's 2.6.10-rc2-mm4 dual Athlon XP,
> but partition won't mount on my K7/K8 machines.

Solution:

You have enabled CONFIG_ACORN_PARTITION_CUMANA. Don't.

Details:
In partitions/check.c the adfspart_check_CUMANA routine
is called earlier than msdos_partition().
This routine adfspart_check_CUMANA() does an adfs_partition() test to see
whether the thing is an adfs partition. That test does adfs_checkbblk()
which checks a checksum. The probability that random garbage will pass
this test is 1 in 256. Disable CONFIG_ACORN_PARTITION_CUMANA unless you
actually have an Acorn and Cumana partitions.

Remarks:
With low frequency people stumble over this problem.
Typically they enable all possible partition types
and do not read any help texts for the various types,
so adding warnings would not help.

Of course it is a bug that the kernel starts doing random partition
recognition. These USB devices all have a DOS-type partition table.
Certainly msdos_partition() should be tried first for them.

And earlier already, it is bad that block_dev.c:do_open() does an
automatic rescan_partitions().

Every now and then I mumble about these things, and usually Linus
disagrees. However, these days we have udev and partx and
blockdev --rereadpt.
I do not really see any reason why the kernel should do
automatic partition guessing for any disk encountered.
(That is just as bad as automatic mounting for any filesystems seen.)
I suppose we should slowly stop doing that, at least for all non-rootfs disks.

Andries

> Jan 17 03:52:00 erg kernel: SCSI device sda: 985088 512-byte hdwr sectors (504 MB)
> Jan 17 03:52:00 erg kernel: sda: Write Protect is off
> Jan 17 03:52:00 erg kernel:  /dev/scsi/host11/bus0/target0/lun0: [CUMANA/ADFS]
> p1<5>Attached scsi removable disk sda at scsi11, channel 0, id 0, lun 0
