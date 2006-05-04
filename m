Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWEDDhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWEDDhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWEDDhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:37:06 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:17402 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750959AbWEDDhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:37:02 -0400
Date: Wed, 3 May 2006 21:37:02 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 4/13: eCryptfs] Main module functions
Message-ID: <20060504033702.GC28613@hellewell.homeip.net>
References: <20060504031755.GA28257@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504031755.GA28257@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

Provides functions to initialize the eCryptfs module and eCryptfs
mounts. Allocates and deallocates kmem_cache regions.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 main.c |  769 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 769 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/main.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/main.c	2006-05-02 19:36:03.000000000 -0600
@@ -0,0 +1,769 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (C) 1997-2003 Erez Zadok
+ * Copyright (C) 2001-2003 Stony Brook University
+ * Copyright (C) 2004-2006 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
+ *              Michael C. Thompson <mcthomps@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <linux/dcache.h>
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/namei.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/mount.h>
+#include <linux/dcache.h>
+#include <linux/pagemap.h>
+#include <linux/key.h>
+#include <linux/parser.h>
+#include <keys/user-type.h>
+#include "ecryptfs_kernel.h"
+
+/**
+ * Module parameter that defines the ecryptfs_verbosity level.
+ */
+int ecryptfs_verbosity = 0;
+
+module_param(ecryptfs_verbosity, int, 0);
+MODULE_PARM_DESC(ecryptfs_verbosity,
+		 "Initial verbosity level (0 or 1; defaults to "
+		 "0, which is Quiet)");
+
+void __ecryptfs_printk(const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	if (fmt[1] == '7') { /* KERN_DEBUG */
+		if (ecryptfs_verbosity >= 1)
+			vprintk(fmt, args);
+	} else
+		vprintk(fmt, args);
+	va_end(args);
+}
+
+/**
+ * Interposes upper and lower dentries.
+ *
+ * This function will allocate an ecryptfs_inode through the call to
+ * iget(sb, lower_inode->i_ino).
+ * 
+ * @param lower_dentry existing dentry in the lower filesystem
+ * @param dentry ecryptfs' dentry
+ * @param sb eCryptfs's super_block
+ * @param flag If set to true, then d_add is called, else
+ *             d_instantiate is called.
+ * @return Zero on success; non-zero otherwise
+ */
+int ecryptfs_interpose(struct dentry *lower_dentry, struct dentry *dentry,
+		       struct super_block *sb, int flag)
+{
+	struct inode *lower_inode;
+	int rc = 0;
+	struct inode *inode;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; lower_dentry = [%p], "
+			"lower_dentry->d_name.name = [%s], dentry = "
+			"[%p], dentry->d_name.name = [%s], sb = [%p]; "
+			"flag = [%.4x]; lower_dentry->d_count "
+			"= [%d]; dentry->d_count = [%d]\n", lower_dentry,
+			lower_dentry->d_name.name, dentry, dentry->d_name.name,
+			sb, flag, atomic_read(&lower_dentry->d_count),
+			atomic_read(&dentry->d_count));
+	lower_inode = lower_dentry->d_inode;
+	if (lower_inode->i_sb != ECRYPTFS_SUPERBLOCK_TO_LOWER(sb)) {
+		rc = -EXDEV;
+		goto out;
+	}
+	inode = iget(sb, lower_inode->i_ino);
+	if (!inode) {
+		rc = -EACCES;
+		goto out;
+	}
+	/* This check is required here because if we failed to allocated the
+	 * required space for an inode_info_cache struct, then the only way
+	 * we know we failed, is by the pointer being NULL */
+	if (!ECRYPTFS_INODE_TO_PRIVATE(inode)) {
+		ecryptfs_printk(KERN_ERR, "Out of memory. Failure to "
+				"allocate memory in ecryptfs_read_inode.\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	if (NULL == ECRYPTFS_INODE_TO_LOWER(inode))
+		ECRYPTFS_INODE_TO_LOWER(inode) = igrab(lower_inode);
+	if (S_ISLNK(lower_inode->i_mode))
+		inode->i_op = &ecryptfs_symlink_iops;
+	else if (S_ISDIR(lower_inode->i_mode))
+		inode->i_op = &ecryptfs_dir_iops;
+	if (S_ISDIR(lower_inode->i_mode))
+		inode->i_fop = &ecryptfs_dir_fops;
+	/* TODO: Is there a better way to identify if the inode is
+	 * special? */
+	if (S_ISBLK(lower_inode->i_mode) || S_ISCHR(lower_inode->i_mode) ||
+	    S_ISFIFO(lower_inode->i_mode) || S_ISSOCK(lower_inode->i_mode))
+		init_special_inode(inode, lower_inode->i_mode,
+				   lower_inode->i_rdev);
+	dentry->d_op = &ecryptfs_dops;
+	if (flag)
+		d_add(dentry, inode);
+	else
+		d_instantiate(dentry, inode);
+	ecryptfs_copy_attr_all(inode, lower_inode);
+	/* This size will be overwritten for real files w/ headers and
+	 * other metadata */
+	ecryptfs_copy_inode_size(inode, lower_inode);
+out:
+	ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+enum { ecryptfs_opt_sig, ecryptfs_opt_debug, ecryptfs_opt_cipher,
+       ecryptfs_opt_err };
+
+static match_table_t tokens = {
+	{ecryptfs_opt_sig, "sig=%s"},
+	{ecryptfs_opt_debug, "debug=%u"},
+	{ecryptfs_opt_cipher, "cipher=%s"},
+	{ecryptfs_opt_err, NULL}
+};
+
+/**
+ * @return Zero on good version; non-zero otherwise
+ */
+int ecryptfs_verify_version(uint16_t version)
+{
+	int rc = 0;
+	unsigned char major;
+	unsigned char minor;
+
+	major = ((version >> 8) & 0xFF);
+	minor = (version & 0xFF);
+	if (major != ECRYPTFS_VERSION_MAJOR) {
+		ecryptfs_printk(KERN_ERR, "Major version number mismatch. "
+				"Expected [%d]; got [%d]\n",
+				ECRYPTFS_VERSION_MAJOR, major);
+		rc = -EINVAL;
+		goto out;
+	}
+	if (minor != ECRYPTFS_VERSION_MINOR) {
+		ecryptfs_printk(KERN_ERR, "Minor version number mismatch. "
+				"Expected [%d]; got [%d]\n",
+				ECRYPTFS_VERSION_MINOR, minor);
+		rc = -EINVAL;
+		goto out;
+	}
+out:
+	return rc;
+}
+
+/**
+ * Parse mount options:
+ * debug=N 	   - ecryptfs_verbosity level for debug output
+ * sig=XXX	   - description(signature) of the key to use
+ * 
+ * Returns the dentry object of the lower-level (lower/interposed)
+ * directory; We want to mount our stackable file system on top of
+ * that lower directory.
+ *
+ * N.B. The signature of the key to use must be the description of a key
+ * 	already in the keyring. Mounting will fail if the key can not be
+ * 	found.
+ *
+ * @param sb
+ * @param options
+ * @return Zero on success; non-zero on error
+ */
+static int ecryptfs_parse_options(struct super_block *sb, char *options)
+{
+	char *p;
+	int rc = 0;
+	int sig_set = 0;
+	int cipher_name_set = 0;
+	struct key *auth_tok_key = NULL;
+	struct ecryptfs_auth_tok *auth_tok = NULL;
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
+		&(ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb)->mount_crypt_stat);
+	substring_t args[MAX_OPT_ARGS];
+	int token;
+	char *sig_src;
+	char *sig_dst;
+	char *debug_src;
+	char *cipher_name_dst;
+	char *cipher_name_src;
+	int cipher_name_len;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; options = [%s]\n", options);
+	if (!options) {
+		rc = -EINVAL;
+		goto out;
+	}
+	while ((p = strsep(&options, ",")) != NULL) {
+		if (!*p)
+			continue;
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case ecryptfs_opt_sig:
+			sig_src = args[0].from;
+			sig_dst =
+				mount_crypt_stat->global_auth_tok_sig;
+			memcpy(sig_dst, sig_src, ECRYPTFS_SIG_SIZE_HEX);
+			sig_dst[ECRYPTFS_SIG_SIZE_HEX] = '\0';
+			ecryptfs_printk(KERN_DEBUG,
+					"The mount_crypt_stat "
+					"global_auth_tok_sig set to: "
+					"[%s]\n", sig_dst);
+			sig_set = 1;
+			break;
+		case ecryptfs_opt_debug:
+			debug_src = args[0].from;
+			ecryptfs_verbosity =
+				(int)simple_strtol(debug_src, &debug_src,
+						   0);
+			ecryptfs_printk(KERN_DEBUG,
+					"Verbosity set to [%d]" "\n",
+					ecryptfs_verbosity);
+			break;
+		case ecryptfs_opt_cipher:
+			cipher_name_src = args[0].from;
+			cipher_name_dst =
+				mount_crypt_stat->
+				global_default_cipher_name;
+			strncpy(cipher_name_dst, cipher_name_src,
+				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
+			ecryptfs_printk(KERN_DEBUG,
+					"The mount_crypt_stat "
+					"global_default_cipher_name set to: "
+					"[%s]\n", cipher_name_dst);
+			cipher_name_set = 1;
+			break;
+		case ecryptfs_opt_err:
+		default:
+			ecryptfs_printk(KERN_WARNING,
+					"eCryptfs: unrecognized option '%s'\n",
+					options);
+		}
+	}
+	/* Do not support lack of mount-wide signature in 0.1
+	 * release */
+	if (!sig_set) {
+		rc = -EINVAL;
+		ecryptfs_printk(KERN_ERR, "You must supply a valid "
+				"passphrase auth tok signature as a mount "
+				"parameter; see the eCryptfs README\n");
+		goto out;
+	}
+	if (!cipher_name_set) {
+		cipher_name_len = strlen(ECRYPTFS_DEFAULT_CIPHER);
+		if (unlikely(cipher_name_len
+			     >= ECRYPTFS_MAX_CIPHER_NAME_SIZE)) {
+			rc = -EINVAL;
+			BUG();
+			goto out;
+		}
+		memcpy(mount_crypt_stat->global_default_cipher_name,
+		       ECRYPTFS_DEFAULT_CIPHER, cipher_name_len);
+		mount_crypt_stat->global_default_cipher_name[cipher_name_len]
+		    = '\0';
+	}
+	ecryptfs_printk(KERN_DEBUG, "Requesting the key with description: "
+			"[%s]\n", mount_crypt_stat->global_auth_tok_sig);
+	/* N.B. The reference to this key is held until umount is done
+	 * The call to key_put is done in ecryptfs_put_super() */
+	auth_tok_key = request_key(&key_type_user,
+				   mount_crypt_stat->global_auth_tok_sig,
+				   NULL);
+	if (!auth_tok_key || IS_ERR(auth_tok_key)) {
+		ecryptfs_printk(KERN_ERR, "Could not find key with "
+				"description: [%s]\n",
+				mount_crypt_stat->global_auth_tok_sig);
+		process_request_key_err(PTR_ERR(auth_tok_key));
+		rc = -EINVAL;
+		goto out;
+	}
+	auth_tok = (struct ecryptfs_auth_tok *)KEY_PAYLOAD_DATA(auth_tok_key);
+	if (ecryptfs_verify_version(auth_tok->version)) {
+		ecryptfs_printk(KERN_ERR, "Data structure version mismatch. "
+				"Userspace tools must match eCryptfs kernel "
+				"module with major version [%d] and minor "
+				"version [%d]\n", ECRYPTFS_VERSION_MAJOR,
+				ECRYPTFS_VERSION_MINOR);
+		rc = -EINVAL;
+		goto out;
+	}
+	if (!ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_PASSWORD)) {
+		ecryptfs_printk(KERN_ERR, "Invalid auth_tok structure "
+				"returned from key\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	mount_crypt_stat->global_auth_tok_key = auth_tok_key;
+	mount_crypt_stat->global_auth_tok = auth_tok;
+out:
+	ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+kmem_cache_t *ecryptfs_sb_info_cache;
+
+/**
+ * Preform the cleanup for ecryptfs_read_super()
+ */
+static inline void ecryptfs_cleanup_read_super(struct super_block *sb)
+{
+	ecryptfs_printk(KERN_DEBUG, "Enter; sb = [%p], sb->s_root = [%p] "
+			"ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb) = [%p] "
+			"sb->s_root.d_name->name = [%s]\n", sb,
+			sb->s_root, ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb),
+			sb->s_root->d_name.name);
+	up_write(&sb->s_umount);
+	deactivate_super(sb);
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+}
+
+/**
+ * Sets up what we can of the sb, rest is done in ecryptfs_read_super
+ *
+ * @param sb		The ecryptfs super block
+ * @param raw_data	The options passed to mount
+ * @param silent	Not used but required by function prototype
+ * @return 		Zero on success; non-zero otherwise
+ */
+static int
+ecryptfs_fill_super(struct super_block *sb, void *raw_data, int silent)
+{
+	int rc = 0;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; sb = [%p] raw_data = [%s] "
+			"silent = [%d]\n", sb, (char *)raw_data, silent);
+	/* Released in ecryptfs_put_super() */
+	ECRYPTFS_SUPERBLOCK_TO_PRIVATE_SM(sb) =
+		kmem_cache_alloc(ecryptfs_sb_info_cache, SLAB_KERNEL);
+	if (!ECRYPTFS_SUPERBLOCK_TO_PRIVATE_SM(sb)) {
+		ecryptfs_printk(KERN_WARNING, "Out of memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	memset(ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb), 0,
+	       sizeof(struct ecryptfs_sb_info));
+	sb->s_op = &ecryptfs_sops;
+	/* Released through deactivate_super(sb) from get_sb_nodev */
+	sb->s_root = d_alloc(NULL, &(const struct qstr) {
+			     .hash = 0,.name = "/",.len = 1});
+	if (!sb->s_root) {
+		ecryptfs_printk(KERN_ERR, "d_alloc failed\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	sb->s_root->d_op = &ecryptfs_dops;
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	/* Released in d_release when dput(sb->s_root) is called */
+	/* through deactivate_super(sb) from get_sb_nodev() */
+	ECRYPTFS_DENTRY_TO_PRIVATE_SM(sb->s_root) =
+		(struct ecryptfs_dentry_info *)
+		kmem_cache_alloc(ecryptfs_dentry_info_cache, SLAB_KERNEL);
+	if (!ECRYPTFS_DENTRY_TO_PRIVATE_SM(sb->s_root)) {
+		ecryptfs_printk(KERN_ERR,
+				"dentry_info_cache alloc failed\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	memset(ECRYPTFS_DENTRY_TO_PRIVATE(sb->s_root), 0,
+	       sizeof(struct ecryptfs_dentry_info));
+	rc = 0;
+out:
+	/* Should be able to rely on deactive_super called from
+	 * get_sb_nodev */
+	ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Read the super block of the lower filesystem, and use
+ * ecryptfs_interpose to create our initial inode and super block
+ * struct.
+ */
+static int ecryptfs_read_super(struct super_block *sb, const char *dev_name)
+{
+	int rc;
+	struct nameidata nd;
+	struct dentry *lower_root;
+
+	memset(&nd, 0, sizeof(struct nameidata));
+	ecryptfs_printk(KERN_DEBUG, "Enter; sb = [%p], dev_name = [%s]\n",
+			sb, dev_name);
+	rc = path_lookup(dev_name, LOOKUP_FOLLOW, &nd);
+	if (rc) {
+		ecryptfs_printk(KERN_WARNING, "path_lookup() failed\n");
+		goto out_free;
+	}
+	lower_root = nd.dentry;
+	ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb)->lower_mnt = nd.mnt;
+	if (!lower_root->d_inode) {
+		ecryptfs_printk(KERN_WARNING,
+				"No directory to interpose on\n");
+		rc = -ENOENT;
+		goto out_free;
+	}
+	ECRYPTFS_SUPERBLOCK_TO_LOWER(sb) = lower_root->d_sb;
+	sb->s_maxbytes = lower_root->d_sb->s_maxbytes;
+	ECRYPTFS_DENTRY_TO_LOWER(sb->s_root) = lower_root;
+	if ((rc = ecryptfs_interpose(lower_root, sb->s_root, sb, 0)))
+		goto out_free;
+	rc = 0;
+	goto out;
+out_free:
+	path_release(&nd);
+	ecryptfs_cleanup_read_super(sb);
+out:
+	ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * The whole ecryptfs_get_sb process is broken into 4 functions:
+ * ecryptfs_parse_options(): handle options passed to ecryptfs, if any
+ * ecryptfs_fill_super(): used by get_sb_nodev, fills out the super_block
+ *                        with as much information as it can before needing
+ *                        the lower filesystem.
+ * ecryptfs_read_super(): this accesses the lower filesystem and uses
+ *                        ecryptfs_interpolate to perform most of the linking
+ * ecryptfs_interpolate(): links the lower filesystem into ecryptfs 
+ */
+static struct super_block *ecryptfs_get_sb(struct file_system_type *fs_type,
+					   int flags, const char *dev_name,
+					   void *raw_data)
+{
+	int rc;
+	struct super_block *sb = NULL;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; fs_type = [%p], flags = [%d],"
+			" dev_name = [%s], raw_data = [%s]\n",
+			fs_type, flags, dev_name, (char *)raw_data);
+	sb = get_sb_nodev(fs_type, flags, raw_data, ecryptfs_fill_super);
+	if (IS_ERR(sb)) {
+		ecryptfs_printk(KERN_ERR, "Getting sb failed. "
+				"sb = [%p]\n", sb);
+		goto out;
+	}
+	rc = ecryptfs_parse_options(sb, raw_data);
+	if (rc) {
+		sb = ERR_PTR(rc);
+		goto out;
+	}
+	rc = ecryptfs_read_super(sb, dev_name);
+	if (rc) {
+		sb = ERR_PTR(rc);
+		ecryptfs_printk(KERN_ERR, "Reading sb failed. "
+				"sb = [%p]\n", sb);
+	}
+out:
+	ecryptfs_printk(KERN_DEBUG, "Exit; sb = [%p]\n", sb);
+	return sb;
+}
+
+/**
+ * Used to bring the superblock down and free the private data.
+ * Private data is free'd in ecryptfs_put_super()
+ */
+static void ecryptfs_kill_block_super(struct super_block *sb)
+{
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
+		&(ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb)->mount_crypt_stat);
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; sb = [%p], sb->s_root = [%p] "
+			"ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb) = [%p]\n", sb,
+			sb->s_root, ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb));
+	memset(mount_crypt_stat, 0, sizeof(struct ecryptfs_mount_crypt_stat));
+	generic_shutdown_super(sb);
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+}
+
+static struct file_system_type ecryptfs_fs_type = {
+	.owner = THIS_MODULE,
+	.name = "ecryptfs",
+	.get_sb = ecryptfs_get_sb,
+	.kill_sb = ecryptfs_kill_block_super,
+	.fs_flags = 0
+};
+
+/**
+ * Initializes the ecryptfs_inode_info_cache when it is created
+ */
+static void
+inode_info_init_once(void *vptr, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct ecryptfs_inode_info *ei = (struct ecryptfs_inode_info *)vptr;
+
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&ei->vfs_inode);
+}
+
+/* This provides a means of backing out cache creations out of the kernel
+ * so that we can elegantly fail should we run out of memory.
+ */
+#define ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE 	0x0001
+#define ECRYPTFS_AUTH_TOK_PKT_SET_CACHE         0x0002
+#define ECRYPTFS_AUTH_TOK_REQUEST_CACHE         0x0004
+#define ECRYPTFS_AUTH_TOK_REQUEST_BLOB_CACHE    0x0008
+#define ECRYPTFS_FILE_INFO_CACHE 		0x0010
+#define ECRYPTFS_DENTRY_INFO_CACHE 		0x0020
+#define ECRYPTFS_INODE_INFO_CACHE 		0x0040
+#define ECRYPTFS_SB_INFO_CACHE 			0x0080
+#define ECRYPTFS_HEADER_CACHE_0 		0x0100
+#define ECRYPTFS_HEADER_CACHE_1 		0x0200
+#define ECRYPTFS_HEADER_CACHE_2 		0x0400
+#define ECRYPTFS_LOWER_PAGE_CACHE 		0x0800
+#define ECRYPTFS_CACHE_CREATION_SUCCESS		0x0FF1
+
+static short ecryptfs_allocated_caches;
+
+/**
+ * Sets ecryptfs_allocated_caches with flags so that we can
+ * free created caches should we run out of memory during
+ * creation period.
+ *
+ * @return Zero on success; non-zero otherwise
+ */
+static int ecryptfs_init_kmem_caches(void)
+{
+	int rc = 0;
+
+	ecryptfs_auth_tok_list_item_cache =
+	    kmem_cache_create("ecryptfs_auth_tok_list_item",
+			      sizeof(struct ecryptfs_auth_tok_list_item),
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_auth_tok_list_item_cache)
+		rc |= ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_auth_tok_list_item "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_file_info_cache =
+	    kmem_cache_create("ecryptfs_file_cache",
+			      sizeof(struct ecryptfs_file_info),
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_file_info_cache)
+		rc |= ECRYPTFS_FILE_INFO_CACHE;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_file_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_dentry_info_cache =
+	    kmem_cache_create("ecryptfs_dentry_cache",
+			      sizeof(struct ecryptfs_dentry_info),
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_dentry_info_cache)
+		rc |= ECRYPTFS_DENTRY_INFO_CACHE;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_dentry_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_inode_info_cache =
+	    kmem_cache_create("ecryptfs_inode_cache",
+			      sizeof(struct ecryptfs_inode_info), 0,
+			      SLAB_HWCACHE_ALIGN, inode_info_init_once, NULL);
+	if (ecryptfs_inode_info_cache)
+		rc |= ECRYPTFS_INODE_INFO_CACHE;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_inode_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_sb_info_cache =
+	    kmem_cache_create("ecryptfs_sb_cache",
+			      sizeof(struct ecryptfs_sb_info),
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_sb_info_cache)
+		rc |= ECRYPTFS_SB_INFO_CACHE;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_sb_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_header_cache_0 =
+	    kmem_cache_create("ecryptfs_headers_0", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_header_cache_0)
+		rc |= ECRYPTFS_HEADER_CACHE_0;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_headers_0 "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_header_cache_1 =
+	    kmem_cache_create("ecryptfs_headers_1", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_header_cache_1)
+		rc |= ECRYPTFS_HEADER_CACHE_1;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_headers_1 "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_header_cache_2 =
+	    kmem_cache_create("ecryptfs_headers_2", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_header_cache_2)
+		rc |= ECRYPTFS_HEADER_CACHE_2;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_headers_2 "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_lower_page_cache =
+	    kmem_cache_create("ecryptfs_lower_page_cache", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_lower_page_cache)
+		rc |= ECRYPTFS_LOWER_PAGE_CACHE;
+	else
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_lower_page_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_allocated_caches = rc;
+	rc = ECRYPTFS_CACHE_CREATION_SUCCESS ^ rc;
+	return rc;
+}
+
+/**
+ * @return Zero on success; non-zero otherwise
+ */
+static int ecryptfs_free_kmem_caches(void)
+{
+	int rc = 0;
+	int err;
+
+	if (ecryptfs_allocated_caches & ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE) {
+		rc = kmem_cache_destroy(ecryptfs_auth_tok_list_item_cache);
+		if (rc)
+			ecryptfs_printk(KERN_WARNING,
+					"Not all ecryptfs_auth_tok_"
+					"list_item_cache structures were "
+					"freed\n");
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_FILE_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_file_info_cache);
+		if (err)
+			ecryptfs_printk(KERN_WARNING,
+					"Not all ecryptfs_file_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_DENTRY_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_dentry_info_cache);
+		if (err)
+			ecryptfs_printk(KERN_WARNING,
+					"Not all ecryptfs_dentry_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_INODE_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_inode_info_cache);
+		if (err)
+			ecryptfs_printk(KERN_WARNING,
+					"Not all ecryptfs_inode_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_SB_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_sb_info_cache);
+		if (err)
+			ecryptfs_printk(KERN_WARNING,
+					"Not all ecryptfs_sb_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_0) {
+		err = kmem_cache_destroy(ecryptfs_header_cache_0);
+		if (err)
+			ecryptfs_printk(KERN_WARNING, "Not all ecryptfs_"
+					"header_cache_0 regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_1) {
+		err = kmem_cache_destroy(ecryptfs_header_cache_1);
+		if (err)
+			ecryptfs_printk(KERN_WARNING, "Not all ecryptfs_"
+					"header_cache_1 regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_2) {
+		err = kmem_cache_destroy(ecryptfs_header_cache_2);
+		if (err)
+			ecryptfs_printk(KERN_WARNING, "Not all ecryptfs_"
+					"header_cache_2 regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_LOWER_PAGE_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_lower_page_cache);
+		if (err)
+			ecryptfs_printk(KERN_WARNING, "Not all ecryptfs_"
+					"lower_page_cache regions were "
+					"freed\n");
+		rc |= err;
+	}
+	return rc;
+}
+
+static int __init init_ecryptfs_fs(void)
+{
+	int rc;
+
+	if (ECRYPTFS_DEFAULT_EXTENT_SIZE > PAGE_CACHE_SIZE) {
+		rc = -EINVAL;
+		ecryptfs_printk(KERN_ERR, "The eCryptfs extent size is "
+				"larger than the host's page size, and so "
+				"eCryptfs cannot run on this system. The "
+				"default eCryptfs extent size is [%d] bytes; "
+				"the page size is [%d] bytes.\n",
+				ECRYPTFS_DEFAULT_EXTENT_SIZE, PAGE_CACHE_SIZE);
+		goto out;
+	}
+	rc = ecryptfs_init_kmem_caches();
+	if (rc) {
+		ecryptfs_printk(KERN_EMERG, "Failure occured while "
+				"attempting to create caches [Mask of created "
+				"caches: 0x%x]. Now freeing caches.\n",
+				ecryptfs_allocated_caches);
+		ecryptfs_free_kmem_caches();
+		rc = -ENOMEM;
+		goto out;
+	}
+	ecryptfs_printk(KERN_DEBUG, "Registering eCryptfs\n");
+	rc = register_filesystem(&ecryptfs_fs_type);
+out:
+	return rc;
+}
+
+static void __exit exit_ecryptfs_fs(void)
+{
+	int rc;
+
+	ecryptfs_printk(KERN_DEBUG, "Unregistering eCryptfs\n");
+	unregister_filesystem(&ecryptfs_fs_type);
+	rc = ecryptfs_free_kmem_caches();
+	if (rc)
+		ecryptfs_printk(KERN_EMERG, "Failure occured while "
+				"attempting to free caches: [%d]\n", rc);
+}
+
+MODULE_AUTHOR("Michael A. Halcrow <mhalcrow@us.ibm.com>");
+MODULE_DESCRIPTION("eCryptfs");
+
+MODULE_LICENSE("GPL");
+
+module_init(init_ecryptfs_fs)
+module_exit(exit_ecryptfs_fs)
