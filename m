Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbVKCDtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbVKCDtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbVKCDtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:49:10 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:27374
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1751532AbVKCDtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:49:08 -0500
Date: Wed, 2 Nov 2005 20:49:29 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 4/12: eCryptfs] Main module functions
Message-ID: <20051103034929.GD3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides functions to initialize the eCryptfs module and eCryptfs
mounts. Allocates and deallocates kmem_cache regions.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 main.c |  973 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 973 insertions(+)
--- linux-2.6.14-rc5-mm1/fs/ecryptfs/main.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/fs/ecryptfs/main.c	2005-11-01 14:41:36.000000000 -0600
@@ -0,0 +1,973 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (c) 1997-2003 Erez Zadok
+ * Copyright (c) 2001-2003 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
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
+#ifdef HAVE_CONFIG_H
+# include <config.h>
+#endif				/* HAVE_CONFIG_H */
+#include <net/sock.h>
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
+#define VERBOSE_DUMP 9
+#ifdef DEBUG
+int ecryptfs_verbosity = VERBOSE_DUMP;
+#else
+int ecryptfs_verbosity = 1;
+#endif
+module_param(ecryptfs_verbosity, int, 1);
+MODULE_PARM_DESC(ecryptfs_verbosity,
+		 "Initial verbosity level (0 or 1; defaults to "
+		 "0, which is Quiet)");
+
+void __ecryptfs_printk(int verb, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	if (unlikely((ecryptfs_verbosity == VERBOSE_DUMP))) {
+		vprintk(fmt, args);
+		goto out;
+	}
+	if ((ecryptfs_verbosity >= verb) && printk_ratelimit()) {
+		vprintk(fmt, args);
+	}
+out:
+	va_end(args);
+}
+
+#ifdef ECRYPTFS_ENABLE_MEMORY_TRACING
+static void ecryptfs_printk_release(void *ptr, const char *fun, int line)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: Releasing memory at location "
+			"[%p]\n", fun, line, ptr);
+}
+
+static void ecryptfs_printk_alloc(void *ptr, size_t size, const char *fun,
+				  int line)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: Allocated memory at location "
+			"[%p] ([%d] bytes)\n", fun, line, ptr, size);
+}
+
+void __ecryptfs_kfree(void *ptr, const char *fun, int line)
+{
+	if (unlikely(ECRYPTFS_ENABLE_MEMORY_TRACING))
+		ecryptfs_printk_release(ptr, fun, line);
+	kfree(ptr);
+}
+
+void *__ecryptfs_kmalloc(size_t size, unsigned int flags, const char *fun,
+			 int line)
+{
+	void *ptr;
+	ptr = kmalloc(size, flags);
+	if (unlikely(ECRYPTFS_ENABLE_MEMORY_TRACING))
+		ecryptfs_printk_alloc(ptr, size, fun, line);
+	return ptr;
+}
+
+#ifndef ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY
+#define ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY 1
+#endif
+
+void __ecryptfs_kmem_cache_free(struct kmem_cache_s *kmem_cache, void *ptr,
+				const char *fun, int line)
+{
+	ecryptfs_printk(ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY,
+			KERN_NOTICE, "%s:%d: calling kmem_cache_free() on "
+			"kmem_cache = [%p]; ptr = [%p]\n", fun, line,
+			kmem_cache, ptr);
+	kmem_cache_free(kmem_cache, ptr);
+}
+
+void *__ecryptfs_kmem_cache_alloc(kmem_cache_t * kmem_cache,
+				  unsigned int slab_type, const char *fun,
+				  int line)
+{
+	void *ptr;
+	ecryptfs_printk(ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY,
+			KERN_NOTICE, "%s:%d: calling kmem_cache_alloc() on "
+			"kmem_cache = [%p]\n", fun, line, kmem_cache);
+	ptr = kmem_cache_alloc(kmem_cache, slab_type);
+	ecryptfs_printk(ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY,
+			KERN_NOTICE, "%s:%d: called kmem_cache_alloc(); ptr "
+			"= [%p]\n", fun, line, ptr);
+	return ptr;
+}
+#endif				/* ECRYPTFS_ENABLE_MEMORY_TRACING */
+
+#ifdef ECRYPTFS_WRAP_VFS_CALLS
+struct inode *__ecryptfs_iget(struct super_block *sb, unsigned long ino,
+			      const char *fun, int line)
+{
+	int count;
+	struct inode *inode;
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling iget(); ino = [%lu]\n",
+			fun, line, ino);
+	inode = iget(sb, ino);
+	count = atomic_read(&inode->i_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called iget(): after call, "
+			"inode = [%p]; inode->i_count = [%d]\n", fun, line,
+			inode, count);
+	return inode;
+}
+
+void __ecryptfs_iput(struct inode *inode, const char *fun, int line)
+{
+	int count;
+	count = atomic_read(&inode->i_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling iput(); before call, "
+			"inode = [%p]; inode->i_count = [%d]\n", fun, line,
+			inode, count);
+	iput(inode);
+	count = atomic_read(&inode->i_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called iput(); after call, "
+			"inode->i_count = [%d]\n", fun, line, count);
+}
+
+void __ecryptfs_fput(struct file *file, const char *fun, int line)
+{
+	int count;
+	count = atomic_read(&file->f_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling fput(); before call, "
+			"file = [%p]; file->f_count = [%d]\n", fun, line,
+			file, count);
+	fput(file);
+	count = atomic_read(&file->f_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called fput(); after call, "
+			"file->f_count = [%d]\n", fun, line, count);
+}
+
+void __ecryptfs_d_add(struct dentry *dentry, struct inode *inode,
+		      const char *fun, int line)
+{
+	int count;
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_add(); before call, "
+			"dentry->d_count = [%d]\n", fun, line, count);
+	d_add(dentry, inode);
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called iget(): after call, "
+			"dentry->d_count = [%d]\n", fun, line, count);
+}
+
+void __ecryptfs_d_instantiate(struct dentry *dentry, struct inode *inode,
+			      const char *fun, int line)
+{
+	int count;
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_instantiate(); "
+			"before call, dentry->d_count = [%d]\n", fun, line,
+			count);
+	d_instantiate(dentry, inode);
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called d_instantiate(); "
+			"dentry->d_count = [%d]\n", fun, line, count);
+}
+
+struct dentry *__ecryptfs_d_alloc(struct dentry *parent,
+				  const struct qstr *name, const char *fun,
+				  int line)
+{
+	struct dentry *dentry;
+	dentry = d_alloc(parent, name);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: Allocated a new dentry at "
+			"location [%p] for name [%s]\n", fun, line, dentry,
+			name);
+	return dentry;
+}
+
+void __ecryptfs_d_drop(struct dentry *dentry, const char *fun, int line)
+{
+	int count;
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_drop() w/ "
+			"dentry = [%p]; dentry->d_count = [%d]\n", fun, line,
+			dentry, count);
+	d_drop(dentry);
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called d_drop(), "
+			"dentry->d_count = [%d]\n", fun, line, count);
+}
+
+void __ecryptfs_dput(struct dentry *dentry, const char *fun, int line)
+{
+	int count;
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling dput() on dentry with "
+			"dentry = [%p]; dentry->d_name.name = [%s]; "
+			"dentry->d_count = [%d]\n", fun, line,
+			dentry, dentry->d_name.name, count);
+	dput(dentry);
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called dput() on dentry; now "
+			"dentry->d_count = [%d]\n", fun, line, count);
+}
+
+struct dentry *__ecryptfs_dget(struct dentry *dentry, const char *fun, int line)
+{
+	int count;
+	struct dentry *ret_dentry;
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling dget() on dentry with "
+			"dentry = [%p]; dentry->d_name.name = [%s]; "
+			"dentry->d_count = [%d]\n", fun, line,
+			dentry, dentry->d_name.name, count);
+	if (count == 0) {
+		ecryptfs_printk(0, KERN_ERR, "%s:%d: The dentry has a count "
+				"of 0, which is illegal!\n");
+	}
+	ret_dentry = dget(dentry);
+	count = atomic_read(&dentry->d_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called dget() on dentry; now "
+			"dentry->d_count = [%d]\n", fun, line, count);
+	return ret_dentry;
+}
+
+struct file *__ecryptfs_dentry_open(struct dentry *dentry, struct vfsmount *mnt,
+				    int flags, const char *fun, int line)
+{
+	struct file *file;
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling dentry_open(); "
+			"dentry=[%p], mnt=[%p], flags=[0x%.8x]); "
+			"dentry->d_count = [%d]\n", fun, line, dentry, mnt,
+			flags, atomic_read(&dentry->d_count));
+	file = dentry_open(dentry, mnt, flags);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called dentry_open()\n",
+			fun, line);
+	return file;
+}
+
+void __ecryptfs_d_delete(struct dentry *dentry, const char *fun, int line)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_delete(); "
+			"dentry = [%p], dentry->d_name.name = [%s], "
+			"dentry->d_count = [%d]\n", fun, line, dentry,
+			dentry->d_name.name, atomic_read(&dentry->d_count));
+	d_delete(dentry);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called d_delete(); "
+			"dentry->d_count = [%d]\n", fun, line,
+			atomic_read(&dentry->d_count));
+}
+
+struct inode *__ecryptfs_igrab(struct inode *inode, const char *fun, int line)
+{
+	struct inode *ret_inode;
+	int count;
+	count = atomic_read(&inode->i_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling igrab(); before call, "
+			"inode = [%p]; inode->i_count = [%d]\n", fun, line,
+			inode, count);
+	ret_inode = igrab(inode);
+	count = atomic_read(&inode->i_count);
+	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called igrab(); after call, "
+			"inode->i_count = [%d]\n", fun, line, count);
+	return ret_inode;
+}
+
+#endif				/* #ifdef ECRYPTFS_WRAP_VFS_CALLS */
+
+/**
+ * Interposes upper and lower dentries.
+ * This function will call an ecryptfs_inode into existance through the call to
+ * ecryptfs_iget(sb, lower_inode->i_ino).
+ * 
+ * @param lower_dentry	existing dentry in the lower filesystem
+ * @param dentry	ecryptfs' dentry
+ * @param sb		eCryptfs's super_block
+ * @param flag		If set to true, then d_add is called, else d_instantiate
+ * 			is called.
+ * @return		Zero on success; non-zero otherwise
+ */
+int ecryptfs_interpose(struct dentry *lower_dentry, struct dentry *dentry,
+		       struct super_block *sb, int flag)
+{
+	struct inode *lower_inode;
+	int err = 0;
+	struct inode *inode;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; lower_dentry = [%p], "
+			"lower_dentry->d_name.name = [%s], dentry = "
+			"[%p], dentry->d_name.name = [%s], sb = [%p]; "
+			"flag = [%.4x]; lower_dentry->d_count "
+			"= [%d]; dentry->d_count = [%d]\n", lower_dentry,
+			lower_dentry->d_name.name, dentry, dentry->d_name.name,
+			sb, flag, atomic_read(&lower_dentry->d_count),
+			atomic_read(&dentry->d_count));
+	lower_inode = lower_dentry->d_inode;
+	if (lower_inode->i_sb != SUPERBLOCK_TO_LOWER(sb)) {
+		err = -EXDEV;
+		goto out;
+	}
+	inode = ecryptfs_iget(sb, lower_inode->i_ino);
+	if (!inode) {
+		err = -EACCES;
+		goto out;
+	}
+	/* This check is required here because if we failed to allocated the
+	 * required space for an inode_info_cache struct, then the only way
+	 * we know we failed, is by the pointer being NULL */
+	if (!INODE_TO_PRIVATE(inode)) {
+		ecryptfs_printk(1, KERN_ERR, "Out of memory. Failure to "
+				"allocate memory in ecryptfs_read_inode.\n");
+		err = -ENOMEM;
+		BUG();
+		goto out;
+	}
+
+	if (NULL == INODE_TO_LOWER(inode)) {
+		INODE_TO_LOWER(inode) = ecryptfs_igrab(lower_inode);
+		/* If we are still NULL at this point, igrab failed.
+		 * We are _NOT_ supposed to be failing here */
+		if (NULL == INODE_TO_LOWER(inode)) {
+			BUG();
+			err = -EINVAL;
+			goto out;
+		}
+	}
+	if (S_ISLNK(lower_inode->i_mode))
+		inode->i_op = &ecryptfs_symlink_iops;
+	else if (S_ISDIR(lower_inode->i_mode))
+		inode->i_op = &ecryptfs_dir_iops;
+	if (S_ISDIR(lower_inode->i_mode))
+		inode->i_fop = &ecryptfs_dir_fops;
+	/* TODO: Is there a better way to identify if the inode is
+	 * special? */
+	if (S_ISBLK(lower_inode->i_mode) || S_ISCHR(lower_inode->i_mode) ||
+	    S_ISFIFO(lower_inode->i_mode) || S_ISSOCK(lower_inode->i_mode)) {
+		init_special_inode(inode, lower_inode->i_mode,
+				   lower_inode->i_rdev);
+	}
+	dentry->d_op = &ecryptfs_dops;
+	if (flag) {
+		ecryptfs_d_add(dentry, inode);
+	} else {
+		ecryptfs_d_instantiate(dentry, inode);
+	}
+	ecryptfs_copy_attr_all(inode, lower_inode);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = %d\n", err);
+	return err;
+}
+
+/**
+ * For rvalue references; better to just use the macro.
+ */
+inline struct dentry *ecryptfs_lower_dentry(struct dentry *dentry)
+{
+	ASSERT(dentry);
+	return DENTRY_TO_LOWER(dentry);
+}
+
+enum { ecryptfs_opt_sig, ecryptfs_opt_debug, ecryptfs_opt_cipher,
+	ecryptfs_opt_err
+};
+
+static match_table_t tokens = {
+	{ecryptfs_opt_sig, "sig=%s"},
+	{ecryptfs_opt_debug, "debug=%u"},
+	{ecryptfs_opt_cipher, "cipher=%s"},
+	{ecryptfs_opt_err, NULL}
+};
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
+	struct ecryptfs_mount_crypt_stats *mount_crypt_stats =
+		&(SUPERBLOCK_TO_PRIVATE(sb)->mount_crypt_stats);
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; options = [%s]\n", options);
+	if (!options) {
+		rc = -EINVAL;
+		goto out;
+	}
+	while ((p = strsep(&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
+			continue;
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case ecryptfs_opt_sig:
+			{
+				char *sig_src;
+				char *sig_dst;
+				sig_src = args[0].from;
+				sig_dst =
+				    mount_crypt_stats->global_auth_tok_sig;
+				memcpy(sig_dst, sig_src, ECRYPTFS_SIG_SIZE_HEX);
+				sig_dst[ECRYPTFS_SIG_SIZE_HEX] = '\0';
+				ecryptfs_printk(1, KERN_NOTICE,
+						"The mount_crypt_stats "
+						"global_auth_tok_sig set to: "
+						"[%s]\n", sig_dst);
+				sig_set = 1;
+			}
+			break;
+		case ecryptfs_opt_debug:
+			{
+				char *debug_src = args[0].from;
+				ecryptfs_verbosity =
+				    (int)simple_strtol(debug_src, &debug_src,
+						       0);
+				ecryptfs_printk(1, KERN_NOTICE,
+						"Verbosity set to [%d]" "\n",
+						ecryptfs_verbosity);
+			}
+			break;
+		case ecryptfs_opt_cipher:
+			{
+				char *cipher_name_dst;
+				char *cipher_name_src;
+				cipher_name_src = args[0].from;
+				cipher_name_dst =
+				    mount_crypt_stats->
+				    global_default_cipher_name;
+				strncpy(cipher_name_dst, cipher_name_src,
+					ECRYPTFS_MAX_CIPHER_NAME_SIZE);
+				ecryptfs_printk(1, KERN_NOTICE,
+						"The mount_crypt_stats "
+						"global_default_cipher_name set to: "
+						"[%s]\n", cipher_name_dst);
+				cipher_name_set = 1;
+			}
+			break;
+		case ecryptfs_opt_err:
+		default:
+			ecryptfs_printk(1, KERN_WARNING,
+					"eCryptfs: unrecognized option '%s'\n",
+					options);
+		}
+	}
+	/* Do not support lack of mount-wide signature */
+	if (!sig_set) {
+		rc = -EINVAL;
+		ecryptfs_printk(0, KERN_ERR, "You must supply a valid "
+				"passphrase auth tok signature as a mount "
+				"parameter; see the eCryptfs README\n");
+		goto out;
+	}
+	if (!cipher_name_set) {
+		int cipher_name_len = strlen(ECRYPTFS_DEFAULT_CIPHER);
+		if (unlikely(cipher_name_len 
+			     >= ECRYPTFS_MAX_CIPHER_NAME_SIZE)) {
+			rc = -EINVAL;
+			BUG();
+			goto out;
+		}
+		memcpy(mount_crypt_stats->global_default_cipher_name,
+		       ECRYPTFS_DEFAULT_CIPHER, cipher_name_len);
+		mount_crypt_stats->global_default_cipher_name[cipher_name_len]
+		    = '\0';
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Requesting the key with description: "
+			"[%s]\n", mount_crypt_stats->global_auth_tok_sig);
+	/* N.B. The reference to this key is held until umount is done
+	 * The call to key_put is done in ecryptfs_put_super() */
+	auth_tok_key = request_key(&key_type_user,
+				   mount_crypt_stats->global_auth_tok_sig,
+				   NULL);
+	if (!auth_tok_key || IS_ERR(auth_tok_key)) {
+		ecryptfs_printk(0, KERN_ERR, "Could not find key with "
+				"description: [%s]\n",
+				mount_crypt_stats->global_auth_tok_sig);
+		process_request_key_err(PTR_ERR(auth_tok_key));
+		rc = -EINVAL;
+		goto out;
+	}
+	auth_tok = (struct ecryptfs_auth_tok *)KEY_PAYLOAD_DATA(auth_tok_key);
+	if (auth_tok->instanceof != ECRYPTFS_PASSWORD) {
+		ecryptfs_printk(0, KERN_ERR, "Invalid auth_tok structure "
+				"returned from key");
+		rc = -EINVAL;
+		goto out;
+	}
+	mount_crypt_stats->global_auth_tok_key = auth_tok_key;
+	mount_crypt_stats->global_auth_tok = auth_tok;
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
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
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; sb = [%p], sb->s_root = [%p] "
+			"SUPERBLOCK_TO_PRIVATE(sb) = [%p] sb->s_root.d_name->"
+			"name = [%s]\n", sb,
+			sb->s_root, SUPERBLOCK_TO_PRIVATE(sb),
+			sb->s_root->d_name.name);
+	up_write(&sb->s_umount);
+	deactivate_super(sb);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
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
+	int err = 0;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; sb = [%p] raw_data = [%s] "
+			"silent = [%d]\n", sb, (char *)raw_data, silent);
+	/* Released in ecryptfs_put_super() */
+	SUPERBLOCK_TO_PRIVATE_SM(sb) =
+	    ecryptfs_kmem_cache_alloc(ecryptfs_sb_info_cache, SLAB_KERNEL);
+	if (!SUPERBLOCK_TO_PRIVATE_SM(sb)) {
+		ecryptfs_printk(0, KERN_WARNING, "Out of memory\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	memset(SUPERBLOCK_TO_PRIVATE(sb), 0, sizeof(struct ecryptfs_sb_info));
+	sb->s_op = &ecryptfs_sops;
+	/* Released through deactivate_super(sb) from get_sb_nodev */
+	sb->s_root = d_alloc(NULL, &(const struct qstr) {
+			     .hash = 0,.name = "/",.len = 1});
+	if (!sb->s_root) {
+		ecryptfs_printk(0, KERN_ERR, "d_alloc failed\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	sb->s_root->d_op = &ecryptfs_dops;
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	/* Released in ecryptfs_d_release when dput(sb->s_root) is called */
+	/* through deactivate_super(sb) from get_sb_nodev() */
+	DENTRY_TO_PRIVATE_SM(sb->s_root) = (struct ecryptfs_dentry_info *)
+	    ecryptfs_kmem_cache_alloc(ecryptfs_dentry_info_cache, SLAB_KERNEL);
+	if (!DENTRY_TO_PRIVATE_SM(sb->s_root)) {
+		ecryptfs_printk(0, KERN_ERR,
+				"dentry_info_cache alloc failed\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	memset(DENTRY_TO_PRIVATE(sb->s_root), 0,
+	       sizeof(struct ecryptfs_dentry_info));
+	err = 0;
+out:
+	/* Should be able to rely on deactive_super called from get_sb_nodev */
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return err;
+}
+
+/**
+ * Read the super block of the lower filesystem, and use ecryptfs_interpose
+ * to create our initial inode and super block struct
+ */
+static int ecryptfs_read_super(struct super_block *sb, const char *dev_name)
+{
+	int err;
+	struct nameidata nd;
+	struct dentry *lower_root;
+	memset(&nd, 0, sizeof(struct nameidata));
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; sb = [%p], dev_name = [%s]\n",
+			sb, dev_name);
+	err = path_lookup(dev_name, LOOKUP_FOLLOW, &nd);
+	if (err) {
+		ecryptfs_printk(0, KERN_WARNING, "path_lookup() failed\n");
+		goto out_free;
+	}
+	lower_root = nd.dentry;
+	SUPERBLOCK_TO_PRIVATE(sb)->lower_mnt = nd.mnt;
+	if (!lower_root->d_inode) {
+		ecryptfs_printk(0, KERN_WARNING,
+				"No directory to interpose on\n");
+		err = -ENOENT;
+		goto out_free;
+	}
+	SUPERBLOCK_TO_LOWER(sb) = lower_root->d_sb;
+	sb->s_maxbytes = lower_root->d_sb->s_maxbytes;
+	DENTRY_TO_LOWER(sb->s_root) = lower_root;
+	if ((err = ecryptfs_interpose(lower_root, sb->s_root, sb, 0))) {
+		goto out_free;
+	}
+	err = 0;
+	goto out;
+out_free:
+	path_release(&nd);
+	ecryptfs_cleanup_read_super(sb);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return err;
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
+	int err;
+	struct super_block *sb = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; fs_type = [%p], flags = [%d],"
+			" dev_name = [%s], raw_data = [%s]\n",
+			fs_type, flags, dev_name, (char *)raw_data);
+	sb = get_sb_nodev(fs_type, flags, raw_data, ecryptfs_fill_super);
+	if (IS_ERR(sb)) {
+		ecryptfs_printk(0, KERN_ERR, "Getting sb failed. "
+				"sb = [%p]\n", sb);
+		goto out;
+	}
+	err = ecryptfs_parse_options(sb, raw_data);
+	if (err) {
+		sb = ERR_PTR(err);
+		goto out;
+	}
+	err = ecryptfs_read_super(sb, dev_name);
+	if (err) {
+		sb = ERR_PTR(err);
+		ecryptfs_printk(0, KERN_ERR, "Reading sb failed. "
+				"sb = [%p]\n", sb);
+	}
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%p]\n", sb);
+	return sb;
+}
+
+/**
+ * Used to bring the superblock down and free the private data.
+ * Private data is free'd in ecryptfs_put_super()
+ */
+static void ecryptfs_kill_block_super(struct super_block *sb)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; sb = [%p], sb->s_root = [%p] "
+			"SUPERBLOCK_TO_PRIVATE(sb) = [%p]\n", sb, sb->s_root,
+			SUPERBLOCK_TO_PRIVATE(sb));
+	generic_shutdown_super(sb);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
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
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		inode_init_once(&ei->vfs_inode);
+	}
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
+ * @return Zero on success; non-zero otherwise
+ *
+ * Sets ecryptfs_allocated_caches with flags so that we can
+ * free created caches should we run out of memory during
+ * creation period.
+ *
+ * The overhead for doing this is offset by the fact that we
+ * only do this once, and that should there be insufficient
+ * memory, then we can elegantly fail, and not leave extra
+ * caches around, or worse, panic the kernel trying to free
+ * something that's not there.
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
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_auth_tok_list_item "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_file_info_cache =
+	    kmem_cache_create("ecryptfs_file_cache",
+			      sizeof(struct ecryptfs_file_info),
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_file_info_cache)
+		rc |= ECRYPTFS_FILE_INFO_CACHE;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_file_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_dentry_info_cache =
+	    kmem_cache_create("ecryptfs_dentry_cache",
+			      sizeof(struct ecryptfs_dentry_info),
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_dentry_info_cache)
+		rc |= ECRYPTFS_DENTRY_INFO_CACHE;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_dentry_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_inode_info_cache =
+	    kmem_cache_create("ecryptfs_inode_cache",
+			      sizeof(struct ecryptfs_inode_info), 0,
+			      SLAB_HWCACHE_ALIGN, inode_info_init_once, NULL);
+	if (ecryptfs_inode_info_cache)
+		rc |= ECRYPTFS_INODE_INFO_CACHE;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_inode_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_sb_info_cache =
+	    kmem_cache_create("ecryptfs_sb_cache",
+			      sizeof(struct ecryptfs_sb_info),
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_sb_info_cache)
+		rc |= ECRYPTFS_SB_INFO_CACHE;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_sb_cache "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_header_cache_0 =
+	    kmem_cache_create("ecryptfs_headers_0", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_header_cache_0)
+		rc |= ECRYPTFS_HEADER_CACHE_0;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_headers_0 "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_header_cache_1 =
+	    kmem_cache_create("ecryptfs_headers_1", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_header_cache_1)
+		rc |= ECRYPTFS_HEADER_CACHE_1;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_headers_1 "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_header_cache_2 =
+	    kmem_cache_create("ecryptfs_headers_2", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_header_cache_2)
+		rc |= ECRYPTFS_HEADER_CACHE_2;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_headers_2 "
+				"kmem_cache_create failed\n");
+
+	ecryptfs_lower_page_cache =
+	    kmem_cache_create("ecryptfs_lower_page_cache", PAGE_CACHE_SIZE,
+			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (ecryptfs_lower_page_cache)
+		rc |= ECRYPTFS_LOWER_PAGE_CACHE;
+	else
+		ecryptfs_printk(0, KERN_WARNING, "ecryptfs_lower_page_cache "
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
+	if (ecryptfs_allocated_caches & ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE) {
+		rc = kmem_cache_destroy(ecryptfs_auth_tok_list_item_cache);
+		if (rc)
+			ecryptfs_printk(0, KERN_WARNING,
+					"Not all ecryptfs_auth_tok_"
+					"list_item_cache structures were "
+					"freed\n");
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_FILE_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_file_info_cache);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING,
+					"Not all ecryptfs_file_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_DENTRY_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_dentry_info_cache);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING,
+					"Not all ecryptfs_dentry_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_INODE_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_inode_info_cache);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING,
+					"Not all ecryptfs_inode_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_SB_INFO_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_sb_info_cache);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING,
+					"Not all ecryptfs_sb_info_"
+					"cache regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_0) {
+		err = kmem_cache_destroy(ecryptfs_header_cache_0);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
+					"header_cache_0 regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_1) {
+		err = kmem_cache_destroy(ecryptfs_header_cache_1);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
+					"header_cache_1 regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_2) {
+		err = kmem_cache_destroy(ecryptfs_header_cache_2);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
+					"header_cache_2 regions were freed\n");
+		rc |= err;
+	}
+	if (ecryptfs_allocated_caches & ECRYPTFS_LOWER_PAGE_CACHE) {
+		err = kmem_cache_destroy(ecryptfs_lower_page_cache);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
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
+	rc = ecryptfs_init_kmem_caches();
+	if (rc) {
+		ecryptfs_printk(0, KERN_EMERG, "Failure occured while "
+				"attempting to create caches [CREATED: %x]."
+				"Now freeing caches.\n",
+				ecryptfs_allocated_caches);
+		ecryptfs_free_kmem_caches();
+		return -ENOMEM;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Registering eCryptfs\n");
+	return register_filesystem(&ecryptfs_fs_type);
+}
+
+static void __exit exit_ecryptfs_fs(void)
+{
+	int rc;
+	ecryptfs_printk(1, KERN_NOTICE, "Unregistering eCryptfs\n");
+	unregister_filesystem(&ecryptfs_fs_type);
+	rc = ecryptfs_free_kmem_caches();
+	if (rc) {
+		ecryptfs_printk(0, KERN_EMERG, "Failure occured while "
+				"attempting to free caches: [%d]\n", rc);
+	}
+}
+
+MODULE_AUTHOR("Michael A. Halcrow <mhalcrow@us.ibm.com>");
+MODULE_DESCRIPTION("eCryptfs");
+
+MODULE_LICENSE("GPL");
+
+module_init(init_ecryptfs_fs)
+module_exit(exit_ecryptfs_fs)
