Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSJOWtK>; Tue, 15 Oct 2002 18:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265005AbSJOWZN>; Tue, 15 Oct 2002 18:25:13 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:41909 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S264885AbSJOWPf>;
	Tue, 15 Oct 2002 18:15:35 -0400
To: torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add default mount options support to ext2/3
From: tytso@mit.edu
Message-Id: <E181a46-0006O4-00@snap.thunk.org>
Date: Tue, 15 Oct 2002 18:21:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds support for default mount options to be stored in the
superblock, so they don't have to be specified on the mount command line
(or in /etc/fstab).  While I was in the code, I also cleaned up the
handling of how mount options are processed in the ext2 and ext3
filesystems.  

Most mount options are now processed *after* the superblock has been
read in.  This allows for a much cleaner handling of those default mount
option parameters that were already stored in the superblock: the
resuid, resgid, and s_errors fields were handled using some fairly gross
special cases.  Now the only mount option which is processed first is
the sb option, which specifies the location of the superblock.  This
allows the handling of all of the default mount parameters to be much
more cleanly and more generally handled.

This does change the behaviour from earlier kernels, in that if the sb
mount option is specified, it must be specified *first*.  However, this
option is rarely used, and if it is, it generally is specified first, so
this seems to be a reasonable restriction.

This patch assumes that the ext2/3 extended attribute and ACL patches
have been applied first.  Support for setting this new superblock field
is available in the e2fsprogs BK repository.

						- Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
#
# fs/ext2/super.c         |  227 ++++++++++++++++++++++++------------------------
# fs/ext3/super.c         |  202 +++++++++++++++++++++---------------------
# include/linux/ext2_fs.h |   23 ++++
# include/linux/ext3_fs.h |   12 ++
# 4 files changed, 251 insertions(+), 213 deletions(-)
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/15	tytso@snap.thunk.org	1.859
# Default mount options from superblock
# 
# Clean up mount-time options parsing and pull mount option defaults from the
# superblock.
# --------------------------------------------
#
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Tue Oct 15 17:00:35 2002
+++ b/fs/ext2/super.c	Tue Oct 15 17:00:35 2002
@@ -53,16 +53,12 @@
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
-	if (test_opt (sb, ERRORS_PANIC) ||
-	    (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC &&
-	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_RO)))
+	if (test_opt (sb, ERRORS_PANIC))
 		panic ("EXT2-fs panic (device %s): %s: %s\n",
 		       sb->s_id, function, error_buf);
 	printk (KERN_CRIT "EXT2-fs error (device %s): %s: %s\n",
 		sb->s_id, function, error_buf);
-	if (test_opt (sb, ERRORS_RO) ||
-	    (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_RO &&
-	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_PANIC))) {
+	if (test_opt (sb, ERRORS_RO)) {
 		printk ("Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
 	}
@@ -243,12 +239,61 @@
 	.get_parent = ext2_get_parent,
 };
 
+static unsigned long get_sb_block(void **data)
+{
+	unsigned long 	sb_block;
+	char 		*options = (char *) *data;
+
+	if (!options || strncmp(options, "sb=", 3) != 0)
+		return 1;	/* Default location */
+	options += 3;
+	sb_block = simple_strtoul(options, &options, 0);
+	if (*options && *options != ',') {
+		printk("EXT2-fs: Invalid sb specification: %s\n",
+		       (char *) *data);
+		return 1;
+	}
+	if (*options == ',')
+		options++;
+	*data = (void *) options;
+	return sb_block;
+}
+
+static int want_value(char *value, char *option)
+{
+	if (!value || !*value) {
+		printk(KERN_NOTICE "EXT2-fs: the %s option needs an argument\n",
+		       option);
+		return -1;
+	}
+	return 0;
+}
+
+static int want_null_value(char *value, char *option)
+{
+	if (*value) {
+		printk(KERN_NOTICE "EXT2-fs: Invalid %s argument: %s\n",
+		       option, value);
+		return -1;
+	}
+	return 0;
+}
+
+static int want_numeric(char *value, char *option, unsigned long *number)
+{
+	if (want_value(value, option))
+		return -1;
+	*number = simple_strtoul(value, &value, 0);
+	if (want_null_value(value, option))
+		return -1;
+	return 0;
+}
+
 /*
  * This function has been shamelessly adapted from the msdos fs
  */
-static int parse_options (char * options, unsigned long * sb_block,
-			  unsigned short *resuid, unsigned short * resgid,
-			  unsigned long * mount_options)
+static int parse_options (char * options,
+			  struct ext2_sb_info *sbi)
 {
 	char * this_char;
 	char * value;
@@ -262,55 +307,52 @@
 			*value++ = 0;
 #ifdef CONFIG_EXT2_FS_XATTR
 		if (!strcmp (this_char, "user_xattr"))
-			set_opt (*mount_options, XATTR_USER);
+			set_opt (sbi->s_mount_opt, XATTR_USER);
 		else if (!strcmp (this_char, "nouser_xattr"))
-			clear_opt (*mount_options, XATTR_USER);
+			clear_opt (sbi->s_mount_opt, XATTR_USER);
 		else
 #endif
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 		if (!strcmp(this_char, "acl"))
-			set_opt(*mount_options, POSIX_ACL);
+			set_opt(sbi->s_mount_opt, POSIX_ACL);
 		else if (!strcmp(this_char, "noacl"))
-			clear_opt(*mount_options, POSIX_ACL);
+			clear_opt(sbi->s_mount_opt, POSIX_ACL);
 		else
 #endif
 		if (!strcmp (this_char, "bsddf"))
-			clear_opt (*mount_options, MINIX_DF);
+			clear_opt (sbi->s_mount_opt, MINIX_DF);
 		else if (!strcmp (this_char, "nouid32")) {
-			set_opt (*mount_options, NO_UID32);
+			set_opt (sbi->s_mount_opt, NO_UID32);
 		}
 		else if (!strcmp (this_char, "check")) {
 			if (!value || !*value || !strcmp (value, "none"))
-				clear_opt (*mount_options, CHECK);
+				clear_opt (sbi->s_mount_opt, CHECK);
 			else
 #ifdef CONFIG_EXT2_CHECK
-				set_opt (*mount_options, CHECK);
+				set_opt (sbi->s_mount_opt, CHECK);
 #else
 				printk("EXT2 Check option not supported\n");
 #endif
 		}
 		else if (!strcmp (this_char, "debug"))
-			set_opt (*mount_options, DEBUG);
+			set_opt (sbi->s_mount_opt, DEBUG);
 		else if (!strcmp (this_char, "errors")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the errors option requires "
-					"an argument\n");
+			if (want_value(value, "errors"))
 				return 0;
-			}
 			if (!strcmp (value, "continue")) {
-				clear_opt (*mount_options, ERRORS_RO);
-				clear_opt (*mount_options, ERRORS_PANIC);
-				set_opt (*mount_options, ERRORS_CONT);
+				clear_opt (sbi->s_mount_opt, ERRORS_RO);
+				clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
+				set_opt (sbi->s_mount_opt, ERRORS_CONT);
 			}
 			else if (!strcmp (value, "remount-ro")) {
-				clear_opt (*mount_options, ERRORS_CONT);
-				clear_opt (*mount_options, ERRORS_PANIC);
-				set_opt (*mount_options, ERRORS_RO);
+				clear_opt (sbi->s_mount_opt, ERRORS_CONT);
+				clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
+				set_opt (sbi->s_mount_opt, ERRORS_RO);
 			}
 			else if (!strcmp (value, "panic")) {
-				clear_opt (*mount_options, ERRORS_CONT);
-				clear_opt (*mount_options, ERRORS_RO);
-				set_opt (*mount_options, ERRORS_PANIC);
+				clear_opt (sbi->s_mount_opt, ERRORS_CONT);
+				clear_opt (sbi->s_mount_opt, ERRORS_RO);
+				set_opt (sbi->s_mount_opt, ERRORS_PANIC);
 			}
 			else {
 				printk ("EXT2-fs: Invalid errors option: %s\n",
@@ -320,52 +362,25 @@
 		}
 		else if (!strcmp (this_char, "grpid") ||
 			 !strcmp (this_char, "bsdgroups"))
-			set_opt (*mount_options, GRPID);
+			set_opt (sbi->s_mount_opt, GRPID);
 		else if (!strcmp (this_char, "minixdf"))
-			set_opt (*mount_options, MINIX_DF);
+			set_opt (sbi->s_mount_opt, MINIX_DF);
 		else if (!strcmp (this_char, "nocheck"))
-			clear_opt (*mount_options, CHECK);
+			clear_opt (sbi->s_mount_opt, CHECK);
 		else if (!strcmp (this_char, "nogrpid") ||
 			 !strcmp (this_char, "sysvgroups"))
-			clear_opt (*mount_options, GRPID);
+			clear_opt (sbi->s_mount_opt, GRPID);
 		else if (!strcmp (this_char, "resgid")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the resgid option requires "
-					"an argument\n");
+			unsigned long v;
+			if (want_numeric(value, "resgid", &v))
 				return 0;
-			}
-			*resgid = simple_strtoul (value, &value, 0);
-			if (*value) {
-				printk ("EXT2-fs: Invalid resgid option: %s\n",
-					value);
-				return 0;
-			}
+			sbi->s_resgid = v;
 		}
 		else if (!strcmp (this_char, "resuid")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the resuid option requires "
-					"an argument");
-				return 0;
-			}
-			*resuid = simple_strtoul (value, &value, 0);
-			if (*value) {
-				printk ("EXT2-fs: Invalid resuid option: %s\n",
-					value);
+			unsigned long v;
+			if (want_numeric(value, "resuid", &v))
 				return 0;
-			}
-		}
-		else if (!strcmp (this_char, "sb")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the sb option requires "
-					"an argument");
-				return 0;
-			}
-			*sb_block = simple_strtoul (value, &value, 0);
-			if (*value) {
-				printk ("EXT2-fs: Invalid sb option: %s\n",
-					value);
-				return 0;
-			}
+			sbi->s_resuid = v;
 		}
 		/* Silently ignore the quota options */
 		else if (!strcmp (this_char, "grpquota")
@@ -505,10 +520,9 @@
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
 	unsigned long sb_block = 1;
-	unsigned short resuid = EXT2_DEF_RESUID;
-	unsigned short resgid = EXT2_DEF_RESGID;
-	unsigned long logic_sb_block = 1;
+	unsigned long logic_sb_block = get_sb_block(&data);
 	unsigned long offset = 0;
+	unsigned long def_mount_opts;
 	int blocksize = BLOCK_SIZE;
 	int db_count;
 	int i, j;
@@ -526,22 +540,6 @@
 	 * This is important for devices that have a hardware
 	 * sectorsize that is larger than the default.
 	 */
-
-	sbi->s_mount_opt = 0;
-#ifdef CONFIG_EXT2_FS_XATTR
-	set_opt (EXT2_SB(sb)->s_mount_opt, XATTR_USER);
-#endif
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	/* set_opt (sb->u.ext2_sb.s_mount_opt, POSIX_ACL); */
-#endif
-	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
-	    &sbi->s_mount_opt))
-		goto failed_sbi;
-
-	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
-		((EXT2_SB(sb)->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ?
-		 MS_POSIXACL : 0);
-
 	blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
 	if (!blocksize) {
 		printk ("EXT2-fs: unable to set blocksize\n");
@@ -549,9 +547,8 @@
 	}
 
 	/*
-	 * If the superblock doesn't start on a sector boundary,
-	 * calculate the offset.  FIXME(eric) this doesn't make sense
-	 * that we would have to do this.
+	 * If the superblock doesn't start on a hardware sector boundary,
+	 * calculate the offset.  
 	 */
 	if (blocksize != BLOCK_SIZE) {
 		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
@@ -575,6 +572,35 @@
 				sb->s_id);
 		goto failed_mount;
 	}
+
+	/* Set defaults before we parse the mount options */
+	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
+	if (def_mount_opts & EXT2_DEFM_DEBUG)
+		set_opt(sbi->s_mount_opt, DEBUG);
+	if (def_mount_opts & EXT2_DEFM_BSDGROUPS)
+		set_opt(sbi->s_mount_opt, GRPID);
+	if (def_mount_opts & EXT2_DEFM_XATTR_USER)
+		set_opt(sbi->s_mount_opt, XATTR_USER);
+	if (def_mount_opts & EXT2_DEFM_ACL)
+		set_opt(sbi->s_mount_opt, POSIX_ACL);
+	if (def_mount_opts & EXT2_DEFM_UID16)
+		set_opt(sbi->s_mount_opt, NO_UID32);
+	
+	if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
+		set_opt(sbi->s_mount_opt, ERRORS_PANIC);
+	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_RO)
+		set_opt(sbi->s_mount_opt, ERRORS_RO);
+
+	sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
+	sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
+	
+	if (!parse_options ((char *) data, sbi))
+		goto failed_mount;
+
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+		((EXT2_SB(sb)->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ?
+		 MS_POSIXACL : 0);
+	
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
 	    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT2_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
@@ -656,14 +682,6 @@
 	sbi->s_desc_per_block = sb->s_blocksize /
 					 sizeof (struct ext2_group_desc);
 	sbi->s_sbh = bh;
-	if (resuid != EXT2_DEF_RESUID)
-		sbi->s_resuid = resuid;
-	else
-		sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
-	if (resgid != EXT2_DEF_RESGID)
-		sbi->s_resgid = resgid;
-	else
-		sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits =
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
@@ -818,25 +836,16 @@
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es;
-	unsigned short resuid = sbi->s_resuid;
-	unsigned short resgid = sbi->s_resgid;
-	unsigned long new_mount_opt;
-	unsigned long tmp;
 
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	new_mount_opt = sbi->s_mount_opt;
-	if (!parse_options (data, &tmp, &resuid, &resgid,
-			    &new_mount_opt))
+	if (!parse_options (data, sbi))
 		return -EINVAL;
 
 	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
-		((new_mount_opt & EXT2_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
+		((sbi->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
 
-	sbi->s_mount_opt = new_mount_opt;
-	sbi->s_resuid = resuid;
-	sbi->s_resgid = resgid;
 	es = sbi->s_es;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Tue Oct 15 17:00:35 2002
+++ b/fs/ext3/super.c	Tue Oct 15 17:00:35 2002
@@ -107,32 +107,6 @@
 
 static char error_buf[1024];
 
-/* Determine the appropriate response to ext3_error on a given filesystem */
-
-static int ext3_error_behaviour(struct super_block *sb)
-{
-	/* First check for mount-time options */
-	if (test_opt (sb, ERRORS_PANIC))
-		return EXT3_ERRORS_PANIC;
-	if (test_opt (sb, ERRORS_RO))
-		return EXT3_ERRORS_RO;
-	if (test_opt (sb, ERRORS_CONT))
-		return EXT3_ERRORS_CONTINUE;
-	
-	/* If no overrides were specified on the mount, then fall back
-	 * to the default behaviour set in the filesystem's superblock
-	 * on disk. */
-	switch (le16_to_cpu(EXT3_SB(sb)->s_es->s_errors)) {
-	case EXT3_ERRORS_PANIC:
-		return EXT3_ERRORS_PANIC;
-	case EXT3_ERRORS_RO:
-		return EXT3_ERRORS_RO;
-	default:
-		break;
-	}
-	return EXT3_ERRORS_CONTINUE;
-}
-
 /* Deal with the reporting of failure conditions on a filesystem such as
  * inconsistencies detected or read IO failures.
  *
@@ -158,20 +132,16 @@
 	if (sb->s_flags & MS_RDONLY)
 		return;
 
-	if (ext3_error_behaviour(sb) != EXT3_ERRORS_CONTINUE) {
-		EXT3_SB(sb)->s_mount_opt |= EXT3_MOUNT_ABORT;
-		journal_abort(EXT3_SB(sb)->s_journal, -EIO);
-	}
-
-	if (ext3_error_behaviour(sb) == EXT3_ERRORS_PANIC) 
+	if (test_opt (sb, ERRORS_PANIC))
 		panic ("EXT3-fs (device %s): panic forced after error\n",
 		       sb->s_id);
-
-	if (ext3_error_behaviour(sb) == EXT3_ERRORS_RO) {
+	if (test_opt (sb, ERRORS_RO)) {
 		printk (KERN_CRIT "Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
+	} else {
+		EXT3_SB(sb)->s_mount_opt |= EXT3_MOUNT_ABORT;
+		journal_abort(EXT3_SB(sb)->s_journal, -EIO);
 	}
-
 	ext3_commit_super(sb, es, 1);
 }
 
@@ -259,7 +229,7 @@
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
 
-	if (ext3_error_behaviour(sb) == EXT3_ERRORS_PANIC)
+	if (test_opt (sb, ERRORS_PANIC))
 		panic ("EXT3-fs panic (device %s): %s: %s\n",
 		       sb->s_id, function, error_buf);
 
@@ -573,18 +543,32 @@
 	return 0;
 }
 
+static unsigned long get_sb_block(void **data)
+{
+	unsigned long 	sb_block;
+	char 		*options = (char *) *data;
+
+	if (!options || strncmp(options, "sb=", 3) != 0)
+		return 1;	/* Default location */
+	options += 3;
+	sb_block = simple_strtoul(options, &options, 0);
+	if (*options && *options != ',') {
+		printk("EXT3-fs: Invalid sb specification: %s\n",
+		       (char *) *data);
+		return 1;
+	}
+	if (*options == ',')
+		options++;
+	*data = (void *) options;
+	return sb_block;
+}
+
 /*
  * This function has been shamelessly adapted from the msdos fs
  */
-static int parse_options (char * options, unsigned long * sb_block,
-			  struct ext3_sb_info *sbi,
-			  unsigned long * inum,
-			  int is_remount)
+static int parse_options (char * options, struct ext3_sb_info *sbi,
+			  unsigned long * inum, int is_remount)
 {
-	unsigned long *mount_options = &sbi->s_mount_opt;
-	
-	uid_t *resuid = &sbi->s_resuid;
-	gid_t *resgid = &sbi->s_resgid;
 	char * this_char;
 	char * value;
 
@@ -597,55 +581,55 @@
 			*value++ = 0;
 #ifdef CONFIG_EXT3_FS_XATTR
 		if (!strcmp (this_char, "user_xattr"))
-			set_opt (*mount_options, XATTR_USER);
+			set_opt (sbi->s_mount_opt, XATTR_USER);
 		else if (!strcmp (this_char, "nouser_xattr"))
-			clear_opt (*mount_options, XATTR_USER);
+			clear_opt (sbi->s_mount_opt, XATTR_USER);
 		else
 #endif
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 		if (!strcmp(this_char, "acl"))
-			set_opt (*mount_options, POSIX_ACL);
+			set_opt (sbi->s_mount_opt, POSIX_ACL);
 		else if (!strcmp(this_char, "noacl"))
-			clear_opt (*mount_options, POSIX_ACL);
+			clear_opt (sbi->s_mount_opt, POSIX_ACL);
 		else
 #endif
 		if (!strcmp (this_char, "bsddf"))
-			clear_opt (*mount_options, MINIX_DF);
+			clear_opt (sbi->s_mount_opt, MINIX_DF);
 		else if (!strcmp (this_char, "nouid32")) {
-			set_opt (*mount_options, NO_UID32);
+			set_opt (sbi->s_mount_opt, NO_UID32);
 		}
 		else if (!strcmp (this_char, "abort"))
-			set_opt (*mount_options, ABORT);
+			set_opt (sbi->s_mount_opt, ABORT);
 		else if (!strcmp (this_char, "check")) {
 			if (!value || !*value || !strcmp (value, "none"))
-				clear_opt (*mount_options, CHECK);
+				clear_opt (sbi->s_mount_opt, CHECK);
 			else
 #ifdef CONFIG_EXT3_CHECK
-				set_opt (*mount_options, CHECK);
+				set_opt (sbi->s_mount_opt, CHECK);
 #else
 				printk(KERN_ERR 
 				       "EXT3 Check option not supported\n");
 #endif
 		}
 		else if (!strcmp (this_char, "debug"))
-			set_opt (*mount_options, DEBUG);
+			set_opt (sbi->s_mount_opt, DEBUG);
 		else if (!strcmp (this_char, "errors")) {
 			if (want_value(value, "errors"))
 				return 0;
 			if (!strcmp (value, "continue")) {
-				clear_opt (*mount_options, ERRORS_RO);
-				clear_opt (*mount_options, ERRORS_PANIC);
-				set_opt (*mount_options, ERRORS_CONT);
+				clear_opt (sbi->s_mount_opt, ERRORS_RO);
+				clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
+				set_opt (sbi->s_mount_opt, ERRORS_CONT);
 			}
 			else if (!strcmp (value, "remount-ro")) {
-				clear_opt (*mount_options, ERRORS_CONT);
-				clear_opt (*mount_options, ERRORS_PANIC);
-				set_opt (*mount_options, ERRORS_RO);
+				clear_opt (sbi->s_mount_opt, ERRORS_CONT);
+				clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
+				set_opt (sbi->s_mount_opt, ERRORS_RO);
 			}
 			else if (!strcmp (value, "panic")) {
-				clear_opt (*mount_options, ERRORS_CONT);
-				clear_opt (*mount_options, ERRORS_RO);
-				set_opt (*mount_options, ERRORS_PANIC);
+				clear_opt (sbi->s_mount_opt, ERRORS_CONT);
+				clear_opt (sbi->s_mount_opt, ERRORS_RO);
+				set_opt (sbi->s_mount_opt, ERRORS_PANIC);
 			}
 			else {
 				printk (KERN_ERR
@@ -656,29 +640,25 @@
 		}
 		else if (!strcmp (this_char, "grpid") ||
 			 !strcmp (this_char, "bsdgroups"))
-			set_opt (*mount_options, GRPID);
+			set_opt (sbi->s_mount_opt, GRPID);
 		else if (!strcmp (this_char, "minixdf"))
-			set_opt (*mount_options, MINIX_DF);
+			set_opt (sbi->s_mount_opt, MINIX_DF);
 		else if (!strcmp (this_char, "nocheck"))
-			clear_opt (*mount_options, CHECK);
+			clear_opt (sbi->s_mount_opt, CHECK);
 		else if (!strcmp (this_char, "nogrpid") ||
 			 !strcmp (this_char, "sysvgroups"))
-			clear_opt (*mount_options, GRPID);
+			clear_opt (sbi->s_mount_opt, GRPID);
 		else if (!strcmp (this_char, "resgid")) {
 			unsigned long v;
 			if (want_numeric(value, "resgid", &v))
 				return 0;
-			*resgid = v;
+			sbi->s_resgid = v;
 		}
 		else if (!strcmp (this_char, "resuid")) {
 			unsigned long v;
 			if (want_numeric(value, "resuid", &v))
 				return 0;
-			*resuid = v;
-		}
-		else if (!strcmp (this_char, "sb")) {
-			if (want_numeric(value, "sb", sb_block))
-				return 0;
+			sbi->s_resuid = v;
 		}
 #ifdef CONFIG_JBD_DEBUG
 		else if (!strcmp (this_char, "ro-after")) {
@@ -709,12 +689,12 @@
 			if (want_value(value, "journal"))
 				return 0;
 			if (!strcmp (value, "update"))
-				set_opt (*mount_options, UPDATE_JOURNAL);
+				set_opt (sbi->s_mount_opt, UPDATE_JOURNAL);
 			else if (want_numeric(value, "journal", inum))
 				return 0;
 		}
 		else if (!strcmp (this_char, "noload"))
-			set_opt (*mount_options, NOLOAD);
+			set_opt (sbi->s_mount_opt, NOLOAD);
 		else if (!strcmp (this_char, "data")) {
 			int data_opt = 0;
 
@@ -733,7 +713,7 @@
 				return 0;
 			}
 			if (is_remount) {
-				if ((*mount_options & EXT3_MOUNT_DATA_FLAGS) !=
+				if ((sbi->s_mount_opt & EXT3_MOUNT_DATA_FLAGS) !=
 							data_opt) {
 					printk(KERN_ERR
 					       "EXT3-fs: cannot change data "
@@ -741,8 +721,8 @@
 					return 0;
 				}
 			} else {
-				*mount_options &= ~EXT3_MOUNT_DATA_FLAGS;
-				*mount_options |= data_opt;
+				sbi->s_mount_opt &= ~EXT3_MOUNT_DATA_FLAGS;
+				sbi->s_mount_opt |= data_opt;
 			}
 		} else if (!strcmp (this_char, "commit")) {
 			unsigned long v;
@@ -997,10 +977,11 @@
 	struct buffer_head * bh;
 	struct ext3_super_block *es = 0;
 	struct ext3_sb_info *sbi;
-	unsigned long sb_block = 1;
+	unsigned long sb_block = get_sb_block(&data);
 	unsigned long logic_sb_block = 1;
 	unsigned long offset = 0;
 	unsigned long journal_inum = 0;
+	unsigned long def_mount_opts;
 	int blocksize;
 	int hblock;
 	int db_count;
@@ -1010,13 +991,6 @@
 #ifdef CONFIG_JBD_DEBUG
 	ext3_ro_after = 0;
 #endif
-	/*
-	 * See what the current blocksize for the device is, and
-	 * use that as the blocksize.  Otherwise (or if the blocksize
-	 * is smaller than the default) use the default.
-	 * This is important for devices that have a hardware
-	 * sectorsize that is larger than the default.
-	 */
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
@@ -1026,18 +1000,18 @@
 	sbi->s_resuid = EXT3_DEF_RESUID;
 	sbi->s_resgid = EXT3_DEF_RESGID;
 
-	/* Default extended attribute flags */
-#ifdef CONFIG_EXT3_FS_XATTR
-	set_opt(sbi->s_mount_opt, XATTR_USER);
-#endif
-
-	if (!parse_options ((char *) data, &sb_block, sbi, &journal_inum, 0))
-		goto out_fail;
-
-	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
-		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
-
+	/*
+	 * See what the current blocksize for the device is, and
+	 * use that as the blocksize.  Otherwise (or if the blocksize
+	 * is smaller than the default) use the default.
+	 * This is important for devices that have a hardware
+	 * sectorsize that is larger than the default.
+	 */
 	blocksize = sb_min_blocksize(sb, EXT3_MIN_BLOCK_SIZE);
+	if (!blocksize) {
+		printk ("EXT3-fs: unable to set blocksize\n");
+		goto out_fail;
+	}
 
 	/*
 	 * The ext3 superblock will not be buffer aligned for other than 1kB
@@ -1066,6 +1040,34 @@
 			       sb->s_id);
 		goto failed_mount;
 	}
+	
+	/* Set defaults before we parse the mount options */
+	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
+	if (def_mount_opts & EXT3_DEFM_DEBUG)
+		set_opt(sbi->s_mount_opt, DEBUG);
+	if (def_mount_opts & EXT3_DEFM_BSDGROUPS)
+		set_opt(sbi->s_mount_opt, GRPID);
+	if (def_mount_opts & EXT3_DEFM_XATTR_USER)
+		set_opt(sbi->s_mount_opt, XATTR_USER);
+	if (def_mount_opts & EXT3_DEFM_ACL)
+		set_opt(sbi->s_mount_opt, POSIX_ACL);
+	if (def_mount_opts & EXT3_DEFM_UID16)
+		set_opt(sbi->s_mount_opt, NO_UID32);
+	
+	if (le16_to_cpu(sbi->s_es->s_errors) == EXT3_ERRORS_PANIC)
+		set_opt(sbi->s_mount_opt, ERRORS_PANIC);
+	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT3_ERRORS_RO)
+		set_opt(sbi->s_mount_opt, ERRORS_RO);
+	
+	sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
+	sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
+
+	if (!parse_options ((char *) data, sbi, &journal_inum, 0))
+		goto failed_mount;
+
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
+
 	if (le32_to_cpu(es->s_rev_level) == EXT3_GOOD_OLD_REV &&
 	    (EXT3_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT3_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
@@ -1163,10 +1165,6 @@
 	sbi->s_itb_per_group = sbi->s_inodes_per_group /sbi->s_inodes_per_block;
 	sbi->s_desc_per_block = blocksize / sizeof(struct ext3_group_desc);
 	sbi->s_sbh = bh;
-	if (sbi->s_resuid == EXT3_DEF_RESUID)
-		sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
-	if (sbi->s_resgid == EXT3_DEF_RESGID)
-		sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits = log2(EXT3_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = log2(EXT3_DESC_PER_BLOCK(sb));
@@ -1750,7 +1748,7 @@
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	if (!parse_options(data, &tmp, sbi, &tmp, 1))
+	if (!parse_options(data, sbi, &tmp, 1))
 		return -EINVAL;
 
 	if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Tue Oct 15 17:00:35 2002
+++ b/include/linux/ext2_fs.h	Tue Oct 15 17:00:35 2002
@@ -387,7 +387,19 @@
 	__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
 	__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
 	__u16	s_padding1;
-	__u32	s_reserved[204];	/* Padding to the end of the block */
+	/*
+	 * Journaling support valid if EXT3_FEATURE_COMPAT_HAS_JOURNAL set.
+	 */
+	__u8	s_journal_uuid[16];	/* uuid of journal superblock */
+	__u32	s_journal_inum;		/* inode number of journal file */
+	__u32	s_journal_dev;		/* device number of journal file */
+	__u32	s_last_orphan;		/* start of list of inodes to delete */
+	__u32	s_hash_seed[4];		/* HTREE hash seed */
+	__u8	s_def_hash_version;	/* Default hash version to use */
+	__u8	s_reserved_char_pad;
+	__u16	s_reserved_word_pad;
+	__u32	s_default_mount_opts;
+	__u32	s_reserved[191];	/* Padding to the end of the block */
 };
 
 /*
@@ -465,6 +477,15 @@
  */
 #define	EXT2_DEF_RESUID		0
 #define	EXT2_DEF_RESGID		0
+
+/*
+ * Default mount options
+ */
+#define EXT2_DEFM_DEBUG		0x0001
+#define EXT2_DEFM_BSDGROUPS	0x0002
+#define EXT2_DEFM_XATTR_USER	0x0004
+#define EXT2_DEFM_ACL		0x0008
+#define EXT2_DEFM_UID16		0x0010
 
 /*
  * Structure of a directory entry
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Tue Oct 15 17:00:35 2002
+++ b/include/linux/ext3_fs.h	Tue Oct 15 17:00:35 2002
@@ -426,7 +426,8 @@
 	__u8	s_def_hash_version;	/* Default hash version to use */
 	__u8	s_reserved_char_pad;
 	__u16	s_reserved_word_pad;
-	__u32	s_reserved[192];	/* Padding to the end of the block */
+	__u32	s_default_mount_opts;
+	__u32	s_reserved[191];	/* Padding to the end of the block */
 };
 
 #ifdef __KERNEL__
@@ -518,6 +519,15 @@
  */
 #define	EXT3_DEF_RESUID		0
 #define	EXT3_DEF_RESGID		0
+
+/*
+ * Default mount options
+ */
+#define EXT3_DEFM_DEBUG		0x0001
+#define EXT3_DEFM_BSDGROUPS	0x0002
+#define EXT3_DEFM_XATTR_USER	0x0004
+#define EXT3_DEFM_ACL		0x0008
+#define EXT3_DEFM_UID16		0x0010
 
 /*
  * Structure of a directory entry
