Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263194AbSJHNuC>; Tue, 8 Oct 2002 09:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJHNtp>; Tue, 8 Oct 2002 09:49:45 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:32272 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263194AbSJHNsO>; Tue, 8 Oct 2002 09:48:14 -0400
Message-ID: <3DA2E385.A16F9325@aitel.hist.no>
Date: Tue, 08 Oct 2002 15:54:13 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com> <3DA1E250.1C5F7220@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
[...]
> ext2 and ext3 filesystems are carved up into "block groups", aka
> "cylinder groups".  Each one is 4096*8 blocks - typically 128 MB.
> So you can easily have hundreds of blockgroups on a single partition.
> 
> The inode allocator is designed to arrange that files which are within the
> same directory fall in the same blockgroup, for locality of reference.
> 
> But new directories are placed "far away", in block groups which have
> plenty of free space.  (find_group_dir -> find a blockgroup for a
> directory).
> 
> The thinking here is that files in a separate directory are related,
> and files in different directories are unrelated.  So we can take
> advantage of that heuristic - go and use a new blockgroup each time
> a new directory is created.  This is a levelling algorithm which
> tries to keep all blockgroups at a similar occupancy level.
> That's a good thing, because high occupancy levels lead to fragmentation.
> 
> find_group_other() is basically first-fit-from-start-of-disk, and
> if we use that for directories as well as files, your untar-onto-a-clean-disk
> simply lays everything out in a contiguous chunk.
> 
> Part of the problem here is that it has got worse over time.  The
> size of a blockgroup is hardwired to blocksize*bits-in-a-byte*blocksize.
> But disks keep on getting bigger.  Five years ago (when, presumably, this
> algorithm was designed), a typical partition had, what?  Maybe four
> blockgroups?  Now it has hundreds, and so the "levelling" is levelling
> across hundreds of blockgroups and not just a handful.

If having only "a few" block groups really work better 
(even for todays bigger disks) then bigger
block groups seems like a solution.

changing the on-disk format might not be popular, but there
is no need for that.  Simply regard several on-disk block
groups as a bigger "allocation group" when using the above
algorithm.  This should be perfectly backwards compatible.

Helge Hafting
