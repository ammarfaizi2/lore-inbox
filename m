Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbUKRPSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbUKRPSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUKRPSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:18:25 -0500
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:62696 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S262471AbUKRPQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:16:26 -0500
Message-ID: <419CBC67.4090809@ttnet.net.tr>
Date: Thu, 18 Nov 2004 17:14:47 +0200
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: wakko@animx.eu.org
Subject: Re: ISO9660 file size limitation
Content-Type: multipart/mixed;
 boundary="------------000604060103000707090003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000604060103000707090003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> I just came across this today after burning backups to dvd-r.  The file that
> caused the problem is 2,471,265,365 bytes.  After searching a little bit
> I found that the kernel doesn't like the size even though it's valid (That
> is from what I read).  So I did this:

2.6 took a better route making cruft a mount time option.
I use the attached patch against 2.4.28, ported from the
patches by Andries Brouwer posted at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103420043728469&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=108808967926140&w=2

Why do I have a feeling that Marcelo would reject this :/

Ozkan Sezer




--------------000604060103000707090003
Content-Type: text/plain;
 name="isofs_24.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isofs_24.diff"

diff -urN 28/fs/isofs/inode.c 28_aac/fs/isofs/inode.c
--- 28/fs/isofs/inode.c	2002-11-29 01:53:15.000000000 +0200
+++ 28_aac/fs/isofs/inode.c	2004-11-17 14:39:56.000000000 +0200
@@ -34,11 +34,6 @@
 
 #include "zisofs.h"
 
-/*
- * We have no support for "multi volume" CDs, but more and more disks carry
- * wrong information within the volume descriptors.
- */
-#define IGNORE_WRONG_MULTI_VOLUME_SPECS
 #define BEQUIET
 
 #ifdef LEAK_CHECK
@@ -489,19 +484,6 @@
 	if (!parse_options((char *) data, &opt))
 		goto out_unlock;
 
-#if 0
-	printk("map = %c\n", opt.map);
-	printk("rock = %c\n", opt.rock);
-	printk("joliet = %c\n", opt.joliet);
-	printk("check = %c\n", opt.check);
-	printk("cruft = %c\n", opt.cruft);
-	printk("unhide = %c\n", opt.unhide);
-	printk("blocksize = %d\n", opt.blocksize);
-	printk("gid = %d\n", opt.gid);
-	printk("uid = %d\n", opt.uid);
-	printk("iocharset = %s\n", opt.iocharset);
-#endif
-
 	/*
 	 * First of all, get the hardware blocksize for this device.
 	 * If we don't know what it is, or the hardware blocksize is
@@ -623,19 +605,11 @@
 
 	if(high_sierra){
 	  rootp = (struct iso_directory_record *) h_pri->root_directory_record;
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	  if (isonum_723 (h_pri->volume_set_size) != 1)
-		goto out_no_support;
-#endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
 	  s->u.isofs_sb.s_nzones = isonum_733 (h_pri->volume_space_size);
 	  s->u.isofs_sb.s_log_zone_size = isonum_723 (h_pri->logical_block_size);
 	  s->u.isofs_sb.s_max_size = isonum_733(h_pri->volume_space_size);
 	} else {
 	  rootp = (struct iso_directory_record *) pri->root_directory_record;
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	  if (isonum_723 (pri->volume_set_size) != 1)
-		goto out_no_support;
-#endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
 	  s->u.isofs_sb.s_nzones = isonum_733 (pri->volume_space_size);
 	  s->u.isofs_sb.s_log_zone_size = isonum_723 (pri->logical_block_size);
 	  s->u.isofs_sb.s_max_size = isonum_733(pri->volume_space_size);
@@ -855,11 +829,6 @@
 	printk(KERN_WARNING "Logical zone size(%d) < hardware blocksize(%u)\n",
 		orig_zonesize, blocksize);
 	goto out_freebh;
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-out_no_support:
-	printk(KERN_WARNING "Multi-volume disks not supported.\n");
-	goto out_freebh;
-#endif
 out_unknown_format:
 	if (!silent)
 		printk(KERN_WARNING "Unable to identify CD-ROM format.\n");
@@ -1212,30 +1181,13 @@
 	}
 
 	/*
-	 * The ISO-9660 filesystem only stores 32 bits for file size.
-	 * mkisofs handles files up to 2GB-2 = 2147483646 = 0x7FFFFFFE bytes
-	 * in size. This is according to the large file summit paper from 1996.
-	 * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
-	 *	    legal. Do not prevent to use DVD's schilling@fokus.gmd.de
-	 */
-	if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
-	    inode->i_sb->u.isofs_sb.s_cruft == 'n') {
-		printk(KERN_WARNING "Warning: defective CD-ROM.  "
-		       "Enabling \"cruft\" mount option.\n");
-		inode->i_sb->u.isofs_sb.s_cruft = 'y';
-	}
-
-	/*
 	 * Some dipshit decided to store some other bit of information
-	 * in the high byte of the file length.  Catch this and holler.
-	 * WARNING: this will make it impossible for a file to be > 16MB
-	 * on the CDROM.
+	 * in the high byte of the file length.  Truncate size in case
+	 * this CDROM was mounted with the cruft option.
 	 */
 
-	if (inode->i_sb->u.isofs_sb.s_cruft == 'y' &&
-	    inode->i_size & 0xff000000) {
+	if (inode->i_sb->u.isofs_sb.s_cruft == 'y')
 		inode->i_size &= 0x00ffffff;
-	}
 
 	if (de->interleave[0]) {
 		printk("Interleaved files not (yet) supported.\n");
@@ -1283,61 +1235,29 @@
 	/* get the volume sequence number */
 	volume_seq_no = isonum_723 (de->volume_sequence_number) ;
 
-    /*
-     * Multi volume means tagging a group of CDs with info in their headers.
-     * All CDs of a group must share the same vol set name and vol set size
-     * and have different vol set seq num. Deciding that data is wrong based
-     * in that three fields is wrong. The fields are informative, for
-     * cataloging purposes in a big jukebox, ie. Read sections 4.17, 4.18, 6.6
-     * of ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf (ECMA 119 2nd Ed = ISO 9660)
-     */
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	/*
-	 * Disable checking if we see any volume number other than 0 or 1.
-	 * We could use the cruft option, but that has multiple purposes, one
-	 * of which is limiting the file size to 16Mb.  Thus we silently allow
-	 * volume numbers of 0 to go through without complaining.
-	 */
-	if (inode->i_sb->u.isofs_sb.s_cruft == 'n' &&
-	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
-		printk(KERN_WARNING "Warning: defective CD-ROM "
-		       "(volume sequence number %d). "
-		       "Enabling \"cruft\" mount option.\n", volume_seq_no);
-		inode->i_sb->u.isofs_sb.s_cruft = 'y';
-	}
-#endif /*IGNORE_WRONG_MULTI_VOLUME_SPECS */
-
 	/* Install the inode operations vector */
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	if (inode->i_sb->u.isofs_sb.s_cruft != 'y' &&
-	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
-		printk(KERN_WARNING "Multi-volume CD somehow got mounted.\n");
-	} else
-#endif /*IGNORE_WRONG_MULTI_VOLUME_SPECS */
-	{
-		if (S_ISREG(inode->i_mode)) {
-			inode->i_fop = &generic_ro_fops;
-			switch ( inode->u.isofs_i.i_file_format ) {
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_fop = &generic_ro_fops;
+		switch ( inode->u.isofs_i.i_file_format ) {
 #ifdef CONFIG_ZISOFS
-			case isofs_file_compressed:
-				inode->i_data.a_ops = &zisofs_aops;
-				break;
-#endif
-			default:
-				inode->i_data.a_ops = &isofs_aops;
-				break;
-			}
-		} else if (S_ISDIR(inode->i_mode)) {
-			inode->i_op = &isofs_dir_inode_operations;
-			inode->i_fop = &isofs_dir_operations;
-		} else if (S_ISLNK(inode->i_mode)) {
-			inode->i_op = &page_symlink_inode_operations;
-			inode->i_data.a_ops = &isofs_symlink_aops;
-		} else
-			/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
-			init_special_inode(inode, inode->i_mode,
-					   kdev_t_to_nr(inode->i_rdev));
-	}
+		case isofs_file_compressed:
+			inode->i_data.a_ops = &zisofs_aops;
+			break;
+#endif
+		default:
+			inode->i_data.a_ops = &isofs_aops;
+			break;
+		}
+	} else if (S_ISDIR(inode->i_mode)) {
+		inode->i_op = &isofs_dir_inode_operations;
+		inode->i_fop = &isofs_dir_operations;
+	} else if (S_ISLNK(inode->i_mode)) {
+		inode->i_op = &page_symlink_inode_operations;
+		inode->i_data.a_ops = &isofs_symlink_aops;
+	} else
+		/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
+		init_special_inode(inode, inode->i_mode,
+				   kdev_t_to_nr(inode->i_rdev));
  out:
 	if (tmpde)
 		kfree(tmpde);
diff -urN 28/include/linux/iso_fs.h 28_aac/include/linux/iso_fs.h
--- 28/include/linux/iso_fs.h	2002-02-25 21:38:13.000000000 +0200
+++ 28_aac/include/linux/iso_fs.h	2004-11-17 14:39:57.000000000 +0200
@@ -179,28 +179,28 @@
 {
 	return *(s8 *)p;
 }
-static inline int isonum_721(char *p)
+static inline unsigned int isonum_721(char *p)
 {
 	return le16_to_cpu(get_unaligned((u16 *)p));
 }
-static inline int isonum_722(char *p)
+static inline unsigned int isonum_722(char *p)
 {
 	return be16_to_cpu(get_unaligned((u16 *)p));
 }
-static inline int isonum_723(char *p)
+static inline unsigned int isonum_723(char *p)
 {
 	/* Ignore bigendian datum due to broken mastering programs */
 	return le16_to_cpu(get_unaligned((u16 *)p));
 }
-static inline int isonum_731(char *p)
+static inline unsigned int isonum_731(char *p)
 {
 	return le32_to_cpu(get_unaligned((u32 *)p));
 }
-static inline int isonum_732(char *p)
+static inline unsigned int isonum_732(char *p)
 {
 	return be32_to_cpu(get_unaligned((u32 *)p));
 }
-static inline int isonum_733(char *p)
+static inline unsigned int isonum_733(char *p)
 {
 	/* Ignore bigendian datum due to broken mastering programs */
 	return le32_to_cpu(get_unaligned((u32 *)p));

--------------000604060103000707090003--

