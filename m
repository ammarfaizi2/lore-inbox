Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRJKDNx>; Wed, 10 Oct 2001 23:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278079AbRJKDNe>; Wed, 10 Oct 2001 23:13:34 -0400
Received: from mailhost.enel.ucalgary.ca ([136.159.102.8]:16322 "EHLO
	mailhost.enel.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S278078AbRJKDNT>; Wed, 10 Oct 2001 23:13:19 -0400
From: Andreas Dilger <adilger@enel.ucalgary.ca>
Message-Id: <200110110313.f9B3Dje11005@munet-d.enel.ucalgary.ca>
Subject: Re: Dump corrupts ext2?
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 10 Oct 2001 21:13:40 -0600 (MDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9q31re$7hb$1@cesium.transmeta.com> from "H. Peter Anvin" at Oct 10, 2001 07:57:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> By author:    Andreas Dilger <adilger@turbolabs.com>
> > In Linus kernels 2.4.11+ the block devices and filesystems all use the
> > page cache, so no more coherency issues.
> 
> How do you find a random block in the page cache?  Last my
> understanding was that the page cache is organized by inode/offset,
> which wouldn't lend itself to looking up a random hardware block.

Doh, you are right of course.  I was just thinking "buffer cache" vs.
"page cache", but of course the address space of /dev/hda1 is different
than that of any file inside the mounted filesystem.  However, at least
the ext2 metadata is coherent between user space and kernel space (which
is half the battle when doing a backup) and your file data can only be
a few seconds out of date.

> I understand this can be done by sending a "quiet point" command to the
> filesystems, followed by an LVM snapshot, but I doubt may people do that!

Yes, there is now a hook in the VFS to support a snapshot of the filesystem
for backups (or whatever), which LVM uses.  It is directly supported by
ext3, reiserfs and XFS.  Other filesystems will only have a fsync_dev() and
write_super done, but this should be enough to get things to disk.

It turns out that this is also a handy thing for doing "live" fsck on an
ext2/ext3 filesystem for systems which don't get rebooted very often - you
can still verify that the disk/cables/kernel haven't corrupted anything.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
