Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSFDUlc>; Tue, 4 Jun 2002 16:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSFDUlb>; Tue, 4 Jun 2002 16:41:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20487 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316686AbSFDUla>;
	Tue, 4 Jun 2002 16:41:30 -0400
Message-ID: <3CFD25A2.FCC7F66A@zip.com.au>
Date: Tue, 04 Jun 2002 13:40:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CFD1FF0.4A02CE96@zip.com.au> <Pine.LNX.4.44.0206041320280.29100-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> I'd still love to see a "fast and slightly stupid" allocator for both
> blocks and inodes, and have some infrastructure to do run-time defragging
> in the background.
> 

I think runtime defrag could yield really good benefits.  In
particular it would allow us to find_group_dir(), and always
put directories in the same blockgroup as their parent (big
speedups for the `untar-a-kernel-tree' workload).

There's a patch at
http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre10/ext3-reloc-page.patch
which provides a simple `relocate page' ioctl for ext3 files.  It
relocates a page's blocks.  The operation is fully journalled and
pagecache-coherent.  So you can turn off the power in the middle
of a defrag operation and the fs will come back just fine.  It doesn't
make any attempt to relocate inodes.  If the page relocation attempt fails
then it just returns -EAGAIN and userspace gets to worry about what
to do.

I simply have not had the time to do anything about the userspace
program which drives that ioctl.  So if there's anyone out there
who has a little time on their hands...

-
