Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311218AbSCQPTV>; Sun, 17 Mar 2002 10:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312042AbSCQPTF>; Sun, 17 Mar 2002 10:19:05 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:900 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S311218AbSCQPSm>; Sun, 17 Mar 2002 10:18:42 -0500
Message-ID: <3C94B3AC.7060909@didntduck.org>
Date: Sun, 17 Mar 2002 10:18:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - isofs
Content-Type: multipart/mixed;
 boundary="------------010407020906090906060506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407020906090906060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates isofs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------010407020906090906060506
Content-Type: text/plain;
 name="sb-iso-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-iso-1"

diff -urN linux-2.5.7-pre2/fs/isofs/dir.c linux/fs/isofs/dir.c
--- linux-2.5.7-pre2/fs/isofs/dir.c	Thu Mar  7 21:18:20 2002
+++ linux/fs/isofs/dir.c	Sat Mar 16 00:32:28 2002
@@ -110,14 +110,13 @@
 	struct buffer_head *bh = NULL;
 	int len;
 	int map;
-	int high_sierra;
 	int first_de = 1;
 	char *p = NULL;		/* Quiet GCC */
 	struct iso_directory_record *de;
+	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
 
 	offset = filp->f_pos & (bufsize - 1);
 	block = filp->f_pos >> bufbits;
-	high_sierra = inode->i_sb->u.isofs_sb.s_high_sierra;
 
 	while (filp->f_pos < inode->i_size) {
 		int de_len;
@@ -166,7 +165,7 @@
 			de = tmpde;
 		}
 
-		if (de->flags[-high_sierra] & 0x80) {
+		if (de->flags[-sbi->s_high_sierra] & 0x80) {
 			first_de = 0;
 			filp->f_pos += de_len;
 			continue;
@@ -194,16 +193,16 @@
 
 		/* Handle everything else.  Do name translation if there
 		   is no Rock Ridge NM field. */
-		if (inode->i_sb->u.isofs_sb.s_unhide == 'n') {
+		if (sbi->s_unhide == 'n') {
 			/* Do not report hidden or associated files */
-			if (de->flags[-high_sierra] & 5) {
+			if (de->flags[-sbi->s_high_sierra] & 5) {
 				filp->f_pos += de_len;
 				continue;
 			}
 		}
 
 		map = 1;
-		if (inode->i_sb->u.isofs_sb.s_rock) {
+		if (sbi->s_rock) {
 			len = get_rock_ridge_filename(de, tmpname, inode);
 			if (len != 0) {		/* may be -1 */
 				p = tmpname;
@@ -212,16 +211,16 @@
 		}
 		if (map) {
 #ifdef CONFIG_JOLIET
-			if (inode->i_sb->u.isofs_sb.s_joliet_level) {
+			if (sbi->s_joliet_level) {
 				len = get_joliet_filename(de, tmpname, inode);
 				p = tmpname;
 			} else
 #endif
-			if (inode->i_sb->u.isofs_sb.s_mapping == 'a') {
+			if (sbi->s_mapping == 'a') {
 				len = get_acorn_filename(de, tmpname, inode);
 				p = tmpname;
 			} else
-			if (inode->i_sb->u.isofs_sb.s_mapping == 'n') {
+			if (sbi->s_mapping == 'n') {
 				len = isofs_name_translate(de, tmpname, inode);
 				p = tmpname;
 			} else {
diff -urN linux-2.5.7-pre2/fs/isofs/inode.c linux/fs/isofs/inode.c
--- linux-2.5.7-pre2/fs/isofs/inode.c	Sat Mar 16 00:17:32 2002
+++ linux/fs/isofs/inode.c	Sat Mar 16 00:32:28 2002
@@ -60,10 +60,11 @@
 
 static void isofs_put_super(struct super_block *sb)
 {
+	struct isofs_sb_info *sbi = ISOFS_SB(sb);
 #ifdef CONFIG_JOLIET
-	if (sb->u.isofs_sb.s_nls_iocharset) {
-		unload_nls(sb->u.isofs_sb.s_nls_iocharset);
-		sb->u.isofs_sb.s_nls_iocharset = NULL;
+	if (sbi->s_nls_iocharset) {
+		unload_nls(sbi->s_nls_iocharset);
+		sbi->s_nls_iocharset = NULL;
 	}
 #endif
 
@@ -72,6 +73,8 @@
 	       check_malloc, check_bread);
 #endif
 
+	kfree(sbi);
+	sb->u.generic_sbp = NULL;
 	return;
 }
 
@@ -518,7 +521,6 @@
 	struct iso_supplementary_descriptor *sec = NULL;
 	struct iso_directory_record   * rootp;
 	int				joliet_level = 0;
-	int				high_sierra;
 	int				iso_blknum, block;
 	int				orig_zonesize;
 	int				table;
@@ -526,9 +528,16 @@
 	unsigned long			first_data_zone;
 	struct inode		      * inode;
 	struct iso9660_options		opt;
+	struct isofs_sb_info	      * sbi;
+
+	sbi = kmalloc(sizeof(struct isofs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	s->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct isofs_sb_info));
 
 	if (!parse_options((char *) data, &opt))
-		goto out_unlock;
+		goto out_freesbi;
 
 #if 0
 	printk("map = %c\n", opt.map);
@@ -554,7 +563,7 @@
 	 */
 	opt.blocksize = sb_min_blocksize(s, opt.blocksize);
 
-	s->u.isofs_sb.s_high_sierra = high_sierra = 0; /* default is iso9660 */
+	sbi->s_high_sierra = 0; /* default is iso9660 */
 
 	vol_desc_start = (opt.sbsector != -1) ?
 		opt.sbsector : isofs_get_last_session(s,opt.session);
@@ -614,8 +623,7 @@
 		    if (isonum_711 (hdp->type) != ISO_VD_PRIMARY)
 		        goto out_freebh;
 		
-		    s->u.isofs_sb.s_high_sierra = 1;
-		    high_sierra = 1;
+		    sbi->s_high_sierra = 1;
 		    opt.rock = 'n';
 		    h_pri = (struct hs_primary_descriptor *)vdp;
 		    goto root_found;
@@ -646,29 +654,29 @@
 	    pri = (struct iso_primary_descriptor *) sec;
 	}
 
-	if(high_sierra){
+	if(sbi->s_high_sierra){
 	  rootp = (struct iso_directory_record *) h_pri->root_directory_record;
 #ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
 	  if (isonum_723 (h_pri->volume_set_size) != 1)
 		goto out_no_support;
 #endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
-	  s->u.isofs_sb.s_nzones = isonum_733 (h_pri->volume_space_size);
-	  s->u.isofs_sb.s_log_zone_size = isonum_723 (h_pri->logical_block_size);
-	  s->u.isofs_sb.s_max_size = isonum_733(h_pri->volume_space_size);
+	  sbi->s_nzones = isonum_733 (h_pri->volume_space_size);
+	  sbi->s_log_zone_size = isonum_723 (h_pri->logical_block_size);
+	  sbi->s_max_size = isonum_733(h_pri->volume_space_size);
 	} else {
 	  rootp = (struct iso_directory_record *) pri->root_directory_record;
 #ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
 	  if (isonum_723 (pri->volume_set_size) != 1)
 		goto out_no_support;
 #endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
-	  s->u.isofs_sb.s_nzones = isonum_733 (pri->volume_space_size);
-	  s->u.isofs_sb.s_log_zone_size = isonum_723 (pri->logical_block_size);
-	  s->u.isofs_sb.s_max_size = isonum_733(pri->volume_space_size);
+	  sbi->s_nzones = isonum_733 (pri->volume_space_size);
+	  sbi->s_log_zone_size = isonum_723 (pri->logical_block_size);
+	  sbi->s_max_size = isonum_733(pri->volume_space_size);
 	}
 
-	s->u.isofs_sb.s_ninodes = 0; /* No way to figure this out easily */
+	sbi->s_ninodes = 0; /* No way to figure this out easily */
 
-	orig_zonesize = s -> u.isofs_sb.s_log_zone_size;
+	orig_zonesize = sbi->s_log_zone_size;
 	/*
 	 * If the zone size is smaller than the hardware sector size,
 	 * this is a fatal error.  This would occur if the disc drive
@@ -680,10 +688,10 @@
 		goto out_bad_size;
 
 	/* RDE: convert log zone size to bit shift */
-	switch (s -> u.isofs_sb.s_log_zone_size)
-	  { case  512: s -> u.isofs_sb.s_log_zone_size =  9; break;
-	    case 1024: s -> u.isofs_sb.s_log_zone_size = 10; break;
-	    case 2048: s -> u.isofs_sb.s_log_zone_size = 11; break;
+	switch (sbi->s_log_zone_size)
+	  { case  512: sbi->s_log_zone_size =  9; break;
+	    case 1024: sbi->s_log_zone_size = 10; break;
+	    case 2048: sbi->s_log_zone_size = 11; break;
 
 	    default:
 		goto out_bad_zone_size;
@@ -705,16 +713,16 @@
 
 	first_data_zone = ((isonum_733 (rootp->extent) +
 			  isonum_711 (rootp->ext_attr_length))
-			 << s -> u.isofs_sb.s_log_zone_size);
-	s->u.isofs_sb.s_firstdatazone = first_data_zone;
+			 << sbi->s_log_zone_size);
+	sbi->s_firstdatazone = first_data_zone;
 #ifndef BEQUIET
 	printk(KERN_DEBUG "Max size:%ld   Log zone size:%ld\n",
-	       s->u.isofs_sb.s_max_size,
-	       1UL << s->u.isofs_sb.s_log_zone_size);
+	       sbi->s_max_size,
+	       1UL << sbi->s_log_zone_size);
 	printk(KERN_DEBUG "First datazone:%ld   Root inode number:%ld\n",
-	       s->u.isofs_sb.s_firstdatazone >> s -> u.isofs_sb.s_log_zone_size,
-	       s->u.isofs_sb.s_firstdatazone);
-	if(high_sierra)
+	       sbi->s_firstdatazone >> sbi->s_log_zone_size,
+	       sbi->s_firstdatazone);
+	if(sbi->s_high_sierra)
 		printk(KERN_DEBUG "Disc in High Sierra format.\n");
 #endif
 
@@ -732,7 +740,7 @@
 			pri->root_directory_record;
 		first_data_zone = ((isonum_733 (rootp->extent) +
 			  	isonum_711 (rootp->ext_attr_length))
-				 << s -> u.isofs_sb.s_log_zone_size);
+				 << sbi->s_log_zone_size);
 	}
 
 	/*
@@ -761,43 +769,43 @@
 	 */
 	sb_set_blocksize(s, orig_zonesize);
 
-	s->u.isofs_sb.s_nls_iocharset = NULL;
+	sbi->s_nls_iocharset = NULL;
 
 #ifdef CONFIG_JOLIET
 	if (joliet_level && opt.utf8 == 0) {
 		char * p = opt.iocharset ? opt.iocharset : "iso8859-1";
-		s->u.isofs_sb.s_nls_iocharset = load_nls(p);
-		if (! s->u.isofs_sb.s_nls_iocharset) {
+		sbi->s_nls_iocharset = load_nls(p);
+		if (! sbi->s_nls_iocharset) {
 			/* Fail only if explicit charset specified */
 			if (opt.iocharset)
-				goto out_unlock;
-			s->u.isofs_sb.s_nls_iocharset = load_nls_default();
+				goto out_freesbi;
+			sbi->s_nls_iocharset = load_nls_default();
 		}
 	}
 #endif
 	s->s_op = &isofs_sops;
-	s->u.isofs_sb.s_mapping = opt.map;
-	s->u.isofs_sb.s_rock = (opt.rock == 'y' ? 2 : 0);
-	s->u.isofs_sb.s_rock_offset = -1; /* initial offset, will guess until SP is found*/
-	s->u.isofs_sb.s_cruft = opt.cruft;
-	s->u.isofs_sb.s_unhide = opt.unhide;
-	s->u.isofs_sb.s_uid = opt.uid;
-	s->u.isofs_sb.s_gid = opt.gid;
-	s->u.isofs_sb.s_utf8 = opt.utf8;
-	s->u.isofs_sb.s_nocompress = opt.nocompress;
+	sbi->s_mapping = opt.map;
+	sbi->s_rock = (opt.rock == 'y' ? 2 : 0);
+	sbi->s_rock_offset = -1; /* initial offset, will guess until SP is found*/
+	sbi->s_cruft = opt.cruft;
+	sbi->s_unhide = opt.unhide;
+	sbi->s_uid = opt.uid;
+	sbi->s_gid = opt.gid;
+	sbi->s_utf8 = opt.utf8;
+	sbi->s_nocompress = opt.nocompress;
 	/*
 	 * It would be incredibly stupid to allow people to mark every file
 	 * on the disk as suid, so we merely allow them to set the default
 	 * permissions.
 	 */
-	s->u.isofs_sb.s_mode = opt.mode & 0777;
+	sbi->s_mode = opt.mode & 0777;
 
 	/*
 	 * Read the root inode, which _may_ result in changing
 	 * the s_rock flag. Once we have the final s_rock value,
 	 * we then decide whether to use the Joliet descriptor.
 	 */
-	inode = iget(s, s->u.isofs_sb.s_firstdatazone);
+	inode = iget(s, sbi->s_firstdatazone);
 
 	/*
 	 * If this disk has both Rock Ridge and Joliet on it, then we
@@ -807,16 +815,16 @@
 	 * CD with Unicode names.  Until someone sees such a beast, it
 	 * will not be supported.
 	 */
-	if (s->u.isofs_sb.s_rock == 1) {
+	if (sbi->s_rock == 1) {
 		joliet_level = 0;
 	} else if (joliet_level) {
-		s->u.isofs_sb.s_rock = 0;
-		if (s->u.isofs_sb.s_firstdatazone != first_data_zone) {
-			s->u.isofs_sb.s_firstdatazone = first_data_zone;
+		sbi->s_rock = 0;
+		if (sbi->s_firstdatazone != first_data_zone) {
+			sbi->s_firstdatazone = first_data_zone;
 			printk(KERN_DEBUG 
 				"ISOFS: changing to secondary root\n");
 			iput(inode);
-			inode = iget(s, s->u.isofs_sb.s_firstdatazone);
+			inode = iget(s, sbi->s_firstdatazone);
 		}
 	}
 
@@ -825,7 +833,7 @@
 		if (joliet_level) opt.check = 'r';
 		else opt.check = 's';
 	}
-	s->u.isofs_sb.s_joliet_level = joliet_level;
+	sbi->s_joliet_level = joliet_level;
 
 	/* check the root inode */
 	if (!inode)
@@ -855,18 +863,18 @@
 out_iput:
 	iput(inode);
 #ifdef CONFIG_JOLIET
-	if (s->u.isofs_sb.s_nls_iocharset)
-		unload_nls(s->u.isofs_sb.s_nls_iocharset);
+	if (sbi->s_nls_iocharset)
+		unload_nls(sbi->s_nls_iocharset);
 #endif
-	goto out_unlock;
+	goto out_freesbi;
 out_no_read:
 	printk(KERN_WARNING "isofs_fill_super: "
 		"bread failed, dev=%s, iso_blknum=%d, block=%d\n",
 		s->s_id, iso_blknum, block);
-	goto out_unlock;
+	goto out_freesbi;
 out_bad_zone_size:
 	printk(KERN_WARNING "Bad logical zone size %ld\n",
-		s->u.isofs_sb.s_log_zone_size);
+		sbi->s_log_zone_size);
 	goto out_freebh;
 out_bad_size:
 	printk(KERN_WARNING "Logical zone size(%d) < hardware blocksize(%u)\n",
@@ -883,7 +891,9 @@
 
 out_freebh:
 	brelse(bh);
-out_unlock:
+out_freesbi:
+	kfree(sbi);
+	s->u.generic_sbp = NULL;
 	return -EINVAL;
 }
 
@@ -891,11 +901,11 @@
 {
 	buf->f_type = ISOFS_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = (sb->u.isofs_sb.s_nzones
-                  << (sb->u.isofs_sb.s_log_zone_size - sb->s_blocksize_bits));
+	buf->f_blocks = (ISOFS_SB(sb)->s_nzones
+                  << (ISOFS_SB(sb)->s_log_zone_size - sb->s_blocksize_bits));
 	buf->f_bfree = 0;
 	buf->f_bavail = 0;
-	buf->f_files = sb->u.isofs_sb.s_ninodes;
+	buf->f_files = ISOFS_SB(sb)->s_ninodes;
 	buf->f_ffree = 0;
 	buf->f_namelen = NAME_MAX;
 	return 0;
@@ -1058,7 +1068,7 @@
 {
 	unsigned long f_pos = inode->i_ino;
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	int high_sierra = inode->i_sb->u.isofs_sb.s_high_sierra;
+	int high_sierra = ISOFS_SB(inode->i_sb)->s_high_sierra;
 	struct buffer_head * bh = NULL;
 	unsigned long block, offset;
 	int i = 0;
@@ -1157,9 +1167,10 @@
 static void isofs_read_inode(struct inode * inode)
 {
 	struct super_block *sb = inode->i_sb;
+	struct isofs_sb_info *sbi = ISOFS_SB(sb);
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	int block = inode->i_ino >> ISOFS_BUFFER_BITS(inode);
-	int high_sierra = sb->u.isofs_sb.s_high_sierra;
+	int high_sierra = sbi->s_high_sierra;
 	struct buffer_head * bh = NULL;
 	struct iso_directory_record * de;
 	struct iso_directory_record * tmpde = NULL;
@@ -1205,7 +1216,7 @@
 				       do it the hard way. */
 	} else {
  		/* Everybody gets to read the file. */
-		inode->i_mode = inode->i_sb->u.isofs_sb.s_mode;
+		inode->i_mode = sbi->s_mode;
 		inode->i_nlink = 1;
 	        inode->i_mode |= S_IFREG;
 		/* If there are no periods in the name,
@@ -1217,8 +1228,8 @@
 		if(i == de->name_len[0] || de->name[i] == ';')
 			inode->i_mode |= S_IXUGO; /* execute permission */
 	}
-	inode->i_uid = inode->i_sb->u.isofs_sb.s_uid;
-	inode->i_gid = inode->i_sb->u.isofs_sb.s_gid;
+	inode->i_uid = sbi->s_uid;
+	inode->i_gid = sbi->s_gid;
 	inode->i_blocks = inode->i_blksize = 0;
 
 	ei->i_format_parm[0] = 0;
@@ -1241,10 +1252,10 @@
 	 *	    legal. Do not prevent to use DVD's schilling@fokus.gmd.de
 	 */
 	if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
-	    inode->i_sb->u.isofs_sb.s_cruft == 'n') {
+	    sbi->s_cruft == 'n') {
 		printk(KERN_WARNING "Warning: defective CD-ROM.  "
 		       "Enabling \"cruft\" mount option.\n");
-		inode->i_sb->u.isofs_sb.s_cruft = 'y';
+		sbi->s_cruft = 'y';
 	}
 
 	/*
@@ -1254,7 +1265,7 @@
 	 * on the CDROM.
 	 */
 
-	if (inode->i_sb->u.isofs_sb.s_cruft == 'y' &&
+	if (sbi->s_cruft == 'y' &&
 	    inode->i_size & 0xff000000) {
 		inode->i_size &= 0x00ffffff;
 	}
@@ -1298,8 +1309,8 @@
 	if (!high_sierra) {
 		parse_rock_ridge_inode(de, inode);
 		/* if we want uid/gid set, override the rock ridge setting */
-		test_and_set_uid(&inode->i_uid, inode->i_sb->u.isofs_sb.s_uid);
-		test_and_set_gid(&inode->i_gid, inode->i_sb->u.isofs_sb.s_gid);
+		test_and_set_uid(&inode->i_uid, sbi->s_uid);
+		test_and_set_gid(&inode->i_gid, sbi->s_gid);
 	}
 
 	/* get the volume sequence number */
@@ -1311,17 +1322,17 @@
 	 * of which is limiting the file size to 16Mb.  Thus we silently allow
 	 * volume numbers of 0 to go through without complaining.
 	 */
-	if (inode->i_sb->u.isofs_sb.s_cruft == 'n' &&
+	if (sbi->s_cruft == 'n' &&
 	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
 		printk(KERN_WARNING "Warning: defective CD-ROM "
 		       "(volume sequence number %d). "
 		       "Enabling \"cruft\" mount option.\n", volume_seq_no);
-		inode->i_sb->u.isofs_sb.s_cruft = 'y';
+		sbi->s_cruft = 'y';
 	}
 
 	/* Install the inode operations vector */
 #ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
-	if (inode->i_sb->u.isofs_sb.s_cruft != 'y' &&
+	if (sbi->s_cruft != 'y' &&
 	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
 		printk(KERN_WARNING "Multi-volume CD somehow got mounted.\n");
 	} else
diff -urN linux-2.5.7-pre2/fs/isofs/joliet.c linux/fs/isofs/joliet.c
--- linux-2.5.7-pre2/fs/isofs/joliet.c	Thu Mar  7 21:18:58 2002
+++ linux/fs/isofs/joliet.c	Sat Mar 16 00:32:28 2002
@@ -77,8 +77,8 @@
 	struct nls_table *nls;
 	unsigned char len = 0;
 
-	utf8 = inode->i_sb->u.isofs_sb.s_utf8;
-	nls = inode->i_sb->u.isofs_sb.s_nls_iocharset;
+	utf8 = ISOFS_SB(inode->i_sb)->s_utf8;
+	nls = ISOFS_SB(inode->i_sb)->s_nls_iocharset;
 
 	if (utf8) {
 		len = wcsntombs_be(outname, de->name,
diff -urN linux-2.5.7-pre2/fs/isofs/namei.c linux/fs/isofs/namei.c
--- linux-2.5.7-pre2/fs/isofs/namei.c	Thu Mar  7 21:18:56 2002
+++ linux/fs/isofs/namei.c	Sat Mar 16 00:32:28 2002
@@ -65,6 +65,7 @@
 	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
 	unsigned int block, f_pos, offset;
 	struct buffer_head * bh = NULL;
+	struct isofs_sb_info *sbi = ISOFS_SB(dir->i_sb);
 
 	if (!ISOFS_I(dir)->i_first_extent)
 		return 0;
@@ -120,19 +121,19 @@
 		dlen = de->name_len[0];
 		dpnt = de->name;
 
-		if (dir->i_sb->u.isofs_sb.s_rock &&
+		if (sbi->s_rock &&
 		    ((i = get_rock_ridge_filename(de, tmpname, dir)))) {
 			dlen = i; 	/* possibly -1 */
 			dpnt = tmpname;
 #ifdef CONFIG_JOLIET
-		} else if (dir->i_sb->u.isofs_sb.s_joliet_level) {
+		} else if (sbi->s_joliet_level) {
 			dlen = get_joliet_filename(de, tmpname, dir);
 			dpnt = tmpname;
 #endif
-		} else if (dir->i_sb->u.isofs_sb.s_mapping == 'a') {
+		} else if (sbi->s_mapping == 'a') {
 			dlen = get_acorn_filename(de, tmpname, dir);
 			dpnt = tmpname;
-		} else if (dir->i_sb->u.isofs_sb.s_mapping == 'n') {
+		} else if (sbi->s_mapping == 'n') {
 			dlen = isofs_name_translate(de, tmpname, dir);
 			dpnt = tmpname;
 		}
@@ -142,8 +143,8 @@
 		 */
 		match = 0;
 		if (dlen > 0 &&
-		    (!(de->flags[-dir->i_sb->u.isofs_sb.s_high_sierra] & 5)
-		     || dir->i_sb->u.isofs_sb.s_unhide == 'y'))
+		    (!(de->flags[-sbi->s_high_sierra] & 5)
+		     || sbi->s_unhide == 'y'))
 		{
 			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
 		}
diff -urN linux-2.5.7-pre2/fs/isofs/rock.c linux/fs/isofs/rock.c
--- linux-2.5.7-pre2/fs/isofs/rock.c	Thu Mar  7 21:18:04 2002
+++ linux/fs/isofs/rock.c	Sat Mar 16 00:32:28 2002
@@ -32,7 +32,7 @@
 #define CHECK_SP(FAIL)	       			\
       if(rr->u.SP.magic[0] != 0xbe) FAIL;	\
       if(rr->u.SP.magic[1] != 0xef) FAIL;       \
-      inode->i_sb->u.isofs_sb.s_rock_offset=rr->u.SP.skip;
+      ISOFS_SB(inode->i_sb)->s_rock_offset=rr->u.SP.skip;
 /* We define a series of macros because each function must do exactly the
    same thing in certain places.  We use the macros to ensure that everything
    is done correctly */
@@ -51,10 +51,10 @@
   if(LEN & 1) LEN++;						\
   CHR = ((unsigned char *) DE) + LEN;				\
   LEN = *((unsigned char *) DE) - LEN;                          \
-  if (inode->i_sb->u.isofs_sb.s_rock_offset!=-1)                \
+  if (ISOFS_SB(inode->i_sb)->s_rock_offset!=-1)                \
   {                                                             \
-     LEN-=inode->i_sb->u.isofs_sb.s_rock_offset;                \
-     CHR+=inode->i_sb->u.isofs_sb.s_rock_offset;                \
+     LEN-=ISOFS_SB(inode->i_sb)->s_rock_offset;                \
+     CHR+=ISOFS_SB(inode->i_sb)->s_rock_offset;                \
      if (LEN<0) LEN=0;                                          \
   }                                                             \
 }                                     
@@ -102,7 +102,7 @@
   /* Return value if we do not find appropriate record. */
   retval = isonum_733 (de->extent);
   
-  if (!inode->i_sb->u.isofs_sb.s_rock) return retval;
+  if (!ISOFS_SB(inode->i_sb)->s_rock) return retval;
 
   SETUP_ROCK_RIDGE(de, chr, len);
  repeat:
@@ -162,7 +162,7 @@
   CONTINUE_DECLS;
   int retnamlen = 0, truncate=0;
  
-  if (!inode->i_sb->u.isofs_sb.s_rock) return 0;
+  if (!ISOFS_SB(inode->i_sb)->s_rock) return 0;
   *retname = 0;
 
   SETUP_ROCK_RIDGE(de, chr, len);
@@ -234,7 +234,7 @@
   int symlink_len = 0;
   CONTINUE_DECLS;
 
-  if (!inode->i_sb->u.isofs_sb.s_rock) return 0;
+  if (!ISOFS_SB(inode->i_sb)->s_rock) return 0;
 
   SETUP_ROCK_RIDGE(de, chr, len);
   if (regard_xa)
@@ -272,7 +272,7 @@
 	CHECK_CE;
 	break;
       case SIG('E','R'):
-	inode->i_sb->u.isofs_sb.s_rock = 1;
+	ISOFS_SB(inode->i_sb)->s_rock = 1;
 	printk(KERN_DEBUG "ISO 9660 Extensions: ");
 	{ int p;
 	  for(p=0;p<rr->u.ER.len_id;p++) printk("%c",rr->u.ER.data[p]);
@@ -368,7 +368,7 @@
 	ISOFS_I(inode)->i_first_extent = isonum_733(rr->u.CL.location);
 	reloc = iget(inode->i_sb,
 		     (ISOFS_I(inode)->i_first_extent <<
-		      inode -> i_sb -> u.isofs_sb.s_log_zone_size));
+		      ISOFS_SB(inode->i_sb)->s_log_zone_size));
 	if (!reloc)
 		goto out;
 	inode->i_mode = reloc->i_mode;
@@ -385,7 +385,7 @@
 	break;
 #ifdef CONFIG_ZISOFS
       case SIG('Z','F'):
-	      if ( !inode->i_sb->u.isofs_sb.s_nocompress ) {
+	      if ( !ISOFS_SB(inode->i_sb)->s_nocompress ) {
 		      int algo;
 		      algo = isonum_721(rr->u.ZF.algorithm);
 		      if ( algo == SIG('p','z') ) {
@@ -478,8 +478,8 @@
    int result=parse_rock_ridge_inode_internal(de,inode,0);
    /* if rockridge flag was reset and we didn't look for attributes
     * behind eventual XA attributes, have a look there */
-   if ((inode->i_sb->u.isofs_sb.s_rock_offset==-1)
-       &&(inode->i_sb->u.isofs_sb.s_rock==2))
+   if ((ISOFS_SB(inode->i_sb)->s_rock_offset==-1)
+       &&(ISOFS_SB(inode->i_sb)->s_rock==2))
      {
 	result=parse_rock_ridge_inode_internal(de,inode,14);
      };
@@ -506,7 +506,7 @@
 	unsigned char *chr;
 	struct rock_ridge *rr;
 
-	if (!inode->i_sb->u.isofs_sb.s_rock)
+	if (!ISOFS_SB(inode->i_sb)->s_rock)
 		panic ("Cannot have symlink with high sierra variant of iso filesystem\n");
 
 	block = inode->i_ino >> bufbits;
diff -urN linux-2.5.7-pre2/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre2/include/linux/fs.h	Sat Mar 16 00:17:34 2002
+++ linux/include/linux/fs.h	Sat Mar 16 00:38:59 2002
@@ -648,7 +648,6 @@
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
-#include <linux/iso_fs_sb.h>
 #include <linux/sysv_fs_sb.h>
 #include <linux/affs_fs_sb.h>
 #include <linux/ufs_fs_sb.h>
@@ -697,7 +696,6 @@
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;
-		struct isofs_sb_info	isofs_sb;
 		struct sysv_sb_info	sysv_sb;
 		struct affs_sb_info	affs_sb;
 		struct ufs_sb_info	ufs_sb;
diff -urN linux-2.5.7-pre2/include/linux/iso_fs.h linux/include/linux/iso_fs.h
--- linux-2.5.7-pre2/include/linux/iso_fs.h	Thu Mar 14 20:53:49 2002
+++ linux/include/linux/iso_fs.h	Sat Mar 16 00:39:11 2002
@@ -160,7 +160,6 @@
 
 #define ISOFS_BUFFER_SIZE(INODE) ((INODE)->i_sb->s_blocksize)
 #define ISOFS_BUFFER_BITS(INODE) ((INODE)->i_sb->s_blocksize_bits)
-#define ISOFS_ZONE_BITS(INODE)   ((INODE)->i_sb->u.isofs_sb.s_log_zone_size)
 
 #define ISOFS_SUPER_MAGIC 0x9660
 
@@ -171,6 +170,12 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 #include <linux/iso_fs_i.h>
+#include <linux/iso_fs_sb.h>
+
+static inline struct isofs_sb_info *ISOFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 
 static inline struct iso_inode_info *ISOFS_I(struct inode *inode)
 {

--------------010407020906090906060506--

