Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbUKIVt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUKIVt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUKIVt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:49:57 -0500
Received: from linux.us.dell.com ([143.166.224.162]:49986 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261709AbUKIVtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:49:49 -0500
Date: Tue, 9 Nov 2004 15:49:35 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davej@redhat.com, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: EFI partition code broken..
Message-ID: <20041109214935.GA617@lists.us.dell.com>
References: <Pine.LNX.4.58.0411070959560.2223@ppc970.osdl.org> <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org> <20041107200351.GA3169@lists.us.dell.com> <Pine.LNX.4.58.0411071306000.24286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411071306000.24286@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 01:13:00PM -0800, Linus Torvalds wrote:
> On Sun, 7 Nov 2004, Matt Domsch wrote:
> > 
> > The check for invalid primary master boot record (PMBR) needs to be
> > moved up ahead of the reads for the GPTs (primary at the start of the
> > disk, alternate/backup at the end of the disk).  When first written,
> > Intel didn't specify that the PMBR (a normal DOS-like MBR partition
> > table with a single entry of type 0xEE covering the whole disk) *had*
> > to exist, so we let the code try looking for GPTs first.  When the
> > PMBR test was added, it should have been added ahead of the GPT tests,
> > not after.  I'll work up a patch to do just that, and will then remove
> > the dependency on IA64.  Fair enough?
> 
> Yes, sounds good. Also, if I understand you correctly, I would suggest
> actually taking the size of the disk from the PMBR 0xEE entry itself,
> rather than depend on what size the disk reports (perhaps double-check
> that it is sane, of course - the more careful the better).

While the PMBR 0xEE entry should cover the whole disk, I've got older
disks from Itanium1 Linux systems where it doesn't quite.  Likewise,
Windows systems appear to put 0xFFFFFFFF there, regardless of drive
size.  So that value can't be trusted.
 
> With people doing things like concatenating partitions with "md", the size
> of the disk itself is less important than what the partition table was set
> up with - even if the size reporting of the disk itself is reliable.
> 
> For example, let's say that you create a EFI table on a RAID (striped or
> whatever), and that in turn then means that the first sub-disk used for
> the RAID will contain (as part of the RAID array) the EFI signature in its 
> PMBR, we don't want to look at the GPT at the end of _that_ disk. See what 
> I'm saying?

Yes.

There are two ways to create software RAID volumes.

a) partition disks, put partitions in the array, then partition /dev/md_d0.

This is handled properly already.  The space projected to the OS as
the RAID volume does not include the underlying disks' partition table
sectors or last few sectors.  I tested this by making an md_d0 raid0
disk set, then partitioning that with GPT using parted, and all works
swimmingly, /dev/md_d0p[123456] all appeared as expected.  This is
the method that RAID autostart expects to find.

b) put whole disks in the array, then partition /dev/md_d0.

This isn't handled properly by existing code, because as you point
out, the MBR for the first disk and the MBR for the partitioned array
would occupy the same blocks.  In such a case, the GPT code would
blindly set up the disk with partitions (which were too big to have
fit on the disk), and then md would have done the same (with
partitions that fit in the md).  I've modified the GPT code to ignore
a partition table where the start or end blocks of the disk are
larger than the reported size of the disk.

There's a pathological case here, where you create a single-whole-disk
/dev/md_d0 device, then partition /dev/md_d0 into pieces.  I don't
know how to solve this, as the partition table data would occupy the
same space, and be valid for both configurations, but you would want
it to ignore the table on the disk and only care about the table on
the md.  I think this is just a case of "don't do that".

Patch to solve the immediate problem will follow in the next email.

Thanks,
Matt  

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
