Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSJIVn4>; Wed, 9 Oct 2002 17:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262102AbSJIVnz>; Wed, 9 Oct 2002 17:43:55 -0400
Received: from hera.cwi.nl ([192.16.191.8]:10432 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262100AbSJIVnl>;
	Wed, 9 Oct 2002 17:43:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 9 Oct 2002 23:49:20 +0200 (MEST)
Message-Id: <UTC200210092149.g99LnKl02510.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] isofs fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some dead code and nonsense code.
The part that changes behaviour is

-       if (sbi->s_cruft == 'n' &&
-           (volume_seq_no != 0) && (volume_seq_no != 1)) {
-               printk(KERN_WARNING "Warning: defective CD-ROM "
-                      "(volume sequence number %d). "
-                      "Enabling \"cruft\" mount option.\n", volume_seq_no);
-               sbi->s_cruft = 'y';
-       }

that has already bitten lots of people.
Nothing is wrong with a volume sequence number different from 0 or 1.
(Cf. Ecma-119.pdf, Sections 4.17, 4.18, 6.6.)

Andries


--- linux-2.5.41/linux/fs/isofs/inode.c	Sat Oct  5 13:46:10 2002
+++ linux-2.5.41a/linux/fs/isofs/inode.c	Wed Oct  9 23:34:06 2002
@@ -34,11 +34,6 @@
 
 #include "zisofs.h"
 
-/*
- * We have no support for "multi volume" CDs, but more and more disks carry
- * wrong information within the volume descriptors.
- */
-#define IGNORE_WRONG_MULTI_VOLUME_SPECS
 #define BEQUIET
 
 #ifdef LEAK_CHECK
@@ -556,19 +551,6 @@
 	if (!parse_options((char *) data, &opt))
 		goto out_freesbi;
 
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
@@ -673,19 +655,11 @@
 
 	if(sbi->s_high_sierra){
 	  rootp = (struct iso_directory_record *) h_pri->root_directory_record;
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	  if (isonum_723 (h_pri->volume_set_size) != 1)
-		goto out_no_support;
-#endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
 	  sbi->s_nzones = isonum_733 (h_pri->volume_space_size);
 	  sbi->s_log_zone_size = isonum_723 (h_pri->logical_block_size);
 	  sbi->s_max_size = isonum_733(h_pri->volume_space_size);
 	} else {
 	  rootp = (struct iso_directory_record *) pri->root_directory_record;
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	  if (isonum_723 (pri->volume_set_size) != 1)
-		goto out_no_support;
-#endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
 	  sbi->s_nzones = isonum_733 (pri->volume_space_size);
 	  sbi->s_log_zone_size = isonum_723 (pri->logical_block_size);
 	  sbi->s_max_size = isonum_733(pri->volume_space_size);
@@ -898,11 +872,6 @@
 	printk(KERN_WARNING "Logical zone size(%d) < hardware blocksize(%u)\n",
 		orig_zonesize, opt.blocksize);
 	goto out_freebh;
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-out_no_support:
-	printk(KERN_WARNING "Multi-volume disks not supported.\n");
-	goto out_freebh;
-#endif
 out_unknown_format:
 	if (!silent)
 		printk(KERN_WARNING "Unable to identify CD-ROM format.\n");
@@ -1313,7 +1282,7 @@
 		iso_date(de->date, high_sierra);
 
 	ei->i_first_extent = (isonum_733 (de->extent) +
-					   isonum_711 (de->ext_attr_length));
+			      isonum_711 (de->ext_attr_length));
 
 	/* Set the number of blocks for stat() - should be done before RR */
 	inode->i_blksize = PAGE_CACHE_SIZE; /* For stat() only */
@@ -1334,51 +1303,30 @@
 	/* get the volume sequence number */
 	volume_seq_no = isonum_723 (de->volume_sequence_number) ;
 
-	/*
-	 * Disable checking if we see any volume number other than 0 or 1.
-	 * We could use the cruft option, but that has multiple purposes, one
-	 * of which is limiting the file size to 16Mb.  Thus we silently allow
-	 * volume numbers of 0 to go through without complaining.
-	 */
-	if (sbi->s_cruft == 'n' &&
-	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
-		printk(KERN_WARNING "Warning: defective CD-ROM "
-		       "(volume sequence number %d). "
-		       "Enabling \"cruft\" mount option.\n", volume_seq_no);
-		sbi->s_cruft = 'y';
-	}
-
 	/* Install the inode operations vector */
-#ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	if (sbi->s_cruft != 'y' &&
-	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
-		printk(KERN_WARNING "Multi-volume CD somehow got mounted.\n");
-	} else
-#endif /*IGNORE_WRONG_MULTI_VOLUME_SPECS */
-	{
-		if (S_ISREG(inode->i_mode)) {
-			inode->i_fop = &generic_ro_fops;
-			switch ( ei->i_file_format ) {
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_fop = &generic_ro_fops;
+		switch ( ei->i_file_format ) {
 #ifdef CONFIG_ZISOFS
-			case isofs_file_compressed:
-				inode->i_data.a_ops = &zisofs_aops;
-				break;
+		case isofs_file_compressed:
+			inode->i_data.a_ops = &zisofs_aops;
+			break;
 #endif
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
+
  out:
 	if (tmpde)
 		kfree(tmpde);
