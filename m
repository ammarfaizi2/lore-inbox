Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVLAMAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVLAMAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVLAMAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:00:35 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:52708 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932164AbVLAMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:00:35 -0500
Message-ID: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: stat64 for over 2TB file returned invalid st_blocks
Date: Thu, 1 Dec 2005 21:00:26 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I found a problem at stat64 on 32bit architecture.

When I called stat64 for a file which is larger than 2TB, stat64
returned an invalid number of blocks at st_blocks on 32bit
architecture, although it returned a valid number of blocks on 64bit
architecture(ia64).

The following describes the cause of this issue:
i_blocks in inode is 4bytes on 32bit architecture.  If it receives
more than 2^32 number of blocks, it would overflow and set an
invalid number to st_blocks.

Below describes a sequence of setting overflowed inode.i_blocks
to st_blocks through stat64.

1. generic_fillattr(struct inode *inode, struct kstat *stat)
  - Copy data from overflowed inode.i_blocks to kstat.blocks.

2. vfs_getattr(struct vfsmount *mnt, struct dentry *dentry,
        struct kstat *stat)
  - Return invalid kstat.blocks to sys_stat64().

3. sys_stat64(char __user * filename, struct stat64 __user * statbuf)
  - Copy data from invalid kstat.blocks to stat64.st_blocks.

I also found the following problem.

- ioctl with FIOQSIZE command returns the size of file's data which
  has written to disk.  The size of file's data is calculated as
  follows in inode_get_bytes().
   
   (((loff_t)inode->i_blocks) << 9) + inode->i_bytes

   On the file which is larger than 2TB, the ioctl will return an
   invalid size because i_blocks can't express the right number of
   blocks.

I think the following modification is essential to fix these
problems.

1. Change the type of inode.i_blocks and kstat.blocks from unsigned
   long to unsigned long long.

2. Change the type of architecture dependent stat64.st_blocks in
   include/asm/asm-*/stat.h from unsigned long to unsigned long long.
   I tried modifying only stat64 of 32bit architecture
   (include/asm-i386/stat.h).

I have some tested for a file whose size is 3TB on JFS filesystem.
The following is the patch.

Signed-off-by: Takashi Sato <sho@bsd.tnes.nec.co.jp>

diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
g/include/asm-i386/stat.h linux-2.6.14-blocks/include/asm-i386/stat.h
--- linux-2.6.14.org/include/asm-i386/stat.h 2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.14-blocks/include/asm-i386/stat.h 2005-11-18 22:42:37.000000000 +0900
@@ -58,8 +58,7 @@ struct stat64 {
  long long st_size;
  unsigned long st_blksize;
 
- unsigned long st_blocks; /* Number 512-byte blocks allocated. */
- unsigned long __pad4;  /* future possible st_blocks high bits */
+ unsigned long long st_blocks; /* Number 512-byte blocks allocated. */
 
  unsigned long st_atime;
  unsigned long st_atime_nsec;
diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
g/include/linux/fs.h linux-2.6.14-blocks/include/linux/fs.h
--- linux-2.6.14.org/include/linux/fs.h 2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.14-blocks/include/linux/fs.h 2005-11-18 17:08:03.000000000 +0900
@@ -438,7 +438,7 @@ struct inode {
  unsigned int  i_blkbits;
  unsigned long  i_blksize;
  unsigned long  i_version;
- unsigned long  i_blocks;
+ unsigned long long i_blocks;
  unsigned short          i_bytes;
  spinlock_t  i_lock; /* i_blocks, i_bytes, maybe i_size */
  struct semaphore i_sem;
diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
g/include/linux/stat.h linux-2.6.14-blocks/include/linux/stat.h
--- linux-2.6.14.org/include/linux/stat.h 2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.14-blocks/include/linux/stat.h 2005-11-18 17:08:56.000000000 +0900
@@ -69,7 +69,7 @@ struct kstat {
  struct timespec mtime;
  struct timespec ctime;
  unsigned long blksize;
- unsigned long blocks;
+ unsigned long long blocks;
 };
 
 #endif

Any feedback and comments are welcome.

Best regards, Takashi Sato
