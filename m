Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136749AbREAW73>; Tue, 1 May 2001 18:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136750AbREAW7T>; Tue, 1 May 2001 18:59:19 -0400
Received: from [63.231.122.81] ([63.231.122.81]:30767 "EHLO lynx.turbolabs.com")
	by vger.kernel.org with ESMTP id <S136749AbREAW7I>;
	Tue, 1 May 2001 18:59:08 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105012257.QAA27361@lynx.turbolabs.com>
Subject: Re: Maximum files per Directory
To: linux-kernel@vger.kernel.org (Linux kernel development list)
Date: Tue, 1 May 2001 16:57:02 -0600 (MDT)
In-Reply-To: <9cn80u$u19$1@cesium.transmeta.com> from "H. Peter Anvin" at May 01, 2001 01:58:06 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Not correct, there can't be more than 2^15 *directories* in a single
> directory.  I belive this is an ext2 limitation.

This is imposed by a number of issues:
- EXT2_LINK_MAX=32000 is checked for new subdirectories
- ext2 bg_used_dirs_count is a __u16
- inode->i_nlink (__kernel_nlink_t) is an unsigned short for some platforms

For stat (old interface) the st_nlinks count is also an unsigned short, so
we _should_ be able to increase EXT2_LINK_MAX to 65500 or so safely.  The
VFS will have problems if you increase the max link count over 65535 because
__kernel_nlink_t is __u16.

I see that reiserfs plays some tricks with the directory i_nlink count.
If you exceed 64536 links in a directory, it reverts to "1" and no longer
tracks the link count.

You will have problems with performance for directories this large on
stock ext2, unless you use Daniel Phillips' indexed directory patch.
I have tested 100k+ _files_ in a single directory without problems
(Daniel has tested 1M _files_ without problems).  I would NOT reccommend
doing this on your production mail server at this time, but it may be
worth testing at least...  It does not (yet) address the issue of lots of
subdirectories, but that is something that can be worked on at least.

http://kernelnewbies.org/~phillips/htree/

Cheers, Andreas
-- 
Andreas Dilger                               Turbolinux filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
