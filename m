Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271032AbRHTCvs>; Sun, 19 Aug 2001 22:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271033AbRHTCve>; Sun, 19 Aug 2001 22:51:34 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:50650 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S271032AbRHTCvR>; Sun, 19 Aug 2001 22:51:17 -0400
Subject: [PATCH] 2.4.8-ac7 NTFS update to 1.1.17
To: alan@lxorguk.ukuu.org.uk
Date: Mon, 20 Aug 2001 03:51:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15YfA3-0007g3-00@draco.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Please apply below patch for your next ac release. It updates the ntfs
driver to the next release.

ChangeLog:
- Fixed system file handling. No longer need to use show_sys_files
  option for driver to work fine. System files are now always treated
  the same, but without the option, they are made invisible to
  directory listings. As a result system files can once again be opened
  even without the show_sys_files option. This is important for the
  statfs system call to work properly, for example.
- Implemented MFT zone including mount parameter to tune it (just like
  in Windows via the registry, only we make it per mount rather than
  global for the whole driver, so we are better but we have no way of
  storing the value as we don't have a registry so either specify on
  each mount or put it in /etc/fstab). [Stage 1 of 3, mount parameter
  handling.]
- Fixed fixup functions to handle corruption cases and to return error
  codes to the caller.
- Made fixup functions apply hotfixes where sensible. [Stage 1 of 2+,
  in memory only.]
- Fixed ommission of "NTFS: " string in ntfs_error() output.
- Fixed stupid if statement bug in unistr.c. Thanks to Yann E. Morin
  for spotting it. 
- Get rid of all uses of max and min macros. This actually allowed for
  optimizing the code in several places so it was a Good Thing(TM).
- Make ntfs use generic_file_open to enforce the O_LARGEFILE flag.
- Detect encrypted files and refuse to access them (return EACCES
  error code to user space).
- Fix handling of encrypted & compressed files so that an encrypted
  file no longer is considered to be compressed (this was causing
  kernel segmentation faults).

Best regards,

Anton
Linux-NTFS Maintainer

--- ntfs-1.1.17.diff ---
diff -urN linux-2.4.8-ac7-vanilla/Documentation/filesystems/ntfs.txt linux-2.4.8-ac7-ntfs-1.1.17/Documentation/filesystems/ntfs.txt
--- linux-2.4.8-ac7-vanilla/Documentation/filesystems/ntfs.txt	Sun Aug 19 12:59:01 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/Documentation/filesystems/ntfs.txt	Mon Aug 20 00:37:24 2001
@@ -64,6 +64,26 @@
 			Be careful not to write anything to them or you could
 			crash the kernel and/or corrupt your file system!
 
+mft_zone_multiplier=	Set the MFT zone multiplier for the volume (this
+			setting is not persistent across mounts and can be
+			changed from mount to mount but cannot be changed on
+			remount). Values of 1 to 4 are allowed, 1 being the
+			default. The MFT zone multiplier determines how much
+			space is reserved for the MFT on the volume. If all
+			other space is used up, then the MFT zone will be
+			shrunk dynamically, so this has no impact on the
+			amount of free space. However, it can have an impact
+			on performance by affecting fragmentation of the MFT.
+			In general use the default. If you have a lot of small
+			files then use a higher value. The values have the
+			following meaning:
+			      Value	     MFT zone size (% of volume size)
+				1		12.5%
+				2		25%
+				3		37.5%
+				4		50%
+			NOTE: This is currently ignored! Work in progress.
+
 Known bugs and (mis-)features
 =============================
 
@@ -71,17 +91,45 @@
   use it, get the Linux-NTFS tools and use the ntfsfix utility after
   dismounting a partition you wrote to.
 
-- Use the show_sys_files mount option which should make things work generally
-  better. (It results in both the short and long file names being shown as well
-  as the sytem files.)
-
 - Writing of extension records is not supported properly.
 
+- $MFT extension is badly broken and really needs rewriting.
+
 Please send bug reports/comments/feed back/abuse to the Linux-NTFS development
 list at sourceforge: linux-ntfs-dev@lists.sourceforge.net
 
 ChangeLog
 =========
+
+NTFS 1.1.17:
+
+	- Fixed system file handling. No longer need to use show_sys_files
+	  option for driver to work fine. System files are now always treated
+	  the same, but without the option, they are made invisible to
+	  directory listings. As a result system files can once again be opened
+	  even without the show_sys_files option. This is important for the
+	  statfs system call to work properly, for example.
+	- Implemented MFT zone including mount parameter to tune it (just like
+	  in Windows via the registry, only we make it per mount rather than
+	  global for the whole driver, so we are better but we have no way of
+	  storing the value as we don't have a registry so either specify on
+	  each mount or put it in /etc/fstab). [Stage 1 of 3, mount parameter
+	  handling.]
+	- Fixed fixup functions to handle corruption cases and to return error
+	  codes to the caller.
+	- Made fixup functions apply hotfixes where sensible. [Stage 1 of 2+,
+	  in memory only.]
+	- Fixed ommission of "NTFS: " string in ntfs_error() output.
+	- Fixed stupid if statement bug in unistr.c. Thanks to Yann E. Morin
+	  for spotting it. 
+	- Get rid of all uses of max and min macros. This actually allowed for
+	  optimizing the code in several places so it was a Good Thing(TM).
+	- Make ntfs use generic_file_open to enforce the O_LARGEFILE flag.
+	- Detect encrypted files and refuse to access them (return EACCES
+	  error code to user space).
+	- Fix handling of encrypted & compressed files so that an encrypted
+	  file no longer is considered to be compressed (this was causing
+	  kernel segmentation faults).
 
 NTFS 1.1.16:
 
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/Makefile linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/Makefile
--- linux-2.4.8-ac7-vanilla/fs/ntfs/Makefile	Sun Aug 19 12:59:31 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/Makefile	Mon Aug 20 00:33:42 2001
@@ -5,7 +5,7 @@
 obj-y   := fs.o sysctl.o support.o util.o inode.o dir.o super.o attr.o unistr.o
 obj-m   := $(O_TARGET)
 # New version format started 3 February 2001.
-EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.16\" #-DDEBUG
+EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.17\" #-DDEBUG
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/attr.c linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/attr.c
--- linux-2.4.8-ac7-vanilla/fs/ntfs/attr.c	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/attr.c	Sun Aug 19 23:59:05 2001
@@ -13,6 +13,7 @@
 #include "attr.h"
 
 #include <linux/errno.h>
+#include <linux/ntfs_fs.h>
 #include "macros.h"
 #include "support.h"
 #include "util.h"
@@ -148,7 +149,10 @@
 					"attribute non-resident. Bug!\n");
 				return -EINVAL;
 			}
-			m = memcmp(value, a->d.data, min(value_len, a->size));
+			m = value_len;
+			if (m > a->size)
+				m = a->size;
+			m = memcmp(value, a->d.data, m);
 			if (m > 0)
 				continue;
 			if (m < 0) {
@@ -234,7 +238,7 @@
 		}
 		if (attr->d.r.runlist) {
 			ntfs_memcpy(new, attr->d.r.runlist, attr->d.r.len
-							* sizeof(ntfs_runlist));
+					* sizeof(ntfs_runlist));
 			ntfs_vfree(attr->d.r.runlist);
 		}
 		attr->d.r.runlist = new;
@@ -250,7 +254,7 @@
 }
 
 /* Extends an attribute. Another run will be added if necessary, but we try to
- * extend the last run in the runlist first.
+ * extend the last run in the run list first.
  * FIXME: what if there isn't enough contiguous space, we don't create
  * multiple runs?
  *
@@ -264,7 +268,8 @@
 	ntfs_cluster_t cluster;
 	int clen;
 
-	if (attr->compressed || ino->record_count > 1)
+	if ((attr->flags & (ATTR_IS_COMPRESSED | ATTR_IS_ENCRYPTED)) ||
+			ino->record_count > 1)
 		return -EOPNOTSUPP;
 	if (attr->resident) {
 		error = ntfs_make_attr_nonresident(ino, attr);
@@ -272,7 +277,7 @@
 			return error;
 	}
 	if (*len <= attr->allocated)
-		return 0;	/* Truely stupid things do sometimes happen. */
+		return 0;	/* Truly stupid things do sometimes happen. */
 	rl = attr->d.r.runlist;
 	rlen = attr->d.r.len - 1;
 	if (rlen >= 0)
@@ -357,7 +362,7 @@
 	if (newsize == oldsize)
 		return 0;
 	/* FIXME: Modifying compressed attributes not supported yet. */
-	if (attr->compressed)
+	if (attr->flags & (ATTR_IS_COMPRESSED | ATTR_IS_ENCRYPTED))
 		/* FIXME: Extending is easy: just insert sparse runs. */
 		return -EOPNOTSUPP;
 	if (attr->resident) {
@@ -370,16 +375,18 @@
 		}
 		v = attr->d.data;
 		if (newsize) {
+			__s64 minsize = newsize;
 			attr->d.data = ntfs_malloc(newsize);
 			if (!attr->d.data) {
 				ntfs_free(v);
 				return -ENOMEM;
 			}
-			if (newsize > oldsize)
+			if (newsize > oldsize) {
+				minsize = oldsize;
 				ntfs_bzero((char*)attr->d.data + oldsize,
 					   newsize - oldsize);
-			ntfs_memcpy((char*)attr->d.data, v,
-				    min(newsize, oldsize));
+			}
+			ntfs_memcpy((char*)attr->d.data, v, minsize);
 		} else
 			attr->d.data = 0;
 		ntfs_free(v);
@@ -389,6 +396,12 @@
 	/* Non-resident attribute. */
 	rl = attr->d.r.runlist;
 	if (newsize < oldsize) {
+		/*
+		 * FIXME: We might be going awfully wrong for newsize = 0,
+		 * possibly even leaking memory really badly. But considering
+		 * in that case there is more breakage due to -ENOTSUP stuff
+		 * further down the code path, who cares for the moment... (AIA)
+		 */
 		for (i = 0, count = 0; i < attr->d.r.len; i++) {
 			if ((__s64)(count + rl[i].len) << clustersizebits >
 									newsize)
@@ -441,7 +454,7 @@
 }
 
 int ntfs_create_attr(ntfs_inode *ino, int anum, char *aname, void *data,
-		     int dsize, ntfs_attribute **rattr)
+		int dsize, ntfs_attribute **rattr)
 {
 	void *name;
 	int namelen;
@@ -463,7 +476,7 @@
 		namelen = 0;
 	}
 	error = ntfs_new_attr(ino, anum, name, namelen, data, dsize, &i,
-									&found);
+			&found);
 	if (error || found) {
 		ntfs_free(name);
 		return error ? error : -EEXIST;
@@ -481,7 +494,8 @@
 				"+ 0x28) (%i)\n", attr->attrno,
 				NTFS_GETU16(ino->attr + 0x28));
 	attr->resident = 1;
-	attr->compressed = attr->cengine = 0;
+	attr->flags = 0;
+	attr->cengine = 0;
 	attr->size = attr->allocated = attr->initialized = dsize;
 
 	/* FIXME: INDEXED information should come from $AttrDef
@@ -498,7 +512,8 @@
 	return 0;
 }
 
-/* Non-resident attributes are stored in runs (intervals of clusters).
+/*
+ * Non-resident attributes are stored in runs (intervals of clusters).
  *
  * This function stores in the inode readable information about a non-resident
  * attribute.
@@ -630,7 +645,7 @@
 	}
 	attr = ino->attrs + i;
 	attr->resident = NTFS_GETU8(attrdata + 8) == 0;
-	attr->compressed = NTFS_GETU16(attrdata + 0xC);
+	attr->flags = *(__u16*)(attrdata + 0xC);
 	attr->attrno = NTFS_GETU16(attrdata + 0xE);
   
 	if (attr->resident) {
@@ -640,13 +655,13 @@
 		if (!attr->d.data)
 			return -ENOMEM;
 		ntfs_memcpy(attr->d.data, data, attr->size);
-		attr->indexed = NTFS_GETU16(attrdata + 0x16);
+		attr->indexed = NTFS_GETU8(attrdata + 0x16);
 	} else {
 		attr->allocated = NTFS_GETS64(attrdata + 0x28);
 		attr->size = NTFS_GETS64(attrdata + 0x30);
 		attr->initialized = NTFS_GETS64(attrdata + 0x38);
 		attr->cengine = NTFS_GETU16(attrdata + 0x22);
-		if (attr->compressed)
+		if (attr->flags & ATTR_IS_COMPRESSED)
 			attr->compsize = NTFS_GETS64(attrdata + 0x40);
 		ntfs_debug(DEBUG_FILE3, "ntfs_insert_attribute: "
 			"attr->allocated = 0x%Lx, attr->size = 0x%Lx, "
@@ -664,11 +679,14 @@
 
 int ntfs_read_zero(ntfs_io *dest, int size)
 {
+	int i;
 	char *sparse = ntfs_calloc(512);
 	if (!sparse)
 		return -ENOMEM;
+	i = 512;
 	while (size) {
-		int i = min(size, 512);
+		if (i > size)
+			i = size;
 		dest->fn_put(dest, sparse, i);
 		size -= i;
 	}
@@ -683,7 +701,7 @@
 	int error = 0;
 	int clustersizebits;
 	int s_vcn, rnum, vcn, got, l1;
-	__s64 copied, len, chunk, offs1, l;
+	__s64 copied, len, chunk, offs1, l, chunk2;
 	ntfs_cluster_t cluster, cl1;
 	char *comp = 0, *comp1;
 	char *decomp = 0;
@@ -720,12 +738,15 @@
 		chunk = 0;
 		if (cluster == (ntfs_cluster_t)-1) {
 			/* Sparse cluster. */
-			__s64 l1;
+			__s64 ll;
+
 			if ((len - (s_vcn - vcn)) & 15)
 				ntfs_error("Unexpected sparse chunk size.");
-			l1 = chunk = min(((__s64)(vcn + len) << clustersizebits)
-								- offset, l);
-			error = ntfs_read_zero(dest, l1);
+			ll = ((__s64)(vcn + len) << clustersizebits) - offset;
+			if (ll > l)
+				ll = l;
+			chunk = ll;
+			error = ntfs_read_zero(dest, ll);
 			if (error)
 				goto out;
 		} else if (dest->do_read) {
@@ -741,14 +762,21 @@
 			cl1 = cluster + s_vcn - vcn;
 			comp1 = comp;
 			do {
+				int delta;
+
 				io.param = comp1;
-				l1 = min(len - max(s_vcn - vcn, 0), 16 - got);
+				delta = s_vcn - vcn;
+				if (delta < 0)
+					delta = 0;
+				l1 = len - delta;
+				if (l1 > 16 - got)
+					l1 = 16 - got;
 				io.size = (__s64)l1 << clustersizebits;
 				error = ntfs_getput_clusters(ino->vol, cl1, 0,
 					       		     &io);
 				if (error)
 					goto out;
-				if (l1 + max(s_vcn - vcn, 0) == len) {
+				if (l1 + delta == len) {
 					rnum++;
 					rl++;
 					vcn += len;
@@ -779,8 +807,11 @@
 				comp1 = decomp;
 			}
 			offs1 = offset - ((__s64)s_vcn << clustersizebits);
-			chunk = min((16 << clustersizebits) - offs1, chunk);
-			chunk = min(l, chunk);
+			chunk2 = (16 << clustersizebits) - offs1;
+			if (chunk2 > l)
+				chunk2 = l;
+			if (chunk > chunk2)
+				chunk = chunk2;
 			dest->fn_put(dest, comp1 + offs1, chunk);
 		}
 		l -= chunk;
@@ -795,7 +826,7 @@
 			len = rl->len;
 		}
 	}
- out:
+out:
 	if (comp)
 		ntfs_free(comp);
 	if (decomp)
@@ -805,7 +836,7 @@
 }
 
 int ntfs_write_compressed(ntfs_inode *ino, ntfs_attribute *attr, __s64 offset,
-			  ntfs_io *dest)
+		ntfs_io *dest)
 {
 	return -EOPNOTSUPP;
 }
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/dir.c linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/dir.c
--- linux-2.4.8-ac7-vanilla/fs/ntfs/dir.c	Sun Aug 19 12:59:31 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/dir.c	Sun Aug 19 13:04:15 2001
@@ -27,8 +27,7 @@
  * be restored. */
 int ntfs_check_index_record(ntfs_inode *ino, char *record)
 {
-	return ntfs_fixup_record(ino->vol, record, "INDX",
-				 ino->u.index.recordsize);
+	return ntfs_fixup_record(record, "INDX", ino->u.index.recordsize);
 }
 
 static inline int ntfs_is_top(ntfs_u64 stack)
@@ -268,12 +267,21 @@
 		ntfs_resize_attr(walk->dir, a, used);
 	} else {
 		NTFS_PUTU16(buf + 0x1C, used - 0x18);
-		ntfs_insert_fixups(buf, vol->sector_size);
 		io.size = walk->dir->u.index.recordsize;
+		error = ntfs_insert_fixups(buf, io.size);
+		if (error) {
+			printk(KERN_ALERT "NTFS: ntfs_index_writeback() caught "
+					"corrupt index record ntfs record "
+					"header. Refusing to write corrupt "
+					"data to disk. Unmount and run chkdsk "
+					"immediately!\n");
+			return -EIO;
+		}
 		error = ntfs_write_attr(walk->dir, vol->at_index_allocation,
-			I30, (__s64)block << vol->cluster_size_bits, &io);
+				I30, (__s64)block << vol->cluster_size_bits,
+				&io);
 		if (error || (io.size != walk->dir->u.index.recordsize &&
-							(error = -EIO, 1)))
+				(error = -EIO, 1)))
 			return error;
 	}
 	return 0;
@@ -467,7 +475,7 @@
 	NTFS_PUTU32(index + 0x24, NTFS_GETU32(root + 0x1C));
 	error = ntfs_index_writeback(&walk, index, walk.newblock, 
 				     isize + NTFS_GETU16(index + 0x18) + 0x18);
-	if(error)
+	if (error)
 		goto out;
 	/* Mark root as split. */
 	NTFS_PUTU32(root + 0x1C, 1);
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/fs.c linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/fs.c
--- linux-2.4.8-ac7-vanilla/fs/ntfs/fs.c	Sun Aug 19 12:59:31 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/fs.c	Mon Aug 20 00:12:32 2001
@@ -11,7 +11,7 @@
  */
 
 #include <linux/config.h>
-
+#include <linux/errno.h>
 #include "ntfstypes.h"
 #include "struct.h"
 #include "util.h"
@@ -27,10 +27,8 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <asm/page.h>
-
-#ifndef NLS_MAX_CHARSET_SIZE
 #include <linux/nls.h>
-#endif
+#include <linux/ntfs_fs.h>
 
 /* Forward declarations. */
 static struct inode_operations ntfs_dir_inode_operations;
@@ -67,6 +65,7 @@
 {
 	int error;
 	ntfs_io io;
+	ntfs_attribute *attr;
 	ntfs_inode *ino = NTFS_LINO2NINO(filp->f_dentry->d_inode);
 
 	/* Inode is not properly initialized. */
@@ -75,11 +74,14 @@
 	ntfs_debug(DEBUG_OTHER, "ntfs_read %x, %Lx, %x ->",
 		   (unsigned)ino->i_number, (unsigned long long)*off,
 		   (unsigned)count);
+	attr = ntfs_find_attr(ino, ino->vol->at_data, NULL);
 	/* Inode has no unnamed data attribute. */
-	if(!ntfs_find_attr(ino, ino->vol->at_data, NULL)) {
+	if (!attr) {
 		ntfs_debug(DEBUG_OTHER, "ntfs_read: $DATA not found!\n");
 		return -EINVAL;
 	}
+	if (attr->flags & ATTR_IS_ENCRYPTED)
+		return -EACCES;
 	/* Read the data. */
 	io.fn_put = ntfs_putuser;
 	io.fn_get = 0;
@@ -285,8 +287,21 @@
 	return 1;
 }
 
+/*
+ * This needs to be outside parse_options() otherwise a remount will reset
+ * these unintentionally.
+ */
+static void init_ntfs_super_block(ntfs_volume* vol)
+{
+	vol->uid = vol->gid = 0;
+	vol->umask = 0077;
+	vol->ngt = ngt_nt;
+	vol->nls_map = (void*)-1;
+	vol->mft_zone_multiplier = -1;
+}
+
 /* Parse the (re)mount options. */
-static int parse_options(ntfs_volume *vol, char *opt, int remount)
+static int parse_options(ntfs_volume *vol, char *opt)
 {
 	char *value;		/* Defaults if not specified and !remount. */
 	ntfs_uid_t uid = -1;	/* 0, root user only */
@@ -296,6 +311,8 @@
 	void *nls_map = NULL;	/* Try to load the default NLS. */
 	int use_utf8 = -1;	/* If no NLS specified and loading the default
 				   NLS failed use utf8. */
+	int mft_zone_mul = -1;	/* 1 */
+
 	if (!opt)
 		goto done;
 	for (opt = strtok(opt, ","); opt; opt = strtok(NULL, ",")) {
@@ -326,6 +343,24 @@
 						"argument\n");
 				return 0;
 			}
+		} else if (strcmp(opt, "mft_zone_multiplier") == 0) {
+			unsigned long ul;
+
+			if (!value || !*value)
+				goto needs_arg;
+			ul = simple_strtoul(value, &value, 0);
+			if (*value) {
+				printk(KERN_ERR "NTFS: mft_zone_multiplier "
+						"invalid argument\n");
+				return 0;
+			}
+			if (ul >= 1 && ul <= 4)
+				mft_zone_mul = ul;
+			else {
+				mft_zone_mul = 1;
+				printk(KERN_WARNING "NTFS: mft_zone_multiplier "
+					      "out of range. Setting to 1.\n");
+			}
 		} else if (strcmp(opt, "posix") == 0) {
 			int val;
 			if (!value || !*value)
@@ -361,40 +396,69 @@
 		}
 	}
 done:
-	if (use_utf8 != -1 && use_utf8) {
-		if (nls_map) {
+	if (use_utf8 == -1) {
+		/* utf8 was not specified at all. */
+		if (!nls_map) {
+			/*
+			 * No NLS was specified. If first mount, load the
+			 * default NLS, otherwise don't change the NLS setting.
+			 */
+			if (vol->nls_map == (void*)-1)
+				vol->nls_map = load_nls_default();
+		} else {
+			/* If an NLS was already loaded, unload it first. */
+			if (vol->nls_map && vol->nls_map != (void*)-1)
+				unload_nls(vol->nls_map);
+			/* Use the specified NLS. */
+			vol->nls_map = nls_map;
+		}
+	} else {
+		/* utf8 was specified. */
+		if (use_utf8 && nls_map) {
 			unload_nls(nls_map);
 			printk(KERN_ERR "NTFS: utf8 cannot be combined with "
 					"iocharset.\n");
 			return 0;
 		}
-		if (remount && vol->nls_map)
+		/* If an NLS was already loaded, unload it first. */
+		if (vol->nls_map && vol->nls_map != (void*)-1)
 			unload_nls(vol->nls_map);
-		vol->nls_map = NULL;
-	} else {
-		if (nls_map) {
-			if (remount && vol->nls_map)
-				unload_nls(vol->nls_map);
-			vol->nls_map = nls_map;
-		} else if (!remount || (remount && !use_utf8 && !vol->nls_map))
-			vol->nls_map = load_nls_default();
+		if (!use_utf8) {
+			/* utf8 was specified as false. */
+			if (!nls_map)
+				/* No NLS was specified, load the default. */
+				vol->nls_map = load_nls_default();
+			else
+				/* Use the specified NLS. */
+				vol->nls_map = nls_map;
+		} else
+			/* utf8 was specified as true. */
+			vol->nls_map = NULL;
 	}
 	if (uid != -1)
 		vol->uid = uid;
-	else if (!remount)
-		vol->uid = 0;
 	if (gid != -1)
 		vol->gid = gid;
-	else if (!remount)
-		vol->gid = 0;
 	if (umask != -1)
 		vol->umask = (ntmode_t)umask;
-	else if (!remount)
-		vol->umask = 0077;
 	if (ngt != -1)
 		vol->ngt = ngt;
-	else if (!remount)
-		vol->ngt = ngt_nt;
+	if (mft_zone_mul != -1) {
+		/* mft_zone_multiplier was specified. */
+		if (vol->mft_zone_multiplier != -1) {
+			/* This is a remount, ignore a change and warn user. */
+			if (vol->mft_zone_multiplier != mft_zone_mul)
+				printk(KERN_WARNING "NTFS: Ignoring changes in "
+						"mft_zone_multiplier on "
+						"remount. If you want to "
+						"change this you need to "
+						"umount and mount again.\n");
+		} else
+			/* Use the specified multiplier. */
+			vol->mft_zone_multiplier = mft_zone_mul;
+	} else if (vol->mft_zone_multiplier == -1)
+		/* No multiplier specified and first mount, so set default. */
+		vol->mft_zone_multiplier = 1;
 	return 1;
 needs_arg:
 	printk(KERN_ERR "NTFS: %s needs an argument", opt);
@@ -441,6 +505,7 @@
 #ifdef CONFIG_NTFS_RW
 	write:		ntfs_write,
 #endif
+	open:		generic_file_open,
 };
 
 static struct inode_operations ntfs_inode_operations_nobmap;
@@ -557,18 +622,8 @@
 }
 #endif
 
-#if 0
-static int ntfs_bmap(struct inode *ino, int block)
-{
-	int ret = ntfs_vcn_to_lcn(NTFS_LINO2NINO(ino), block);
-	ntfs_debug(DEBUG_OTHER, "bmap of %lx, block %x is %x\n", ino->i_ino,
-		   block, ret);
-	return (ret == -1) ? 0 : ret;
-}
-#endif
-
 /* It's fscking broken. */
-/* FIXME: [bm]map code is disabled until ntfs_get_block() gets sorted! */
+/* FIXME: mmap code is disabled until ntfs_get_block() gets sorted! */
 /*
 static int ntfs_get_block(struct inode *inode, long block, struct buffer_head *bh, int create)
 {
@@ -583,6 +638,7 @@
 #ifdef CONFIG_NTFS_RW
 	write:		ntfs_write,
 #endif
+	open:		generic_file_open,
 };
 
 static struct inode_operations ntfs_inode_operations;
@@ -648,19 +704,10 @@
 
 	vol = NTFS_INO2VOL(inode);
 	inode->i_mode = 0;
-	ntfs_debug(DEBUG_OTHER, "ntfs_read_inode 0x%x\n", (unsigned)inode->i_ino);
-	/*
-	 * This kills all accesses to system files (except $Extend directory).
-	 * The driver can bypass this by calling ntfs_init_inode() directly.
-	 * Only if ngt is ngt_full do we allow access to the system files.
-	 */
+	ntfs_debug(DEBUG_OTHER, "ntfs_read_inode 0x%lx\n", inode->i_ino);
 	switch (inode->i_ino) {
 		/* Those are loaded special files. */
 	case FILE_$Mft:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to open $MFT!\n");
-			return;
-		}
 		if (!vol->mft_ino || ((vol->ino_flags & 1) == 0))
 			goto sys_file_error;
 		ntfs_memcpy(&inode->u.ntfs_i, vol->mft_ino, sizeof(ntfs_inode));
@@ -672,10 +719,6 @@
 		ntfs_debug(DEBUG_OTHER, "Opening $MFT!\n");
 		break;
 	case FILE_$MftMirr:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to open $MFTMirr!\n");
-			return;
-		}
 		if (!vol->mftmirr || ((vol->ino_flags & 2) == 0))
 			goto sys_file_error;
 		ntfs_memcpy(&inode->u.ntfs_i, vol->mftmirr, sizeof(ntfs_inode));
@@ -687,10 +730,6 @@
 		ntfs_debug(DEBUG_OTHER, "Opening $MFTMirr!\n");
 		break;
 	case FILE_$BitMap:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to open $Bitmap!\n");
-			return;
-		}
 		if (!vol->bitmap || ((vol->ino_flags & 4) == 0))
 			goto sys_file_error;
 		ntfs_memcpy(&inode->u.ntfs_i, vol->bitmap, sizeof(ntfs_inode));
@@ -702,14 +741,10 @@
 		ntfs_debug(DEBUG_OTHER, "Opening $Bitmap!\n");
 		break;
 	case FILE_$LogFile ... FILE_$AttrDef:
-	/* We need to allow reading the root directory. */
+	/* No need to log root directory accesses. */
 	case FILE_$Boot ... FILE_$UpCase:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to open system file %i!\n",
-								inode->i_ino);
-	 		return;
-		} /* Do the default for ngt_full. */
-		ntfs_debug(DEBUG_OTHER, "Opening system file %i!\n", inode->i_ino);
+		ntfs_debug(DEBUG_OTHER, "Opening system file %i!\n",
+				inode->i_ino);
 	default:
 		ino = &inode->u.ntfs_i;
 		if (!ino || ntfs_init_inode(ino, NTFS_INO2VOL(inode),
@@ -733,7 +768,8 @@
 		inode->i_size = data->size;
 		/* FIXME: once ntfs_get_block is implemented, uncomment the
 		 * next line and remove the "can_mmap = 0;". (AIA) */
-		/* can_mmap = !data->resident && !data->compressed; */
+		/* can_mmap = !data->resident && !(data->flags &
+		 * 		(ATTR_IS_COMPRESSED | ATTR_IS_ENCRYPTED)); */
 		can_mmap = 0;
 	}
 	/* Get the file modification times from the standard information. */
@@ -770,7 +806,7 @@
 		inode->i_mode = S_IFREG | S_IRUGO;
 	}
 #ifdef CONFIG_NTFS_RW
-	if (!data || !data->compressed)
+	if (!data || !(data->flags & (ATTR_IS_COMPRESSED | ATTR_IS_ENCRYPTED)))
 		inode->i_mode |= S_IWUGO;
 #endif
 	inode->i_mode &= ~vol->umask;
@@ -800,13 +836,10 @@
 	ntfs_debug(DEBUG_OTHER, "_ntfs_clear_inode 0x%x\n", inode->i_ino);
 	vol = NTFS_INO2VOL(inode);
 	if (!vol)
-		ntfs_error("_ntfs_clear_inode: vol = NTFS_INO2VOL(inode) is NULL.\n");
+		ntfs_error("_ntfs_clear_inode: vol = NTFS_INO2VOL(inode) is "
+				"NULL.\n");
 	switch (inode->i_ino) {
 	case FILE_$Mft:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to _clear_inode of $MFT!\n");
-			goto unl_out;
-		}
 		if (vol->mft_ino && ((vol->ino_flags & 1) == 0)) {
 			ino = (ntfs_inode*)ntfs_malloc(sizeof(ntfs_inode));
 			ntfs_memcpy(ino, &inode->u.ntfs_i, sizeof(ntfs_inode));
@@ -816,10 +849,6 @@
 		}
 		break;
 	case FILE_$MftMirr:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to _clear_inode of $MFTMirr!\n");
-			goto unl_out;
-		}
 		if (vol->mftmirr && ((vol->ino_flags & 2) == 0)) {
 			ino = (ntfs_inode*)ntfs_malloc(sizeof(ntfs_inode));
 			ntfs_memcpy(ino, &inode->u.ntfs_i, sizeof(ntfs_inode));
@@ -829,10 +858,6 @@
 		}
 		break;
 	case FILE_$BitMap:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to _clear_inode of $Bitmap!\n");
-			goto unl_out;
-		}
 		if (vol->bitmap && ((vol->ino_flags & 4) == 0)) {
 			ino = (ntfs_inode*)ntfs_malloc(sizeof(ntfs_inode));
 			ntfs_memcpy(ino, &inode->u.ntfs_i, sizeof(ntfs_inode));
@@ -841,13 +866,6 @@
 			goto unl_out;
 		}
 		break;
-	case FILE_$LogFile ... FILE_$AttrDef:
-	case FILE_$Boot ... FILE_$UpCase:
-		if (vol->ngt != ngt_full) {
-			ntfs_error("Trying to _clear_inode of system file %i! "
-					"Shouldn't happen.\n", inode->i_ino);
-			goto unl_out;
-		} /* Do the default for ngt_full. */
 	default:
 		/* Nothing. Just clear the inode and exit. */
 	}
@@ -907,7 +925,7 @@
 /* Called when remounting a filesystem by do_remount_sb() in fs/super.c. */
 static int ntfs_remount_fs(struct super_block *sb, int *flags, char *options)
 {
-	if (!parse_options(NTFS_SB2VOL(sb), options, 1))
+	if (!parse_options(NTFS_SB2VOL(sb), options))
 		return -EINVAL;
 	return 0;
 }
@@ -1008,11 +1026,12 @@
 {
 	ntfs_volume *vol;
 	struct buffer_head *bh;
-	int i;
+	int i, to_read;
 
 	ntfs_debug(DEBUG_OTHER, "ntfs_read_super\n");
 	vol = NTFS_SB2VOL(sb);
-	if (!parse_options(vol, (char*)options, 0))
+	init_ntfs_super_block(vol);
+	if (!parse_options(vol, (char*)options))
 		goto ntfs_read_super_vol;
 	/* Assume a 512 bytes block device for now. */
 	set_blocksize(sb->s_dev, 512);
@@ -1050,12 +1069,17 @@
 	set_blocksize(sb->s_dev, sb->s_blocksize);
 	ntfs_debug(DEBUG_OTHER, "set_blocksize\n");
 	/* Allocate an MFT record (MFT record can be smaller than a cluster). */
-	if (!(vol->mft = ntfs_malloc(max(vol->mft_record_size,
-							 vol->cluster_size))))
+	i = vol->cluster_size;
+	if (i < vol->mft_record_size)
+		i = vol->mft_record_size;
+	if (!(vol->mft = ntfs_malloc(i)))
 		goto ntfs_read_super_unl;
 
 	/* Read at least the MFT record for $Mft. */
-	for (i = 0; i < max(vol->mft_clusters_per_record, 1); i++) {
+	to_read = vol->mft_clusters_per_record;
+	if (to_read < 1)
+		to_read = 1;
+	for (i = 0; i < to_read; i++) {
 		if (!(bh = bread(sb->s_dev, vol->mft_lcn + i,
 							  vol->cluster_size))) {
 			ntfs_error("Could not read $Mft record 0\n");
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/inode.c linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/inode.c
--- linux-2.4.8-ac7-vanilla/fs/ntfs/inode.c	Tue Jul 24 00:23:58 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/inode.c	Sun Aug 19 23:59:53 2001
@@ -20,6 +20,7 @@
 #include "dir.h"
 #include "support.h"
 #include "util.h"
+#include <linux/ntfs_fs.h>
 #include <linux/smp_lock.h>
 
 typedef struct {
@@ -88,7 +89,7 @@
 	/* Try to allocate at least 0.1% of the remaining disk space for
 	 * inodes. If the disk is almost full, make sure at least one inode is
 	 * requested. */
-	int rcount, error, block, blockbits;
+	int rcount, error, mft_rec_size;
 	__s64 size;
 	ntfs_attribute *mdata, *bmp;
 	ntfs_u8 *buf;
@@ -97,35 +98,34 @@
 	mdata = ntfs_find_attr(vol->mft_ino, vol->at_data, 0);
 	if (!mdata)
 		return -EINVAL;
+	mft_rec_size = vol->mft_record_size;
 	/* First check whether there is uninitialized space. */
-	if (mdata->allocated < mdata->size + vol->mft_record_size) {
+	if (mdata->allocated < mdata->size + mft_rec_size) {
 		size = (__s64)ntfs_get_free_cluster_count(vol->bitmap) <<
-							vol->cluster_size_bits;
+				vol->cluster_size_bits >> 10;
 		/* On error, size will be negative. We can ignore this as we
 		 * will fall back to the minimal size allocation below. (AIA) */
-		block = vol->mft_record_size;
-		blockbits = vol->mft_record_size_bits;
-		size = max(size >> 10, mdata->size + vol->mft_record_size);
-		size = (__s64)((size + block - 1) >> blockbits) << blockbits;
-		/* Require this to be a single chunk. */
+		if (size < mdata->size + mft_rec_size)
+			size = mdata->size + mft_rec_size;
+		size += mft_rec_size - 1;
+		size &= ~(__s64)(mft_rec_size - 1);
 		error = ntfs_extend_attr(vol->mft_ino, mdata, &size,
-							   ALLOC_REQUIRE_SIZE);
+				ALLOC_REQUIRE_SIZE);
 		/* Try again, now we have the largest available fragment. */
 		if (error == -ENOSPC) {
 			/* Round down to multiple of mft record size. */
-			size = (__s64)(size >> vol->mft_record_size_bits) <<
-						vol->mft_record_size_bits;
+			size &= ~(__s64)(mft_rec_size - 1);
 			if (!size)
 				return -ENOSPC;
 			error = ntfs_extend_attr(vol->mft_ino, mdata, &size,
-							   ALLOC_REQUIRE_SIZE);
+					ALLOC_REQUIRE_SIZE);
 		}
 		if (error)
 			return error;
 	}
 	/* Even though we might have allocated more than needed, we initialize
 	 * only one record. */
-	mdata->size += vol->mft_record_size;
+	mdata->size += mft_rec_size;
 	/* Now extend the bitmap if necessary. */
 	rcount = mdata->size >> vol->mft_record_size_bits;
 	bmp = ntfs_find_attr(vol->mft_ino, vol->at_bitmap, 0);
@@ -144,27 +144,34 @@
 		io.param = buf;
 		io.size = 1;
 		error = ntfs_write_attr(vol->mft_ino, vol->at_bitmap, 0,
-					bmp->size - 1, &io);
+				bmp->size - 1, &io);
 		if (error)
 			return error;
 		if (io.size != 1)
 			return -EIO;
 	}
 	/* Now fill in the MFT header for the new block. */
-	buf = ntfs_calloc(vol->mft_record_size);
+	buf = ntfs_calloc(mft_rec_size);
 	if (!buf)
 		return -ENOMEM;
-	ntfs_fill_mft_header(buf, vol->mft_record_size, vol->sector_size, 0);
-	ntfs_insert_fixups(buf, vol->sector_size);
+	ntfs_fill_mft_header(buf, mft_rec_size, vol->sector_size, 0);
+	error = ntfs_insert_fixups(buf, mft_rec_size);
+	if (error) {
+		printk(KERN_ALERT "NTFS: ntfs_extend_mft() caught corrupt "
+				"mtf record ntfs record header. Refusing to "
+				"write corrupt data to disk. Unmount and run "
+				"chkdsk immediately!\n");
+		return -EIO;
+	}
 	io.param = buf;
-	io.size = vol->mft_record_size;
+	io.size = mft_rec_size;
 	io.fn_put = ntfs_put;
 	io.fn_get = ntfs_get;
 	error = ntfs_write_attr(vol->mft_ino, vol->at_data, 0,
 			(__s64)(rcount - 1) << vol->mft_record_size_bits, &io);
 	if (error)
 		return error;
-	if (io.size != vol->mft_record_size)
+	if (io.size != mft_rec_size)
 		return -EIO;
 	error = ntfs_update_inode(vol->mft_ino);
 	if (error)
@@ -394,11 +401,14 @@
 		io.fn_put = ntfs_put;
 		io.fn_get = 0;
 		io.param = buf + delta;
-		io.size = len = min(datasize, 1024 - delta);
+		len = 1024 - delta;
+		if (len > datasize)
+			len = datasize;
 		ntfs_debug(DEBUG_FILE2, "load_attributes %x: len = %i\n",
 						ino->i_number, len);
 		ntfs_debug(DEBUG_FILE2, "load_attributes %x: delta = %i\n",
 						ino->i_number, delta);
+		io.size = len;
 		if (ntfs_read_attr(ino, vol->at_attribute_list, 0, offset,
 				   &io))
 			ntfs_error("error in load_attributes\n");
@@ -472,7 +482,7 @@
 /* Check and fixup a MFT record. */
 int ntfs_check_mft_record(ntfs_volume *vol, char *record)
 {
-	return ntfs_fixup_record(vol, record, "FILE", vol->mft_record_size);
+	return ntfs_fixup_record(record, "FILE", vol->mft_record_size);
 }
 
 /* Return (in result) the value indicating the next available attribute 
@@ -540,8 +550,7 @@
 	ntfs_attribute *attr = ntfs_find_attr(ino, type, name);
 	if (!attr)
 		return 0;
-	return
-		attr->resident;
+	return attr->resident;
 }
 	
 /*
@@ -702,10 +711,10 @@
 				return error;
 			return ntfs_read_zero(dest, l - chunk);
 		}
-		if (attr->compressed)
+		if (attr->flags & ATTR_IS_COMPRESSED)
 			return ntfs_read_compressed(ino, attr, offset, dest);
 	} else {
-		if (attr->compressed)
+		if (attr->flags & ATTR_IS_COMPRESSED)
 			return ntfs_write_compressed(ino, attr, offset, dest);
 	}
 	vcn = 0;
@@ -720,7 +729,7 @@
 			"inode = 0x%x, rnum = %i, offset = 0x%Lx, vcn = , 0x%x"
 			"s_vcn = 0x%x\n", ino->i_number, rnum, offset, vcn,
 			s_vcn);
-		/*FIXME: Should extend runlist. */
+		/*FIXME: Should extend run list. */
 		return -EOPNOTSUPP;
 	}
 	copied = 0;
@@ -729,8 +738,9 @@
 		cluster = attr->d.r.runlist[rnum].cluster;
 		len = attr->d.r.runlist[rnum].len;
 		s_cluster = cluster + s_vcn - vcn;
-		chunk = min(((__s64)(vcn + len) << clustersizebits) - offset,
-									l);
+		chunk = ((__s64)(vcn + len) << clustersizebits) - offset;
+		if (chunk > l)
+			chunk = l;
 		dest->size = chunk;
 		error = ntfs_getput_clusters(ino->vol, s_cluster, offset -
 				((__s64)s_vcn << clustersizebits), dest);
@@ -787,7 +797,8 @@
 	
 	data = ntfs_find_attr(ino, ino->vol->at_data, 0);
 	/* It's hard to give an error code. */
-	if (!data || data->resident || data->compressed)
+	if (!data || data->resident || data->flags & (ATTR_IS_COMPRESSED |
+			ATTR_IS_ENCRYPTED))
 		return -1;
 	if (data->size <= (__s64)vcn << ino->vol->cluster_size_bits)
 		return -1;
@@ -845,15 +856,15 @@
 }
 
 /**
- * layout_runs - compress runlist into mapping pairs array
- * @attr:	attribute containing the runlist to compress
+ * layout_runs - compress run list into mapping pairs array
+ * @attr:	attribute containing the run list to compress
  * @rec:	destination buffer to hold the mapping pairs array
  * @offs:	current position in @rec (in/out variable)
  * @size:	size of the buffer @rec
  *
- * layout_runs walks the runlist in @attr, compresses it and writes it out the
+ * layout_runs walks the run list in @attr, compresses it and writes it out the
  * resulting mapping pairs array into @rec (up to a maximum of @size bytes are
- * written). On entry @offs is the offset in @rec at which to begin writting the
+ * written). On entry @offs is the offset in @rec at which to begin writing the
  * mapping pairs array. On exit, it contains the offset in @rec of the first
  * byte after the end of the mapping pairs array.
  */
@@ -997,14 +1008,14 @@
 		if (size < asize)
 			return -E2BIG;
 		NTFS_PUTU32(buf + 0x10, attr->size);
-		NTFS_PUTU16(buf + 0x16, attr->indexed);
+		NTFS_PUTU8(buf + 0x16, attr->indexed);
 		NTFS_PUTU16(buf + 0x14, hdrsize);
 		if (attr->size)
 			ntfs_memcpy(buf + hdrsize, attr->d.data, attr->size);
 	} else {
 		int error;
 
- 		if (attr->compressed)
+ 		if (attr->flags & ATTR_IS_COMPRESSED)
  			nameoff = 0x48;
  		else
  			nameoff = 0x40;
@@ -1029,7 +1040,7 @@
 		NTFS_PUTS64(buf + 0x28, attr->allocated);
 		NTFS_PUTS64(buf + 0x30, attr->size);
 		NTFS_PUTS64(buf + 0x38, attr->initialized);
-		if (attr->compressed)
+		if (attr->flags & ATTR_IS_COMPRESSED)
 			NTFS_PUTS64(buf + 0x40, attr->compsize);
 	}
 	NTFS_PUTU32(buf, attr->type);
@@ -1037,7 +1048,7 @@
 	NTFS_PUTU8(buf + 8, attr->resident ? 0 : 1);
 	NTFS_PUTU8(buf + 9, attr->namelen);
 	NTFS_PUTU16(buf + 0xa, nameoff);
-	NTFS_PUTU16(buf + 0xc, attr->compressed);
+	NTFS_PUTU16(buf + 0xc, attr->flags);
 	NTFS_PUTU16(buf + 0xe, attr->attrno);
 	if (attr->namelen)
 		ntfs_memcpy(buf + nameoff, attr->name, 2 * attr->namelen);
@@ -1151,14 +1162,24 @@
 	io.fn_get = ntfs_get;
 	io.fn_put = 0;
 	for (i = 0; i < store.count; i++) {
-		ntfs_insert_fixups(store.records[i].record,
-						ino->vol->sector_size);
+		error = ntfs_insert_fixups(store.records[i].record,
+				ino->vol->mft_record_size);
+		if (error) {
+			printk(KERN_ALERT "NTFS: ntfs_update_inode() caught "
+					"corrupt %s mtf record ntfs record "
+					"header. Refusing to write corrupt "
+					"data to disk. Unmount and run chkdsk "
+					"immediately!\n", i ? "extension":
+					"base");
+			deallocate_store(&store);
+			return -EIO;
+		}
 		io.param = store.records[i].record;
 		io.size = ino->vol->mft_record_size;
 		/* FIXME: Is this the right way? */
 		error = ntfs_write_attr(ino->vol->mft_ino, ino->vol->at_data,
-					0, (__s64)store.records[i].recno <<
-					ino->vol->mft_record_size_bits, &io);
+				0, (__s64)store.records[i].recno <<
+				ino->vol->mft_record_size_bits, &io);
 		if (error || io.size != ino->vol->mft_record_size) {
 			/* Big trouble, partially written file. */
 			ntfs_error("Please unmount: Write error in inode "
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/macros.h linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/macros.h
--- linux-2.4.8-ac7-vanilla/fs/ntfs/macros.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/macros.h	Sun Aug 19 13:04:15 2001
@@ -11,12 +11,6 @@
 #define NTFS_INO2VOL(ino)	(&((ino)->i_sb->u.ntfs_sb))
 #define NTFS_LINO2NINO(ino)     (&((ino)->u.ntfs_i))
 
-/* Classical min and max macros still missing in standard headers... */
-#ifndef min
-#define min(a,b)	((a) <= (b) ? (a) : (b))
-#define max(a,b)	((a) >= (b) ? (a) : (b))
-#endif
-
 #define IS_MAGIC(a,b)		(*(int*)(a) == *(int*)(b))
 #define IS_MFT_RECORD(a)	IS_MAGIC((a),"FILE")
 #define IS_INDEX_RECORD(a)	IS_MAGIC((a),"INDX")
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/struct.h linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/struct.h
--- linux-2.4.8-ac7-vanilla/fs/ntfs/struct.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/struct.h	Mon Aug 20 00:22:22 2001
@@ -4,6 +4,7 @@
  * Copyright (C) 1997 Régis Duchesne
  * Copyright (C) 2000-2001 Anton Altaparmakov (AIA)
  */
+#include <linux/ntfs_fs.h>
 
 /* Necessary forward definition. */
 struct ntfs_inode;
@@ -28,7 +29,8 @@
 	int namelen;
 	int attrno;
 	__s64 size, allocated, initialized, compsize;
-	int compressed, resident, indexed;
+	ATTR_FLAGS flags;
+	__u8 resident, indexed;
 	int cengine;
 	union {
 		void *data;             /* if resident */
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/super.c linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/super.c
--- linux-2.4.8-ac7-vanilla/fs/ntfs/super.c	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/super.c	Sun Aug 19 14:24:07 2001
@@ -7,16 +7,18 @@
  * Copyright (C) 2000-2001 Anton Altparmakov (AIA)
  */
 
+#include <linux/ntfs_fs.h>
+#include <linux/errno.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
 #include "ntfstypes.h"
 #include "struct.h"
 #include "super.h"
-
-#include <linux/errno.h>
-#include <linux/bitops.h>
 #include "macros.h"
 #include "inode.h"
 #include "support.h"
 #include "util.h"
+#include <linux/smp_lock.h>
 
 /* All important structures in NTFS use 2 consistency checks:
  * . a magic structure identifier (FILE, INDX, RSTR, RCRD...)
@@ -24,14 +26,18 @@
  *   structure's record should end with the word at offset <n> of the first
  *   sector, and if it is the case, must be replaced with the words following
  *   <n>. The value of <n> and the number of fixups is taken from the fields
- *   at the offsets 4 and 6.
+ *   at the offsets 4 and 6. Note that the sector size is defined as
+ *   NTFS_SECTOR_SIZE and not as the hardware sector size (this is concordant
+ *   with what the Windows NTFS driver does).
  *
- * This function perform these 2 checks, and _fails_ if :
+ * This function perform these 2 checks, and _fails_ if:
+ * . the input size is invalid
+ * . the fixup header is invalid
+ * . the size does not match the number of sectors
  * . the magic identifier is wrong
- * . the size is given and does not match the number of sectors
  * . a fixup is invalid
  */
-int ntfs_fixup_record(ntfs_volume *vol, char *record, char *magic, int size)
+int ntfs_fixup_record(char *record, char *magic, int size)
 {
 	int start, count, offset;
 	ntfs_u16 fixup;
@@ -39,19 +45,24 @@
 	if (!IS_MAGIC(record, magic))
 		return 0;
 	start = NTFS_GETU16(record + 4);
-	count = NTFS_GETU16(record + 6);
-	count--;
-	if(size && vol->sector_size * count != size)
+	count = NTFS_GETU16(record + 6) - 1;
+	if (size & (NTFS_SECTOR_SIZE - 1) || start & 1 ||
+			start + count * 2 > size || size >> 9 != count) {
+		if (size <= 0)
+			printk(KERN_ERR "NTFS: BUG: ntfs_fixup_record() got "
+					"zero size! Please report this to "
+					"linux-ntfs-dev@lists.sf.net\n");
 		return 0;
+	}
 	fixup = NTFS_GETU16(record + start);
 	start += 2;
-	offset = vol->sector_size - 2;
-	while (count--){
+	offset = NTFS_SECTOR_SIZE - 2;
+	while (count--) {
 		if (NTFS_GETU16(record + offset) != fixup)
 			return 0;
 		NTFS_PUTU16(record + offset, NTFS_GETU16(record + start));
 		start += 2;
-		offset += vol->sector_size;
+		offset += NTFS_SECTOR_SIZE;
 	}
 	return 1;
 }
@@ -63,8 +74,9 @@
 int ntfs_init_volume(ntfs_volume *vol, char *boot)
 {
 	int sectors_per_cluster_bits;
+	__s64 ll;
 
-	/* Historical default values, in case we don't load $AttrDef. */
+	/* System defined default values, in case we don't load $AttrDef. */
 	vol->at_standard_information = 0x10;
 	vol->at_attribute_list = 0x20;
 	vol->at_file_name = 0x30;
@@ -77,7 +89,7 @@
 	vol->at_index_allocation = 0xA0;
 	vol->at_bitmap = 0xB0;
 	vol->at_symlink = 0xC0;
-	/* Sector size */
+	/* Sector size. */
 	vol->sector_size = NTFS_GETU16(boot + 0xB);
 	ntfs_debug(DEBUG_FILE3, "ntfs_init_volume: vol->sector_size = 0x%x\n",
 				vol->sector_size);
@@ -127,22 +139,49 @@
 		vol->index_record_size = 1 << -vol->index_clusters_per_record;
 	vol->index_record_size_bits = ffs(vol->index_record_size) - 1;
 	ntfs_debug(DEBUG_FILE3, "ntfs_init_volume: vol->index_record_size = "
-				"0x%x\n", vol->index_record_size); 
+				"0x%x\n", vol->index_record_size);
 	ntfs_debug(DEBUG_FILE3, "ntfs_init_volume: vol->index_record_size_bits "
-				"= 0x%x\n", vol->index_record_size_bits); 
+				"= 0x%x\n", vol->index_record_size_bits);
 	/*
-	 * Check mft and mftmirr locations for 64-bit-ness. NOTE: This is a
-	 * crude check only as many other things could be out of bounds later
-	 * on, but it will catch at least some of the cases, since the mftmirr
-	 * is located in the middle of the volume so if the volume is very
-	 * large the mftmirr probably will be out of 32-bit bounds.
+	 * Get the size of the volume in clusters (ofs 0x28 is nr_sectors) and
+	 * check for 64-bit-ness. Windows currently only uses 32 bits to save
+	 * the clusters so we do the same as it is much faster on 32-bit CPUs.
 	 */
-	vol->mft_lcn = NTFS_GETS64(boot + 0x30);
-	if (vol->mft_lcn >= (__s64)1 << 31 ||
-	    NTFS_GETS64(boot + 0x38) >= (__s64)1 << 31) {
-		ntfs_error("Cannot handle 64-bit clusters yet.\n");
+	ll = NTFS_GETS64(boot + 0x28) >> sectors_per_cluster_bits;
+	if (ll >= (__s64)1 << 31) {
+		ntfs_error("Cannot handle 64-bit clusters. Please inform "
+				"linux-ntfs-dev@lists.sf.net that you got this "
+				"error.\n");
 		return -1;
 	}
+	vol->nr_clusters = (ntfs_cluster_t)ll;
+	ntfs_debug(DEBUG_FILE3, "ntfs_init_volume: vol->nr_clusters = 0x%x\n",
+			vol->nr_clusters);
+	/*
+	 * Determine MFT zone size. FIXME: Need to take into consideration
+	 * where the mft zone starts (at vol->mft_lcn) as vol->mft_zone_end
+	 * needs to be relative to that.
+	 */
+	vol->mft_zone_end = vol->nr_clusters;
+	switch (vol->mft_zone_multiplier) {  /* % of volume size in clusters */
+	case 4:
+		vol->mft_zone_end = vol->mft_zone_end >> 1;	/* 50%   */
+		break;
+	case 3:
+		vol->mft_zone_end = vol->mft_zone_end * 3 >> 3;	/* 37.5% */
+		break;
+	case 2:
+		vol->mft_zone_end = vol->mft_zone_end >> 2;	/* 25%   */
+		break;
+	/* case 1: */
+	default:
+		vol->mft_zone_end = vol->mft_zone_end >> 3;	/* 12.5% */
+		break;
+	}
+	ntfs_debug(DEBUG_FILE3, "ntfs_init_volume: vol->mft_zone_end = %x\n",
+			vol->mft_zone_end);
+	vol->mft_lcn = (ntfs_cluster_t)NTFS_GETS64(boot + 0x30);
+	vol->mft_mirr_lcn = (ntfs_cluster_t)NTFS_GETS64(boot + 0x38);
 	/* This will be initialized later. */
 	vol->upcase = 0;
 	vol->upcase_length = 0;
@@ -304,8 +343,7 @@
 	error = -ENOMEM;
 	ntfs_debug(DEBUG_BSD, "Going to load MFT\n");
 	if (!vol->mft_ino || (error = ntfs_init_inode(vol->mft_ino, vol,
-						      FILE_$Mft)))
-	{
+			FILE_$Mft))) {
 		ntfs_error("Problem loading MFT\n");
 		return error;
 	}
@@ -443,26 +481,48 @@
 	return clusters;
 }
 
-/* Insert the fixups for the record. The number and location of the fixes
- * is obtained from the record header */
-void ntfs_insert_fixups(unsigned char *rec, int secsize)
+/*
+ * Insert the fixups for the record. The number and location of the fixes
+ * is obtained from the record header but we double check with @rec_size and
+ * use that as the upper boundary, if necessary overwriting the count value in
+ * the record header.
+ *
+ * We return 0 on success or -1 if fixup header indicated the beginning of the
+ * update sequence array to be beyond the valid limit.
+ */
+int ntfs_insert_fixups(unsigned char *rec, int rec_size)
 {
-	int first = NTFS_GETU16(rec + 4);
-	int count = NTFS_GETU16(rec + 6);
+	int first;
+	int count;
 	int offset = -2;
-	ntfs_u16 fix = NTFS_GETU16(rec + first);
+	ntfs_u16 fix;
 	
-	fix++;
+	first = NTFS_GETU16(rec + 4);
+	count = (rec_size >> NTFS_SECTOR_BITS) + 1;
+	if (first + count * 2 > NTFS_SECTOR_SIZE - 2) {
+		printk(KERN_CRIT "NTFS: ntfs_insert_fixups() detected corrupt "
+				"NTFS record update sequence array position. - "
+				"Cannot hotfix.\n");
+		return -1;
+	}
+	if (count != NTFS_GETU16(rec + 6)) {
+		printk(KERN_ERR "NTFS: ntfs_insert_fixups() detected corrupt "
+				"NTFS record update sequence array size. - "
+				"Applying hotfix.\n");
+		NTFS_PUTU16(rec + 6, count);
+	}
+	fix = (NTFS_GETU16(rec + first) + 1) & 0xffff;
 	if (fix == 0xffff || !fix)
 		fix = 1;
 	NTFS_PUTU16(rec + first, fix);
 	count--;
 	while (count--) {
 		first += 2;
-		offset += secsize;
+		offset += NTFS_SECTOR_SIZE;
 		NTFS_PUTU16(rec + first, NTFS_GETU16(rec + offset));
 		NTFS_PUTU16(rec + offset, fix);
-	};
+	}
+	return 0;
 }
 
 /* Search the bitmap bits of l bytes for *cnt zero bits. Return the bit number
@@ -475,7 +535,7 @@
 	int bc = 0;
 	int bstart = 0, bstop = 0, found = 0;
 	int start, stop = 0, in = 0;
-	/* special case searching for a single block */
+	/* Special case searching for a single block. */
 	if (*cnt == 1) {
 		while (l && *bits == 0xFF) {
 			bits++;
@@ -501,7 +561,7 @@
 		if (in) {
 			if ((c & 1) == 0)
 				stop++;
-			else { /* end of sequence of zeroes */
+			else { /* End of sequence of zeroes. */
 				in = 0;
 				if (!found || bstop-bstart < stop-start) {
 					bstop = stop; bstart = start;
@@ -514,7 +574,7 @@
 		} else {
 			if (c & 1)
 				start++;
-			else { /*start of sequence*/
+			else { /* Start of sequence. */
 				in = 1;
 				stop = start + 1;
 			}
@@ -523,7 +583,9 @@
 		c >>= 1;
 	}
 	if (in && (!found || bstop - bstart < stop - start)) {
-		bstop = stop; bstart = start; found = 1;
+		bstop = stop;
+		bstart = start;
+		found = 1;
 	}
 	if (!found)
 		return -ENOSPC;
@@ -541,21 +603,21 @@
 
 	io.fn_put = ntfs_put;
 	io.fn_get = ntfs_get;
-	bsize = (cnt + (loc & 7) + 7) >> 3; /* round up to multiple of 8*/
+	bsize = (cnt + (loc & 7) + 7) >> 3; /* Round up to multiple of 8. */
 	bits = ntfs_malloc(bsize);
 	if (!bits)
 		return -ENOMEM;
 	io.param = bits;
 	io.size = bsize;
 	error = ntfs_read_attr(bitmap, bitmap->vol->at_data, 0, loc >> 3, &io);
-	if (error || io.size != bsize){
+	if (error || io.size != bsize) {
 		ntfs_free(bits);
 		return error ? error : -EIO;
 	}
 	/* Now set the bits. */
 	it = bits;
 	locit = loc;
-	while (locit % 8 && cnt) { /* process first byte */
+	while (locit % 8 && cnt) { /* Process first byte. */
 		if (bit)
 			*it |= 1 << (locit % 8);
 		else
@@ -565,13 +627,13 @@
 		if (locit % 8 == 0)
 			it++;
 	}
-	while (cnt > 8) { /*process full bytes */
+	while (cnt > 8) { /* Process full bytes. */
 		*it = bit ? 0xFF : 0;
 		cnt -= 8;
 		locit += 8;
 		it++;
 	}
-	while (cnt) { /*process last byte */
+	while (cnt) { /* Process last byte. */
 		if (bit)
 			*it |= 1 << (locit % 8);
 		else
@@ -579,7 +641,7 @@
 		cnt--;
 		locit++;
 	}
-	/* reset to start */
+	/* Reset to start. */
 	io.param = bits;
 	io.size = bsize;
 	error = ntfs_write_attr(bitmap, bitmap->vol->at_data, 0, loc >> 3, &io);
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/super.h linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/super.h
--- linux-2.4.8-ac7-vanilla/fs/ntfs/super.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/super.h	Sun Aug 19 13:04:15 2001
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 1995-1997 Martin von Löwis
  * Copyright (C) 1996-1997 Régis Duchesne
+ * Copyright (c) 2001 Anton Altaparmakov
  */
 
 #define ALLOC_REQUIRE_LOCATION 1
@@ -18,13 +19,13 @@
 
 int ntfs_release_volume(ntfs_volume *vol);
 
-void ntfs_insert_fixups(unsigned char *rec, int secsize);
+int ntfs_insert_fixups(unsigned char *rec, int rec_size);
 
-int ntfs_fixup_record(ntfs_volume *vol, char *record, char *magic, int size);
+int ntfs_fixup_record(char *record, char *magic, int size);
 
 int ntfs_allocate_clusters(ntfs_volume *vol, ntfs_cluster_t *location,
-			   int *count, int flags);
+		int *count, int flags);
 
 int ntfs_deallocate_clusters(ntfs_volume *vol, ntfs_cluster_t location,
-			     int count);
+		int count);
 
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/support.c linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/support.c
--- linux-2.4.8-ac7-vanilla/fs/ntfs/support.c	Sun Aug 19 12:59:31 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/support.c	Sun Aug 19 13:04:15 2001
@@ -17,10 +17,7 @@
 #include "util.h"
 #include "inode.h"
 #include "macros.h"
-
-#ifndef NLS_MAX_CHARSET_SIZE
 #include <linux/nls.h>
-#endif
 
 static char print_buf[1024];
 
@@ -108,8 +105,8 @@
         va_list ap;
 
         va_start(ap, fmt);
-        strcpy(print_buf, KERN_ERR);
-        vsprintf(print_buf + 3, fmt, ap);
+        strcpy(print_buf, KERN_ERR "NTFS: ");
+        vsprintf(print_buf + 9, fmt, ap);
         printk(print_buf);
         va_end(ap);
 }
@@ -162,8 +159,8 @@
 	return 0;
 }
 
-int ntfs_getput_clusters(ntfs_volume *vol, int cluster,	ntfs_size_t start_offs,
-			 ntfs_io *buf)
+int ntfs_getput_clusters(ntfs_volume *vol, int cluster, ntfs_size_t start_offs,
+		ntfs_io *buf)
 {
 	struct super_block *sb = NTFS_SB(vol);
 	struct buffer_head *bh;
@@ -173,6 +170,7 @@
 
 	ntfs_debug(DEBUG_OTHER, "%s_clusters %d %d %d\n", 
 		   buf->do_read ? "get" : "put", cluster, start_offs, length);
+	to_copy = vol->cluster_size - start_offs;
 	while (length) {
 		if (!(bh = bread(sb->s_dev, cluster, vol->cluster_size))) {
 			ntfs_debug(DEBUG_OTHER, "%s failed\n",
@@ -180,7 +178,8 @@
 			error = -EIO;
 			goto error_ret;
 		}
-		to_copy = min(vol->cluster_size - start_offs, length);
+		if (to_copy > length)
+			to_copy = length;
 		lock_buffer(bh);
 		if (buf->do_read) {
 			buf->fn_put(buf, bh->b_data + start_offs, to_copy);
@@ -211,10 +210,11 @@
 				}
 			}
 		}
+		brelse(bh);
 		length -= to_copy;
 		start_offs = 0;
+		to_copy = vol->cluster_size;
 		cluster++;
-		brelse(bh);
 	}
 error_ret:
 	return error;
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/unistr.c linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/unistr.c
--- linux-2.4.8-ac7-vanilla/fs/ntfs/unistr.c	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/unistr.c	Sun Aug 19 13:04:15 2001
@@ -1,6 +1,4 @@
 /*
- * $Id: unistr.c,v 1.4 2001/04/08 03:02:55 antona Exp $
- *
  * unistr.c - Unicode string handling. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2000,2001 Anton Altaparmakov.
@@ -93,11 +91,13 @@
 		       wchar_t *name2, __u32 name2_len,
 		       int ic, int err_val)
 {
-	__u32 cnt;
+	__u32 cnt, min_len;
 	wchar_t c1, c2;
 
-	for (cnt = 0; cnt < min(name1_len, name2_len); ++cnt)
-	{
+	min_len = name1_len;
+	if (min_len > name2_len)
+		min_len = name2_len;
+	for (cnt = 0; cnt < min_len; ++cnt) {
 		c1 = le16_to_cpu(*name1++);
 		c2 = le16_to_cpu(*name2++);
 		if (ic) {
@@ -106,7 +106,7 @@
 			if (c2 < upcase_len)
 				c2 = le16_to_cpu(upcase[c2]);
 		}
-		if (c1 < 64 && legal_ansi_char_array[c1] & 8);
+		if (c1 < 64 && legal_ansi_char_array[c1] & 8)
 			return err_val;
 		if (c1 < c2)
 			return -1;
diff -urN linux-2.4.8-ac7-vanilla/fs/ntfs/unistr.h linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/unistr.h
--- linux-2.4.8-ac7-vanilla/fs/ntfs/unistr.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/fs/ntfs/unistr.h	Mon Aug 20 00:10:36 2001
@@ -1,6 +1,4 @@
 /*
- * $Id: unistr.h,v 1.5 2001/04/11 11:49:16 antona Exp $
- *
  * unistr.h - Exports for unicode string handling. Part of the Linux-NTFS
  *	      project.
  *
diff -urN linux-2.4.8-ac7-vanilla/include/linux/ntfs_fs.h linux-2.4.8-ac7-ntfs-1.1.17/include/linux/ntfs_fs.h
--- linux-2.4.8-ac7-vanilla/include/linux/ntfs_fs.h	Mon Mar 13 20:35:39 2000
+++ linux-2.4.8-ac7-ntfs-1.1.17/include/linux/ntfs_fs.h	Mon Aug 20 00:22:05 2001
@@ -1,3 +1,21 @@
 #ifndef _LINUX_NTFS_FS_H
 #define _LINUX_NTFS_FS_H
+
+#include <asm/byteorder.h>
+
+#define NTFS_SECTOR_BITS 9
+#define NTFS_SECTOR_SIZE 512
+
+/*
+ * Attribute flags (16-bit).
+ */
+typedef enum {
+	ATTR_IS_COMPRESSED      = cpu_to_le16(0x0001),
+	ATTR_COMPRESSION_MASK   = cpu_to_le16(0x00ff),  /* Compression method
+							 * mask. Also, first
+							 * illegal value. */
+	ATTR_IS_ENCRYPTED       = cpu_to_le16(0x4000),
+	ATTR_IS_SPARSE          = cpu_to_le16(0x8000),
+} __attribute__ ((__packed__)) ATTR_FLAGS;
+
 #endif
diff -urN linux-2.4.8-ac7-vanilla/include/linux/ntfs_fs_i.h linux-2.4.8-ac7-ntfs-1.1.17/include/linux/ntfs_fs_i.h
--- linux-2.4.8-ac7-vanilla/include/linux/ntfs_fs_i.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/include/linux/ntfs_fs_i.h	Mon Aug 20 00:05:04 2001
@@ -1,6 +1,8 @@
 #ifndef _LINUX_NTFS_FS_I_H
 #define _LINUX_NTFS_FS_I_H
 
+#include <linux/types.h>
+
 /* Forward declarations, to keep number of mutual includes low */
 struct ntfs_attribute;
 struct ntfs_sb_info;
diff -urN linux-2.4.8-ac7-vanilla/include/linux/ntfs_fs_sb.h linux-2.4.8-ac7-ntfs-1.1.17/include/linux/ntfs_fs_sb.h
--- linux-2.4.8-ac7-vanilla/include/linux/ntfs_fs_sb.h	Sun Aug 19 12:59:38 2001
+++ linux-2.4.8-ac7-ntfs-1.1.17/include/linux/ntfs_fs_sb.h	Mon Aug 20 00:05:04 2001
@@ -1,7 +1,7 @@
 #ifndef _LINUX_NTFS_FS_SB_H
 #define _LINUX_NTFS_FS_SB_H
 
-typedef __s64 LCN;
+#include <linux/ntfs_fs_i.h>
 
 struct ntfs_sb_info{
 	/* Configuration provided by user at mount time. */
@@ -10,6 +10,8 @@
 	ntmode_t umask;
 	void *nls_map;
 	unsigned int ngt;
+	char mft_zone_multiplier;
+	ntfs_cluster_t mft_zone_end;
 	/* Configuration provided by user with the ntfstools.
 	 * FIXME: This is no longer possible. What is this good for? (AIA) */
 	ntfs_size_t partition_bias;	/* For access to underlying device. */
@@ -36,7 +38,9 @@
 	int index_clusters_per_record;
 	int index_record_size;
 	int index_record_size_bits;
-	LCN mft_lcn;
+	ntfs_cluster_t nr_clusters;
+	ntfs_cluster_t mft_lcn;
+	ntfs_cluster_t mft_mirr_lcn;
 	/* Data read from special files. */
 	unsigned char *mft;
 	unsigned short *upcase;
