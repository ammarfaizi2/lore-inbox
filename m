Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316493AbSEOVuO>; Wed, 15 May 2002 17:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316504AbSEOVuN>; Wed, 15 May 2002 17:50:13 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:48016 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S316493AbSEOVuM>;
	Wed, 15 May 2002 17:50:12 -0400
Subject: Re: [PATCH] remove 2TB block device limit
From: Steve Lord <lord@sgi.com>
To: Hirotaka Sasaki <sasaki@valinux.co.jp>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, taka@valinux.co.jp,
        minoura@valinux.co.jp, alexr@valinux.co.jp
In-Reply-To: <20020515094613.DA2C97001F@sv1.valinux.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 May 2002 16:49:16 -0500
Message-Id: <1021499356.19994.686.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-15 at 04:41, Hirotaka Sasaki wrote:
> Hi,
> My name is Hirotaka Sasaki and I work for VA Linux Japan.  
> We've had a need for large disk support as well, and so I've developed
> support for 64-bit block numbers and page cache indices. 
> 
> I'm not subscribed to this list so please CC on any responses.
> 
> All development I've done so far has been tested on 2.4.17 w/XFS
>         - linux-2.4.17
>         - xfs-1.0.2
>         - x86 (p3) architecture
> 
> The main revisions my patch includes:
>         - 64-bit page cache indices (doesn't support 64-bit mmap)

You will need to extend this into the xfs code base, particularly pagebuf.

>         - 64-bit block #'s, sector #'s in the block I/O layer
>         - 64-bit block device file (support for block #'s)
>         - raw and direct I/O support for 64-bit block and sector #'s
>         - 64-bit start_sect/nr_sect support in struct hd_struct
>         - 64-bit blk_size table
>         - 64-bit SCSI device sizes (sd_sizes/sr_sizes)
>         - 64-bit loop device
> 
>   This patch at:
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-block64-2.4.17.patch
> 
> Other revisions (not necessarily including the kernel):
> 
> In order to create a file system larger than 2TB on XFS I,
>         - changed ioctl(BLKGETSIZE) to ioctl(BLKGETSIZE64) in mkfs.xfs
>         - in the kernel fixed an error in the handling of ioctl(BLKGETSIZE64)
> 
>   This patches at:
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-blkgetsize64-2.4.17.patch
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/xfsprogs-1.3.17-blkgetsize64.patch
> 
> In order to display a file system size larger than 16TB using df I,
>         - added a new system call to the kernel, statfs64
>         - added statfs64 to struct super
>         - modified XFS and NFSv3 to support statfs64
>         - created a new library, statvfs64, to use statfs64 which is
>                   then called by df command
> 
>   This patches at:
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64-2.4.17.patch
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64_xfs-2.4.17.patch
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64_nfsd-2.4.17.patch
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64_nfs-2.4.17.patch        
>   ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/fileutils-4.1-df_statvfs64.patch
> 
> I ran several tests on XFS by creating a file system and mounting
> it on the loop device.  I noticed that the size of the file system
> is limited to 16TB by XFS_MAX_FILE_OFFSET.  I need to test file systems
> > 16TB so I changed XFS_MAX_FILE_OFFSET to (long long)((1ULL<<63)-1ULL).
> However, XFS internally uses unsigned long's for the page cache indices
> which means everything works great until you mount the file system, but
> after that it all falls apart.

XFS_MAX_FILE_OFFSET on linux was reduced to reflect the maximum
cachable offset in a file. This only affects access to files themselves,
not to metadata. For the metadata end of things you need to look at
_pagebuf_lookup_pages in fs/xfs/pagebuf/page_buf.c. I have not looked
at your patches yet, but abstracting the page index into a special
typedef would be the way to go if you have not already done so.

I am about to totally revamp the XFS I/O path, so you might want to
wait a bit and then pick up the xfs cvs tree from oss.sgi.com.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
