Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLOHpd>; Fri, 15 Dec 2000 02:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLOHpY>; Fri, 15 Dec 2000 02:45:24 -0500
Received: from laxmls02.socal.rr.com ([24.30.163.11]:52634 "EHLO
	laxmls02.socal.rr.com") by vger.kernel.org with ESMTP
	id <S129314AbQLOHpN>; Fri, 15 Dec 2000 02:45:13 -0500
From: Shane Nay <shane@agendacomputing.com>
Reply-To: shane@agendacomputing.com
Organization: Agenda Computing
To: Tim Riker <Tim@Rikers.org>, shane@agendacomputing.com
Subject: Re: cramfs filesystem patch
Date: Thu, 14 Dec 2000 20:14:01 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Daniel Quinlan <quinlan@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200012080511.VAA02305@sodium.transmeta.com> <0012090153240K.23219@www.easysolutions.net> <3A31D3BC.46FBFBEB@Rikers.org>
In-Reply-To: <3A31D3BC.46FBFBEB@Rikers.org>
MIME-Version: 1.0
Message-Id: <0012142014013V.01011@www.easysolutions.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 December 2000 06:39, Tim Riker wrote:
> I'd like to see these patches as well. They may be useful on the iPAQ
> (and similar hardware like my Yopy here... ;-)
>
> I wish some hardware vendor out there would build an x86 box that used
> memory addressable flash from 0 up and RAM up higher. A simple Linux
> kernel boot loader could then replace the BIOS. Flash would be less
> expensive than 8086 lower memory windowed flash hacks.
>
> Has any work been done on e2compr in 2.4 yet?
>

Patch inserted.  It's not ready for kernel inclusion or anything..., there are some
remaining issues to fix that I haven't figured out good ways to handle yet.
For instance, we still use a /dev/rom to bootstrap the kernel as to which
file system module to pull up.  Then all the read/writes completely by pass
/dev/rom.  Silly, I know, but I haven't figured out a smart way to deal with
this particular problem.

Sorry for the late reply..., your message got lost in a sea of mail.  You might
find some other interesting stuff on the ftp.agendacomputing.com ftp site.
XIP MTD flash read/write, which I haven't forward ported to MTDs CVS yet.
(Working on it)  But that would allow if you guys can get XIP kernel working
in ARM like we have in MIPS to read and write to flash.  Other randomn stuff,
and things get added with a slightly normal frequency.  One benefit with this
patch is copying, the other is dumping that 32k buffer, and giving it back to
pageable memory.

Thanks,
Shane.

diff -urN linux.orig/fs/Config.in linux/fs/Config.in
--- linux.orig/fs/Config.in	Fri Oct 27 04:23:18 2000
+++ linux/fs/Config.in	Fri Oct 27 03:57:52 2000
@@ -29,6 +29,10 @@
 	int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
+dep_mbool 'Linear addressing for CRAMFS' CONFIG_CRAMFS_LINEAR_ADDRESSING $CONFIG_CRAMFS
+if [ "$CONFIG_CRAMFS_LINEAR_ADDRESSING" != "n" ] ; then
+	hex 'Starting address for CRAMFS filesystem' CONFIG_CRAMFS_LA_ADDRESS bf200008
+fi
 tristate 'Simple RAM-based file system support' CONFIG_RAMFS
 
 tristate 'ISO 9660 CDROM file system support' CONFIG_ISO9660_FS
diff -urN linux.orig/fs/cramfs/inode.c linux/fs/cramfs/inode.c
--- linux.orig/fs/cramfs/inode.c	Fri Oct 27 04:22:36 2000
+++ linux/fs/cramfs/inode.c	Fri Oct 27 04:30:18 2000
@@ -11,6 +11,20 @@
  * The actual compression is based on zlib, see the other files.
  */
 
+/* Linear Addressing code
+ *
+ * Copyright (C) 2000 Shane Nay.
+ *
+ * Allows you to have a linearly addressed cramfs filesystem.
+ * Saves the need for buffer, and the munging of the buffer.
+ * Savings a bit over 32k with default PAGE_SIZE, BUFFER_SIZE
+ * etc.  Usefull on embedded platform with ROM :-).
+ *
+ * Downsides- Currently linear addressed cramfs partitions
+ * don't co-exist with block cramfs partitions.
+ *
+ */
+
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
@@ -68,6 +82,23 @@
 	return inode;
 }
 
+#if defined(CONFIG_CRAMFS_CRAMFS_LINEAR_ADDRESSING) && defined (CONFIG_CRAMFS_LA_ADDRESS)
+
+/*
+ * Returns a pointer to the linearly addressed filesystem.
+ * Simple byte size pointer addition.
+ */
+static unsigned char* romdisk_top=(unsigned char*) CONFIG_CRAMFS_LA_ADDRESS;
+
+static void *cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
+{
+	if (!len)
+		return NULL;
+	return romdisk_top + offset;
+}
+
+#else /* !CONFIG_CRAMFS_LINEAR_ADDRESSING aka Regular block mode */
+
 /*
  * We have our own block cache: don't fill up the buffer cache
  * with the rom-image, because the way the filesystem is set
@@ -149,6 +180,8 @@
 	}
 	return read_buffers[buffer] + offset;
 }
+
+#endif
 			
 
 static struct super_block * cramfs_read_super(struct super_block *sb, void *data, int silent)
@@ -161,10 +194,11 @@
 	set_blocksize(sb->s_dev, PAGE_CACHE_SIZE);
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;

+#if !( defined(CONFIG_CRAMFS_CRAMFS_LINEAR_ADDRESSING) && defined (CONFIG_CRAMFS_LA_ADDRESS) )
 	/* Invalidate the read buffers on mount: think disk change.. */
 	for (i = 0; i < READ_BUFFERS; i++)
 		buffer_blocknr[i] = -1;
+#endif
 
 	/* Read the first block and get the superblock from it */
 	memcpy(&super, cramfs_read(sb, 0, sizeof(super)), sizeof(super));

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
