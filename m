Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282103AbRK1KVm>; Wed, 28 Nov 2001 05:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282105AbRK1KVc>; Wed, 28 Nov 2001 05:21:32 -0500
Received: from [195.66.192.167] ([195.66.192.167]:62982 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S282103AbRK1KVY>; Wed, 28 Nov 2001 05:21:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [BUG] 2.4.16pre1: minix initrd does not work, ext2 does
Date: Wed, 28 Nov 2001 12:18:45 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011127151356.ast@domdv.de>
In-Reply-To: <XFMail.20011127151356.ast@domdv.de>
MIME-Version: 1.0
Message-Id: <01112812184503.00924@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 12:13, Andreas Steinmetz wrote:
> Well, no pointer but the same effect with 2.4.15pre7 and romfs (as posted
> earlier to the list). It seems initrd handling is fs type picky :-(
>
> Just to repeat myself:
>
> 1. the romfs initrd is fine, loop mounting it works.
> 2. the romfs initrd is detected at boot time.
> 3. the romfs initrd is not root mounted at boot time, thus without a root
> fs the kernel panics.
> 4. Doing the same with an ext2 initrd works fine.

Ok, here what I did to further investigate initrd problem:

ext2.gz contains gzipped ext2 ramdisk image.
minix.gz contains gzipped minix ramdisk image.
minix is gunzipped minix.gz.

Initrd          2.4.10  2.4.13,2.4.16pre1
--------------- ------- -----------------
ext2.gz         ok      ok
minix.gz        ok      minix fs not detected (bad fs magic)
minix           ok      minix magic ok, can't open console, can't find init

(2.4.16pre1 was instrumented to show minix magic etc)

As you can see, we have decompression bug: results for
compressed and uncompressed minix ramdisks are different.
Or maybe kernel corrupts ramdisk image after gunzip.
I'm puzzled...

Guys, who fiddled with zlib/ramdisk/??? in 2.4.11 - 2.4.13 range?

Intrumenting diff attached.
Test tarball with both initrd images and both kernels is at
http://port.imtp.ilyichevsk.odessa.ua/linux/vda/initrd.tar.bz2
(4.5 meg file). It is designed to be started from DOS
via loadlin or linld. Problem is not in loaders since both preform
identically.
--
vda

diff -u --recursive linux-2.4.16pre1-orig/fs/minix/inode.c 
linux-2.4.16pre1-new/fs/minix/inode.c
--- linux-2.4.16pre1-orig/fs/minix/inode.c	Sun Sep 30 17:26:08 2001
+++ linux-2.4.16pre1-new/fs/minix/inode.c	Wed Nov 28 01:52:30 2001
@@ -119,6 +119,10 @@
 	return 0;
 }
 
+/* Defined nowhere. Used to trigger link errors.
+*/
+extern void compile_time_bug_here(void);
+
 static struct super_block *minix_read_super(struct super_block *s, void 
*data,
 				     int silent)
 {
@@ -131,12 +135,16 @@
 	unsigned int hblock;
 	struct minix_sb_info *sbi = &s->u.minix_sb;
 
+	printk("VDA: entered minix_read_super\n");
+	
 	/* N.B. These should be compile-time tests.
 	   Unfortunately that is impossible. */
-	if (32 != sizeof (struct minix_inode))
-		panic("bad V1 i-node size");
+	if (32 != sizeof(struct minix_inode))
+		compile_time_bug_here();
+		//panic("bad V1 i-node size");
 	if (64 != sizeof(struct minix2_inode))
-		panic("bad V2 i-node size");
+		compile_time_bug_here();
+		//panic("bad V2 i-node size");
 
 	hblock = get_hardsect_size(dev);
 	if (hblock > BLOCK_SIZE)
@@ -160,6 +168,11 @@
 	sbi->s_log_zone_size = ms->s_log_zone_size;
 	sbi->s_max_size = ms->s_max_size;
 	s->s_magic = ms->s_magic;
+	printk("VDA: ms->s_magic = %lu\n",ms->s_magic);
+	printk("VDA: MINIX_SUPER_MAGIC   %lu\n",MINIX_SUPER_MAGIC  );
+	printk("VDA: MINIX_SUPER_MAGIC2  %lu\n",MINIX_SUPER_MAGIC2 );
+	printk("VDA: MINIX2_SUPER_MAGIC  %lu\n",MINIX2_SUPER_MAGIC );
+	printk("VDA: MINIX2_SUPER_MAGIC2 %lu\n",MINIX2_SUPER_MAGIC2);
 	if (s->s_magic == MINIX_SUPER_MAGIC) {
 		sbi->s_version = MINIX_V1;
 		sbi->s_dirsize = 16;
@@ -242,7 +255,7 @@
 	goto out_freemap;
 
 out_no_root:
-	if (!silent)
+	//if (!silent)
 		printk("MINIX-fs: get root inode failed\n");
 	goto out_freemap;
 
@@ -257,12 +270,12 @@
 	goto out_release;
 
 out_no_map:
-	if (!silent)
+	//if (!silent)
 		printk ("MINIX-fs: can't allocate map\n");
 	goto out_release;
 
 out_no_fs:
-	if (!silent)
+	//if (!silent)
 		printk("VFS: Can't find a Minix or Minix V2 filesystem on device "
 		       "%s.\n", kdevname(dev));
     out_release:
@@ -275,7 +288,7 @@
 
 out_bad_sb:
 	printk("MINIX-fs: unable to read superblock\n");
- out:
+out:
 	return NULL;
 }
 
diff -u --recursive linux-2.4.16pre1-orig/fs/super.c 
linux-2.4.16pre1-new/fs/super.c
--- linux-2.4.16pre1-orig/fs/super.c	Mon Nov 26 20:17:18 2001
+++ linux-2.4.16pre1-new/fs/super.c	Wed Nov 28 01:18:59 2001
@@ -1021,7 +1021,9 @@
 			kdevname(ROOT_DEV));
 	}
 
+	printk ("VDA: check_disk_change\n");
 	check_disk_change(ROOT_DEV);
+	printk ("VDA: get_super\n");
 	sb = get_super(ROOT_DEV);
 	if (sb) {
 		/* FIXME */
@@ -1036,6 +1038,7 @@
 		struct file_system_type * fs_type = get_fs_type(p);
 		if (!fs_type)
   			continue;
+		printk ("VDA: read_super %s\n", p);
   		sb = read_super(ROOT_DEV, bdev, fs_type,
 				root_mountflags, root_mount_data);
 		if (sb) 
