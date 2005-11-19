Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVKSESi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVKSESi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVKSESi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:18:38 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:758 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1751315AbVKSESh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:18:37 -0500
Date: Fri, 18 Nov 2005 21:18:37 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 5/12: eCryptfs] Header declarations
Message-ID: <20051119041837.GE15747@sshock.rn.byu.edu>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119041130.GA15559@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This header contains declarations for various structs used in
eCryptfs. Some of these are accessed both in userspace and in the
kernel, so it is important to make sure that the struct declarations
match in both places.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Michael Thompson <mcthomps@us.ibm.com>

---

 ecryptfs_kernel.h |  430 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 430 insertions(+)
--- linux-2.6.15-rc1-mm1/fs/ecryptfs/ecryptfs_kernel.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.15-rc1-mm1-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h	2005-11-18 11:20:09.000000000 -0600
@@ -0,0 +1,430 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ * Kernel declarations.
+ *
+ * Copyright (c) 1997-2003 Erez Zadok
+ * Copyright (c) 2001-2003 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
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
+#ifndef ECRYPTFS_KERNEL_H
+#define ECRYPTFS_KERNEL_H
+
+#include <linux/fs.h>
+#include <asm/semaphore.h>
+#include <asm/scatterlist.h>
+
+#define ECRYPTFS_MAX_PASSWORD_LENGTH 64
+#define ECRYPTFS_MAX_PASSPHRASE_BYTES ECRYPTFS_MAX_PASSWORD_LENGTH
+#define ECRYPTFS_SALT_SIZE 8
+#define ECRYPTFS_SALT_SIZE_HEX (ECRYPTFS_SALT_SIZE*2)
+/* The original signature size is only for what is stored on disk; all
+ * in-memory representations are expanded hex, so it better adapted to
+ * be passed around or referenced on the command line */
+#define ECRYPTFS_SIG_SIZE 8
+#define ECRYPTFS_SIG_SIZE_HEX (ECRYPTFS_SIG_SIZE*2)
+#define ECRYPTFS_PASSWORD_SIG_SIZE ECRYPTFS_SIG_SIZE_HEX
+#define ECRYPTFS_MAX_KEY_BYTES 16
+#define ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES 512
+#define ECRYPTFS_DEFAULT_IV_BYTES 8
+#define ECRYPTFS_FILE_VERSION 0x01
+
+/**
+ * For convenience, we may need to pass around the encrypted session
+ * key between kernel and userspace because the authentication token
+ * may not be extractable.  For example, the TPM may not release the
+ * private key, instead requiring the encrypted data and returning the
+ * decrypted data.
+ */
+struct ecryptfs_session_key {
+#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT 0x01
+#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT 0x02
+#define ECRYPTFS_CONTAINS_DECRYPTED_KEY 0x04
+#define ECRYPTFS_CONTAINS_ENCRYPTED_KEY 0x08
+	int32_t flags;
+	int32_t encrypted_key_size;
+	int32_t decrypted_key_size;
+	uint8_t decrypted_key[ECRYPTFS_MAX_KEY_BYTES];
+	uint8_t encrypted_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
+};
+
+/**
+ * States for this struct are:
+ *  - Uninstantiated: no password, but the salt, encrypted session
+ *    key, etc. are filled in
+ *  - Uninstantiated: no password, salt, etc. are filled in; at this
+ *    time, there is no reason for the auth_tok to exist and be in
+ *    this state
+ *  - Instantiated: password, but no salt, and hence no encrypted
+ *    session key, etc.  eCryptfs will generate those items when the
+ *    time come to write out the headers to disk
+ *  - Instantiated: password, salt, encrypted session key, etc.  This
+ *    is typically used to actually obtain the session key for the
+ *    file
+ */
+struct ecryptfs_password {
+	int32_t saltless;       /* If set, this is the ``seed'' token
+				 * from which other salted tokens are
+				 * derived. Note that this is _not_
+				 * the same as a token that just has
+				 * not received its salt yet. */
+	int32_t password_size;
+	int32_t hash_algo;
+	int32_t hash_iterations;
+	int32_t session_key_encryption_key_size;	/* In bytes */
+	int32_t session_key_encryption_key_set;
+	uint8_t salt[ECRYPTFS_SALT_SIZE];
+	/* Always in expanded hex */
+	uint8_t signature[ECRYPTFS_PASSWORD_SIG_SIZE + 1];
+	uint8_t password[ECRYPTFS_MAX_PASSWORD_LENGTH];
+	/* Iterated-hash concatenation of salt and passphrase */
+	uint8_t session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
+};
+
+/* May be a password or a private key */
+struct ecryptfs_auth_tok {
+	int32_t instantiated;	/* When not instantiated, this struct only
+				 * contains enough information to construct
+				 * the file headers, which contain token
+				 * descriptors */
+#define ECRYPTFS_PASSWORD 0
+#define ECRYPTFS_PRIVATE_KEY 1
+	int32_t instanceof;
+	int32_t expired;
+	uid_t uid;
+	int64_t creation_time;
+	int64_t expiration_time;
+	/* This is in case we want userspace to extract the session
+	 * key */
+	struct ecryptfs_session_key session_key;
+	union {
+		struct ecryptfs_password password;
+		/* Private key is in future eCryptfs releases */
+	} token;
+};
+
+void dump_auth_tok(struct ecryptfs_auth_tok *auth_tok);
+extern void ecryptfs_to_hex(char *dst, char *src, int src_size);
+extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
+
+/* For ecryptfs_auth_tok_packet_set.packet_set_type */
+#define ECRYPTFS_PACKET_SET_TYPE_PASSWORD 0
+
+#ifndef ECRYPTFS_DEBUG
+#define ECRYPTFS_DEBUG 1
+#endif
+
+/* See RFC 2440 */
+struct ecryptfs_key_record {
+	unsigned char type;
+	unsigned char sig[ECRYPTFS_SIG_SIZE];
+	u16 enc_key_size_bits;
+	unsigned char enc_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
+};
+#define KEY_REC_SIZE(key_rec) \
+        ( sizeof(struct ecryptfs_key_record) - ECRYPTFS_MAX_KEY_BYTES \
+          + key_rec.enc_key_size_bits/8 )
+
+/* TODO: kref */
+struct ecryptfs_auth_tok_list {
+	struct ecryptfs_auth_tok *auth_tok;
+	struct list_head list;
+};
+
+/* Structure prototypes */
+struct ecryptfs_crypt_stats;
+struct ecryptfs_mount_crypt_stats;
+
+#define KEY_PAYLOAD_DATA(key) \
+	( ((struct user_key_payload*)key->payload.data)->data)
+#define KEY_PAYLOAD_LEN(key) \
+	( ((struct user_key_payload*)key->payload.data)->datalen)
+
+#define ECRYPTFS_SUPER_MAGIC 0xf15f
+#define ECRYPTFS_MAX_KEYSET_SIZE 1024
+#define ECRYPTFS_MAX_CIPHER_NAME_SIZE 32
+#define ECRYPTFS_MAX_NUM_ENC_KEYS 64
+#define ECRYPTFS_MAX_NUM_KEYSIGS 64	/* TODO: make it a list */
+#define ECRYPTFS_MAX_IV_BYTES 8	/* 64 bits */
+#define ECRYPTFS_SALT_BYTES 2
+#define MAGIC_ECRYPTFS_MARKER 0x3c81b7f5
+#define MAGIC_ECRYPTFS_MARKER_SIZE_BYTES 8	/* 4*2 */
+#define ECRYPTFS_FILE_SIZE_BYTES 8
+#define ECRYPTFS_DEFAULT_CIPHER "blowfish"
+#define ECRYPTFS_DEFAULT_KEY_BYTES 16
+
+/**
+ * IV_SIZE (i.e., 8 bytes)
+ * HMAC_SIZE (i.e., 20 bytes)
+ * IVS_PER_PAGE (i.e., 512)
+ * IVS_PER_PAGE * HMAC_SIZE = TOTAL_SIZE_PER_EXTENT; 512 * 20 = 10240
+ * TOTAL_SIZE_PER_EXTENT / PAGE_SIZE = NUM_PAGES_FOR_HMACS = 2.5
+ * PIIHHHHHDx1024IIHHHHHDx1024...
+ * PIDx512IDx512...
+ * Or: [Ix146+Hx146] (wastes 8 bytes per page)
+ */
+
+/**
+ * This is the primary struct associated with each encrypted file.
+ *
+ * TODO: cache align/pack?
+ */
+struct ecryptfs_crypt_stats {
+	int struct_initialized;
+	int policy_applied;
+	int new_file;
+	int encrypted;
+	int security_warning;	/* This flag is set if something happens
+				 * that could weaken the security of the
+				 * file */
+	int iv_bytes;		/* Set to 0 if encryption not enabled */
+	int records_per_page;	/* extent_size / (iv_bytes + hmac_bytes) */
+#define ECRYPTFS_IV_ROTATE_NO 0
+#define ECRYPTFS_IV_ROTATE_INCREMENT 1
+#define ECRYPTFS_IV_ROTATE_PERMUTATE 2
+#define ECRYPTFS_IV_ROTATE_RANDOM 3
+	int rotate_iv;		/* Whether or not to rotate the IV on each
+				 * write (performance vs. security tradeoff) */
+	int encrypt_iv_pages;	/* To attempt to hide sparse regions? */
+	int num_keysigs;
+	int num_header_pages;	/* Number of pages that comprise the
+				 * header */
+	int extent_size;
+	int key_size_bits;
+	int key_valid;
+	struct crypto_tfm *tfm;
+	unsigned char iv[ECRYPTFS_MAX_IV_BYTES];
+	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
+	char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
+	struct semaphore iv_sem;
+	char keysigs[ECRYPTFS_MAX_NUM_KEYSIGS][ECRYPTFS_SIG_SIZE_HEX];
+};
+
+/* inode private data. */
+struct ecryptfs_inode_info {
+	struct inode *wii_inode;
+	struct ecryptfs_crypt_stats crypt_stats;
+	struct inode vfs_inode;
+};
+
+/* dentry private data. */
+struct ecryptfs_dentry_info {
+	struct dentry *wdi_dentry;
+	struct ecryptfs_crypt_stats *crypt_stats;
+};
+
+/**
+ * This struct is to enable a mount-wide passphrase/salt combo. This
+ * is more or less a stopgap to provide similar functionality to other
+ * crypto filesystems like EncFS or CFS until full policy support is
+ * implemented in eCryptfs.
+ */
+struct ecryptfs_mount_crypt_stats {
+	/* N.B. Pointers to memory we do not own, do not free these */
+	struct ecryptfs_auth_tok *global_auth_tok;
+	struct key *global_auth_tok_key;
+	char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
+	char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
+};
+
+/* super block private data. */
+struct ecryptfs_sb_info {
+	struct super_block *wsi_sb;
+	struct vfsmount *lower_mnt;
+	struct ecryptfs_mount_crypt_stats mount_crypt_stats;
+};
+
+/* file private data. */
+struct ecryptfs_file_info {
+	struct file *wfi_file;
+	struct ecryptfs_crypt_stats *crypt_stats;
+};
+
+/* auth_tok <=> encrypted_session_key mappings */
+struct ecryptfs_auth_tok_list_item {
+	struct list_head list;
+	struct ecryptfs_auth_tok auth_tok;
+	char encrypted_session_key[ECRYPTFS_MAX_KEY_BYTES];
+};
+
+extern inline pgoff_t 
+ecryptfs_pg_idx_to_lwr_pg_idx(struct ecryptfs_crypt_stats *crypt_stats,
+			      pgoff_t idx)
+{
+	return ((idx / crypt_stats->records_per_page) + idx
+		+ crypt_stats->num_header_pages + 1);
+}
+
+#ifndef DEFAULT_POLLMASK
+#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
+#endif				/* ndef DEFAULT_POLLMASK */
+
+#define OBSERVE_ASSERTS 1
+#ifdef OBSERVE_ASSERTS
+#define ASSERT(EX)	                                                      \
+do {	                                                                      \
+        if (unlikely(!(EX))) {                                                \
+	        printk(KERN_CRIT "ASSERTION FAILED: %s at %s:%d (%s)\n", #EX, \
+	               __FILE__, __LINE__, __FUNCTION__);	              \
+                BUG();                                                        \
+        }	                                                              \
+} while (0)
+#else
+#define ASSERT(EX) ;
+#endif				/* OBSERVE_ASSERTS */
+
+/**
+ * Halcrow: What does the kernel VFS do to ensure that there is no
+ * contention for file->private_data?
+ */
+#define ECRYPTFS_FILE_TO_PRIVATE(file) ((struct ecryptfs_file_info *) \
+                                        ((file)->private_data))
+#define ECRYPTFS_FILE_TO_PRIVATE_SM(file) ((file)->private_data)
+#define ECRYPTFS_FILE_TO_LOWER(file) \
+        ((ECRYPTFS_FILE_TO_PRIVATE(file))->wfi_file)
+#define ECRYPTFS_INODE_TO_PRIVATE(ino) ((struct ecryptfs_inode_info *) \
+                                        (ino)->u.generic_ip)
+#define ECRYPTFS_INODE_TO_PRIVATE_SM(ino) ((ino)->u.generic_ip)
+#define ECRYPTFS_INODE_TO_LOWER(ino) (ECRYPTFS_INODE_TO_PRIVATE(ino)->wii_inode)
+#define ECRYPTFS_SUPERBLOCK_TO_PRIVATE(super) ((struct ecryptfs_sb_info *) \
+                                               (super)->s_fs_info)
+#define ECRYPTFS_SUPERBLOCK_TO_PRIVATE_SM(super) ((super)->s_fs_info)
+#define ECRYPTFS_SUPERBLOCK_TO_LOWER(super) \
+        (ECRYPTFS_SUPERBLOCK_TO_PRIVATE(super)->wsi_sb)
+#define ECRYPTFS_DENTRY_TO_PRIVATE_SM(dentry) ((dentry)->d_fsdata)
+#define ECRYPTFS_DENTRY_TO_PRIVATE(dentry) ((struct ecryptfs_dentry_info *) \
+                                            (dentry)->d_fsdata)
+#define ECRYPTFS_DENTRY_TO_LOWER(dentry) \
+        (ECRYPTFS_DENTRY_TO_PRIVATE(dentry)->wdi_dentry)
+
+/*
+ * Flags for ecryptfs_{en,de}code_filename
+ * DO_DOTS means the special entries . and .. should be encoded (for symlink)
+ * SKIP_DOTS means they should be preserved intact
+ */
+#define ECRYPTFS_DO_DOTS   0
+#define ECRYPTFS_SKIP_DOTS 1
+
+/**
+ * EXTERNALS:
+ */
+extern struct file_operations ecryptfs_main_fops;
+extern struct file_operations ecryptfs_dir_fops;
+extern struct inode_operations ecryptfs_main_iops;
+extern struct inode_operations ecryptfs_dir_iops;
+extern struct inode_operations ecryptfs_symlink_iops;
+extern struct super_operations ecryptfs_sops;
+extern struct dentry_operations ecryptfs_dops;
+extern struct address_space_operations ecryptfs_aops;
+struct ecryptfs_key_record;
+struct ecryptfs_auth_tok;
+
+/**
+ * TODO: Make eCryptfs's memory usage as lean as possible
+ */
+extern kmem_cache_t *ecryptfs_auth_tok_list_item_cache;
+extern kmem_cache_t *ecryptfs_file_info_cache;
+extern kmem_cache_t *ecryptfs_dentry_info_cache;
+extern kmem_cache_t *ecryptfs_inode_info_cache;
+extern kmem_cache_t *ecryptfs_sb_info_cache;
+extern kmem_cache_t *ecryptfs_header_cache_0;
+extern kmem_cache_t *ecryptfs_header_cache_1;
+extern kmem_cache_t *ecryptfs_header_cache_2;
+extern kmem_cache_t *ecryptfs_lower_page_cache;
+
+int ecryptfs_interpose(struct dentry *hidden_dentry,
+		       struct dentry *this_dentry, struct super_block *sb,
+		       int flag);
+int ecryptfs_fill_zeros(struct file *file, loff_t new_length);
+int ecryptfs_decode_filename(const char *name, int length,
+			     char **decrypted_name, int skip_dots,
+			     struct ecryptfs_crypt_stats *crypt_stats);
+int ecryptfs_encode_filename(const char *name, int length,
+			     char **encoded_name, int skip_dots,
+			     struct ecryptfs_crypt_stats *crypt_stats);
+struct dentry *ecryptfs_lower_dentry(struct dentry *this_dentry);
+
+void ecryptfs_copy_attr_times(struct inode *dest, const struct inode *src);
+void ecryptfs_copy_attr_atime(struct inode *dest, const struct inode *src);
+void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src);
+void ecryptfs_copy_inode_size(struct inode *dst, const struct inode *src);
+
+#define ecryptfs_printk(verb, type, fmt, arg...) \
+        __ecryptfs_printk((verb), type "%s: " fmt, __FUNCTION__, ## arg);
+void __ecryptfs_printk(int verb, const char *fmt, ...);
+
+extern int ecryptfs_verbosity;
+
+/* crypto */
+void ecryptfs_dump_hex(char *data, int bytes);
+int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
+			int sg_size);
+void ecryptfs_rotate_iv(unsigned char *iv);
+void ecryptfs_init_crypt_stats(struct ecryptfs_crypt_stats *crypt_stats);
+void ecryptfs_destruct_crypt_stats(struct ecryptfs_crypt_stats *crypt_stats);
+int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stats *crypt_stats);
+int ecryptfs_write_inode_size_to_header(struct file *lower_file,
+					struct inode *lower_inode,
+					struct inode *inode);
+int do_encrypt_page(struct ecryptfs_crypt_stats *crypt_stats,
+		    struct page *dest_page, struct page *src_page,
+		    unsigned char *iv);
+int do_encrypt_page_offset(struct ecryptfs_crypt_stats *crypt_stats,
+			   struct page *dest_page, int dest_offset,
+			   struct page *src_page, int src_offset, int size,
+			   unsigned char *iv);
+int do_decrypt_page(struct ecryptfs_crypt_stats *crypt_stats,
+		    struct page *dest_page, struct page *src_page,
+		    unsigned char *iv);
+int do_decrypt_page_offset(struct ecryptfs_crypt_stats *crypt_stats,
+			   struct page *dest_page, int dest_offset,
+			   struct page *src_page, int src_offset, int size,
+			   unsigned char *iv);
+int do_encrypt_virt(struct ecryptfs_crypt_stats *crypt_stats,
+		    char *dest_virt_addr, const char *src_virt_addr,
+		    int size, unsigned char *iv);
+int do_decrypt_virt(struct ecryptfs_crypt_stats *crypt_stats,
+		    char *dest_virt_addr, const char *src_virt_addr,
+		    int size, unsigned char *iv);
+int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
+			   struct file *lower_file);
+int ecryptfs_write_headers_virt(char *page_virt, 
+				struct ecryptfs_crypt_stats *crypt_stats,
+				struct dentry *ecryptfs_dentry, int version);
+int ecryptfs_read_headers(struct dentry *ecryptfs_dentry,
+			  struct file *lower_file);
+int ecryptfs_new_file_context(struct dentry *ecryptfs_dentry);
+int contains_ecryptfs_marker(char *data);
+int ecryptfs_read_header_region(char *data, struct dentry *dentry,
+				struct nameidata *nd);
+u16 ecryptfs_code_for_cipher_string(char *str);
+int ecryptfs_cipher_code_to_string(char *str, u16 cipher_code);
+void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stats *crypt_stats);
+int ecryptfs_generate_key_packet_set(char *dest_base,
+				     struct ecryptfs_crypt_stats *crypt_stats,
+				     struct dentry *ecryptfs_dentry, int *len);
+int process_request_key_err(long err_code);
+int ecryptfs_parse_packet_set(unsigned char *dest,
+			      struct ecryptfs_crypt_stats *crypt_stats,
+			      struct dentry *ecryptfs_dentry, int version);
+
+/* inode.c */
+int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
+
+#endif				/* ndef ECRYPTFS_KERNEL_H */
