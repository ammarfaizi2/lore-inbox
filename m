Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTHYLKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTHYLKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:10:20 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:1153 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261507AbTHYLIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:08:54 -0400
Subject: [PATCH] NTFS bugfix, buildfix for 2.4.22-rc4
From: Richard Russon <ntfs@flatcap.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Anton Altaparmakov <aia21@cantab.net>
Content-Type: text/plain
Message-Id: <1061809730.3727.12.camel@ipa.flatcap.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 25 Aug 2003 12:08:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This patch:
  Fixes all NTFS build warnings
  Fixes some broken macros (debug build only)

Gerardo Exequiel Pozzi sent you a patch to fix the NTFS build warnings.
I have tested the patch and fixed a couple of broken macros he missed.
Anton Altaparmakov has given the patch his seal of approval :-)

Please can you apply the patch to 2.4.22-rc4

Cheers,
  FlatCap - Richard Russon
  ntfs@flatcap.org


diff -urN linux-2.4.22-rc4/fs/ntfs/dir.c linux-2.4.22-rc4-ntfs/fs/ntfs/dir.c
--- linux-2.4.22-rc4/fs/ntfs/dir.c	2001-11-04 00:35:46.000000000 +0000
+++ linux-2.4.22-rc4-ntfs/fs/ntfs/dir.c	2003-08-25 11:54:54.000000000 +0100
@@ -802,17 +802,17 @@
 	u8 ibs_bits;
 
 	if (!ino) {
-		ntfs_error(__FUNCTION__ "(): No inode! Returning -EINVAL.\n");
+		ntfs_error("%s(): No inode! Returning -EINVAL.\n",__FUNCTION__);
 		return -EINVAL;
 	}
 	vol = ino->vol;
 	if (!vol) {
-		ntfs_error(__FUNCTION__ "(): Inode 0x%lx has no volume. "
-				"Returning -EINVAL.\n", ino->i_number);
+		ntfs_error("%s(): Inode 0x%lx has no volume. Returning "
+			    "-EINVAL.\n", __FUNCTION__, ino->i_number);
 		return -EINVAL;
 	}
-	ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 1: Entering for "
-			"inode 0x%lx, p_high = 0x%x, p_low = 0x%x.\n",
+	ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 1: Entering for inode 0x%lx, "
+			"p_high = 0x%x, p_low = 0x%x.\n", __FUNCTION__,
 			ino->i_number, *p_high, *p_low);
 	if (!*p_high) {
 		/* We are still in the index root. */
@@ -827,8 +827,8 @@
 		ino->u.index.recordsize = ibs = NTFS_GETU32(buf + 0x8);
 		ino->u.index.clusters_per_record = NTFS_GETU32(buf + 0xC);
 		entry = buf + 0x20;
-		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 2: In index "
-				"root.\n");
+		ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 2: In index root.\n",
+				__FUNCTION__);
 		ibs_bits = ffs(ibs) - 1;
 		/* Compensate for faked "." and "..". */
 		start = 2;
@@ -850,15 +850,15 @@
 		if (err || io.size != ibs)
 			goto read_err_ret;
 		if (!ntfs_check_index_record(ino, buf)) {
-			ntfs_error(__FUNCTION__ "(): Index block 0x%x is not "
-					"an index record. Returning "
-					"-ENOTDIR.\n", *p_high - 1);
+			ntfs_error("%s(): Index block 0x%x is not an index "
+					"record. Returning -ENOTDIR.\n",
+					 __FUNCTION__, *p_high - 1);
 			ntfs_free(buf);
 			return -ENOTDIR;
 		}
 		entry = buf + 0x18 + NTFS_GETU16(buf + 0x18);
-		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 3: In index "
-				"allocation.\n");
+		ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 3: In index "
+				"allocation.\n", __FUNCTION__);
 		start = 0;
 	}
 	/* Process the entries. */
@@ -867,29 +867,30 @@
 			entry += NTFS_GETU16(entry + 8)) {
 		if (start < finish) {
 			/* Skip entries that were already processed. */
-			ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 4: "
-					"Skipping already processed entry "
-					"p_high 0x%x, p_low 0x%x.\n", *p_high,
+			ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 4: Skipping "
+					"already processed entry p_high 0x%x, "
+					"p_low 0x%x.\n", __FUNCTION__, *p_high,
 					start);
 			start++;
 			continue;
 		}
-		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 5: "
-				"Processing entry p_high 0x%x, p_low 0x%x.\n",
+		ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 5: Processing entry "
+				"p_high 0x%x, p_low 0x%x.\n", __FUNCTION__,
 				*p_high, *p_low);
 		if ((err = cb(entry, param))) {
 			/* filldir signalled us to stop. */
-			ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): "
-					"Unsorted 6: cb returned %i, "
-					"returning 0, p_high 0x%x, p_low 0x%x."
-					"\n", *p_high, *p_low);
+			ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 6: cb returned "
+					"%i, returning 0, p_high 0x%x, "
+					"p_low 0x%x.\n", __FUNCTION__, err,
+					*p_high, *p_low);
 			ntfs_free(buf);
 			return 0;
 		}
 		++*p_low;
 	}
-	ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 7: After processing "
-			"entries, p_high 0x%x, p_low 0x%x.\n", *p_high, *p_low);
+	ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 7: After processing entries, "
+			"p_high 0x%x, p_low 0x%x.\n", __FUNCTION__, *p_high,
+			*p_low);
 	/* We have to locate the next record. */
 	ntfs_free(buf);
 	buf = 0;
@@ -898,15 +899,15 @@
 	if (!attr) {
 		/* Directory does not have index bitmap and index allocation. */
 		*p_high = 0x7fff;
-		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 8: No index "
-				"allocation. Returning 0, p_high 0x7fff, "
-				"p_low 0x0.\n");
+		ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 8: No index allocation. "
+				"Returning 0, p_high 0x7fff, p_low 0x0.\n",
+				__FUNCTION__);
 		return 0;
 	}
 	max_size = attr->size;
 	if (max_size > 0x7fff >> 3) {
-		ntfs_error(__FUNCTION__ "(): Directory too large. Visible "
-				"length is truncated.\n");
+		ntfs_error("%s(): Directory too large. Visible "
+				"length is truncated.\n", __FUNCTION__);
 		max_size = 0x7fff >> 3;
 	}
 	buf = ntfs_malloc(max_size);
@@ -920,26 +921,26 @@
 	attr = ntfs_find_attr(ino, vol->at_index_allocation, I30);
 	if (!attr) {
 		ntfs_free(buf);
-		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 9: Find "
-				"attr failed. Returning -EIO.\n");
+		ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 9: Find attr failed. "
+				"Returning -EIO.\n", __FUNCTION__);
 		return -EIO;
 	}
 	if (attr->resident) {
 		ntfs_free(buf);
-		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 9.5: IA is "
-				"resident. Not allowed. Returning EINVAL.\n");
+		ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 9.5: IA is resident. Not"
+				" allowed. Returning EINVAL.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 	/* Loop while going through non-allocated index records. */
 	max_size <<= 3;
 	while (1) {
 		if (++*p_high >= 0x7fff) {
-			ntfs_error(__FUNCTION__ "(): Unsorted 10: Directory "
+			ntfs_error("%s(): Unsorted 10: Directory "
 					"inode 0x%lx overflowed the maximum "
 					"number of index allocation buffers "
 					"the driver can cope with. Pretending "
 					"to be at end of directory.\n",
-					ino->i_number);
+					__FUNCTION__, ino->i_number);
 			goto fake_eod;
 		}
 		if (*p_high > max_size || (s64)*p_high << ibs_bits >
@@ -949,10 +950,9 @@
 			*p_high = 0x7fff;
 			*p_low = 0;
 			ntfs_free(buf);
-			ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted "
-					"10.5: No more index records. "
-					"Returning 0, p_high 0x7fff, p_low "
-					"0.\n");
+			ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 10.5: No more "
+					"index records. Returning 0, p_high "
+					"0x7fff, p_low 0.\n", __FUNCTION__);
 			return 0;
 		}
 		byte = (ntfs_cluster_t)(*p_high - 1);
@@ -961,16 +961,15 @@
 		if ((buf[byte] & bit))
 			break;
 	};
-	ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 11: Done. "
-			"Returning 0, p_high 0x%x, p_low 0x%x.\n", *p_high,
-			*p_low);
+	ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 11: Done. Returning 0, p_high "
+			"0x%x, p_low 0x%x.\n", __FUNCTION__, *p_high, *p_low);
 	ntfs_free(buf);
 	return 0;
 read_err_ret:
 	if (!err)
 		err = -EIO;
-	ntfs_error(__FUNCTION__ "(): Read failed. Returning error code %i.\n",
-			err);
+	ntfs_error("%s(): Read failed. Returning error code %i.\n",
+			__FUNCTION__, err);
 	ntfs_free(buf);
 	return err;
 }
diff -urN linux-2.4.22-rc4/fs/ntfs/fs.c linux-2.4.22-rc4-ntfs/fs/ntfs/fs.c
--- linux-2.4.22-rc4/fs/ntfs/fs.c	2002-08-03 01:39:45.000000000 +0100
+++ linux-2.4.22-rc4-ntfs/fs/ntfs/fs.c	2003-08-25 11:54:54.000000000 +0100
@@ -114,9 +114,9 @@
 
 	if (!ntfs_ino)
 		return -EINVAL;
-	ntfs_debug(DEBUG_LINUX, __FUNCTION__ "(): Entering for inode 0x%lx, "
-			"*pos 0x%Lx, count 0x%x.\n", ntfs_ino->i_number, *pos,
-			count);
+	ntfs_debug(DEBUG_LINUX, "%s(): Entering for inode 0x%lx, *pos 0x%Lx, "
+			"count 0x%x.\n", __FUNCTION__, ntfs_ino->i_number,
+			*pos, count);
 	/* Allows to lock fs ro at any time. */
 	if (vfs_ino->i_sb->s_flags & MS_RDONLY)
 		return -EROFS;
@@ -140,7 +140,7 @@
 	io.size = count;
 	io.do_read = 0;
 	err = ntfs_readwrite_attr(ntfs_ino, data, *pos, &io);
-	ntfs_debug(DEBUG_LINUX, __FUNCTION__ "(): Returning %i\n", -err);
+	ntfs_debug(DEBUG_LINUX, "%s(): Returning %i\n", __FUNCTION__, -err);
 	if (!err) {
 		*pos += io.size;
 		if (*pos > vfs_ino->i_size)
@@ -196,20 +196,20 @@
 	err = ntfs_encodeuni(NTFS_INO2VOL(nf->dir), (ntfs_u16*)(entry + 0x52),
 			name_len, &nf->name, &nf->namelen);
 	if (err) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Skipping "
-				"unrepresentable file.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Skipping unrepresentable "
+				"file.\n", __FUNCTION__);
 		err = 0;
 		goto err_ret;
 	}
 	if (!show_sys_files && inum < 0x10UL) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Skipping system "
-				"file (%s).\n", nf->name);
+		ntfs_debug(DEBUG_OTHER, "%s(): Skipping system file (%s).\n",
+				__FUNCTION__, nf->name);
 		err = 0;
 		goto err_ret;
 	}
 	/* Do not return ".", as this is faked. */
 	if (nf->namelen == 1 && nf->name[0] == '.') {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Skipping \".\"\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Skipping \".\"\n", __FUNCTION__);
 		err = 0;
 		goto err_ret;
 	}
@@ -218,8 +218,8 @@
 		file_type = DT_DIR;
 	else
 		file_type = DT_REG;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Calling filldir for %s with "
-			"len %i, f_pos 0x%Lx, inode %lu, %s.\n",
+	ntfs_debug(DEBUG_OTHER, "%s(): Calling filldir for %s with "
+			"len %i, f_pos 0x%Lx, inode %lu, %s.\n", __FUNCTION__,
 			nf->name, nf->namelen, (loff_t)(nf->ph << 16) | nf->pl,
 			inum, file_type == DT_DIR ? "DT_DIR" : "DT_REG");
 	/*
@@ -254,16 +254,16 @@
 	cb.pl = filp->f_pos & 0xffff;
 	cb.ph = (filp->f_pos >> 16) & 0x7fff;
 	filp->f_pos = (loff_t)(cb.ph << 16) | cb.pl;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Entering for inode %lu, "
-			"f_pos 0x%Lx, i_mode 0x%x, i_count %lu.\n", dir->i_ino,
-			filp->f_pos, (unsigned int)dir->i_mode,
+	ntfs_debug(DEBUG_OTHER, "%s(): Entering for inode %lu, f_pos 0x%Lx, "
+			"i_mode 0x%x, i_count %lu.\n", __FUNCTION__,
+			dir->i_ino, filp->f_pos, (unsigned int)dir->i_mode,
 			atomic_read(&dir->i_count));
 	if (!cb.ph) {
 		/* Start of directory. Emulate "." and "..". */
 		if (!cb.pl) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Calling "
-				    "filldir for . with len 1, f_pos 0x%Lx, "
-				    "inode %lu, DT_DIR.\n", filp->f_pos,
+			ntfs_debug(DEBUG_OTHER, "%s(): Calling filldir for . "
+				    "with len 1, f_pos 0x%Lx, inode %lu, "
+				    "DT_DIR.\n", __FUNCTION__, filp->f_pos,
 				    dir->i_ino);
 			cb.ret_code = filldir(dirent, ".", 1, filp->f_pos,
 				    dir->i_ino, DT_DIR);
@@ -273,9 +273,9 @@
 			filp->f_pos = (loff_t)(cb.ph << 16) | cb.pl;
 		}
 		if (cb.pl == (u32)1) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Calling "
-				    "filldir for .. with len 2, f_pos 0x%Lx, "
-				    "inode %lu, DT_DIR.\n", filp->f_pos,
+			ntfs_debug(DEBUG_OTHER, "%s(): Calling filldir for .. "
+				    "with len 2, f_pos 0x%Lx, inode %lu, "
+				    "DT_DIR.\n", __FUNCTION__, filp->f_pos,
 				    filp->f_dentry->d_parent->d_inode->i_ino);
 			cb.ret_code = filldir(dirent, "..", 2, filp->f_pos,
 				    filp->f_dentry->d_parent->d_inode->i_ino,
@@ -293,30 +293,31 @@
 	cb.dirent = dirent;
 	cb.type = NTFS_INO2VOL(dir)->ngt;
 	do {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Looking for next "
-				"file using ntfs_getdir_unsorted(), f_pos "
-				"0x%Lx.\n", (loff_t)(cb.ph << 16) | cb.pl);
+		ntfs_debug(DEBUG_OTHER, "%s(): Looking for next file using "
+				"ntfs_getdir_unsorted(), f_pos 0x%Lx.\n",
+				__FUNCTION__, (loff_t)(cb.ph << 16) | cb.pl);
 		err = ntfs_getdir_unsorted(NTFS_LINO2NINO(dir), &cb.ph, &cb.pl,
 				ntfs_printcb, &cb);
 	} while (!err && !cb.ret_code && cb.ph < 0x7fff);
 	filp->f_pos = (loff_t)(cb.ph << 16) | cb.pl;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After ntfs_getdir_unsorted()"
-			" calls, f_pos 0x%Lx.\n", filp->f_pos);
+	ntfs_debug(DEBUG_OTHER, "%s(): After ntfs_getdir_unsorted()"
+			" calls, f_pos 0x%Lx.\n", __FUNCTION__, filp->f_pos);
 	if (!err) {
 done:
 #ifdef DEBUG
 		if (!cb.ret_code)
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): EOD, f_pos "
-					"0x%Lx, returning 0.\n", filp->f_pos);
+			ntfs_debug(DEBUG_OTHER, "%s(): EOD, f_pos 0x%Lx, "
+					"returning 0.\n", __FUNCTION__,
+					filp->f_pos);
 		else 
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): filldir "
-					"returned %i, returning 0, f_pos "
-					"0x%Lx.\n", cb.ret_code, filp->f_pos);
+			ntfs_debug(DEBUG_OTHER, "%s(): filldir returned %i, "
+					"returning 0, f_pos 0x%Lx.\n",
+					__FUNCTION__, cb.ret_code, filp->f_pos);
 #endif
 		return 0;
 	}
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Returning %i, f_pos 0x%Lx.\n",
-			err, filp->f_pos);
+	ntfs_debug(DEBUG_OTHER, "%s(): Returning %i, f_pos 0x%Lx.\n",
+			__FUNCTION__, err, filp->f_pos);
 	return err;
 }
 
@@ -524,8 +525,8 @@
 	ntfs_iterate_s walk;
 	int err;
 	
-	ntfs_debug(DEBUG_NAME1, __FUNCTION__ "(): Looking up %s in directory "
-			"ino 0x%x.\n", d->d_name.name, (unsigned)dir->i_ino);
+	ntfs_debug(DEBUG_NAME1, "%s(): Looking up %s in directory ino 0x%x.\n",
+			__FUNCTION__, d->d_name.name, (unsigned)dir->i_ino);
 	walk.name = NULL;
 	walk.namelen = 0;
 	/* Convert to wide string. */
@@ -847,7 +848,6 @@
 			goto unl_out;
 		}
 		break;
-	default:
 		/* Nothing. Just clear the inode and exit. */
 	}
 	ntfs_clear_inode(&inode->u.ntfs_i);
diff -urN linux-2.4.22-rc4/fs/ntfs/inode.c linux-2.4.22-rc4-ntfs/fs/ntfs/inode.c
--- linux-2.4.22-rc4/fs/ntfs/inode.c	2001-12-21 17:42:03.000000000 +0000
+++ linux-2.4.22-rc4-ntfs/fs/ntfs/inode.c	2003-08-25 11:54:54.000000000 +0100
@@ -671,8 +671,8 @@
 	ntfs_cluster_t cluster, s_cluster, vcn, len;
 	__s64 l, chunk, copied;
 
-	ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): %s 0x%x bytes at offset "
-			"0x%Lx %s inode 0x%x, attr type 0x%x.\n",
+	ntfs_debug(DEBUG_FILE3, "%s(): %s 0x%x bytes at offset "
+			"0x%Lx %s inode 0x%x, attr type 0x%x.\n", __FUNCTION__,
 			dest->do_read ? "Read" : "Write", dest->size, offset,
 			dest->do_read ? "from" : "to", ino->i_number,
 			attr->type);
@@ -746,10 +746,10 @@
 			vcn + attr->d.r.runlist[rnum].len <= s_vcn; rnum++)
 		vcn += attr->d.r.runlist[rnum].len;
 	if (rnum == attr->d.r.len) {
-		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): EOPNOTSUPP: "
+		ntfs_debug(DEBUG_FILE3, "%s(): EOPNOTSUPP: "
 			"inode = 0x%x, rnum = %i, offset = 0x%Lx, vcn = 0x%x, "
-			"s_vcn = 0x%x.\n", ino->i_number, rnum, offset, vcn,
-			s_vcn);
+			"s_vcn = 0x%x.\n", __FUNCTION__, ino->i_number, rnum,
+			offset, vcn, s_vcn);
 		dump_runlist(attr->d.r.runlist, attr->d.r.len);
 		/*FIXME: Should extend runlist. */
 		return -EOPNOTSUPP;
@@ -793,8 +793,8 @@
 	buf->do_read = 1;
 	attr = ntfs_find_attr(ino, type, name);
 	if (!attr) {
-		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): attr 0x%x not found "
-				"in inode 0x%x\n", type, ino->i_number);
+		ntfs_debug(DEBUG_FILE3, "%s(): attr 0x%x not found in inode "
+				"0x%x\n", __FUNCTION__, type, ino->i_number);
 		return -EINVAL;
 	}
 	return ntfs_readwrite_attr(ino, attr, offset, buf);
@@ -808,8 +808,8 @@
 	buf->do_read = 0;
 	attr = ntfs_find_attr(ino, type, name);
 	if (!attr) {
-		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): attr 0x%x not found "
-				"in inode 0x%x\n", type, ino->i_number);
+		ntfs_debug(DEBUG_FILE3, "%s(): attr 0x%x not found in inode "
+				"0x%x\n", __FUNCTION__, type, ino->i_number);
 		return -EINVAL;
 	}
 	return ntfs_readwrite_attr(ino, attr, offset, buf);
@@ -1332,7 +1332,7 @@
 	int i;
 	ntfs_cluster_t ct;
 
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): rlen = %i.\n", rlen);
+	ntfs_debug(DEBUG_OTHER, "%s(): rlen = %i.\n", __FUNCTION__, rlen);
 	ntfs_debug(DEBUG_OTHER, "VCN        LCN        Run length\n");
 	for (i = 0, ct = 0; i < rlen; ct += rl[i++].len) {
 		if (rl[i].lcn == (ntfs_cluster_t)-1)
@@ -1372,30 +1372,31 @@
 	ntfs_runlist *rl;
 	int rlen, rl_size, rl2_pos;
 
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Entering with *r1len = %i, "
-			"r2len = %i.\n", *r1len, r2len);
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Dumping 1st runlist.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): Entering with *r1len = %i, "
+			"r2len = %i.\n", __FUNCTION__, *r1len, r2len);
+	ntfs_debug(DEBUG_OTHER, "%s(): Dumping 1st runlist.\n", __FUNCTION__);
 	if (*rl1)
 		dump_runlist(*rl1, *r1len);
 	else
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Not present.\n");
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Dumping 2nd runlist.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Not present.\n", __FUNCTION__);
+	ntfs_debug(DEBUG_OTHER, "%s(): Dumping 2nd runlist.\n", __FUNCTION__);
 	dump_runlist(rl2, r2len);
 	rlen = *r1len + r2len + 1;
 	rl_size = (rlen * sizeof(ntfs_runlist) + PAGE_SIZE - 1) &
 			PAGE_MASK;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): rlen = %i, rl_size = %i.\n",
-			rlen, rl_size);
+	ntfs_debug(DEBUG_OTHER, "%s(): rlen = %i, rl_size = %i.\n",
+			__FUNCTION__, rlen, rl_size);
 	/* Do we have enough space? */
 	if (rl_size <= ((*r1len * sizeof(ntfs_runlist) + PAGE_SIZE - 1) &
 			PAGE_MASK)) {
 		/* Have enough space already. */
 		rl = *rl1;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Have enough space "
-				"already.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Have enough space already.\n",
+				__FUNCTION__);
 	} else {
 		/* Need more space. Reallocate. */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Need more space.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Need more space.\n",
+				__FUNCTION__);
 		rl = ntfs_vmalloc(rlen << sizeof(ntfs_runlist));
 		if (!rl)
 			return -ENOMEM;
@@ -1406,17 +1407,17 @@
 	}
 	/* Reuse rl_size as the current position index into rl. */
 	rl_size = *r1len - 1;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): rl_size = %i.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): rl_size = %i.\n", __FUNCTION__,rl_size);
 	/* Coalesce neighbouring elements, if present. */
 	rl2_pos = 0;
 	if (rl[rl_size].lcn + rl[rl_size].len == rl2[rl2_pos].lcn) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Coalescing adjacent "
-				"runs.\n");
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Before: "
-				"rl[rl_size].len = %i.\n", rl[rl_size].len);
+		ntfs_debug(DEBUG_OTHER, "%s(): Coalescing adjacent runs.\n",
+				__FUNCTION__);
+		ntfs_debug(DEBUG_OTHER, "%s(): Before: rl[rl_size].len = %i.\n",
+				__FUNCTION__, rl[rl_size].len);
 		rl[rl_size].len += rl2[rl2_pos].len;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After: "
-				"rl[rl_size].len = %i.\n", rl[rl_size].len);
+		ntfs_debug(DEBUG_OTHER, "%s(): After: rl[rl_size].len = %i.\n",
+				__FUNCTION__, rl[rl_size].len);
 		rl2_pos++;
 		r2len--;
 		rlen--;
@@ -1428,10 +1429,11 @@
 	rl[rlen].lcn = (ntfs_cluster_t)-1;
 	rl[rlen].len = (ntfs_cluster_t)0;
 	*r1len = rlen;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Dumping result runlist.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): Dumping result runlist.\n",
+			__FUNCTION__);
 	dump_runlist(*rl1, *r1len);
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Returning with *r1len = "
-			"%i.\n", rlen);
+	ntfs_debug(DEBUG_OTHER, "%s(): Returning with *r1len = %i.\n",
+			__FUNCTION__, rlen);
 	return 0;
 }
 
@@ -1546,7 +1548,7 @@
 	/* Determine the number of allocated mft records in the mft. */
 	pass_end = nr_mft_records = data->allocated >>
 			vol->mft_record_size_bits;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): nr_mft_records = %lu.\n",
+	ntfs_debug(DEBUG_OTHER, "%s(): nr_mft_records = %lu.\n", __FUNCTION__,
 			nr_mft_records);
 	/* Make sure we don't overflow the bitmap. */
 	l = bmp->initialized << 3;
@@ -1565,9 +1567,10 @@
 	lcn = rl[rlen].lcn + rl[rlen].len;
 	io.fn_put = ntfs_put;
 	io.fn_get = ntfs_get;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Starting bitmap search.\n");
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): pass = %i, pass_start = %lu, "
-			"pass_end = %lu.\n", pass, pass_start, pass_end);
+	ntfs_debug(DEBUG_OTHER, "%s(): Starting bitmap search.\n",
+			__FUNCTION__);
+	ntfs_debug(DEBUG_OTHER, "%s(): pass = %i, pass_start = %lu, pass_end = "
+			"%lu.\n", __FUNCTION__, pass, pass_start, pass_end);
 	byte = NULL; // FIXME: For debugging only.
 	/* Loop until a free mft record is found. */
 	io.size = (nr_mft_records >> 3) & ~PAGE_MASK;
@@ -1575,29 +1578,29 @@
 		io.param = buf;
 		io.do_read = 1;
 		last_read_pos = buf_pos >> 3;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Before: "
-				"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-				"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+		ntfs_debug(DEBUG_OTHER, "%s(): Before: bmp->allocated = 0x%Lx, "
+				"bmp->size = 0x%Lx, bmp->initialized = "
+				"0x%Lx.\n", __FUNCTION__, bmp->allocated,
 				bmp->size, bmp->initialized);
 		err = ntfs_readwrite_attr(vol->mft_ino, bmp, last_read_pos,
 				&io);
 		if (err)
 			goto err_ret;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Read %lu bytes.\n",
+		ntfs_debug(DEBUG_OTHER, "%s(): Read %lu bytes.\n", __FUNCTION__,
 				(unsigned long)io.size);
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After: "
-				"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-				"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+		ntfs_debug(DEBUG_OTHER, "%s(): After: bmp->allocated = 0x%Lx, "
+				"bmp->size = 0x%Lx, bmp->initialized = "
+				"0x%Lx.\n", __FUNCTION__, bmp->allocated,
 				bmp->size, bmp->initialized);
 		if (!io.size)
 			goto pass_done;
 		buf_size = io.size << 3;
 		bit = buf_pos & 7UL;
 		buf_pos &= ~7UL;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Before loop: "
-				"buf_size = %lu, buf_pos = %lu, bit = %lu, "
-				"*byte = 0x%x, b = %u.\n",
-				buf_size, buf_pos, bit, byte ? *byte : -1, b);
+		ntfs_debug(DEBUG_OTHER, "%s(): Before loop: buf_size = %lu, "
+				"buf_pos = %lu, bit = %lu, *byte = 0x%x, b = "
+				"%u.\n", __FUNCTION__, buf_size, buf_pos, bit,
+				byte ? *byte : -1, b);
 		for (; bit < buf_size && bit + buf_pos < pass_end;
 				bit &= ~7UL, bit += 8UL) {
 			byte = buf + (bit >> 3);
@@ -1606,34 +1609,35 @@
 			b = ffz((unsigned long)*byte);
 			if (b < (__u8)8 && b >= (bit & 7UL)) {
 				bit = b + (bit & ~7UL) + buf_pos;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Found free rec in for loop. "
-						"bit = %lu\n", bit);
+				ntfs_debug(DEBUG_OTHER, "%s(): Found free rec "
+						"in for loop. bit = %lu\n",
+						__FUNCTION__, bit);
 				goto found_free_rec;
 			}
 		}
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After loop: "
-				"buf_size = %lu, buf_pos = %lu, bit = %lu, "
-				"*byte = 0x%x, b = %u.\n",
-				buf_size, buf_pos, bit, byte ? *byte : -1, b);
+		ntfs_debug(DEBUG_OTHER, "%s(): After loop: buf_size = %lu, "
+				"buf_pos = %lu, bit = %lu, *byte = 0x%x, b = "
+				"%u.\n", __FUNCTION__, buf_size, buf_pos, bit,
+				byte ? *byte : -1, b);
 		buf_pos += buf_size;
 		if (buf_pos < pass_end)
 			continue;
 pass_done:	/* Finished with the current pass. */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At pass_done.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): At pass_done.\n", __FUNCTION__);
 		if (pass == 1) {
 			/*
 			 * Now do pass 2, scanning the first part of the zone
 			 * we omitted in pass 1.
 			 */
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Done pass "
-					"1.\n");
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Pass = 2.\n");
+			ntfs_debug(DEBUG_OTHER, "%s(): Done pass 1.\n",
+					__FUNCTION__);
+			ntfs_debug(DEBUG_OTHER, "%s(): Pass = 2.\n",
+					__FUNCTION__);
 			pass = 2;
 			pass_end = pass_start;
 			buf_pos = pass_start = 24UL;
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): pass = %i, "
-					"pass_start = %lu, pass_end = %lu.\n",
+			ntfs_debug(DEBUG_OTHER, "%s(): pass = %i, pass_start = "
+					"%lu, pass_end = %lu.\n", __FUNCTION__,
 					pass, pass_start, pass_end);
 			continue;
 		} /* pass == 2 */
@@ -1649,21 +1653,21 @@
 			bit = nr_mft_records;
 			if (bit < 24UL)
 				bit = 24UL;
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Found free "
-					"record bit (#1) = 0x%lx.\n", bit);
+			ntfs_debug(DEBUG_OTHER, "%s(): Found free record bit "
+					"(#1) = 0x%lx.\n", __FUNCTION__, bit);
 			goto found_free_rec;
 		}
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Done pass 2.\n");
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Before: "
-				"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-				"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+		ntfs_debug(DEBUG_OTHER, "%s(): Done pass 2.\n", __FUNCTION__);
+		ntfs_debug(DEBUG_OTHER, "%s(): Before: bmp->allocated = 0x%Lx, "
+				"bmp->size = 0x%Lx, bmp->initialized = "
+				"0x%Lx.\n", __FUNCTION__, bmp->allocated,
 				bmp->size, bmp->initialized);
 		/* Need to extend the mft bitmap. */
 		if (bmp->initialized + 8LL > bmp->allocated) {
 			ntfs_io io2;
 
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Initialized "
-					"> allocated.\n");
+			ntfs_debug(DEBUG_OTHER, "%s(): Initialized "
+					"> allocated.\n", __FUNCTION__);
 			/* Need to extend bitmap by one more cluster. */
 			rl = bmp->d.r.runlist;
 			rlen = bmp->d.r.len - 1;
@@ -1677,8 +1681,8 @@
 					&io2);
 			if (err)
 				goto err_ret;
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Read %lu "
-					"bytes.\n", (unsigned long)io2.size);
+			ntfs_debug(DEBUG_OTHER, "%s(): Read %lu bytes.\n",
+					__FUNCTION__, (unsigned long)io2.size);
 			if (io2.size == 1 && b != 0xff) {
 				__u8 tb = 1 << (lcn & (ntfs_cluster_t)7);
 				if (!(b & tb)) {
@@ -1695,9 +1699,10 @@
 					}
 append_mftbmp_simple:			rl[rlen].len++;
 					have_allocated_mftbmp |= 1;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Appending one "
-							"cluster to mftbmp.\n");
+					ntfs_debug(DEBUG_OTHER, "%s(): "
+							"Appending one cluster "
+							"to mftbmp.\n",
+							__FUNCTION__);
 				}
 			}
 			if (!have_allocated_mftbmp) {
@@ -1713,11 +1718,12 @@
 					if (count > 0) {
 rl2_dealloc_err_out:				if (ntfs_deallocate_clusters(
 							vol, rl2, r2len))
-							ntfs_error(__FUNCTION__
-							"(): Cluster "
+							ntfs_error("%s(): "
+							"Cluster "
 							"deallocation in error "
 							"code path failed! You "
-							"should run chkdsk.\n");
+							"should run chkdsk.\n",
+							__FUNCTION__);
 					}
 					ntfs_vfree(rl2);
 					if (!err)
@@ -1752,10 +1758,9 @@
 				rl[rlen].len = count;
 				bmp->d.r.len = ++rlen;
 				have_allocated_mftbmp |= 2;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Adding run to mftbmp. "
-						"LCN = %i, len = %i\n", lcn,
-						count);
+				ntfs_debug(DEBUG_OTHER, "%s(): Adding run to "
+						"mftbmp. LCN = %i, len = %i\n",
+						__FUNCTION__, lcn, count);
 			}
 			/*
 			 * We now have extended the mft bitmap allocated size
@@ -1763,24 +1768,24 @@
 			 */
 			bmp->allocated += (__s64)vol->cluster_size;
 		}
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After: "
-				"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-				"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+		ntfs_debug(DEBUG_OTHER, "%s(): After: bmp->allocated = 0x%Lx, "
+				"bmp->size = 0x%Lx, bmp->initialized = "
+				"0x%Lx.\n", __FUNCTION__, bmp->allocated,
 				bmp->size, bmp->initialized);
 		/* We now have sufficient allocated space. */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Now have sufficient "
-				"allocated space in mftbmp.\n");
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Before: "
-				"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-				"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+		ntfs_debug(DEBUG_OTHER, "%s(): Now have sufficient allocated "
+				"space in mftbmp.\n", __FUNCTION__);
+		ntfs_debug(DEBUG_OTHER, "%s(): Before: bmp->allocated = 0x%Lx, "
+				"bmp->size = 0x%Lx, bmp->initialized = "
+				"0x%Lx.\n", __FUNCTION__, bmp->allocated,
 				bmp->size, bmp->initialized);
 		buf_pos = bmp->initialized;
 		bmp->initialized += 8LL;
 		if (bmp->initialized > bmp->size)
 			bmp->size = bmp->initialized;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After: "
-				"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-				"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+		ntfs_debug(DEBUG_OTHER, "%s(): After: bmp->allocated = 0x%Lx, "
+				"bmp->size = 0x%Lx, bmp->initialized = "
+				"0x%Lx.\n", __FUNCTION__, bmp->allocated,
 				bmp->size, bmp->initialized);
 		have_allocated_mftbmp |= 4;
 		/* Update the mft bitmap attribute value. */
@@ -1794,27 +1799,27 @@
 				err = -EIO;
 			goto shrink_mftbmp_err_ret;
 		}
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Wrote extended "
-				"mftbmp bytes %lu.\n", (unsigned long)io.size);
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After write: "
-				"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-				"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+		ntfs_debug(DEBUG_OTHER, "%s(): Wrote extended mftbmp bytes "
+				"%lu.\n", __FUNCTION__, (unsigned long)io.size);
+		ntfs_debug(DEBUG_OTHER, "%s(): After write: bmp->allocated = "
+				"0x%Lx, bmp->size = 0x%Lx, bmp->initialized = "
+				"0x%Lx.\n", __FUNCTION__, bmp->allocated,
 				bmp->size, bmp->initialized);
 		bit = buf_pos << 3;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Found free record "
-				"bit (#2) = 0x%lx.\n", bit);
+		ntfs_debug(DEBUG_OTHER, "%s(): Found free record bit (#2) = "
+				"0x%lx.\n", __FUNCTION__, bit);
 		goto found_free_rec;
 	}
 found_free_rec:
 	/* bit is the found free mft record. Allocate it in the mft bitmap. */
 	vol->mft_data_pos = bit;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At found_free_rec.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At found_free_rec.\n", __FUNCTION__);
 	io.param = buf;
 	io.size = 1;
 	io.do_read = 1;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Before update: "
-			"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-			"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+	ntfs_debug(DEBUG_OTHER, "%s(): Before update: bmp->allocated = 0x%Lx, "
+			"bmp->size = 0x%Lx, bmp->initialized = 0x%Lx.\n",
+			__FUNCTION__, bmp->allocated,
 			bmp->size, bmp->initialized);
 	err = ntfs_readwrite_attr(vol->mft_ino, bmp, bit >> 3, &io);
 	if (err || io.size != 1) {
@@ -1822,7 +1827,7 @@
 			err = -EIO;
 		goto shrink_mftbmp_err_ret;
 	}
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Read %lu bytes.\n",
+	ntfs_debug(DEBUG_OTHER, "%s(): Read %lu bytes.\n", __FUNCTION__,
 			(unsigned long)io.size);
 #ifdef DEBUG
 	/* Check our bit is really zero! */
@@ -1838,22 +1843,22 @@
 			err = -EIO;
 		goto shrink_mftbmp_err_ret;
 	}
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Wrote %lu bytes.\n",
+	ntfs_debug(DEBUG_OTHER, "%s(): Wrote %lu bytes.\n", __FUNCTION__,
 			(unsigned long)io.size);
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After update: "
-			"bmp->allocated = 0x%Lx, bmp->size = 0x%Lx, "
-			"bmp->initialized = 0x%Lx.\n", bmp->allocated,
+	ntfs_debug(DEBUG_OTHER, "%s(): After update: bmp->allocated = 0x%Lx, "
+			"bmp->size = 0x%Lx, bmp->initialized = 0x%Lx.\n",
+			__FUNCTION__, bmp->allocated,
 			bmp->size, bmp->initialized);
 	/* The mft bitmap is now uptodate. Deal with mft data attribute now. */
 	ll = (__s64)(bit + 1) << vol->mft_record_size_bits;
 	if (ll <= data->initialized) {
 		/* The allocated record is already initialized. We are done! */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Allocated mft record "
-				"already initialized!\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Allocated mft record "
+				"already initialized!\n", __FUNCTION__);
 		goto done_ret;
 	}
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Allocated mft record needs "
-			"to be initialized.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): Allocated mft record needs "
+			"to be initialized.\n", __FUNCTION__);
 	/* The mft record is outside the initialized data. */
 	mft_rec_size = (unsigned long)vol->mft_record_size;
 	/* Preserve old values for undo purposes. */
@@ -1868,32 +1873,31 @@
 	while (ll > data->allocated) {
 		ntfs_cluster_t lcn2, nr_lcn2, nr, min_nr;
 
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Extending mft "
-				"data allocation, data->allocated = 0x%Lx, "
-				"data->size = 0x%Lx, data->initialized = "
-				"0x%Lx.\n", data->allocated, data->size,
-				data->initialized);
+		ntfs_debug(DEBUG_OTHER, "%s(): Extending mft data allocation, "
+				"data->allocated = 0x%Lx, data->size = 0x%Lx, "
+				"data->initialized = 0x%Lx.\n", __FUNCTION__,
+				data->allocated, data->size, data->initialized);
 		/* Minimum allocation is one mft record worth of clusters. */
 		if (mft_rec_size <= vol->cluster_size)
 			min_nr = (ntfs_cluster_t)1;
 		else
 			min_nr = mft_rec_size >> vol->cluster_size_bits;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): min_nr = %i.\n",
+		ntfs_debug(DEBUG_OTHER, "%s(): min_nr = %i.\n", __FUNCTION__,
 				min_nr);
 		/* Allocate 16 mft records worth of clusters. */
 		nr = mft_rec_size << 4 >> vol->cluster_size_bits;
 		if (!nr)
 			nr = (ntfs_cluster_t)1;
 		/* Determine the preferred allocation location. */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): nr = %i.\n", nr);
+		ntfs_debug(DEBUG_OTHER, "%s(): nr = %i.\n", __FUNCTION__, nr);
 		rl2 = data->d.r.runlist;
 		r2len = data->d.r.len;
 		lcn2 = rl2[r2len - 1].lcn + rl2[r2len - 1].len;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): rl2[r2len - 1].lcn "
-				"= %i, .len = %i.\n", rl2[r2len - 1].lcn,
+		ntfs_debug(DEBUG_OTHER, "%s(): rl2[r2len - 1].lcn = %i, .len = "
+				"%i.\n", __FUNCTION__, rl2[r2len - 1].lcn,
 				rl2[r2len - 1].len);
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): lcn2 = %i, r2len = "
-				"%i.\n", lcn2, r2len);
+		ntfs_debug(DEBUG_OTHER, "%s(): lcn2 = %i, r2len = %i.\n",
+				__FUNCTION__, lcn2, r2len);
 retry_mft_data_allocation:
 		nr_lcn2 = nr;
 		err = ntfs_allocate_clusters(vol, &lcn2, &nr_lcn2, &rl2,
@@ -1913,36 +1917,34 @@
 			if (err == -ENOSPC && nr > min_nr &&
 					nr_lcn2 >= min_nr) {
 				nr = min_nr;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Retrying mft data "
-						"allocation, nr = min_nr = %i"
-						".\n", nr);
+				ntfs_debug(DEBUG_OTHER, "%s(): Retrying mft "
+						"data allocation, nr = min_nr "
+						"= %i.\n", __FUNCTION__, nr);
 				goto retry_mft_data_allocation;
 			}
 			goto undo_mftbmp_alloc_err_ret;
 		}
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Allocated %i "
-				"clusters starting at LCN %i.\n", nr_lcn2,
-				lcn2);
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Allocated "
-				"runlist:\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Allocated %i clusters starting "
+				"at LCN %i.\n", __FUNCTION__, nr_lcn2, lcn2);
+		ntfs_debug(DEBUG_OTHER, "%s(): Allocated runlist:\n",
+				__FUNCTION__);
 		dump_runlist(rl2, r2len);
 		/* Append rl2 to the mft data attribute's run list. */
 		err = splice_runlists(&data->d.r.runlist, (int*)&data->d.r.len,
 				rl2, r2len);
 		if (err) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-					"splice_runlists failed with error "
-					"code %i.\n", -err);
+			ntfs_debug(DEBUG_OTHER, "%s(): splice_runlists failed "
+					"with error code %i.\n", __FUNCTION__,
+					-err);
 			goto undo_partial_data_alloc_err_ret;
 		}
 		/* Reflect the allocated clusters in the mft allocated data. */
 		data->allocated += nr_lcn2 << vol->cluster_size_bits;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After extending mft "
-				"data allocation, data->allocated = 0x%Lx, "
+		ntfs_debug(DEBUG_OTHER, "%s(): After extending mft data "
+				"allocation, data->allocated = 0x%Lx, "
 				"data->size = 0x%Lx, data->initialized = "
-				"0x%Lx.\n", data->allocated, data->size,
-				data->initialized);
+				"0x%Lx.\n", __FUNCTION__, data->allocated,
+				data->size, data->initialized);
 	}
 	/* Prepare a formatted (empty) mft record. */
 	memset(buf, 0, mft_rec_size);
@@ -1959,8 +1961,8 @@
 	old_data_initialized = data->initialized;
 	old_data_size = data->size;
 	while (ll > data->initialized) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Initializing mft "
-				"record 0x%Lx.\n",
+		ntfs_debug(DEBUG_OTHER, "%s(): Initializing mft record "
+				"0x%Lx.\n", __FUNCTION__, 
 				data->initialized >> vol->mft_record_size_bits);
 		io.param = buf;
 		io.size = mft_rec_size;
@@ -1972,15 +1974,15 @@
 				err = -EIO;
 			goto undo_data_init_err_ret;
 		}
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Wrote %i bytes to "
-				"mft data.\n", io.size);
+		ntfs_debug(DEBUG_OTHER, "%s(): Wrote %i bytes to mft data.\n",
+				__FUNCTION__, io.size);
 	}
 	/* Update the VFS inode size as well. */
 	VFS_I(vol->mft_ino)->i_size = data->size;
 #ifdef DEBUG
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After mft record "
+	ntfs_debug(DEBUG_OTHER, "%s(): After mft record "
 			"initialization: data->allocated = 0x%Lx, data->size "
-			"= 0x%Lx, data->initialized = 0x%Lx.\n",
+			"= 0x%Lx, data->initialized = 0x%Lx.\n", __FUNCTION__,
 			data->allocated, data->size, data->initialized);
 	/* Sanity checks. */
 	if (data->size > data->allocated || data->size < data->initialized ||
@@ -1989,45 +1991,47 @@
 #endif
 done_ret:
 	/* Return the number of the allocated mft record. */
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At done_ret. *result = bit = "
-			"0x%lx.\n", bit);
+	ntfs_debug(DEBUG_OTHER, "%s(): At done_ret. *result = bit = 0x%lx.\n",
+			__FUNCTION__, bit);
 	*result = bit;
 	vol->mft_data_pos = bit + 1;
 err_ret:
 	unlock_kernel();
 	free_page((unsigned long)buf);
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Syncing inode $MFT.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): Syncing inode $MFT.\n", __FUNCTION__);
 	if (ntfs_update_inode(vol->mft_ino))
-		ntfs_error(__FUNCTION__ "(): Failed to sync inode $MFT. "
-				"Continuing anyway.\n");
+		ntfs_error("%s(): Failed to sync inode $MFT. "
+				"Continuing anyway.\n",__FUNCTION__);
 	if (!err) {
-		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): Done. Allocated mft "
-				"record number *result = 0x%lx.\n", *result);
+		ntfs_debug(DEBUG_FILE3, "%s(): Done. Allocated mft record "
+				"number *result = 0x%lx.\n", __FUNCTION__,
+				*result);
 		return 0;
 	}
 	if (err != -ENOSPC)
-		ntfs_error(__FUNCTION__ "(): Failed to allocate an mft "
-				"record. Returning error code %i.\n", -err);
+		ntfs_error("%s(): Failed to allocate an mft record. Returning "
+				"error code %i.\n", __FUNCTION__, -err);
 	else
-		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): Failed to allocate "
-				"an mft record due to lack of free space.\n");
+		ntfs_debug(DEBUG_FILE3, "%s(): Failed to allocate an mft "
+				"record due to lack of free space.\n",
+				__FUNCTION__);
 	return err;
 undo_data_init_err_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At "
-			"undo_data_init_err_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At undo_data_init_err_ret.\n",
+			__FUNCTION__);
 	data->initialized = old_data_initialized;
 	data->size = old_data_size;
 undo_data_alloc_err_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At undo_data_alloc_err_ret."
-			"\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At undo_data_alloc_err_ret.\n",
+			__FUNCTION__);
 	data->allocated = old_data_allocated;
 undo_partial_data_alloc_err_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At "
-			"undo_partial_data_alloc_err_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At undo_partial_data_alloc_err_ret.\n",
+			__FUNCTION__);
 	/* Deallocate the clusters. */
 	if (ntfs_deallocate_clusters(vol, rl2, r2len))
-		ntfs_error(__FUNCTION__ "(): Error deallocating clusters in "
-				"error code path. You should run chkdsk.\n");
+		ntfs_error("%s(): Error deallocating clusters in error code "
+			"path. You should run chkdsk.\n", __FUNCTION__);
 	ntfs_vfree(rl2);
 	/* Revert the run list back to what it was before. */
 	r2len = data->d.r.len;
@@ -2047,13 +2051,13 @@
 			ntfs_vfree(data->d.r.runlist);
 			data->d.r.runlist = rl2;
 		} else
-			ntfs_error(__FUNCTION__ "(): Error reallocating "
+			ntfs_error("%s(): Error reallocating "
 					"memory in error code path. This "
-					"should be harmless.\n");
+					"should be harmless.\n", __FUNCTION__);
 	}	
 undo_mftbmp_alloc_err_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At "
-			"undo_mftbmp_alloc_err_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At undo_mftbmp_alloc_err_ret.\n",
+			__FUNCTION__);
 	/* Deallocate the allocated bit in the mft bitmap. */
 	io.param = buf;
 	io.size = 1;
@@ -2068,13 +2072,14 @@
 	if (err || io.size != 1) {
 		if (!err)
 			err = -EIO;
-		ntfs_error(__FUNCTION__ "(): Error deallocating mft record in "
-				"error code path. You should run chkdsk.\n");
+		ntfs_error("%s(): Error deallocating mft record in error code "
+			"path. You should run chkdsk.\n", __FUNCTION__);
 	}
 shrink_mftbmp_err_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At shrink_mftbmp_err_ret.\n");
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): have_allocated_mftbmp = "
-			"%i.\n", have_allocated_mftbmp);
+	ntfs_debug(DEBUG_OTHER, "%s(): At shrink_mftbmp_err_ret.\n",
+			__FUNCTION__);
+	ntfs_debug(DEBUG_OTHER, "%s(): have_allocated_mftbmp = %i.\n",
+			__FUNCTION__, have_allocated_mftbmp);
 	if (!have_allocated_mftbmp)
 		goto err_ret;
 	/* Shrink the mftbmp back to previous size. */
@@ -2083,15 +2088,15 @@
 	bmp->initialized -= 8LL;
 	have_allocated_mftbmp &= ~4;
 	/* If no allocation occured then we are done. */
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): have_allocated_mftbmp = "
-			"%i.\n", have_allocated_mftbmp);
+	ntfs_debug(DEBUG_OTHER, "%s(): have_allocated_mftbmp = %i.\n",
+			__FUNCTION__, have_allocated_mftbmp);
 	if (!have_allocated_mftbmp)
 		goto err_ret;
 	/* Deallocate the allocated cluster. */
 	bmp->allocated -= (__s64)vol->cluster_size;
 	if (ntfs_deallocate_cluster_run(vol, lcn, (ntfs_cluster_t)1))
-		ntfs_error(__FUNCTION__ "(): Error deallocating cluster in "
-				"error code path. You should run chkdsk.\n");
+		ntfs_error("%s(): Error deallocating cluster in error code "
+			"path. You should run chkdsk.\n", __FUNCTION__);
 	switch (have_allocated_mftbmp & 3) {
 	case 1:
 		/* Delete the last lcn from the last run of mftbmp. */
@@ -2111,10 +2116,10 @@
 				ntfs_vfree(rl);
 				bmp->d.r.runlist = rl = rlt;
 			} else
-				ntfs_error(__FUNCTION__ "(): Error "
+				ntfs_error("%s(): Error "
 						"reallocating memory in error "
 						"code path. This should be "
-						"harmless.\n");
+						"harmless.\n", __FUNCTION__);
 		}
 		bmp->d.r.runlist[bmp->d.r.len].lcn = (ntfs_cluster_t)-1;
 		bmp->d.r.runlist[bmp->d.r.len].len = (ntfs_cluster_t)0;
@@ -2256,7 +2261,7 @@
 	err = ntfs_alloc_mft_record(vol, &(result->i_number));
 	if (err) {
 		if (err == -ENOSPC)
-			ntfs_error(__FUNCTION__ "(): No free inodes.\n");
+			ntfs_error("%s(): No free inodes.\n", __FUNCTION__);
 		return err;
 	}
 	/* Get the sequence number. */
diff -urN linux-2.4.22-rc4/fs/ntfs/super.c linux-2.4.22-rc4-ntfs/fs/ntfs/super.c
--- linux-2.4.22-rc4/fs/ntfs/super.c	2001-09-08 20:24:40.000000000 +0100
+++ linux-2.4.22-rc4-ntfs/fs/ntfs/super.c	2003-08-25 11:54:54.000000000 +0100
@@ -639,13 +639,13 @@
 	int rlpos = 0, rlsize, buf_size, err = 0;
 	ntfs_io io;
 
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Entering with *location = "
-			"0x%x, *count = 0x%x, zone = %s_ZONE.\n", *location,
-			*count, zone == DATA_ZONE ? "DATA" : "MFT");
+	ntfs_debug(DEBUG_OTHER, "%s(): Entering with *location = 0x%x, "
+			"*count = 0x%x, zone = %s_ZONE.\n", __FUNCTION__,
+			*location, *count, zone == DATA_ZONE ? "DATA" : "MFT");
 	buf = (char*)__get_free_page(GFP_NOFS);
 	if (!buf) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Returning "
-				"-ENOMEM.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Returning -ENOMEM.\n",
+				__FUNCTION__);
 		return -ENOMEM;
 	}
 	io.fn_put = ntfs_put;
@@ -721,101 +721,101 @@
 	clusters = *count;
 	rlpos = rlsize = 0;
 	if (*count <= 0) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): *count <= 0, "
-				"returning -EINVAL.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): *count <= 0, "
+				"returning -EINVAL.\n", __FUNCTION__);
 		err = -EINVAL;
 		goto err_ret;
 	}
 	while (1) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Start of outer while "
+		ntfs_debug(DEBUG_OTHER, "%s(): Start of outer while "
 				"loop: done_zones = 0x%x, search_zone = %i, "
 				"pass = %i, zone_start = 0x%x, zone_end = "
 				"0x%x, initial_location = 0x%x, buf_pos = "
 				"0x%x, rlpos = %i, rlsize = %i.\n",
-				done_zones, search_zone, pass, zone_start,
-				zone_end, initial_location, buf_pos, rlpos,
-				rlsize);
+				__FUNCTION__, done_zones, search_zone, pass,
+				zone_start, zone_end, initial_location, buf_pos,
+				rlpos, rlsize);
 		/* Loop until we run out of free clusters. */
 		io.param = buf;
 		io.size = PAGE_SIZE;
 		io.do_read = 1;
 		last_read_pos = buf_pos >> 3;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): last_read_pos = "
-				"0x%x.\n", last_read_pos);
+		ntfs_debug(DEBUG_OTHER, "%s(): last_read_pos = 0x%x.\n",
+				__FUNCTION__, last_read_pos);
 		err = ntfs_readwrite_attr(vol->bitmap, data, last_read_pos,
 				&io);
 		if (err) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-					"ntfs_read_attr failed with error "
-					"code %i, going to err_ret.\n", -err);
+			ntfs_debug(DEBUG_OTHER, "%s(): ntfs_read_attr failed "
+					"with error code %i, going to "
+					"err_ret.\n", __FUNCTION__, -err);
 			goto err_ret;
 		}
 		if (!io.size) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): !io.size, "
-					"going to zone_pass_done.\n");
+			ntfs_debug(DEBUG_OTHER, "%s(): !io.size, going to "
+					"zone_pass_done.\n", __FUNCTION__);
 			goto zone_pass_done;
 		}
 		buf_size = io.size << 3;
 		lcn = buf_pos & 7;
 		buf_pos &= ~7;
 		need_writeback = 0;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Before inner while "
+		ntfs_debug(DEBUG_OTHER, "%s(): Before inner while "
 				"loop: buf_size = 0x%x, lcn = 0x%x, buf_pos = "
-				"0x%x, need_writeback = %i.\n", buf_size, lcn,
-				buf_pos, need_writeback);
+				"0x%x, need_writeback = %i.\n", __FUNCTION__,
+				buf_size, lcn, buf_pos, need_writeback);
 		while (lcn < buf_size && lcn + buf_pos < zone_end) {
 			byte = buf + (lcn >> 3);
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): In inner "
-					"while loop: buf_size = 0x%x, lcn = "
-					"0x%x, buf_pos = 0x%x, need_writeback "
-					"= %i, byte ofs = 0x%x, *byte = "
-					"0x%x.\n", buf_size, lcn, buf_pos,
-					need_writeback, lcn >> 3, *byte);
+			ntfs_debug(DEBUG_OTHER, "%s(): In inner while loop: "
+					"buf_size = 0x%x, lcn = 0x%x, buf_pos "
+					"= 0x%x, need_writeback = %i, byte ofs "
+					"= 0x%x, *byte = 0x%x.\n", __FUNCTION__,
+					buf_size, lcn, buf_pos,	need_writeback,
+					lcn >> 3, *byte);
 			/* Skip full bytes. */
 			if (*byte == 0xff) {
 				lcn += 8;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"continuing while loop 1.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): continuing while"
+					    " loop 1.\n", __FUNCTION__);
 				continue;
 			}
 			bit = 1 << (lcn & 7);
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): bit = %i.\n",
-					bit);
+			ntfs_debug(DEBUG_OTHER, "%s(): bit = %i.\n",
+					__FUNCTION__, bit);
 			/* If the bit is already set, go onto the next one. */
 			if (*byte & bit) {
 				lcn++;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"continuing while loop 2.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): continuing while"
+					    " loop 2.\n", __FUNCTION__);
 				continue;
 			}
 			/* Allocate the bitmap bit. */
 			*byte |= bit;
 			/* We need to write this bitmap buffer back to disk! */
 			need_writeback = 1;
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): *byte = "
-					"0x%x, need_writeback = %i.\n", *byte,
-					need_writeback);
+			ntfs_debug(DEBUG_OTHER, "%s(): *byte = 0x%x, "
+					"need_writeback = %i.\n", __FUNCTION__,
+					*byte, need_writeback);
 			/* Reallocate memory if necessary. */
 			if ((rlpos + 2) * sizeof(ntfs_runlist) >= rlsize) {
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Reallocating space.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): Reallocating "
+						"space.\n", __FUNCTION__);
 				/* Setup first free bit return value. */
 				if (!rl2) {
 					*location = lcn + buf_pos;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): *location = "
-							"0x%x.\n", *location);
+					ntfs_debug(DEBUG_OTHER,	"%s(): "
+							"*location = 0x%x.\n",
+							__FUNCTION__,
+							*location);
 				}
 				rlsize += PAGE_SIZE;
 				rlt = ntfs_vmalloc(rlsize);
 				if (!rlt) {
 					err = -ENOMEM;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Failed to "
-							"allocate memory, "
+					ntfs_debug(DEBUG_OTHER, "%s(): Failed "
+							"to allocate memory, "
 							"returning -ENOMEM, "
-							"going to "
-							"wb_err_ret.\n");
+							"going to wb_err_ret.\n",
+							__FUNCTION__);
 					goto wb_err_ret;
 				}
 				if (rl2) {
@@ -824,45 +824,46 @@
 					ntfs_vfree(rl2);
 				}
 				rl2 = rlt;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Reallocated memory, rlsize = "
-						"0x%x.\n", rlsize);
+				ntfs_debug(DEBUG_OTHER, "%s(): Reallocated "
+						"memory, rlsize = 0x%x.\n",
+						__FUNCTION__, rlsize);
 			}
 			/*
 			 * Coalesce with previous run if adjacent LCNs.
 			 * Otherwise, append a new run.
 			 */
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Adding run "
-					"(lcn 0x%x, len 0x%x), prev_lcn = "
-					"0x%x, lcn = 0x%x, buf_pos = 0x%x, "
-					"prev_run_len = 0x%x, rlpos = %i.\n",
+			ntfs_debug(DEBUG_OTHER, "%s(): Adding run (lcn 0x%x, "
+					"len 0x%x), prev_lcn = 0x%x, lcn = "
+					"0x%x, buf_pos = 0x%x, prev_run_len = "
+					"0x%x, rlpos = %i.\n", __FUNCTION__,
 					lcn + buf_pos, 1, prev_lcn, lcn,
 					buf_pos, prev_run_len, rlpos);
 			if (prev_lcn == lcn + buf_pos - prev_run_len && rlpos) {
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Coalescing to run (lcn 0x%x, "
-						"len 0x%x).\n",
+				ntfs_debug(DEBUG_OTHER, "%s(): Coalescing to "
+						"run (lcn 0x%x, len 0x%x).\n",
+						__FUNCTION__,
 						rl2[rlpos - 1].lcn,
 						rl2[rlpos - 1].len);
 				rl2[rlpos - 1].len = ++prev_run_len;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Run now (lcn 0x%x, len 0x%x), "
-						"prev_run_len = 0x%x.\n",
+				ntfs_debug(DEBUG_OTHER, "%s(): Run now (lcn "
+						"0x%x, len 0x%x), prev_run_len "
+						"= 0x%x.\n", __FUNCTION__,
 						rl2[rlpos - 1].lcn,
 						rl2[rlpos - 1].len,
 						prev_run_len);
 			} else {
 				if (rlpos)
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Adding new run, "
-							"(previous run lcn "
-							"0x%x, len 0x%x).\n",
+					ntfs_debug(DEBUG_OTHER, "%s(): Adding "
+							"new run, (previous "
+							"run lcn 0x%x, "
+							"len 0x%x).\n",
+							__FUNCTION__,
 							rl2[rlpos - 1].lcn,
 							rl2[rlpos - 1].len);
 				else
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Adding new run, "
-							"is first run.\n");
+					ntfs_debug(DEBUG_OTHER, "%s(): Adding "
+							"new run, is first "
+							"run.\n", __FUNCTION__);
 				rl2[rlpos].lcn = prev_lcn = lcn + buf_pos;
 				rl2[rlpos].len = prev_run_len =
 						(ntfs_cluster_t)1;
@@ -878,17 +879,16 @@
 				 * during the respective zone switches.
 				 */
 				tc = lcn + buf_pos + 1;
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Done. Updating current zone "
-						"position, tc = 0x%x, "
-						"search_zone = %i.\n", tc,
-						search_zone);
+				ntfs_debug(DEBUG_OTHER, "%s(): Done. Updating "
+						"current zone position, tc = "
+						"0x%x, search_zone = %i.\n",
+						__FUNCTION__, tc, search_zone);
 				switch (search_zone) {
 				case 1:
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Before checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): Before checks, "
 							"vol->mft_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->mft_zone_pos);
 					if (tc >= vol->mft_zone_end) {
 						vol->mft_zone_pos =
@@ -901,17 +901,17 @@
 							tc > vol->mft_zone_pos)
 							&& tc >= vol->mft_lcn)
 						vol->mft_zone_pos = tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): After checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): After checks, "
 							"vol->mft_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->mft_zone_pos);
 					break;
 				case 2:
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Before checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): Before checks, "
 							"vol->data1_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data1_zone_pos);
 					if (tc >= vol->nr_clusters)
 						vol->data1_zone_pos =
@@ -921,17 +921,17 @@
 						    tc > vol->data1_zone_pos)
 						    && tc >= vol->mft_zone_end)
 						vol->data1_zone_pos = tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): After checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): After checks, "
 							"vol->data1_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data1_zone_pos);
 					break;
 				case 4:
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Before checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): Before checks, "
 							"vol->data2_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data2_zone_pos);
 					if (tc >= vol->mft_zone_start)
 						vol->data2_zone_pos =
@@ -940,52 +940,52 @@
 						      vol->data2_zone_pos ||
 						      tc > vol->data2_zone_pos)
 						vol->data2_zone_pos = tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): After checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): After checks, "
 							"vol->data2_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data2_zone_pos);
 					break;
 				default:
 					BUG();
 				}
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Going to done_ret.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): Going to "
+						"done_ret.\n", __FUNCTION__);
 				goto done_ret;
 			}
 			lcn++;
 		}
 		buf_pos += buf_size;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After inner while "
+		ntfs_debug(DEBUG_OTHER, "%s(): After inner while "
 				"loop: buf_size = 0x%x, lcn = 0x%x, buf_pos = "
-				"0x%x, need_writeback = %i.\n", buf_size, lcn,
-				buf_pos, need_writeback);
+				"0x%x, need_writeback = %i.\n", __FUNCTION__,
+				buf_size, lcn, buf_pos, need_writeback);
 		if (need_writeback) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Writing "
-					"back.\n");
+			ntfs_debug(DEBUG_OTHER, "%s(): Writing back.\n",
+					__FUNCTION__);
 			need_writeback = 0;
 			io.param = buf;
 			io.do_read = 0;
 			err = ntfs_readwrite_attr(vol->bitmap, data,
 					last_read_pos, &io);
 			if (err) {
-				ntfs_error(__FUNCTION__ "(): Bitmap writeback "
-						"failed in read next buffer "
-						"code path with error code "
-						"%i.\n", -err);
+				ntfs_error("%s(): Bitmap writeback failed "
+						"in read next buffer code "
+						"path with error code %i.\n",
+						__FUNCTION__, -err);
 				goto err_ret;
 			}
 		}
 		if (buf_pos < zone_end) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Continuing "
+			ntfs_debug(DEBUG_OTHER, "%s(): Continuing "
 					"outer while loop, buf_pos = 0x%x, "
-					"zone_end = 0x%x.\n", buf_pos,
-					zone_end);
+					"zone_end = 0x%x.\n", __FUNCTION__,
+					buf_pos, zone_end);
 			continue;
 		}
 zone_pass_done:	/* Finished with the current zone pass. */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At zone_pass_done, "
-				"pass = %i.\n", pass);
+		ntfs_debug(DEBUG_OTHER, "%s(): At zone_pass_done, pass = %i.\n",
+				__FUNCTION__, pass);
 		if (pass == 1) {
 			/*
 			 * Now do pass 2, scanning the first part of the zone
@@ -1010,36 +1010,37 @@
 			if (zone_end < zone_start)
 				zone_end = zone_start;
 			buf_pos = zone_start;
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Continuing "
+			ntfs_debug(DEBUG_OTHER, "%s(): Continuing "
 					"outer while loop, pass = 2, "
 					"zone_start = 0x%x, zone_end = 0x%x, "
-					"buf_pos = 0x%x.\n");
+					"buf_pos = 0x%x.\n", __FUNCTION__,
+					zone_start, zone_end, buf_pos);
 			continue;
 		} /* pass == 2 */
 done_zones_check:
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At done_zones_check, "
+		ntfs_debug(DEBUG_OTHER, "%s(): At done_zones_check, "
 				"search_zone = %i, done_zones before = 0x%x, "
-				"done_zones after = 0x%x.\n",
+				"done_zones after = 0x%x.\n", __FUNCTION__,
 				search_zone, done_zones, done_zones |
 				search_zone);
 		done_zones |= search_zone;
 		if (done_zones < 7) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Switching "
-					"zone.\n");
+			ntfs_debug(DEBUG_OTHER, "%s(): Switching zone.\n",
+					__FUNCTION__);
 			/* Now switch to the next zone we haven't done yet. */
 			pass = 1;
 			switch (search_zone) {
 			case 1:
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Switching from mft zone to "
-						"data1 zone.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): Switching from "
+						"mft zone to data1 zone.\n",
+						__FUNCTION__);
 				/* Update mft zone position. */
 				if (rlpos) {
 					ntfs_cluster_t tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Before checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): Before checks, "
 							"vol->mft_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->mft_zone_pos);
 					tc = rl2[rlpos - 1].lcn +
 							rl2[rlpos - 1].len;
@@ -1054,10 +1055,10 @@
 							tc > vol->mft_zone_pos)
 							&& tc >= vol->mft_lcn)
 						vol->mft_zone_pos = tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): After checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): After checks, "
 							"vol->mft_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->mft_zone_pos);
 				}
 				/* Switch from mft zone to data1 zone. */
@@ -1074,16 +1075,16 @@
 				}
 				break;
 			case 2:
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Switching from data1 zone to "
-						"data2 zone.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): Switching from "
+						"data1 zone to data2 zone.\n",
+						__FUNCTION__);
 				/* Update data1 zone position. */
 				if (rlpos) {
 					ntfs_cluster_t tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Before checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): Before checks, "
 							"vol->data1_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data1_zone_pos);
 					tc = rl2[rlpos - 1].lcn +
 							rl2[rlpos - 1].len;
@@ -1095,10 +1096,10 @@
 						    tc > vol->data1_zone_pos)
 						    && tc >= vol->mft_zone_end)
 						vol->data1_zone_pos = tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): After checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): After checks, "
 							"vol->data1_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data1_zone_pos);
 				}
 				/* Switch from data1 zone to data2 zone. */
@@ -1116,16 +1117,16 @@
 				}
 				break;
 			case 4:
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Switching from data2 zone to "
-						"data1 zone.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): Switching from "
+						"data2 zone to data1 zone.\n",
+						__FUNCTION__);
 				/* Update data2 zone position. */
 				if (rlpos) {
 					ntfs_cluster_t tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): Before checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): Before checks, "
 							"vol->data2_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data2_zone_pos);
 					tc = rl2[rlpos - 1].lcn +
 							rl2[rlpos - 1].len;
@@ -1136,10 +1137,10 @@
 						      vol->data2_zone_pos ||
 						      tc > vol->data2_zone_pos)
 						vol->data2_zone_pos = tc;
-					ntfs_debug(DEBUG_OTHER, __FUNCTION__
-							"(): After checks, "
+					ntfs_debug(DEBUG_OTHER,
+							"%s(): After checks, "
 							"vol->data2_zone_pos = "
-							"0x%x.\n",
+							"0x%x.\n", __FUNCTION__,
 							vol->data2_zone_pos);
 				}
 				/* Switch from data2 zone to data1 zone. */
@@ -1147,45 +1148,45 @@
 			default:
 				BUG();
 			}
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After zone "
-					"switch, search_zone = %i, pass = %i, "
+			ntfs_debug(DEBUG_OTHER, "%s(): After zone switch, "
+					"search_zone = %i, pass = %i, "
 					"initial_location = 0x%x, zone_start "
 					"= 0x%x, zone_end = 0x%x.\n",
-					search_zone, pass, initial_location,
-					zone_start, zone_end);
+					__FUNCTION__, search_zone, pass,
+					initial_location, zone_start, zone_end);
 			buf_pos = zone_start;
 			if (zone_start == zone_end) {
-				ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): "
-						"Empty zone, going to "
-						"done_zones_check.\n");
+				ntfs_debug(DEBUG_OTHER, "%s(): Empty zone, "
+						"going to done_zones_check.\n",
+						__FUNCTION__);
 				/* Empty zone. Don't bother searching it. */
 				goto done_zones_check;
 			}
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Continuing "
-					"outer while loop.\n");
+			ntfs_debug(DEBUG_OTHER, "%s(): Continuing outer while "
+					"loop.\n", __FUNCTION__);
 			continue;
 		} /* done_zones == 7 */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): All zones are "
-				"finished.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): All zones are finished.\n",
+				__FUNCTION__);
 		/*
 		 * All zones are finished! If DATA_ZONE, shrink mft zone. If
 		 * MFT_ZONE, we have really run out of space.
 		 */
 		mft_zone_size = vol->mft_zone_end - vol->mft_zone_start;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): vol->mft_zone_start "
-				"= 0x%x, vol->mft_zone_end = 0x%x, "
-				"mft_zone_size = 0x%x.\n", vol->mft_zone_start,
+		ntfs_debug(DEBUG_OTHER, "%s(): vol->mft_zone_start = 0x%x, "
+				"vol->mft_zone_end = 0x%x, mft_zone_size = "
+				"0x%x.\n", __FUNCTION__, vol->mft_zone_start,
 				vol->mft_zone_end, mft_zone_size);
 		if (zone == MFT_ZONE || mft_zone_size <= (ntfs_cluster_t)0) {
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): No free "
-					"clusters left, returning -ENOSPC, "
-					"going to fail_ret.\n");
+			ntfs_debug(DEBUG_OTHER, "%s(): No free clusters left, "
+					"returning -ENOSPC, going to "
+					"fail_ret.\n", __FUNCTION__);
 			/* Really no more space left on device. */
 			err = -ENOSPC;
 			goto fail_ret;
 		} /* zone == DATA_ZONE && mft_zone_size > 0 */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Shrinking mft "
-				"zone.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Shrinking mft zone.\n",
+				__FUNCTION__);
 		zone_end = vol->mft_zone_end;
 		mft_zone_size >>= 1;
 		if (mft_zone_size > (ntfs_cluster_t)0)
@@ -1203,71 +1204,72 @@
 		search_zone = 2;
 		pass = 2;
 		done_zones &= ~2;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After shrinking mft "
+		ntfs_debug(DEBUG_OTHER, "%s(): After shrinking mft "
 				"zone, mft_zone_size = 0x%x, "
 				"vol->mft_zone_start = 0x%x, vol->mft_zone_end "
 				"= 0x%x, vol->mft_zone_pos = 0x%x, search_zone "
 				"= 2, pass = 2, dones_zones = 0x%x, zone_start "
 				"= 0x%x, zone_end = 0x%x, vol->data1_zone_pos "
 				"= 0x%x, continuing outer while loop.\n",
-				mft_zone_size, vol->mft_zone_start,
-				vol->mft_zone_end, vol->mft_zone_pos,
-				search_zone, pass, done_zones, zone_start,
+				__FUNCTION__, mft_zone_size,
+				vol->mft_zone_start, vol->mft_zone_end,
+				vol->mft_zone_pos, done_zones, zone_start,
 				zone_end, vol->data1_zone_pos);
 	}
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After outer while loop.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): After outer while loop.\n",
+			__FUNCTION__);
 done_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At done_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At done_ret.\n", __FUNCTION__);
 	rl2[rlpos].lcn = (ntfs_cluster_t)-1;
 	rl2[rlpos].len = (ntfs_cluster_t)0;
 	*rl = rl2;
 	*rl_len = rlpos;
 	if (need_writeback) {
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Writing back.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Writing back.\n", __FUNCTION__);
 		need_writeback = 0;
 		io.param = buf;
 		io.do_read = 0;
 		err = ntfs_readwrite_attr(vol->bitmap, data, last_read_pos,
 				&io);
 		if (err) {
-			ntfs_error(__FUNCTION__ "(): Bitmap writeback failed "
-					"in done code path with error code "
-					"%i.\n", -err);
+			ntfs_error("%s(): Bitmap writeback failed in done "
+					"code path with error code %i.\n",
+					__FUNCTION__, -err);
 			goto err_ret;
 		}
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Wrote 0x%Lx bytes.\n",
-				io.size);
+		ntfs_debug(DEBUG_OTHER, "%s(): Wrote 0x%Lx bytes.\n",
+				__FUNCTION__, io.size);
 	}
 done_fail_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At done_fail_ret (follows "
-			"done_ret).\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At done_fail_ret (follows done_ret).\n",
+			 __FUNCTION__);
 	unlock_kernel();
 	free_page((unsigned long)buf);
 	if (err)
-		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): Failed to allocate "
+		ntfs_debug(DEBUG_FILE3, "%s(): Failed to allocate "
 				"clusters. Returning with error code %i.\n",
-				-err);
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Syncing $Bitmap inode.\n");
+				__FUNCTION__, -err);
+	ntfs_debug(DEBUG_OTHER, "%s(): Syncing $Bitmap inode.\n", __FUNCTION__);
 	if (ntfs_update_inode(vol->bitmap))
-		ntfs_error(__FUNCTION__ "(): Failed to sync inode $Bitmap. "
-				"Continuing anyway.\n");
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Returning with code %i.\n",
+		ntfs_error("%s(): Failed to sync inode $Bitmap. "
+				"Continuing anyway.\n", __FUNCTION__);
+	ntfs_debug(DEBUG_OTHER, "%s(): Returning with code %i.\n", __FUNCTION__,
 			err);
 	return err;
 fail_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At fail_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At fail_ret.\n", __FUNCTION__);
 	if (rl2) {
 		if (err == -ENOSPC) {
 			/* Return first free lcn and count of free clusters. */
 			*location = rl2[0].lcn;
 			*count -= clusters;
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): err = "
-					"-ENOSPC, *location = 0x%x, *count = "
-					"0x%x.\n", *location, *count);
+			ntfs_debug(DEBUG_OTHER, "%s(): err = -ENOSPC, "
+					"*location = 0x%x, *count = 0x%x.\n",
+					__FUNCTION__, *location, *count);
 		}
 		/* Deallocate all allocated clusters. */
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Deallocating "
-				"allocated clusters.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Deallocating allocated "
+				"clusters.\n", __FUNCTION__);
 		ntfs_deallocate_clusters(vol, rl2, rlpos);
 		/* Free the runlist. */
 		ntfs_vfree(rl2);
@@ -1276,34 +1278,35 @@
 			/* Nothing free at all. */
 			*location = vol->data1_zone_pos; /* Irrelevant... */
 			*count = 0;
-			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): No space "
-					"left at all, err = -ENOSPC, *location "
-					"= 0x%x, *count = 0.\n", *location);
+			ntfs_debug(DEBUG_OTHER, "%s(): No space left at all, "
+					"err = -ENOSPC, *location = 0x%x, "
+					"*count = 0.\n",
+					__FUNCTION__, *location);
 		}
 	}
 	*rl = NULL;
 	*rl_len = 0;
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): *rl = NULL, *rl_len = 0, "
-			"going to done_fail_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): *rl = NULL, *rl_len = 0, "
+			"going to done_fail_ret.\n", __FUNCTION__);
 	goto done_fail_ret;
 wb_err_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At wb_err_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At wb_err_ret.\n", __FUNCTION__);
 	if (need_writeback) {
 		int __err;
-		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Writing back.\n");
+		ntfs_debug(DEBUG_OTHER, "%s(): Writing back.\n", __FUNCTION__);
 		io.param = buf;
 		io.do_read = 0;
 		__err = ntfs_readwrite_attr(vol->bitmap, data, last_read_pos,
 				&io);
 		if (__err)
-			ntfs_error(__FUNCTION__ "(): Bitmap writeback failed "
-					"in error code path with error code "
-					"%i.\n", -__err);
+			ntfs_error("%s(): Bitmap writeback failed in error "
+					"code path with error code %i.\n",
+					__FUNCTION__, -__err);
 		need_writeback = 0;
 	}
 err_ret:
-	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At err_ret, *location = -1, "
-			"*count = 0, going to fail_ret.\n");
+	ntfs_debug(DEBUG_OTHER, "%s(): At err_ret, *location = -1, "
+			"*count = 0, going to fail_ret.\n", __FUNCTION__);
 	*location = -1;
 	*count = 0;
 	goto fail_ret;



