Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131679AbRCXO1R>; Sat, 24 Mar 2001 09:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131680AbRCXO1H>; Sat, 24 Mar 2001 09:27:07 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40908 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131679AbRCXO07>;
	Sat, 24 Mar 2001 09:26:59 -0500
Date: Sat, 24 Mar 2001 15:25:43 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103241425.PAA08694.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, hpa@transmeta.com, torvalds@transmeta.com,
        tytso@MIT.EDU
Subject: Larger dev_t
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus and all,

One of these days we must change dev_t.

There are several aspects to this, but this letter touches
only the kernel-*libc interface.

We need a size, and I am strongly in favor of sizeof(dev_t) = 8;
this is already true in glibc.

The two main uses of dev_t are in struct stat and as parameter
of the mknod system call. There are a few other occurrences,
such as ustat() and the use of dev_t as a field in struct loopinfo
returned by some ioctl.
- For stat all is fine already since we got stat64.
- For mknod a little work is required.
- The state of affairs with loopinfo is sad today (the fact that
kernel and glibc use dev_t of different size causes problems)
but all will be well with 64-bit dev_t.
- With ustat the converse is true. Of course it is obsolete,
but with 64-bit dev_t we are forced to throw it out - libc5
has xustat just like xstat and xmknod, but glibc hasn't so it
is not easy to save it. There are still some programs that use it:
in CD players to test (before eject) whether a CD is mounted;
in various programs such as sendmail and uucp to test how much
free space we have.
So, glibc will have to return EINVAL (or EOVERFLOW) here
for device numbers that actually use more than 16 bits.

The transformation from 64 bits to pair (major,minor) is
                if ((major = (dev >> 32)) != 0)
                        minor = (dev & 0xffffffff);
                else if ((major = (dev >> 16)) != 0)
                        minor = (dev & 0xffff);
                else {
                        major = (dev >> 8);
                        minor = (dev & 0xff);
                }
This means that old device numbers remain valid.

The stuff below describes a working interface where 64-bit values
are passed to and from the kernel, and to and from the filesystem.
That is, it is dev_t stuff. Some other time on kernel-internal matters,
that is, kdev_t stuff.

Details of my setup of today (with 64-bit dev_t):
(i) ext2:

diff -r linux-2.4.2/linux/fs/ext2/inode.c linux-2.4.2kdevt/linux/fs/ext2/inode.c
1076,1078c1076,1081
<       } else 
<               init_special_inode(inode, inode->i_mode,
<                                  le32_to_cpu(raw_inode->i_block[0]));
---
>       } else {
>               unsigned int lo = le32_to_cpu(raw_inode->i_block[0]);
>               unsigned int hi = le32_to_cpu(raw_inode->i_block[1]);
>               dev_t devno = ((unsigned long long) hi << 32) | lo;
>               init_special_inode(inode, inode->i_mode, devno);
>       }
1211,1213c1214,1221
<       if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
<               raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev))
;
<       else for (block = 0; block < EXT2_N_BLOCKS; block++)
---
>       if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
>               /* we use that EXT2_N_BLOCKS > 1 */
>               dev_t devno = kdev_t_to_nr(inode->i_rdev);
>               unsigned int hi = (devno >> 32);
>               unsigned int lo = (devno & 0xffffffff);
>               raw_inode->i_block[0] = cpu_to_le32(lo);
>               raw_inode->i_block[1] = cpu_to_le32(hi);
>       } else for (block = 0; block < EXT2_N_BLOCKS; block++)

Ted, please complain if I am mistaken in thinking that
raw_inode->i_block[1] can be used.
There is a minor conversion problem here: there is no guarantee
that raw_inode->i_block[1] will be zero in old systems.


(ii) vfs:

diff -r linux-2.4.2/linux/fs/devices.c linux-2.4.2kdevt/linux/fs/devices.c
200c200
< void init_special_inode(struct inode *inode, umode_t mode, int rdev)
---
> void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)

(iii) mknod:
Then there is the prototype of mknod.
I changed it for all filesystems to

diff -r linux-2.4.2/linux/fs/ext2/namei.c linux-2.4.2kdevt/linux/fs/ext2/namei.c
387c387,388
< static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
---
> static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode,
>                      dev_t rdev)

The system call itself cannot easily be changed to take a larger dev_t,
mostly because under old glibc the high order part would be random.
So, mknod64, with

diff linux-2.4.2/linux/fs/namei.c linux-2.4.2kdevt/linux/fs/namei.c
1205c1208
< asmlinkage long sys_mknod(const char * filename, int mode, dev_t dev)
---
> static long mknod_common(const char * filename, int mode, dev_t dev)
1245a1249,1259
> }
> 
> asmlinkage long sys_mknod64(const char * filename, int mode,
>                           unsigned int ma, unsigned int mi)
> {
>       return mknod_common(filename, mode, ((dev_t) ma << 32) | mi);
> }
> 
> asmlinkage long sys_mknod(const char * filename, int mode, unsigned short dev)
> {
>       return mknod_common(filename, mode, dev);

and __NR_mknod64 in unistd.h and .long SYMBOL_NAME(sys_mknod64) in entry.S.

Changes to glibc2:

--- glibc-2.2.1/sysdeps/unix/sysv/linux/xmknod.c        Fri Jul  7 19:57:38 2000
+++ glibc-2.2.1mk/sysdeps/unix/sysv/linux/xmknod.c      Sat Mar 24 13:53:50 2001
@@ -29,6 +29,13 @@
 extern int __syscall_mknod (const char *__unbounded, unsigned short int,
                            unsigned short int);
 
+extern int __syscall_mknod64 (const char *__unbounded, unsigned short int,
+                           dev_t);
+
+#ifndef __NR_mknod64
+#define __NR_mknod64            223
+#endif
+
 /* Create a device file named PATH, with permission and special bits MODE
    and device number DEV (which can be constructed from major and minor
    device numbers with the `makedev' macro above).  */
@@ -36,6 +43,7 @@
 __xmknod (int vers, const char *path, mode_t mode, dev_t *dev)
 {
   unsigned short int k_dev;
+  unsigned int ma, mi;
 
   if (vers != _MKNOD_VER)
     {
@@ -43,9 +51,17 @@
       return -1;
     }
 
+  if ((*dev >> 16) != 0)
+    {
+      /* need mknod64 */  
+      /* pass the 64-bit arg as two 32-bit integers (le) */
+      ma = ((*dev) >> 32);
+      mi = ((*dev) & 0xffffffff);
+      return INLINE_SYSCALL (mknod64, 4, CHECK_STRING (path), mode, ma, mi);
+    }
+  
   /* We must convert the value to dev_t type used by the kernel.  */
   k_dev = ((major (*dev) & 0xff) << 8) | (minor (*dev) & 0xff);
-
   return INLINE_SYSCALL (mknod, 3, CHECK_STRING (path), mode, k_dev);
 }

I almost submitted this as an actual patch, but it changes vfs
prototypes, and probably that is against the rules during a stable series.
If something in this style is OK I'll make a patch as soon as 2.5
is started.

Andries

[the above is running on the machine I send this mail from]
