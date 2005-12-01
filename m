Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVLAOc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVLAOc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVLAOc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:32:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:15747 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932249AbVLAOc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:32:26 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 01 Dec 2005 08:32:19 -0600
Message-Id: <1133447539.8557.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 21:00 +0900, Takashi Sato wrote:
> Hi all,
> 
> I found a problem at stat64 on 32bit architecture.
> 
> When I called stat64 for a file which is larger than 2TB, stat64
> returned an invalid number of blocks at st_blocks on 32bit
> architecture, although it returned a valid number of blocks on 64bit
> architecture(ia64).

For jfs, it's a bigger problem than just stat64.  When writing the inode
to disk, jfs calculates the number of blocks from the 32-bit value:
	dip->di_nblocks = cpu_to_le64(PBLK2LBLK(ip->i_sb, ip->i_blocks))

So it won't only report the wrong number of blocks, but it will actually
store the wrong number.  :-(

> The following describes the cause of this issue:
> i_blocks in inode is 4bytes on 32bit architecture.  If it receives
> more than 2^32 number of blocks, it would overflow and set an
> invalid number to st_blocks.
> 
> Below describes a sequence of setting overflowed inode.i_blocks
> to st_blocks through stat64.
> 
> 1. generic_fillattr(struct inode *inode, struct kstat *stat)
>   - Copy data from overflowed inode.i_blocks to kstat.blocks.
> 
> 2. vfs_getattr(struct vfsmount *mnt, struct dentry *dentry,
>         struct kstat *stat)
>   - Return invalid kstat.blocks to sys_stat64().
> 
> 3. sys_stat64(char __user * filename, struct stat64 __user * statbuf)
>   - Copy data from invalid kstat.blocks to stat64.st_blocks.
> 
> I also found the following problem.
> 
> - ioctl with FIOQSIZE command returns the size of file's data which
>   has written to disk.  The size of file's data is calculated as
>   follows in inode_get_bytes().
>    
>    (((loff_t)inode->i_blocks) << 9) + inode->i_bytes
> 
>    On the file which is larger than 2TB, the ioctl will return an
>    invalid size because i_blocks can't express the right number of
>    blocks.
> 
> I think the following modification is essential to fix these
> problems.
> 
> 1. Change the type of inode.i_blocks and kstat.blocks from unsigned
>    long to unsigned long long.

This would be okay.

> 2. Change the type of architecture dependent stat64.st_blocks in
>    include/asm/asm-*/stat.h from unsigned long to unsigned long long.
>    I tried modifying only stat64 of 32bit architecture
>    (include/asm-i386/stat.h).

This changes the API, but the structure does suggest that the 4-byte pad
should be used for the high-order bytes of st_blocks, so that's not
really a problem.  A correct fix would replace __pad4 with
st_blocks_high (or something like that) and ensure that the high-order
word was stored there.  Your proposed fix would only be correct on
little-endian hardware, as Jörn pointed out.

> I have some tested for a file whose size is 3TB on JFS filesystem.
> The following is the patch.
> 
> Signed-off-by: Takashi Sato <sho@bsd.tnes.nec.co.jp>
> 
> diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
> g/include/asm-i386/stat.h linux-2.6.14-blocks/include/asm-i386/stat.h
> --- linux-2.6.14.org/include/asm-i386/stat.h 2005-10-28 09:02:08.000000000 +0900
> +++ linux-2.6.14-blocks/include/asm-i386/stat.h 2005-11-18 22:42:37.000000000 +0900
> @@ -58,8 +58,7 @@ struct stat64 {
>   long long st_size;
>   unsigned long st_blksize;
>  
> - unsigned long st_blocks; /* Number 512-byte blocks allocated. */
> - unsigned long __pad4;  /* future possible st_blocks high bits */
> + unsigned long long st_blocks; /* Number 512-byte blocks allocated. */
>  
>   unsigned long st_atime;
>   unsigned long st_atime_nsec;
> diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
> g/include/linux/fs.h linux-2.6.14-blocks/include/linux/fs.h
> --- linux-2.6.14.org/include/linux/fs.h 2005-10-28 09:02:08.000000000 +0900
> +++ linux-2.6.14-blocks/include/linux/fs.h 2005-11-18 17:08:03.000000000 +0900
> @@ -438,7 +438,7 @@ struct inode {
>   unsigned int  i_blkbits;
>   unsigned long  i_blksize;
>   unsigned long  i_version;
> - unsigned long  i_blocks;
> + unsigned long long i_blocks;
>   unsigned short          i_bytes;
>   spinlock_t  i_lock; /* i_blocks, i_bytes, maybe i_size */
>   struct semaphore i_sem;
> diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
> g/include/linux/stat.h linux-2.6.14-blocks/include/linux/stat.h
> --- linux-2.6.14.org/include/linux/stat.h 2005-10-28 09:02:08.000000000 +0900
> +++ linux-2.6.14-blocks/include/linux/stat.h 2005-11-18 17:08:56.000000000 +0900
> @@ -69,7 +69,7 @@ struct kstat {
>   struct timespec mtime;
>   struct timespec ctime;
>   unsigned long blksize;
> - unsigned long blocks;
> + unsigned long long blocks;
>  };
>  
>  #endif
> 
> Any feedback and comments are welcome.
> 
> Best regards, Takashi Sato
-- 
David Kleikamp
IBM Linux Technology Center

