Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288007AbSAMHzC>; Sun, 13 Jan 2002 02:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288008AbSAMHyw>; Sun, 13 Jan 2002 02:54:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:38666 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288007AbSAMHyr>; Sun, 13 Jan 2002 02:54:47 -0500
Message-ID: <3C413BF0.24576AEC@zip.com.au>
Date: Sat, 12 Jan 2002 23:49:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kyle <kyle@actarg.com>
CC: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: Hard lock when mounting loopback file
In-Reply-To: <3C3F3267.7050103@actarg.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:
> 
> I have a digital camera flash card that is locking up my machine (stock
> redhat 7.2 w/2.4.9-13 kernel).
> 
> I can mount the card, but as soon as I browse the filesystem, the
> machine locks hard.  I successfully copied the file system from the raw
> device to a file and tried mounting it as:
> 
> mount -o loop flash.img /mnt/flash
> 
> and it still locks up the machine just as before.  This makes me think
> it has nothing to do with the USB reader or the SCSI emulation, etc.
> 
> My guess is I have a corrupt filesystem on the flash that the filesystem
> handler (vfat) is intolerant of (all my other flash cards work fine).
> 
> This seems like a possible kernel bug to me.  I'm not much of a kernel
> expert but I have a copy of the offending image if anyone wants to or
> can look at it.  (ftp://actarg.com/pub/misc/flash.img)  Is there someone
> that knows how to figure out if the driver can spit out a harmless
> message about filesystem corruption rather than taking the whole kernel
> down?
> 

I don't know a thing about fat layout, but it appears that it uses a
linked list of blocks, and if that list ends up pointing back onto
itself, the kernel goes into an infinite loop in several places chasing
its way to the end of the list.

The below patch fixed it for me, and I was able to mount and read
your filesystem image.

Unless someone has a smarter fix, I'll send this to the kernel
maintainers in a week or two.



--- linux-2.4.18-pre3/fs/fat/misc.c	Fri Oct 12 13:48:42 2001
+++ linux-akpm/fs/fat/misc.c	Sat Jan 12 23:28:03 2002
@@ -478,6 +478,8 @@ static int raw_scan_nonroot(struct super
 	printk("raw_scan_nonroot: start=%d\n",start);
 #endif
 	do {
+		int old_start = start;
+
 		for (count = 0; count < MSDOS_SB(sb)->cluster_size; count++) {
 			if ((cluster = raw_scan_sector(sb,(start-2)*
 			    MSDOS_SB(sb)->cluster_size+MSDOS_SB(sb)->data_start+
@@ -486,6 +488,11 @@ static int raw_scan_nonroot(struct super
 		}
 		if (!(start = fat_access(sb,start,-1))) {
 			fat_fs_panic(sb,"FAT error");
+			break;
+		}
+		if (start == old_start) {
+			/* Prevent infinite loop on corrupt fs */
+			fat_fs_panic(sb, "FAT loop");
 			break;
 		}
 #ifdef DEBUG
--- linux-2.4.18-pre3/fs/fat/inode.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/fat/inode.c	Sat Jan 12 23:37:44 2002
@@ -392,12 +392,18 @@ static void fat_read_root(struct inode *
 		MSDOS_I(inode)->i_start = sbi->root_cluster;
 		if ((nr = MSDOS_I(inode)->i_start) != 0) {
 			while (nr != -1) {
+				int old_nr = nr;
 				inode->i_size += 1 << sbi->cluster_bits;
 				if (!(nr = fat_access(sb, nr, -1))) {
 					printk("Directory %ld: bad FAT\n",
 					       inode->i_ino);
 					break;
 				}
+				if (nr == old_nr) {
+					printk("Directory %ld: FAT loop\n",
+					       inode->i_ino);
+					break;
+				}
 			}
 		}
 	} else {
@@ -918,9 +924,15 @@ static void fat_fill_inode(struct inode 
 #endif
 		if ((nr = MSDOS_I(inode)->i_start) != 0)
 			while (nr != -1) {
+				int old_nr = nr;
 				inode->i_size += 1 << sbi->cluster_bits;
 				if (!(nr = fat_access(sb, nr, -1))) {
 					printk("Directory %ld: bad FAT\n",
+					    inode->i_ino);
+					break;
+				}
+				if (nr == old_nr) {
+					printk("Directory %ld: FAT loop\n",
 					    inode->i_ino);
 					break;
 				}
