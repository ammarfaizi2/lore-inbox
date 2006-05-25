Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWEYS1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWEYS1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWEYS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:27:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:58837 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030287AbWEYS1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:27:47 -0400
Subject: Re: [UPDATE][0/24]extend file size and filesystem size
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: sho@tnes.nec.co.jp
Cc: adilger@clusterfs.com, jitendra@linsyssoft.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060525213906sho@rifu.tnes.nec.co.jp>
References: <20060525213906sho@rifu.tnes.nec.co.jp>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 25 May 2006 11:27:19 -0700
Message-Id: <1148581640.3715.16.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 21:39 +0900, sho@tnes.nec.co.jp wrote:

> This reform consists of the following 23 patches.
> Five of them([12/24], [13/24], [14/24], [18/24], [22/24]) are the
> patches I modified this time,
> 
> two of them([1/24], [2/24]) are the update of Minming Cao's patches
> linked from the following URL,
> 
>   http://marc.theaimsgroup.com/?l=ext2-devel&m=114368281629281&w=2
> 

Hi,

As we have discussed before, it's saner to define ext3 fs blocks type
and group block type and then fix the kernel ext3 block variable type
bugs....So above patches from me are going to be replaced by a new set
of ext3 filesystem blocks patches, I have sent out a RFC to the ext2-
devel list in the last few weeks:

http://marc.theaimsgroup.com/?l=ext2-devel&m=114722190816690&w=2

http://marc.theaimsgroup.com/?l=ext2-devel&m=114784919525942&w=2

I am testing this series patches now, shall post the updated full series
to the list soon.

> one of them([19/24]) is the update of Jitendra Pawar's patch linked
> from the following URL,
> 
>   http://marc.theaimsgroup.com/?l=ext2-devel&m=114734611020743&w=2
> 
> and the others are just the same as before except for version.
> Minming, Jitendra, thanks for your help.
> 
> I'm working on typedef, but haven't merged yet.
> 
> 
> ----------------------
>   Summary Of Patches
> ----------------------
> The following is the patches for applying to linux-2.6.17-rc4.
> 
>   [1/24]  modify around the block allocation code(ext3)
>           - Modify around the ext3 block allocation code to replace
>             "int" type filesystem block number with "unsigned long".
> 
>   [2/24]  modify non block allocation code(ext3)
>           - Same fix as above.
> 
>   [3/24]  add percpu_llcounter for ext3
>           - The number of blocks and inodes are counted using
>             percpu_counter whose entry for counter is long type, so it
>             can only have less than 2G-1.  Then I add percpu_llcounter
>             whose entry for counter is long long type in ext3.
> 
>   [4/24]  add percpu_llcounter for ext2
>           - Same fix as ext3 described above [3/23].
> 

The percpu counter data type changes to support more than 31 bit ext3
has been posted and included in mm tree:
http://marc.theaimsgroup.com/?l=ext2-devel&m=114469200807475&w=2

The 2.6.17-rc4 version of this percpu counter patch could be found here:
http://ext2.sourceforge.net/48bitext3/patches/patches-2.6.17-
rc4-05242006/percpu_counter_longlong.patch


>   [5/24]  modify format strings in print(ext3)
>           - The part which prints the signed value, related to a block
>             and an inode, in decimal is corrected so that it can print
>             unsigned one.
> 

This has been discussed as well, we decide the define a format string
for filesystem block, so we don't have to re-do the same work when
moving ext3 from 32 bit to 48 bit.

>   [6/24]  modify format strings in print(ext2)
>           - Same fix as ext3 described above [5/23].
> 
>   [7/24]  modify format strings in print(bfs)
>           - As i_blocks of VFS inode gets 8 byte variable, change its
>             string format to %lld.
> 
>   [8/24]  modify format strings in print(efs)
>           - Same fix as bfs described above [7/23].
> 
>   [9/24]  modify format strings in print(jbd)
>           - Same fix as ext3 described above [5/23].
> 
>   [10/24]  change the type of variables manipulating a block or an
>           inode(ext3)
>           - Change the type of 4byte variables manipulating a block or
>             an inode from signed to unsigned.
> 
>           - Where an overflow occurs in process of operation, casting
>             it to long long.
> 
>   [11/24]  change the type of variables manipulating a block or an
>            inode(ext2)
>           - Same fix as ext3 described above [10/23].
> 
>   [12/24] enlarge block size(ext3)
>           - Add an incompat flag "EXT3_FEATURE_INCOMPAT_LARGE_BLOCK"
>             which indicates that the filesystem is extended.
> 
>           - Allow block size till pagesize in ext3.
> 
>   [13/24] extend file size(ext3)
>           - If the flag is set to super block, i_blocks of disk inode
>             (ext3_inode) is filesystem-block unit, and i_blocks of VFS
>             inode is sector unit.
> 
>           - If the flag is set to super block, max file size is set to
>             (FS blocksize) * (2^32 -1).
> 
>   [14/24] extend file size(ext2)
>           - Same fix as ext3 described above [13/23].
> 
> 
> The following is the patches for applying to e2fsprogs-1.39-WIP-2006-04-09.
> 
>   [15/24] modify format strings in print
>           - The part which prints the signed value, related to a block
>             and an inode, in decimal is corrected so that it can print
>             unsigned one.
> 
>   [16/24] change the type of variables manipulating a block and an
>           inode
>           - Change the type of 4byte variables manipulating a block or
>             an inode from signed to unsigned.
> 
>           - Where an overflow occurs in process of operation, casting
>             it to long long.
> 
>   [17/24] change the type of variables which manipulate bitmap
>           - Change the type of 4byte variables manipulating bitmap
>             from signed to unsigned.
> 
>   [18/24] enlarge file size and filesystem size
>           - Add an option "-O large_block" in mke2fs.
> 
>           - With this option, the maximum size of a file is (blocksize)
>             * (2^32-1) bytes, and of a filesystem is (pagesize) *
>            (2^32-1).
> 
>   [19/24] large files and filesystem support
>           - This fixes what remains unmodified.
> 
> 
> The following is the patches for applying to ext2resize-1.1.19.
> 
>   [20/24] fix the bug related to the option "resize_inode"
>           - A format of resize-inode in ext2prepare is different from
>             the one in mke2fs, so ext2prepare fails.  Then I adapt
>             ext2prepare's to mke2fs's.
> 
>   [21/24] fix the bug that an offset of an inode table is erroneously
>           calculated
>           - Running ext2resize results in failure due to an erroneous
>             offset of an inode table, then I fix how to calculate it.
> 
>   [22/24] enlarge file size and filesystem size
>           - With "-O large_block" option in mke2fs, the maximum size of
>             a file is (blocksize) * (2^32-1) bytes, and of a filesystem
>             is (pagesize) * (2^32-1).
> 
>   [23/24] change the type of variables manipulating a block or an inode
>           - Change the type of 4byte variables manipulating a block or
>             an inode from signed to unsigned.
> 
>           - Where an overflow occurs in process of operation, casting
>             it to long long.
> 
>   [24/24] modify format strings in print
>           - The part which prints the signed value, related to a block
>             and an inode, in decimal is corrected so that it can print
>             unsigned one.
> 
> 
> Andreas, does this fix meet your demand?
> 
> 
> Cheers, sho

