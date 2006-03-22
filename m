Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWCVXoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWCVXoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWCVXoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:44:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:25057 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932632AbWCVXn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:43:59 -0500
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support
	2^32-1blocks(e2fsprogs)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
In-Reply-To: <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp>
References: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp>
	 <1142630359.15257.30.camel@dyn9047017100.beaverton.ibm.com>
	 <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 15:45:43 -0800
Message-Id: <1143071143.6086.70.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 14:57 +0900, Takashi Sato wrote:
> Hi,
> 
> > Hi,
> > 
> > Few comments on the patches:
> > 
> > 1) Both kernel patch and e2fsprogs doesn't seem to apply cleanly for
> > the versions you mentioned. I had to fix few rejects.
> 
> Sorry. My patches were corrupted because my poor mailer had
> removed spaces in the patch.
> I will take care of it when I update this patch.
> 
> > 2) I am still not able to make filesystem bigger than 8TB with your
> > patch. I get following message.
> > 
> > # fdisk -l /dev/md0
> > 
> > Disk /dev/md0: 10479.7 GB, 10479753756672 bytes
> > 2 heads, 4 sectors/track, -1736433664 cylinders
> > Units = cylinders of 8 * 512 = 4096 bytes
> > 
> > 
> > elm3b29:~/e2fsprogs-1.38/misc # ./mke2fs /dev/md0
> > mke2fs 1.38 (30-Jun-2005)
> > mke2fs: Filesystem too large.  No more than 2**31-1 blocks
> >         (8TB using a blocksize of 4k) are currently supported.
> > 
> > When I try to create "ext3":
> 
> As I said in my previous mail, You should specify -F option to
> create ext2/3 which has more than 2**31-1 blocks.
> It is because of the compatibility.
> 
> > elm3b29:~/e2fsprogs-1.38/misc # ./mke2fs -t ext3 /dev/md0
> > mke2fs 1.38 (30-Jun-2005)
> > mke2fs: invalid blocks count - /dev/md0
> > 
> > Were you able to test these changes ?
> 
> You should specify -j option to create ext3 as below.
> 
> # ./mke2fs -j /dev/md0

Okay. I tested your patches and mkfs changes.

I am able to create a >8TB filesystem and was able to
mount it :)

elm3b29:~ # df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2             79366980  76545536   2821444  97% /
tmpfs                  3574032         8   3574024   1% /dev/shm
/dev/md0             9833697924    131228 9677640816   1% /mnt

I run single "fsx" tests and quickly ran into issues. fsx complained
about data mismatch :(

Here is the "dmesg" output:

EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs error (device md0): ext3_new_block: Allocating block in system
zone - block = 131072
Aborting journal on device md0.
ext3_abort called.
EXT3-fs error (device md0): ext3_journal_start_sb: Detected aborted
journal
Remounting filesystem read-only
fsx-linux[15668]: segfault at fffffffffffffffb rip 00002b33b3eddda0 rsp
00007fffffef1e38 error 4
fsx-linux[15667]: segfault at fffffffffffffffb rip 00002b7736f5dda0 rsp
00007fffffb70da8 error 4
ext3_new_block: block was unexpectedly set in b_committed_data
EXT3-fs error (device md0) in ext3_reserve_inode_write: Journal has
aborted
fsx-linux[15666]: segfault at fffffffffffffffb rip 00002b0582de6da0 rsp
00007fffffd24f18 error 4
fsx-linux[15669]: segfault at 00000000ffffffff rip 00002ad94d283da0 rsp
00007fffff95aa28 error 4
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data



Thanks,
Badari

