Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUFHL4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUFHL4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUFHLxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:53:49 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:63167 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265112AbUFHLqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:46:49 -0400
Date: Tue, 8 Jun 2004 12:46:48 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: Re: [2.6.7-BK] NTFS 2.1.13 patch 8/8
In-Reply-To: <Pine.SOL.4.58.0406081246070.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081246340.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244580.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245130.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245290.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245500.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081246070.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 8 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/06/08 1.1750)
   NTFS: 2.1.13 - Enable overwriting of resident files and housekeeping of system files.
   - Mark the volume dirty when (re)mounting read-write and mark it clean
     when unmounting or remounting read-only.  If any volume errors are
     found, the volume is left marked dirty to force chkdsk to run.
   - Add code to set the NT4 compatibility flag when (re)mounting
     read-write for newer NTFS versions but leave it commented out for now
     since we do not make any modifications that are NTFS 1.2 specific yet
     and since setting this flag breaks Captive-NTFS which is not nice.
     This code must be enabled once we start writing NTFS 1.2 specific
     changes otherwise Windows NTFS driver might crash / cause corruption.
   - Fix a silly bug that caused a deadlock in ntfs_mft_writepage().
     For inode 0, i.e. $MFT itself, we cannot use ilookup5() from
     there because the inode is already locked by the kernel
     (fs/fs-writeback.c::__sync_single_inode()) and ilookup5() waits
     until the inode is unlocked before returning it and it never gets
     unlocked because ntfs_mft_writepage() never returns.  )-:
     Fortunately, we have inode 0 pinned in icache for the duration
     of the mount so we can access it directly.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-06-08 12:22:24 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-06-08 12:22:24 +01:00
@@ -273,6 +273,19 @@

 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.

+2.1.13:
+	- Implement writing of inodes (access time updates are not implemented
+	  yet so mounting with -o noatime,nodiratime is enforced).
+	- Enable writing out of resident files so you can now overwrite any
+	  uncompressed, unencrypted, nonsparse file as long as you do not
+	  change the file size.
+	- Add housekeeping of ntfs system files so that ntfsfix no longer needs
+	  to be run after writing to an NTFS volume.
+	  NOTE:  This still leaves quota tracking and user space journalling on
+	  the side but they should not cause data corruption.  In the worst
+	  case the charged quotas will be out of date ($Quota) and some
+	  userspace applications might get confused due to the out of date
+	  userspace journal ($UsnJrnl).
 2.1.12:
 	- Fix the second fix to the decompression engine from the 2.1.9 release
 	  and some further internals cleanups.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:24 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:24 +01:00
@@ -1,4 +1,4 @@
-ToDo:
+ToDo/Notes:
 	- Find and fix bugs.
 	- Either invalidate quotas or update the quota charges on NTFS 3.x
 	  volumes with quota tracking enabled ($Quota).
@@ -32,8 +32,10 @@
 	  inode having been discarded already.  Whether this can actually ever
 	  happen is unclear however so it is worth waiting until someone hits
 	  the problem.
+	- Enable the code for setting the NT4 compatibility flag when we start
+	  making NTFS 1.2 specific modifications.

-2.1.13 - WIP.
+2.1.13 - Enable overwriting of resident files and housekeeping of system files.

 	- Implement writing of mft records (fs/ntfs/mft.[hc]), which includes
 	  keeping the mft mirror in sync with the mft when mirrored mft records
@@ -70,6 +72,15 @@
 	  are present and ask the user to email us if they see this happening.
 	- Add functions ntfs_{clear,set}_volume_flags(), to modify the volume
 	  information flags (fs/ntfs/super.c).
+	- Mark the volume dirty when (re)mounting read-write and mark it clean
+	  when unmounting or remounting read-only.  If any volume errors are
+	  found, the volume is left marked dirty to force chkdsk to run.
+	- Add code to set the NT4 compatibility flag when (re)mounting
+	  read-write for newer NTFS versions but leave it commented out for now
+	  since we do not make any modifications that are NTFS 1.2 specific yet
+	  and since setting this flag breaks Captive-NTFS which is not nice.
+	  This code must be enabled once we start writing NTFS 1.2 specific
+	  changes otherwise Windows NTFS driver might crash / cause corruption.

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-06-08 12:22:24 +01:00
+++ b/fs/ntfs/Makefile	2004-06-08 12:22:24 +01:00
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.13-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.13\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-06-08 12:22:24 +01:00
+++ b/fs/ntfs/mft.c	2004-06-08 12:22:24 +01:00
@@ -933,44 +933,77 @@
 		na.name = NULL;
 		na.name_len = 0;
 		na.type = AT_UNUSED;
-
 		/*
 		 * Check if the inode corresponding to this mft record is in
 		 * the VFS inode cache and obtain a reference to it if it is.
 		 */
-		vi = ilookup5(sb, mft_no, (test_t)ntfs_test_inode, &na);
+		ntfs_debug("Looking for inode 0x%lx in icache.", mft_no);
+		/*
+		 * For inode 0, i.e. $MFT itself, we cannot use ilookup5() from
+		 * here or we deadlock because the inode is already locked by
+		 * the kernel (fs/fs-writeback.c::__sync_single_inode()) and
+		 * ilookup5() waits until the inode is unlocked before
+		 * returning it and it never gets unlocked because
+		 * ntfs_mft_writepage() never returns.  )-:  Fortunately, we
+		 * have inode 0 pinned in icache for the duration of the mount
+		 * so we can access it directly.
+		 */
+		if (!mft_no) {
+			/* Balance the below iput(). */
+			vi = igrab(mft_vi);
+			BUG_ON(vi != mft_vi);
+		} else
+			vi = ilookup5(sb, mft_no, (test_t)ntfs_test_inode, &na);
 		if (vi) {
+			ntfs_debug("Inode 0x%lx is in icache.", mft_no);
 			/* The inode is in icache.  Check if it is dirty. */
 			ni = NTFS_I(vi);
 			if (!NInoDirty(ni)) {
 				/* The inode is not dirty, skip this record. */
+				ntfs_debug("Inode 0x%lx is not dirty, "
+						"continuing search.", mft_no);
 				iput(vi);
 				continue;
 			}
+			ntfs_debug("Inode 0x%lx is dirty, aborting search.",
+					mft_no);
 			/* The inode is dirty, no need to search further. */
 			iput(vi);
 			is_dirty = TRUE;
 			break;
 		}
+		ntfs_debug("Inode 0x%lx is not in icache.", mft_no);
 		/* The inode is not in icache. */
 		/* Skip the record if it is not a mft record (type "FILE"). */
-		if (!ntfs_is_mft_recordp(maddr))
+		if (!ntfs_is_mft_recordp(maddr)) {
+			ntfs_debug("Mft record 0x%lx is not a FILE record, "
+					"continuing search.", mft_no);
 			continue;
+		}
 		m = (MFT_RECORD*)maddr;
 		/*
 		 * Skip the mft record if it is not in use.  FIXME:  What about
 		 * deleted/deallocated (extent) inodes?  (AIA)
 		 */
-		if (!(m->flags & MFT_RECORD_IN_USE))
+		if (!(m->flags & MFT_RECORD_IN_USE)) {
+			ntfs_debug("Mft record 0x%lx is not in use, "
+					"continuing search.", mft_no);
 			continue;
+		}
 		/* Skip the mft record if it is a base inode. */
-		if (!m->base_mft_record)
+		if (!m->base_mft_record) {
+			ntfs_debug("Mft record 0x%lx is a base record, "
+					"continuing search.", mft_no);
 			continue;
+		}
 		/*
 		 * This is an extent mft record.  Check if the inode
 		 * corresponding to its base mft record is in icache.
 		 */
 		na.mft_no = MREF_LE(m->base_mft_record);
+		ntfs_debug("Mft record 0x%lx is an extent record.  Looking "
+				"for base inode 0x%lx in icache.", mft_no,
+				na.mft_no);
 		vi = ilookup5(sb, na.mft_no, (test_t)ntfs_test_inode,
 				&na);
 		if (!vi) {
@@ -978,8 +1011,11 @@
 			 * The base inode is not in icache.  Skip this extent
 			 * mft record.
 			 */
+			ntfs_debug("Base inode 0x%lx is not in icache, "
+					"continuing search.", na.mft_no);
 			continue;
 		}
+		ntfs_debug("Base inode 0x%lx is in icache.", na.mft_no);
 		/*
 		 * The base inode is in icache.  Check if it has the extent
 		 * inode corresponding to this extent mft record attached.
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-06-08 12:22:24 +01:00
+++ b/fs/ntfs/super.c	2004-06-08 12:22:24 +01:00
@@ -411,27 +411,63 @@
 	 * For the read-write compiled driver, if we are remounting read-write,
 	 * make sure there are no volume errors and that no unsupported volume
 	 * flags are set.  Also, empty the logfile journal as it would become
-	 * stale as soon as something is written to the volume.
+	 * stale as soon as something is written to the volume and mark the
+	 * volume dirty so that chkdsk is run if the volume is not umounted
+	 * cleanly.
+	 *
+	 * When remounting read-only, mark the volume clean if no volume errors
+	 * have occured.
 	 */
 	if ((sb->s_flags & MS_RDONLY) && !(*flags & MS_RDONLY)) {
 		static const char *es = ".  Cannot remount read-write.";

+		/* Remounting read-write. */
 		if (NVolErrors(vol)) {
 			ntfs_error(sb, "Volume has errors and is read-only%s",
 					es);
 			return -EROFS;
 		}
+		if (vol->vol_flags & VOLUME_IS_DIRTY) {
+			ntfs_error(sb, "Volume is dirty and read-only%s", es);
+			return -EROFS;
+		}
 		if (vol->vol_flags & VOLUME_MUST_MOUNT_RO_MASK) {
 			ntfs_error(sb, "Volume has unsupported flags set and "
 					"is read-only%s", es);
 			return -EROFS;
 		}
+		if (ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY)) {
+			ntfs_error(sb, "Failed to set dirty bit in volume "
+					"information flags%s", es);
+			return -EROFS;
+		}
+#if 0
+		// TODO: Enable this code once we start modifying anything that
+		//	 is different between NTFS 1.2 and 3.x...
+		/* Set NT4 compatibility flag on newer NTFS version volumes. */
+		if ((vol->major_ver > 1)) {
+			if (ntfs_set_volume_flags(vol, VOLUME_MOUNTED_ON_NT4)) {
+				ntfs_error(sb, "Failed to set NT4 "
+						"compatibility flag%s", es);
+				NVolSetErrors(vol);
+				return -EROFS;
+			}
+		}
+#endif
 		if (!ntfs_empty_logfile(vol->logfile_ino)) {
 			ntfs_error(sb, "Failed to empty journal $LogFile%s",
 					es);
 			NVolSetErrors(vol);
 			return -EROFS;
 		}
+	} else if (!(sb->s_flags & MS_RDONLY) && (*flags & MS_RDONLY)) {
+		/* Remounting read-only. */
+		if (!NVolErrors(vol)) {
+			if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
+				ntfs_warning(sb, "Failed to clear dirty bit "
+						"in volume information "
+						"flags.  Run chkdsk.");
+		}
 	}
 	// TODO:  For now we enforce no atime and dir atime updates as they are
 	// not implemented.
@@ -1232,7 +1268,7 @@
 			le32_to_cpu(ctx->attr->data.resident.value_length) >
 			(u8*)ctx->attr + le32_to_cpu(ctx->attr->length))
 		goto err_put_vol;
-	/* Setup volume flags and version. */
+	/* Copy the volume flags and version to the ntfs_volume structure. */
 	vol->vol_flags = vi->flags;
 	vol->major_ver = vi->major_ver;
 	vol->minor_ver = vi->minor_ver;
@@ -1243,9 +1279,12 @@
 #ifdef NTFS_RW
 	/* Make sure that no unsupported volume flags are set. */
 	if (vol->vol_flags & VOLUME_MUST_MOUNT_RO_MASK) {
-		static const char *es1 = "Volume has unsupported flags set";
+		static const char *es1a = "Volume is dirty";
+		static const char *es1b = "Volume has unsupported flags set";
 		static const char *es2 = ".  Run chkdsk and mount in Windows.";
-
+		const char *es1;
+
+		es1 = vol->vol_flags & VOLUME_IS_DIRTY ? es1a : es1b;
 		/* If a read-write mount, convert it to a read-only mount. */
 		if (!(sb->s_flags & MS_RDONLY)) {
 			if (!(vol->on_errors & (ON_ERRORS_REMOUNT_RO |
@@ -1272,10 +1311,12 @@
 	 */
 	if (!load_and_check_logfile(vol) ||
 			!ntfs_is_logfile_clean(vol->logfile_ino)) {
-		static const char *es1 = "Failed to load $LogFile";
-		static const char *es2 = "$LogFile is not clean";
-		static const char *es3 = ".  Mount in Windows.";
+		static const char *es1a = "Failed to load $LogFile";
+		static const char *es1b = "$LogFile is not clean";
+		static const char *es2 = ".  Mount in Windows.";
+		const char *es1;

+		es1 = !vol->logfile_ino ? es1a : es1b;
 		/* If a read-write mount, convert it to a read-only mount. */
 		if (!(sb->s_flags & MS_RDONLY)) {
 			if (!(vol->on_errors & (ON_ERRORS_REMOUNT_RO |
@@ -1283,21 +1324,66 @@
 				ntfs_error(sb, "%s and neither on_errors="
 						"continue nor on_errors="
 						"remount-ro was specified%s",
-						!vol->logfile_ino ? es1 : es2,
-						es3);
+						es1, es2);
 				goto iput_logfile_err_out;
 			}
 			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
-			ntfs_error(sb, "%s.  Mounting read-only%s",
-					!vol->logfile_ino ? es1 : es2, es3);
+			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		} else
 			ntfs_warning(sb, "%s.  Will not be able to remount "
-					"read-write%s",
-					!vol->logfile_ino ? es1 : es2, es3);
+					"read-write%s", es1, es2);
 		/* This will prevent a read-write remount. */
 		NVolSetErrors(vol);
-	/* If a read-write mount, empty the logfile. */
-	} else if (!(sb->s_flags & MS_RDONLY) &&
+	}
+	/* If (still) a read-write mount, mark the volume dirty. */
+	if (!(sb->s_flags & MS_RDONLY) &&
+			ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY)) {
+		static const char *es1 = "Failed to set dirty bit in volume "
+				"information flags";
+		static const char *es2 = ".  Run chkdsk.";
+
+		/* Convert to a read-only mount. */
+		if (!(vol->on_errors & (ON_ERRORS_REMOUNT_RO |
+				ON_ERRORS_CONTINUE))) {
+			ntfs_error(sb, "%s and neither on_errors=continue nor "
+					"on_errors=remount-ro was specified%s",
+					es1, es2);
+			goto iput_logfile_err_out;
+		}
+		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
+		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+		/*
+		 * Do not set NVolErrors() because ntfs_remount() might manage
+		 * to set the dirty flag in which case all would be well.
+		 */
+	}
+#if 0
+	// TODO: Enable this code once we start modifying anything that is
+	//	 different between NTFS 1.2 and 3.x...
+	/*
+	 * If (still) a read-write mount, set the NT4 compatibility flag on
+	 * newer NTFS version volumes.
+	 */
+	if (!(sb->s_flags & MS_RDONLY) && (vol->major_ver > 1) &&
+			ntfs_set_volume_flags(vol, VOLUME_MOUNTED_ON_NT4)) {
+		static const char *es1 = "Failed to set NT4 compatibility flag";
+		static const char *es2 = ".  Run chkdsk.";
+
+		/* Convert to a read-only mount. */
+		if (!(vol->on_errors & (ON_ERRORS_REMOUNT_RO |
+				ON_ERRORS_CONTINUE))) {
+			ntfs_error(sb, "%s and neither on_errors=continue nor "
+					"on_errors=remount-ro was specified%s",
+					es1, es2);
+			goto iput_logfile_err_out;
+		}
+		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
+		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+		NVolSetErrors(vol);
+	}
+#endif
+	/* If (still) a read-write mount, empty the logfile. */
+	if (!(sb->s_flags & MS_RDONLY) &&
 			!ntfs_empty_logfile(vol->logfile_ino)) {
 		static const char *es1 = "Failed to empty $LogFile";
 		static const char *es2 = ".  Mount in Windows.";
@@ -1310,12 +1396,11 @@
 					es1, es2);
 			goto iput_logfile_err_out;
 		}
-		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
 		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		/* This will prevent a read-write remount. */
+		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
 		NVolSetErrors(vol);
 	}
-#endif
+#endif /* NTFS_RW */
 	/*
 	 * Get the inode for the attribute definitions file and parse the
 	 * attribute definitions.
@@ -1390,19 +1475,18 @@

 /**
  * ntfs_put_super - called by the vfs to unmount a volume
- * @vfs_sb:	vfs superblock of volume to unmount
+ * @sb:		vfs superblock of volume to unmount
  *
  * ntfs_put_super() is called by the VFS (from fs/super.c::do_umount()) when
  * the volume is being unmounted (umount system call has been invoked) and it
  * releases all inodes and memory belonging to the NTFS specific part of the
  * super block.
  */
-static void ntfs_put_super(struct super_block *vfs_sb)
+static void ntfs_put_super(struct super_block *sb)
 {
-	ntfs_volume *vol = NTFS_SB(vfs_sb);
+	ntfs_volume *vol = NTFS_SB(sb);

 	ntfs_debug("Entering.");
-
 #ifdef NTFS_RW
 	/*
 	 * Commit all inodes while they are still open in case some of them
@@ -1431,8 +1515,28 @@

 	if (vol->mftmirr_ino)
 		ntfs_commit_inode(vol->mftmirr_ino);
-
 	ntfs_commit_inode(vol->mft_ino);
+
+	/*
+	 * If a read-write mount and no volume errors have occured, mark the
+	 * volume clean.  Also, re-commit all affected inodes.
+	 */
+	if (!(sb->s_flags & MS_RDONLY)) {
+		if (!NVolErrors(vol)) {
+			if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
+				ntfs_warning(sb, "Failed to clear dirty bit "
+						"in volume information "
+						"flags.  Run chkdsk.");
+			ntfs_commit_inode(vol->vol_ino);
+			ntfs_commit_inode(vol->root_ino);
+			if (vol->mftmirr_ino)
+				ntfs_commit_inode(vol->mftmirr_ino);
+			ntfs_commit_inode(vol->mft_ino);
+		} else {
+			ntfs_warning(sb, "Volume has errors.  Leaving volume "
+					"marked dirty.  Run chkdsk.");
+		}
+	}
 #endif /* NTFS_RW */

 	iput(vol->vol_ino);
@@ -1464,7 +1568,6 @@
 		iput(vol->logfile_ino);
 		vol->logfile_ino = NULL;
 	}
-
 	if (vol->mftmirr_ino) {
 		/* Re-commit the mft mirror and mft just in case. */
 		ntfs_commit_inode(vol->mftmirr_ino);
@@ -1481,26 +1584,27 @@
 	 */
 	ntfs_commit_inode(vol->mft_ino);
 	write_inode_now(vol->mft_ino, 1);
-	if (!list_empty(&vfs_sb->s_dirty)) {
-		char *s1, *s2;
+	if (!list_empty(&sb->s_dirty)) {
+		const char *s1, *s2;

 		down(&vol->mft_ino->i_sem);
 		truncate_inode_pages(vol->mft_ino->i_mapping, 0);
 		up(&vol->mft_ino->i_sem);
 		write_inode_now(vol->mft_ino, 1);
-		if (!list_empty(&vfs_sb->s_dirty)) {
-			static char *_s1 = "inodes";
-			static char *_s2 = "";
+		if (!list_empty(&sb->s_dirty)) {
+			static const char *_s1 = "inodes";
+			static const char *_s2 = "";
 			s1 = _s1;
 			s2 = _s2;
 		} else {
-			static char *_s1 = "mft pages";
-			static char *_s2 = "They have been thrown away.  ";
+			static const char *_s1 = "mft pages";
+			static const char *_s2 = "They have been thrown "
+					"away.  ";
 			s1 = _s1;
 			s2 = _s2;
 		}
-		ntfs_error(vfs_sb, "Dirty %s found at umount time.  %s"
-				"You should run chkdsk.  Please email "
+		ntfs_error(sb, "Dirty %s found at umount time.  %sYou should "
+				"run chkdsk.  Please email "
 				"linux-ntfs-dev@lists.sourceforge.net and say "
 				"that you saw this message.  Thank you.", s1,
 				s2);
@@ -1513,7 +1617,7 @@
 	vol->upcase_len = 0;
 	/*
 	 * Decrease the number of mounts and destroy the global default upcase
-	 * table if necessary. Also decrease the number of upcase users if we
+	 * table if necessary.  Also decrease the number of upcase users if we
 	 * are a user.
 	 */
 	down(&ntfs_lock);
@@ -1537,7 +1641,7 @@
 		unload_nls(vol->nls_map);
 		vol->nls_map = NULL;
 	}
-	vfs_sb->s_fs_info = NULL;
+	sb->s_fs_info = NULL;
 	kfree(vol);
 	return;
 }
