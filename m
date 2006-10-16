Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWJPG1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWJPG1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWJPG1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:27:34 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:44218 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1161048AbWJPG1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:27:33 -0400
Date: Sun, 15 Oct 2006 23:27:33 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Neil Brown <neilb@suse.de>, vherva@vianova.fi,
       linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
In-Reply-To: <20061016060227.GA3090@apps.cwi.nl>
Message-ID: <Pine.LNX.4.64.0610152313420.10294@twinlark.arctic.org>
References: <17710.54489.486265.487078@cse.unsw.edu.au> <20061015082921.GC22674@vianova.fi>
 <17714.51511.845336.721450@cse.unsw.edu.au> <20061016060227.GA3090@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Andries Brouwer wrote:

> On Mon, Oct 16, 2006 at 09:50:15AM +1000, Neil Brown wrote:
> > On Sunday October 15, vherva@vianova.fi wrote:
> 
> > > I wonder if there's ever a change the kernel partition detection code could
> > > _write_ on the disk, even when there's really no partition table?
> > 
> > No, kernel partition detection never writes.
> 
> There is something else that writes, however, that I have gotten complaints about.
> (But I have not investigated.)
> People doing forensics take a copy of a disk and want to preserve
> that copy as-is, never changing a single bit, only looking at it.
> But it is reported that also when a partition is mounted read-only,
> the journaling code of ext3 will write to the journal.

xfs has a similar problem -- on umount it writes even if the filesystem
was mounted read-only.  for example here's a test with a small loopback
device, note the two WRITEs to loop0 near the bottom of the block_dump.

# echo 1 >/proc/sys/vm/block_dump; mount -o ro /dev/loop/0 /mnt; sleep 1; umount /mnt; sleep 1; echo 0 >/proc/sys/vm/block_dump

<7>mount(14602): READ block 0 on loop0
<7>mount(14602): READ block 8 on loop0
<7>mount(14602): READ block 16 on loop0
<7>mount(14602): READ block 24 on loop0
<7>mount(14602): READ block 32 on loop0
<7>mount(14602): READ block 40 on loop0
<7>mount(14602): READ block 48 on loop0
<7>mount(14602): READ block 56 on loop0
<7>mount(14602): READ block 64 on loop0
<7>mount(14602): READ block 72 on loop0
<7>mount(14602): READ block 80 on loop0
<7>mount(14602): READ block 88 on loop0
<7>mount(14602): READ block 96 on loop0
<7>mount(14602): READ block 104 on loop0
<7>mount(14602): READ block 112 on loop0
<7>mount(14602): READ block 120 on loop0
<7>mount(14602): READ block 128 on loop0
<7>mount(14602): READ block 136 on loop0
<7>mount(14602): READ block 144 on loop0
<7>mount(14602): READ block 152 on loop0
<7>mount(14602): READ block 160 on loop0
<7>mount(14602): READ block 168 on loop0
<7>mount(14602): READ block 176 on loop0
<7>mount(14602): READ block 184 on loop0
<7>mount(14602): READ block 192 on loop0
<7>mount(14602): READ block 200 on loop0
<7>mount(14602): READ block 208 on loop0
<7>mount(14602): READ block 216 on loop0
<7>mount(14602): READ block 224 on loop0
<7>mount(14602): READ block 232 on loop0
<7>mount(14602): READ block 240 on loop0
<7>mount(14602): READ block 248 on loop0
<7>mount(14602): READ block 0 on loop0
<7>mount(14602): READ block 524280 on loop0
<5>XFS mounting filesystem loop0
<7>mount(14602): READ block 262176 on loop0
<7>mount(14602): READ block 271775 on loop0
<7>mount(14602): READ block 266975 on loop0
<7>mount(14602): READ block 264575 on loop0
<7>mount(14602): READ block 263375 on loop0
<7>mount(14602): READ block 262775 on loop0
<7>mount(14602): READ block 262475 on loop0
<7>mount(14602): READ block 262325 on loop0
<7>mount(14602): READ block 262250 on loop0
<7>mount(14602): READ block 262213 on loop0
<7>mount(14602): READ block 262194 on loop0
<7>mount(14602): READ block 262185 on loop0
<7>mount(14602): READ block 262180 on loop0
<7>mount(14602): READ block 262178 on loop0
<7>mount(14602): READ block 262179 on loop0
<7>mount(14602): READ block 262176 on loop0
<7>mount(14602): READ block 262176 on loop0
<7>mount(14602): READ block 262179 on loop0
<7>mount(14602): READ block 262178 on loop0
<7>mount(14602): READ block 262179 on loop0
<7>mount(14602): READ block 64 on loop0
<7>Ending clean XFS mount for filesystem: loop0
<7>mount(14602): dirtied inode 8880357 (blkid.tab-rOdAVQ) on md3
<7>mount(14602): dirtied inode 8880459 (?) on md3
<7>md3_raid1(821): WRITE block 147539744 on sdb4
<7>md3_raid1(821): WRITE block 147539744 on sda4
<7>md3_raid1(821): WRITE block 147539760 on sdb4
<7>md3_raid1(821): WRITE block 147539760 on sda4
<7>md3_raid1(821): WRITE block 147539768 on sdb4
<7>md3_raid1(821): WRITE block 147539768 on sda4
<7>md3_raid1(821): WRITE block 147539720 on sdb4
<7>md3_raid1(821): WRITE block 147539720 on sda4
<7>md3_raid1(821): WRITE block 147539784 on sdb4
<7>md3_raid1(821): WRITE block 147539784 on sda4
<7>umount(14607): WRITE block 0 on loop0
<7>loop0(14289): dirtied inode 19 (test) on md3
<7>umount(14607): WRITE block 0 on loop0
<7>umount(14607): dirtied inode 8880877 (mtab.tmp) on md3
<7>zsh(4125): dirtied inode 4026531942 (block_dump) on proc

-dean
