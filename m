Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316360AbSEOJqQ>; Wed, 15 May 2002 05:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316361AbSEOJqP>; Wed, 15 May 2002 05:46:15 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:17929 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S316360AbSEOJqO>;
	Wed, 15 May 2002 05:46:14 -0400
X-My-Real-Login-Name: sasaki; mail.valinux.co.jp
MIME-Version: 1.0
X-Mailer: Denshin 8 Go V32.1.3.1
Date: Wed, 15 May 2002 18:41:48 +0900
From: Hirotaka Sasaki <sasaki@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: taka@valinux.co.jp, minoura@valinux.co.jp, alexr@valinux.co.jp
Subject: Re: [PATCH] remove 2TB block device limit
Message-Id: <20020515094613.DA2C97001F@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
My name is Hirotaka Sasaki and I work for VA Linux Japan.  
We've had a need for large disk support as well, and so I've developed
support for 64-bit block numbers and page cache indices. 

I'm not subscribed to this list so please CC on any responses.

All development I've done so far has been tested on 2.4.17 w/XFS
        - linux-2.4.17
        - xfs-1.0.2
        - x86 (p3) architecture

The main revisions my patch includes:
        - 64-bit page cache indices (doesn't support 64-bit mmap)
        - 64-bit block #'s, sector #'s in the block I/O layer
        - 64-bit block device file (support for block #'s)
        - raw and direct I/O support for 64-bit block and sector #'s
        - 64-bit start_sect/nr_sect support in struct hd_struct
        - 64-bit blk_size table
        - 64-bit SCSI device sizes (sd_sizes/sr_sizes)
        - 64-bit loop device

  This patch at:
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-block64-2.4.17.patch

Other revisions (not necessarily including the kernel):

In order to create a file system larger than 2TB on XFS I,
        - changed ioctl(BLKGETSIZE) to ioctl(BLKGETSIZE64) in mkfs.xfs
        - in the kernel fixed an error in the handling of ioctl(BLKGETSIZE64)

  This patches at:
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-blkgetsize64-2.4.17.patch
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/xfsprogs-1.3.17-blkgetsize64.patch

In order to display a file system size larger than 16TB using df I,
        - added a new system call to the kernel, statfs64
        - added statfs64 to struct super
        - modified XFS and NFSv3 to support statfs64
        - created a new library, statvfs64, to use statfs64 which is
                  then called by df command

  This patches at:
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64-2.4.17.patch
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64_xfs-2.4.17.patch
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64_nfsd-2.4.17.patch
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-statfs64_nfs-2.4.17.patch        
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/fileutils-4.1-df_statvfs64.patch

I ran several tests on XFS by creating a file system and mounting
it on the loop device.  I noticed that the size of the file system
is limited to 16TB by XFS_MAX_FILE_OFFSET.  I need to test file systems
> 16TB so I changed XFS_MAX_FILE_OFFSET to (long long)((1ULL<<63)-1ULL).
However, XFS internally uses unsigned long's for the page cache indices
which means everything works great until you mount the file system, but
after that it all falls apart.

  This patch at:
  ftp://ftp.valinux.co.jp/pub/people/sasaki/blk64/va-xfs_max_file_offset-2.4.17.patch

Under XFS I've tested,
        - 16TB XFS file system (successfully mounted and accessed)
        - 32TB XFS file system (successfully mounted but access failed
                as outlined above)

Further improvements I plan on making:
        - 64-bit support for LVM (including LVM tools)
        - SCSI device support for 64-bit in the common layer
        - 16-byte SCSI command support

Any help or advice you can offer is greatly appreciated!

# Thanks to Alexander Reeder for translating 
--
Hirotaka Sasaki <sasaki@valinux.co.jp>
Engineering Dept.
VA Linux Systems Japan K.K. 
