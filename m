Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316166AbSEJXsN>; Fri, 10 May 2002 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316169AbSEJXsM>; Fri, 10 May 2002 19:48:12 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:18670 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316166AbSEJXsL>; Fri, 10 May 2002 19:48:11 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 10 May 2002 17:46:23 -0600
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Jeremy Andrews <jeremy@kerneltrap.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020510234623.GC12975@turbolinux.com>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	Jeremy Andrews <jeremy@kerneltrap.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au> <20020510084713.43ce396e.jeremy@kerneltrap.org> <15580.7052.396951.568702@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2002  05:12 +1000, Peter Chubb wrote:
> See http://www.gelato.unsw.edu.au/~peterc/lfs.html
> (which I'm intending to update next week, after some testing to
> check the new limits with my new code -- I found the 1TB limit in
> the generic code (someone using a signed int instead of unsigned long))

Any chance you could rename this from "LFS" to something else (e.g. LBD
for Large Block Device).  LFS == Large File Summit which describes the
use/access of > 2GB _files_ on 32-bit systems under Unix.

> There are three different limits that apply:
> 
>  --- The physical layout on disc (e.g., ext2 uses 32-bit for block
>      numbers within a file system; thus the max size is
>      (2^32-1)*block_size;  although it's theoretically possible to use
>      larger blocksizes, the current toolchain has a maximum of 4k,
>      thus the largest size of an ext[23] filesystem is ((2^32)-1)*4k
>      bytes --- around 16TB)

For 64-bit systems like Alpha, it is relatively easy to use 8kB blocks for
ext3.  It has been discouraged because such a filesystem is non-portable
to other (smaller page-sized) filesystems.  Maybe this rationale should
be re-examined - I could probably whip up a configure option for
e2fsprogs to allow 8kB blocks in a few hours.

Does x86-64 and/or ia64 actually _use_ > 4kB page sizes?  If so, it
may be more worthwhile to allow larger block sizes with e2fsprogs.
It may be that the kernel supports >4kB blocks already on systems with
larger PAGE_SIZE, I don't know (no way for me to test this).

>      It's extremely unlikely that you'd want to use a non-journalled
>      file system on such a large partition, so your best bets are
>      reiserfs, jfs or XFS.

I find it somewhat ironic that you suggest reiserfs over ext3, when in
fact they both currently have the same 16TB filesystem limit.  On your
web page, you say the ext[23] limit is 1TB, which it definitely is not
(unless there are bugs in the code).  There is currently a 16TB filesystem
limit for 4kB blocks, but there are plans towards fixing that also.

>  --- Limitations imposed by the partitioning scheme.
>      As far as I know, only the EFI GUID partitioning scheme uses
>      64-bit block offsets, so under any other scheme you're limited to
>      2^32 or 2^31 blocks per disc; some use the underlying hardware
>      sector size, some use a block size that's  multiple of this.

LVM does not need to have partitions, and presumably EVMS using Linux
or AIX LVM devices doesn't either.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

