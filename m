Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272648AbRIKXps>; Tue, 11 Sep 2001 19:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272644AbRIKXpk>; Tue, 11 Sep 2001 19:45:40 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:61342 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S272643AbRIKXp0>; Tue, 11 Sep 2001 19:45:26 -0400
Subject: [PATCH] NTFS fix for bug report
To: torvalds@transmeta.com
Date: Wed, 12 Sep 2001 00:45:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15gxDt-0005ZW-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,

Please apply below patch. It should fix the reported hang on NTFS in Win2k
together with a few more bugs I came across while tracking it down.

Patch is against 2.4.7-pre10 but it should apply cleanly to the latest
-ac. (I haven't tested -ac but NTFS should be identical in both trees at
the moment so it can#t go wrong... <famous last words>)

ChangeLog NTFS 1.1.19
=====================

- Fixed ntfs_getdir_unsorted(), ntfs_readdir() and ntfs_printcb() to cope
with arbitrary cluster sizes. Very important for Win2k+. Also, make them
detect directories which are too large and truncate the enumeration
pretending end of directory was reached. Detect more error conditions and
overflows. All this fixes the problem where the driver could end up in an
infinite loop under certain circumstances.

- Fixed potential memory leaks in Unicode conversion functions and setup
correct NULL return values.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

----- snip: linux-2.4.10-pre7-ntfs-1.1.19.diff -----
diff -u -urN linux-2.4.10-pre7-vanilla/Documentation/filesystems/ntfs.txt linux-2.4.10-pre7-ntfs-1.1.19/Documentation/filesystems/ntfs.txt
--- linux-2.4.10-pre7-vanilla/Documentation/filesystems/ntfs.txt	Tue Sep 11 23:53:42 2001
+++ linux-2.4.10-pre7-ntfs-1.1.19/Documentation/filesystems/ntfs.txt	Tue Sep 11 23:57:59 2001
@@ -98,6 +98,16 @@
 ChangeLog
 =========
 
+NTFS 1.1.19:
+	- Fixed ntfs_getdir_unsorted(), ntfs_readdir() and ntfs_printcb() to
+	  cope with arbitrary cluster sizes. Very important for Win2k+. Also,
+	  make them detect directories which are too large and truncate the
+	  enumeration pretending end of directory was reached. Detect more
+	  error conditions and overflows. All this fixes the problem where the
+	  driver could end up in an infinite loop under certain circumstances.
+	- Fixed potential memory leaks in Unicode conversion functions and
+	  setup correct NULL return values.
+
 NTFS 1.1.18:
 
 	- Enhanced & bug fixed cluster deallocation (race fixes, etc.)
diff -u -urN linux-2.4.10-pre7-vanilla/fs/ntfs/Makefile linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/Makefile
--- linux-2.4.10-pre7-vanilla/fs/ntfs/Makefile	Tue Sep 11 23:53:48 2001
+++ linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/Makefile	Tue Sep 11 22:20:39 2001
@@ -5,7 +5,7 @@
 obj-y   := fs.o sysctl.o support.o util.o inode.o dir.o super.o attr.o unistr.o
 obj-m   := $(O_TARGET)
 # New version format started 3 February 2001.
-EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.18\" #-DDEBUG
+EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.19\" #-DDEBUG
 
 include $(TOPDIR)/Rules.make
 
diff -u -urN linux-2.4.10-pre7-vanilla/fs/ntfs/dir.c linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/dir.c
--- linux-2.4.10-pre7-vanilla/fs/ntfs/dir.c	Tue Sep 11 23:53:48 2001
+++ linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/dir.c	Tue Sep 11 23:27:02 2001
@@ -94,15 +94,15 @@
 #endif
 
 /* True if the entry points to another block of entries. */
-static inline int ntfs_entry_has_subnodes(char* entry)
+static inline int ntfs_entry_has_subnodes(char *entry)
 {
-	return (int)NTFS_GETU8(entry + 12) & 1;
+	return (NTFS_GETU16(entry + 0xc) & 1);
 }
 
 /* True if it is not the 'end of dir' entry. */
-static inline int ntfs_entry_is_used(char* entry)
+static inline int ntfs_entry_is_used(char *entry)
 {
-	return (int)(NTFS_GETU8(entry + 12) & 2) == 0;
+	return !(NTFS_GETU16(entry + 0xc) & 2);
 }
 
 /*
@@ -791,12 +791,14 @@
 int ntfs_getdir_unsorted(ntfs_inode *ino, u32 *p_high, u32 *p_low,
 		int (*cb)(ntfs_u8 *, void *), void *param)
 {
+	s64 ib_ofs;
 	char *buf = 0, *entry = 0;
 	ntfs_attribute *attr;
 	ntfs_volume *vol;
-	int length, block, byte, bit, error = 0;
-	u32 start, finish;
+	int byte, bit, err = 0;
+	u32 start, finish, ibs, max_size;
 	ntfs_io io;
+	u8 ibs_bits;
 
 	if (!ino) {
 		ntfs_error(__FUNCTION__ "(): No inode! Returning -EINVAL.\n");
@@ -804,60 +806,64 @@
 	}
 	vol = ino->vol;
 	if (!vol) {
-		ntfs_error(__FUNCTION__ "(): Inode %lx has no volume. "
+		ntfs_error(__FUNCTION__ "(): Inode 0x%lx has no volume. "
 				"Returning -EINVAL.\n", ino->i_number);
 		return -EINVAL;
 	}
 	ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 1: Entering for "
 			"inode 0x%lx, p_high = 0x%x, p_low = 0x%x.\n",
 			ino->i_number, *p_high, *p_low);
-	if (*p_high == 0) {
+	if (!*p_high) {
 		/* We are still in the index root. */
-		buf = ntfs_malloc(length = vol->mft_record_size);
+		buf = ntfs_malloc(io.size = vol->mft_record_size);
 		if (!buf)
 			return -ENOMEM;
 		io.fn_put = ntfs_put;
 		io.param = buf;
-		io.size = length;
-		error = ntfs_read_attr(ino, vol->at_index_root, I30, 0, &io);
-		if (error)
+		err = ntfs_read_attr(ino, vol->at_index_root, I30, 0, &io);
+		if (err || !io.size)
 			goto read_err_ret;
-		ino->u.index.recordsize = NTFS_GETU32(buf + 0x8);
+		ino->u.index.recordsize = ibs = NTFS_GETU32(buf + 0x8);
 		ino->u.index.clusters_per_record = NTFS_GETU32(buf + 0xC);
 		entry = buf + 0x20;
 		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 2: In index "
 				"root.\n");
+		ibs_bits = ffs(ibs) - 1;
 		/* Compensate for faked "." and "..". */
 		start = 2;
 	} else { /* We are in an index record. */
-		length = ino->u.index.recordsize;
-		buf = ntfs_malloc(length);
+		io.size = ibs = ino->u.index.recordsize;
+		buf = ntfs_malloc(ibs);
 		if (!buf)
 			return -ENOMEM;
+		ibs_bits = ffs(ibs) - 1;
 		io.fn_put = ntfs_put;
 		io.param = buf;
-		io.size = length;
-		/* 0 is index root, index allocation starts with 4. */
-		block = *p_high - ino->u.index.clusters_per_record;
-		error = ntfs_read_attr(ino, vol->at_index_allocation, I30,
-				(__s64)block << vol->cluster_size_bits, &io);
-		if (error || io.size != length)
+		/*
+		 * 0 is index root, index allocation starts at 1 and works in
+		 * units of index block size (ibs).
+		 */
+		ib_ofs = (s64)(*p_high - 1) << ibs_bits;
+		err = ntfs_read_attr(ino, vol->at_index_allocation, I30, ib_ofs,
+				&io);
+		if (err || io.size != ibs)
 			goto read_err_ret;
 		if (!ntfs_check_index_record(ino, buf)) {
-			ntfs_error(__FUNCTION__ "(): Block 0x%x is not an "
-					"index record. Returning -ENOTDIR.\n",
-					block);
+			ntfs_error(__FUNCTION__ "(): Index block 0x%x is not "
+					"an index record. Returning "
+					"-ENOTDIR.\n", *p_high - 1);
 			ntfs_free(buf);
 			return -ENOTDIR;
 		}
-		entry = buf + NTFS_GETU16(buf + 0x18) + 0x18;
+		entry = buf + 0x18 + NTFS_GETU16(buf + 0x18);
 		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 3: In index "
 				"allocation.\n");
 		start = 0;
 	}
 	/* Process the entries. */
 	finish = *p_low;
-	for (; ntfs_entry_is_used(entry); entry += NTFS_GETU16(entry + 8)) {
+	for (; entry < (buf + ibs) && ntfs_entry_is_used(entry);
+			entry += NTFS_GETU16(entry + 8)) {
 		if (start < finish) {
 			/* Skip entries that were already processed. */
 			ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 4: "
@@ -870,7 +876,7 @@
 		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 5: "
 				"Processing entry p_high 0x%x, p_low 0x%x.\n",
 				*p_high, *p_low);
-		if ((error = cb(entry, param))) {
+		if ((err = cb(entry, param))) {
 			/* filldir signalled us to stop. */
 			ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): "
 					"Unsorted 6: cb returned %i, "
@@ -889,20 +895,26 @@
 	*p_low = 0;
 	attr = ntfs_find_attr(ino, vol->at_bitmap, I30);
 	if (!attr) {
-		/* Directory does not have index allocation. */
+		/* Directory does not have index bitmap and index allocation. */
 		*p_high = 0x7fff;
 		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 8: No index "
 				"allocation. Returning 0, p_high 0x7fff, "
 				"p_low 0x0.\n");
 		return 0;
 	}
-	buf = ntfs_malloc(length = attr->size);
+	max_size = attr->size;
+	if (max_size > 0x7fff >> 3) {
+		ntfs_error(__FUNCTION__ "(): Directory too large. Visible "
+				"length is truncated.\n");
+		max_size = 0x7fff >> 3;
+	}
+	buf = ntfs_malloc(max_size);
 	if (!buf)
 		return -ENOMEM;
 	io.param = buf;
-	io.size = length;
-	error = ntfs_read_attr(ino, vol->at_bitmap, I30, 0, &io);
-	if (error || io.size != length)
+	io.size = max_size;
+	err = ntfs_read_attr(ino, vol->at_bitmap, I30, 0, &io);
+	if (err || io.size != max_size)
 		goto read_err_ret;
 	attr = ntfs_find_attr(ino, vol->at_index_allocation, I30);
 	if (!attr) {
@@ -911,35 +923,55 @@
 				"attr failed. Returning -EIO.\n");
 		return -EIO;
 	}
+	if (attr->resident) {
+		ntfs_free(buf);
+		ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 9.5: IA is "
+				"resident. Not allowed. Returning EINVAL.\n");
+		return -EINVAL;
+	}
 	/* Loop while going through non-allocated index records. */
-	do {
-		if ((s64)*p_high << vol->cluster_size_bits >
+	max_size <<= 3;
+	while (1) {
+		if (++*p_high >= 0x7fff) {
+			ntfs_error(__FUNCTION__ "(): Unsorted 10: Directory "
+					"inode 0x%lx overflowed the maximum "
+					"number of index allocation buffers "
+					"the driver can cope with. Pretending "
+					"to be at end of directory.\n",
+					ino->i_number);
+			goto fake_eod;
+		}
+		if (*p_high > max_size || (s64)*p_high << ibs_bits >
 				attr->initialized) {
+fake_eod:
 			/* No more index records. */
 			*p_high = 0x7fff;
+			*p_low = 0;
 			ntfs_free(buf);
-			ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 10: "
-					"No more index records. Returning 0, "
-					"p_high 0x7fff, p_low 0x%x.\n", *p_low);
+			ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted "
+					"10.5: No more index records. "
+					"Returning 0, p_high 0x7fff, p_low "
+					"0.\n");
 			return 0;
 		}
-		*p_high += ino->u.index.clusters_per_record;
-		byte = *p_high / ino->u.index.clusters_per_record - 1;
+		byte = (ntfs_cluster_t)(*p_high - 1);
 		bit = 1 << (byte & 7);
-		byte = byte >> 3;
-	} while (!(buf[byte] & bit));
+		byte >>= 3;
+		if ((buf[byte] & bit))
+			break;
+	};
 	ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 11: Done. "
 			"Returning 0, p_high 0x%x, p_low 0x%x.\n", *p_high,
 			*p_low);
 	ntfs_free(buf);
 	return 0;
 read_err_ret:
-	if (!error)
-		error = -EIO;
+	if (!err)
+		err = -EIO;
 	ntfs_error(__FUNCTION__ "(): Read failed. Returning error code %i.\n",
-			error);
+			err);
 	ntfs_free(buf);
-	return error;
+	return err;
 }
 
 int ntfs_dir_add(ntfs_inode *dir, ntfs_inode *new, ntfs_attribute *name)
diff -u -urN linux-2.4.10-pre7-vanilla/fs/ntfs/fs.c linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/fs.c
--- linux-2.4.10-pre7-vanilla/fs/ntfs/fs.c	Tue Sep 11 23:53:48 2001
+++ linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/fs.c	Tue Sep 11 23:59:30 2001
@@ -192,23 +192,25 @@
 	default:
 		BUG();
 	}
-	if (ntfs_encodeuni(NTFS_INO2VOL(nf->dir), (ntfs_u16*)(entry + 0x52),
-			name_len, &nf->name, &nf->namelen)) {
+	err = ntfs_encodeuni(NTFS_INO2VOL(nf->dir), (ntfs_u16*)(entry + 0x52),
+			name_len, &nf->name, &nf->namelen);
+	if (err) {
 		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Skipping "
 				"unrepresentable file.\n");
-		if (nf->name)
-			ntfs_free(nf->name);
-		return 0;
+		err = 0;
+		goto err_ret;
 	}
 	if (!show_sys_files && inum < 0x10UL) {
 		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Skipping system "
 				"file (%s).\n", nf->name);
-		return 0;
+		err = 0;
+		goto err_ret;
 	}
 	/* Do not return ".", as this is faked. */
 	if (nf->namelen == 1 && nf->name[0] == '.') {
 		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Skipping \".\"\n");
-		return 0;
+		err = 0;
+		goto err_ret;
 	}
 	nf->name[nf->namelen] = 0;
 	if (flags & 0x10000000) /* FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT */
@@ -229,7 +231,10 @@
 			(loff_t)(nf->ph << 16) | nf->pl, inum, file_type);
 	if (err)
 		nf->ret_code = err;
+err_ret:
+	nf->namelen = 0;
 	ntfs_free(nf->name);
+	nf->name = NULL;
 	return err;
 }
 
@@ -292,7 +297,7 @@
 				"0x%Lx.\n", (loff_t)(cb.ph << 16) | cb.pl);
 		err = ntfs_getdir_unsorted(NTFS_LINO2NINO(dir), &cb.ph, &cb.pl,
 				ntfs_printcb, &cb);
-	} while (!err && cb.ph < 0x7fff);
+	} while (!err && !cb.ret_code && cb.ph < 0x7fff);
 	filp->f_pos = (loff_t)(cb.ph << 16) | cb.pl;
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After ntfs_getdir_unsorted()"
 			" calls, f_pos 0x%Lx.\n", filp->f_pos);
@@ -520,18 +525,22 @@
 	struct inode *res = 0;
 	char *item = 0;
 	ntfs_iterate_s walk;
-	int error;
+	int err;
 	
 	ntfs_debug(DEBUG_NAME1, __FUNCTION__ "(): Looking up %s in directory "
 			"ino 0x%x.\n", d->d_name.name, (unsigned)dir->i_ino);
+	walk.name = NULL;
+	walk.namelen = 0;
 	/* Convert to wide string. */
-	error = ntfs_decodeuni(NTFS_INO2VOL(dir), (char*)d->d_name.name,
+	err = ntfs_decodeuni(NTFS_INO2VOL(dir), (char*)d->d_name.name,
 			       d->d_name.len, &walk.name, &walk.namelen);
-	if (error)
-		return ERR_PTR(error);
+	if (err)
+		goto err_ret;
 	item = ntfs_malloc(ITEM_SIZE);
-	if (!item)
-		return ERR_PTR(-ENOMEM);
+	if (!item) {
+		err = -ENOMEM;
+		goto err_ret;
+	}
 	/* ntfs_getdir will place the directory entry into item, and the first
 	 * long long is the MFT record number. */
 	walk.type = BY_NAME;
@@ -544,6 +553,9 @@
 	ntfs_free(walk.name);
 	/* Always return success, the dcache will handle negative entries. */
 	return NULL;
+err_ret:
+	ntfs_free(walk.name);
+	return ERR_PTR(err);
 }
 
 static struct file_operations ntfs_file_operations = {
diff -u -urN linux-2.4.10-pre7-vanilla/fs/ntfs/support.c linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/support.c
--- linux-2.4.10-pre7-vanilla/fs/ntfs/support.c	Tue Sep 11 23:53:48 2001
+++ linux-2.4.10-pre7-ntfs-1.1.19/fs/ntfs/support.c	Tue Sep 11 23:18:55 2001
@@ -242,8 +242,8 @@
 			if (chl > 1) {
 				buf = ntfs_malloc(*out_len + chl - 1);
 				if (!buf) {
-					ntfs_free(result);
-					return -ENOMEM;
+					i = -ENOMEM;
+					goto err_ret;
 				}
 				memcpy(buf, result, o);
 				ntfs_free(result);
@@ -259,13 +259,18 @@
 					"to chosen character set. Remount "
 					"with utf8 encoding and this should "
 					"work.\n");
-			ntfs_free(result);
-			return -EILSEQ;
+			i = -EILSEQ;
+			goto err_ret;
 		}
 	}
 	result[*out_len] = '\0';
 	*out = result;
 	return 0;
+err_ret:
+	ntfs_free(result);
+	*out_len = 0;
+	*out = NULL;
+	return i;
 }
 
 int ntfs_dupmap2uni(ntfs_volume *vol, char* in, int in_len, ntfs_u16 **out,
@@ -276,8 +281,10 @@
 	struct nls_table *nls = vol->nls_map;
 
 	*out = result = ntfs_malloc(2 * in_len);
-	if (!result)
+	if (!result) {
+		*out_len = 0;
 		return -ENOMEM;
+	}
 	*out_len = in_len;
 	for (i = o = 0; i < in_len; i++, o++) {
 		wchar_t uni;
@@ -285,22 +292,25 @@
 
 		charlen = nls->char2uni(&in[i], in_len - i, &uni);
 		if (charlen < 0) {
-			printk(KERN_ERR "NTFS: Name contains a character that "
-					"cannot be converted to Unicode.\n");
-			ntfs_free(result);
-			return charlen;
+			i = charlen;
+			goto err_ret;
 		}
 		*out_len -= charlen - 1;
 		i += charlen - 1;
 		/* FIXME: Byte order? */
 		result[o] = uni;
 		if (!result[o]) {
-			printk(KERN_ERR "NTFS: Name contains a character that "
-					"cannot be converted to Unicode.\n");
-			ntfs_free(result);
-			return -EILSEQ;
+			i = -EILSEQ;
+			goto err_ret;
 		}
 	}
 	return 0;
+err_ret:
+	printk(KERN_ERR "NTFS: Name contains a character that cannot be "
+			"converted to Unicode.\n");
+	ntfs_free(result);
+	*out_len = 0;
+	*out = NULL;
+	return i;
 }
 

