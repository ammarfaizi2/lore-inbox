Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVB1VNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVB1VNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVB1VLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:11:52 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:14156 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261749AbVB1VG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:06:58 -0500
Message-ID: <4223888D.2070401@suse.com>
Date: Mon, 28 Feb 2005 16:09:33 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, zensonic@zensonic.dk, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Help tracking down problem --- endless loop in __find_get_block_slow
 (now with the patch)
References: <4219BC1A.1060007@zensonic.dk>	<20050222011821.2a917859.akpm@osdl.org>	<421BB65F.7040306@suse.com> <20050222152833.75fb79a2.akpm@osdl.org> <421FBCD8.7090804@suse.com>
In-Reply-To: <421FBCD8.7090804@suse.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040708080108070706000607"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708080108070706000607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Mahoney wrote:
> Andrew Morton wrote:
>
>>>Jeff Mahoney <jeffm@suse.com> wrote:
>>>
>>>
>>>>In my experience, the loop is actually outside of
>>>>__find_get_block_slow(), in __getblk_slow(). I've been using xmon to
>>>>interrupt the kernel, and the results vary but are all rooted in the
>>>>for(;;) loop in __getblk_slow. It appears as though grow_buffers is
>>>>finding/creating the page, but then __find_get_block can't locate the
>>>>buffer it needs.
>>>
>>>
>>>Yes, that'll happen.  Because there are still buffers attached to the page
>>>which have the wrong blocksize.  Say, if someone is trying to read a 2k
>>>buffer_head which is backed by a page which already has 1k buffer_heads
>>>attached to it.
>>>
>>>Does your kernel not have that big printk in __find_get_block_slow()?  If
>>>it does, maybe some of the buffers are unmapped.  Try:
>
>
> I think it's likely I'm experiencing a different bug than the original
> poster. I've tried making the printk unconditional, and I get no output.
> However, I've continued to track it down, and I believe I've found a
> umount race. I can also reproduce it without subfs, with the attached
> script.
>
> I added some debug output to aid in my search:
> __find_get_block_slow: find_get_page
> [block=17508,blksize=2048,index=8754,sizebits=1,size=512] returned null
> returning page [index=2188,block=17504,size=512,sizebits=3]
> Couldn't find buffer @ block 17508
>
> What I'm observing is that __find_get_block_slow is calculating the
> index using the blocksize for the device, and the grow_buffers call is
> using the blocksize handed down from the filesystem via sb_bread(). They
> *should* be the same, but here's where my suspected race comes in. Since
> the buffers are being searched for in the wrong place, they're never
> found, causing the infinite loop.
>
> The open_bdev_excl() call in get_sb_bdev() should be keeping callers out
> until the block device is actually closed, but it uses the fs_type
> struct as the holder which, given that the filesystem to be mounted is
> the same one as the one being umounted, will be the same. This allows
> the mount attempt to continue. If the superblock for the umounting
> filesystem is already in the process of getting shut down, sget() will
> create a new superblock and the mount attempt will use that one. The
> umount will continue, destroying the old superblock and setting the
> blocksize back to its original value, dropping all buffers in the process.
>
> If kill_block_super resets the blocksize while an sb_bread is in
> progress, the sizes won't match up and we'll get stuck in the loop.
>
> I'll be working on a fix, but figured I'd send out a quick update.

Resent: Forgot to attach the patch. :-\

To prove the race, I made bd_claim return -EBUSY even if the passed
holder == current holder. This eliminated the race, but made a
potentially unacceptable change to how block devices are handled. [1]

Attached is a patch that isn't pretty but does still allow the
multiple-open semantics of open_bdev_excl() while eliminating the race.
Basically, it creates a call path that allows the device's block size to
be changed only if the caller holds the sole reference to the block
device. This has passed my admittedly small test cases without returning
invalid results.

Only the close case is protected by bdev_lock. This may seem racy, but I
don't believe it to be. The only way a caller could have the opportunity
to reset the block size while the block device is opened is if the
holder value is the same, which means that it must be the same
filesystem type. The same filesystem type opening the same device will
result in finding the same on-disk superblock that the umounting
filesystem was using, so it would be the same block size. set_blocksize
will exit early if the block size is the same, thus avoiding the code
that could cause issues.

I'd appreciate any feedback.

- -Jeff

[1] Currently, mtd is the only non-filesystem caller of open_bdev_excl.
While it's possible for mtd to call open_bdev_excl twice on the same
device, it would require passing the same device more than once as a
module parameter.
- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCI4iNLPWxlyuTD7IRAhdtAJ9s/GELyA4GE4SQaDiztuAtjzffgQCcCWyO
MZ3swZSz7YJI+ElgH9YS5kE=
=Sd5k
-----END PGP SIGNATURE-----

--------------040708080108070706000607
Content-Type: text/x-patch;
 name="set_blocksize_race.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="set_blocksize_race.diff"

diff -ruNpX dontdiff linux-2.6.11-rc4.orig/fs/block_dev.c linux-2.6.11-rc4/fs/block_dev.c
--- linux-2.6.11-rc4.orig/fs/block_dev.c	2005-02-28 14:06:59.000000000 -0500
+++ linux-2.6.11-rc4/fs/block_dev.c	2005-02-28 14:49:52.000000000 -0500
@@ -62,7 +62,7 @@ static void kill_bdev(struct block_devic
 	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
 }	
 
-int set_blocksize(struct block_device *bdev, int size)
+int __set_blocksize(struct block_device *bdev, int size, int sync)
 {
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
 	if (size > PAGE_SIZE || size < 512 || (size & (size-1)))
@@ -74,7 +74,8 @@ int set_blocksize(struct block_device *b
 
 	/* Don't change the size if it is same as current */
 	if (bdev->bd_block_size != size) {
-		sync_blockdev(bdev);
+		if (sync)
+			sync_blockdev(bdev);
 		bdev->bd_block_size = size;
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
@@ -82,7 +83,7 @@ int set_blocksize(struct block_device *b
 	return 0;
 }
 
-EXPORT_SYMBOL(set_blocksize);
+EXPORT_SYMBOL(__set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
@@ -480,17 +481,19 @@ int bd_claim(struct block_device *bdev, 
 
 EXPORT_SYMBOL(bd_claim);
 
-void bd_release(struct block_device *bdev)
+void __bd_release(struct block_device *bdev, int size)
 {
 	spin_lock(&bdev_lock);
 	if (!--bdev->bd_contains->bd_holders)
 		bdev->bd_contains->bd_holder = NULL;
-	if (!--bdev->bd_holders)
+	if (!--bdev->bd_holders) {
 		bdev->bd_holder = NULL;
+		set_blocksize_nosync (bdev, size);
+	}
 	spin_unlock(&bdev_lock);
 }
 
-EXPORT_SYMBOL(bd_release);
+EXPORT_SYMBOL(__bd_release);
 
 /*
  * Tries to open block device by device number.  Use it ONLY if you
@@ -914,10 +917,10 @@ EXPORT_SYMBOL(open_bdev_excl);
  *
  * This is the counterpart to open_bdev_excl().
  */
-void close_bdev_excl(struct block_device *bdev)
+void __close_bdev_excl(struct block_device *bdev, int size)
 {
-	bd_release(bdev);
+	__bd_release(bdev, size);
 	blkdev_put(bdev);
 }
 
-EXPORT_SYMBOL(close_bdev_excl);
+EXPORT_SYMBOL(__close_bdev_excl);
diff -ruNpX dontdiff linux-2.6.11-rc4.orig/fs/super.c linux-2.6.11-rc4/fs/super.c
--- linux-2.6.11-rc4.orig/fs/super.c	2005-02-28 14:07:01.000000000 -0500
+++ linux-2.6.11-rc4/fs/super.c	2005-02-28 14:42:49.000000000 -0500
@@ -732,8 +732,7 @@ void kill_block_super(struct super_block
 
 	bdev_uevent(bdev, KOBJ_UMOUNT);
 	generic_shutdown_super(sb);
-	set_blocksize(bdev, sb->s_old_blocksize);
-	close_bdev_excl(bdev);
+	__close_bdev_excl(bdev, sb->s_old_blocksize);
 }
 
 EXPORT_SYMBOL(kill_block_super);
diff -ruNpX dontdiff linux-2.6.11-rc4.orig/include/linux/fs.h linux-2.6.11-rc4/include/linux/fs.h
--- linux-2.6.11-rc4.orig/include/linux/fs.h	2005-02-28 14:07:42.000000000 -0500
+++ linux-2.6.11-rc4/include/linux/fs.h	2005-02-28 14:50:53.000000000 -0500
@@ -1294,7 +1294,10 @@ extern long compat_blkdev_ioctl(struct f
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
-extern void bd_release(struct block_device *);
+extern void __bd_release(struct block_device *, int);
+static inline void bd_release(struct block_device *bdev) {
+	__bd_release (bdev, bdev->bd_block_size);
+}
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
@@ -1311,7 +1314,10 @@ extern const char *__bdevname(dev_t, cha
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern struct block_device *open_bdev_excl(const char *, int, void *);
-extern void close_bdev_excl(struct block_device *);
+extern void __close_bdev_excl(struct block_device *, int);
+static inline void close_bdev_excl(struct block_device *bdev) {
+	__close_bdev_excl(bdev, bdev->bd_block_size);
+}
 
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
@@ -1447,7 +1453,14 @@ extern void file_kill(struct file *f);
 struct bio;
 extern void submit_bio(int, struct bio *);
 extern int bdev_read_only(struct block_device *);
-extern int set_blocksize(struct block_device *, int);
+extern int __set_blocksize(struct block_device *, int, int);
+static inline int set_blocksize(struct block_device *bdev, int size) {
+	return __set_blocksize (bdev, size, 1);
+}
+static inline int set_blocksize_nosync(struct block_device *bdev, int size) {
+	return __set_blocksize (bdev, size, 0);
+}
+
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
 

--------------040708080108070706000607--
