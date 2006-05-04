Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWEDDhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWEDDhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWEDDhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:37:50 -0400
Received: from c-67-177-57-20.hsd1.co.comcast.net ([67.177.57.20]:22010 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750974AbWEDDhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:37:48 -0400
Date: Wed, 3 May 2006 21:37:50 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 5/13: eCryptfs] Header declarations
Message-ID: <20060504033750.GD28613@hellewell.homeip.net>
References: <20060504031755.GA28257@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504031755.GA28257@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 5th patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

This header contains declarations for various structs used in
eCryptfs.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 ecryptfs_kernel.h |  400 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 400 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h	2006-05-02 19:36:00.000000000 -0600
@@ -0,0 +1,400 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ * Kernel declarations.
+ *
+ * Copyright (C) 1997-2003 Erez Zadok
+ * Copyright (C) 2001-2003 Stony Brook University
+ * Copyright (C) 2004-2006 International Business Machines Corp.
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
+#ifdef CONFIG_ECRYPT_DEBUG
+#define OBSERVE_ASSERTS 1
+#endif
+
+#include <linux/fs.h>
+#include <asm/semaphore.h>
+#include <asm/scatterlist.h>
+
+/* Version verification for shared data structures w/ userspace */
+#ifndef ECRYPTFS_VERSION_MAJOR
+#define ECRYPTFS_VERSION_MAJOR 0x00
+#endif
+#ifndef ECRYPTFS_VERSION_MINOR
+#define ECRYPTFS_VERSION_MINOR 0x01
+#endif
+
+#ifndef ECRYPTFS_SUPPORTED_FILE_VERSION
+#define ECRYPTFS_SUPPORTED_FILE_VERSION 0x01
+#endif
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
+#define ECRYPTFS_DEFAULT_IV_BYTES 16
+#define ECRYPTFS_FILE_VERSION 0x01
+#define ECRYPTFS_DEFAULT_HEADER_EXTENT_SIZE 8192
+#define ECRYPTFS_DEFAULT_EXTENT_SIZE 4096
+#define ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE 8192
+
+#define ECRYPTFS_SET_FLAG(flag_bit_vector, flag) (flag_bit_vector |= (flag))
+#define ECRYPTFS_CLEAR_FLAG(flag_bit_vector, flag) (flag_bit_vector &= ~(flag))
+#define ECRYPTFS_CHECK_FLAG(flag_bit_vector, flag) (flag_bit_vector & (flag))
+
+/**
+ * For convenience, we may need to pass around the encrypted session
+ * key between kernel and userspace because the authentication token
+ * may not be extractable.  For example, the TPM may not release the
+ * private key, instead requiring the encrypted data and returning the
+ * decrypted data.
+ */
+struct ecryptfs_session_key {
+#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT 0x00000001
+#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT 0x00000002
+#define ECRYPTFS_CONTAINS_DECRYPTED_KEY 0x00000004
+#define ECRYPTFS_CONTAINS_ENCRYPTED_KEY 0x00000008
+	int32_t flags;
+	int32_t encrypted_key_size;
+	int32_t decrypted_key_size;
+	uint8_t encrypted_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
+	uint8_t decrypted_key[ECRYPTFS_MAX_KEY_BYTES];
+};
+
+struct ecryptfs_password {
+	int32_t password_bytes;
+	int32_t hash_algo;
+	int32_t hash_iterations;
+	int32_t session_key_encryption_key_bytes;
+#define ECRYPTFS_PERSISTENT_PASSWORD             0x01
+#define ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET  0x02
+	uint32_t flags;
+	/* Iterated-hash concatenation of salt and passphrase */
+	uint8_t session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
+	uint8_t signature[ECRYPTFS_PASSWORD_SIG_SIZE + 1];
+	/* Always in expanded hex */
+	uint8_t salt[ECRYPTFS_SALT_SIZE];
+};
+
+/* May be a password or a private key */
+struct ecryptfs_auth_tok {
+	uint16_t version; /* 8-bit major and 8-bit minor */
+#define ECRYPTFS_PASSWORD         0x00000001
+#define ECRYPTFS_PRIVATE_KEY      0x00000002
+#define ECRYPTFS_CONTAINS_SECRET  0x00000004
+#define ECRYPTFS_EXPIRED          0x00000008
+	uint32_t flags;
+	uid_t uid;
+	int64_t creation_time;
+	int64_t expiration_time;
+	union {
+		struct ecryptfs_password password;
+		/* Private key is in future eCryptfs releases */
+	} token;
+	struct ecryptfs_session_key session_key;
+};
+
+void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok);
+extern void ecryptfs_to_hex(char *dst, char *src, int src_size);
+extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
+
+struct ecryptfs_key_record {
+	u16 enc_key_size_bits;
+	unsigned char type;
+	unsigned char sig[ECRYPTFS_SIG_SIZE];
+	unsigned char enc_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
+};
+
+struct ecryptfs_auth_tok_list {
+	struct ecryptfs_auth_tok *auth_tok;
+	struct list_head list;
+};
+
+struct ecryptfs_crypt_stat;
+struct ecryptfs_mount_crypt_stat;
+
+struct ecryptfs_page_crypt_context {
+	struct page *page;
+#define ECRYPTFS_PREPARE_COMMIT_MODE 0
+#define ECRYPTFS_WRITEPAGE_MODE      1
+	int mode;
+	union {
+		struct file *lower_file;
+		struct writeback_control *wbc;
+	} param;
+};
+
+#define KEY_PAYLOAD_DATA(key) \
+	(((struct user_key_payload*)key->payload.data)->data)
+#define KEY_PAYLOAD_LEN(key) \
+	(((struct user_key_payload*)key->payload.data)->datalen)
+
+#define ECRYPTFS_SUPER_MAGIC 0xf15f
+#define ECRYPTFS_MAX_KEYSET_SIZE 1024
+#define ECRYPTFS_MAX_CIPHER_NAME_SIZE 32
+#define ECRYPTFS_MAX_NUM_ENC_KEYS 64
+#define ECRYPTFS_MAX_NUM_KEYSIGS 2 /* TODO: Make this a linked list */
+#define ECRYPTFS_MAX_IV_BYTES 16	/* 128 bits */
+#define ECRYPTFS_SALT_BYTES 2
+#define MAGIC_ECRYPTFS_MARKER 0x3c81b7f5
+#define MAGIC_ECRYPTFS_MARKER_SIZE_BYTES 8	/* 4*2 */
+#define ECRYPTFS_FILE_SIZE_BYTES 8
+#define ECRYPTFS_DEFAULT_CIPHER "aes"
+#define ECRYPTFS_DEFAULT_KEY_BYTES 16
+#define ECRYPTFS_DEFAULT_CHAINING_MODE CRYPTO_TFM_MODE_CBC
+#define ECRYPTFS_TAG_3_PACKET_TYPE 0x8C
+#define ECRYPTFS_TAG_11_PACKET_TYPE 0xED
+#ifndef MD5_DIGEST_SIZE
+#define MD5_DIGEST_SIZE 16
+#endif
+
+/**
+ * This is the primary struct associated with each encrypted file.
+ *
+ * TODO: cache align/pack?
+ */
+struct ecryptfs_crypt_stat {
+#define ECRYPTFS_STRUCT_INITIALIZED 0x00000001
+#define ECRYPTFS_POLICY_APPLIED     0x00000002
+#define ECRYPTFS_NEW_FILE           0x00000004
+#define ECRYPTFS_ENCRYPTED          0x00000008
+#define ECRYPTFS_SECURITY_WARNING   0x00000010
+#define ECRYPTFS_ENABLE_HMAC        0x00000020
+#define ECRYPTFS_ENCRYPT_IV_PAGES   0x00000040
+#define ECRYPTFS_KEY_VALID          0x00000080
+	u32 flags;
+	int file_version;
+	int iv_bytes;
+	int num_keysigs;
+	int header_extent_size;
+	int num_header_extents_at_front; /* Number of header extents
+					  * at the front of the file */
+	int extent_size; /* Data extent size; default is 4096 */
+	int key_size_bits;
+	unsigned int extent_shift;
+	unsigned int extent_mask;
+	struct crypto_tfm *tfm;
+	struct crypto_tfm *md5_tfm; /* Crypto context for generating
+				     * the initialization vectors */
+	char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
+	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
+	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
+	char keysigs[ECRYPTFS_MAX_NUM_KEYSIGS][ECRYPTFS_SIG_SIZE_HEX];
+	struct mutex cs_mutex;
+};
+
+/* inode private data. */
+struct ecryptfs_inode_info {
+	struct inode *wii_inode;
+	struct inode vfs_inode;
+	struct ecryptfs_crypt_stat crypt_stat;
+};
+
+/* dentry private data. */
+struct ecryptfs_dentry_info {
+	struct dentry *wdi_dentry;
+	struct ecryptfs_crypt_stat *crypt_stat;
+};
+
+/**
+ * This struct is to enable a mount-wide passphrase/salt combo. This
+ * is more or less a stopgap to provide similar functionality to other
+ * crypto filesystems like EncFS or CFS until full policy support is
+ * implemented in eCryptfs.
+ */
+struct ecryptfs_mount_crypt_stat {
+	/* Pointers to memory we do not own, do not free these */
+	struct ecryptfs_auth_tok *global_auth_tok;
+	struct key *global_auth_tok_key;
+	char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
+	char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
+};
+
+/* superblock private data. */
+struct ecryptfs_sb_info {
+	struct super_block *wsi_sb;
+	struct vfsmount *lower_mnt;
+	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
+};
+
+/* file private data. */
+struct ecryptfs_file_info {
+	struct file *wfi_file;
+	struct ecryptfs_crypt_stat *crypt_stat;
+};
+
+/* auth_tok <=> encrypted_session_key mappings */
+struct ecryptfs_auth_tok_list_item {
+	char encrypted_session_key[ECRYPTFS_MAX_KEY_BYTES];
+	struct list_head list;
+	struct ecryptfs_auth_tok auth_tok;
+};
+
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
+#endif /* OBSERVE_ASSERTS */
+
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
+#define ecryptfs_printk(type, fmt, arg...) \
+        __ecryptfs_printk(type "%s: " fmt, __FUNCTION__, ## arg);
+void __ecryptfs_printk(const char *fmt, ...);
+
+extern struct file_operations ecryptfs_main_fops;
+extern struct file_operations ecryptfs_dir_fops;
+extern struct inode_operations ecryptfs_main_iops;
+extern struct inode_operations ecryptfs_dir_iops;
+extern struct inode_operations ecryptfs_symlink_iops;
+extern struct super_operations ecryptfs_sops;
+extern struct dentry_operations ecryptfs_dops;
+extern struct address_space_operations ecryptfs_aops;
+extern int ecryptfs_verbosity;
+
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
+int ecryptfs_decode_filename(struct ecryptfs_crypt_stat *crypt_stat,
+			     const char *name, int length,
+			     char **decrypted_name);
+int ecryptfs_encode_filename(struct ecryptfs_crypt_stat *crypt_stat,
+			     const char *name, int length,
+			     char **encoded_name);
+struct dentry *ecryptfs_lower_dentry(struct dentry *this_dentry);
+void ecryptfs_copy_attr_times(struct inode *dest, const struct inode *src);
+void ecryptfs_copy_attr_atime(struct inode *dest, const struct inode *src);
+void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src);
+void ecryptfs_copy_inode_size(struct inode *dst, const struct inode *src);
+void ecryptfs_dump_hex(char *data, int bytes);
+int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
+			int sg_size);
+int ecryptfs_calculate_md5(char *dst, struct ecryptfs_crypt_stat *crypt_stat,
+			   char *src, int len);
+int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
+		       pgoff_t offset);
+int ecryptfs_compute_root_iv(struct ecryptfs_crypt_stat *crypt_stat);
+void ecryptfs_rotate_iv(unsigned char *iv);
+void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
+void ecryptfs_destruct_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
+int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
+int ecryptfs_write_inode_size_to_header(struct file *lower_file,
+					struct inode *lower_inode,
+					struct inode *inode);
+int ecryptfs_get_lower_page(struct page **lower_page, struct inode *lower_inode,
+			    struct file *lower_file,
+			    unsigned long lower_page_index, int byte_offset,
+			    int region_bytes);
+int
+ecryptfs_commit_lower_page(struct page *lower_page, struct inode *lower_inode,
+			   struct file *lower_file, int byte_offset,
+			   int region_size);
+int ecryptfs_copy_page_to_lower(struct page *page, struct inode *lower_inode,
+				struct file *lower_file);
+int ecryptfs_do_readpage(struct file *file, struct page *page,
+			 pgoff_t lower_page_index);
+int ecryptfs_grab_and_map_lower_page(struct page **lower_page,
+				     char **lower_virt,
+				     struct inode *lower_inode,
+				     unsigned long lower_page_index);
+int ecryptfs_writepage_and_release_lower_page(struct page *lower_page,
+					      struct inode *lower_inode,
+					      struct writeback_control *wbc);
+int ecryptfs_encrypt_page(struct ecryptfs_page_crypt_context *ctx);
+int
+ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
+			     struct page *dst_page, int dst_offset,
+			     struct page *src_page, int src_offset, int size,
+			     unsigned char *iv);
+int ecryptfs_decrypt_page(struct file *file, struct page *page);
+int
+ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
+			     struct page *dst_page, int dst_offset,
+			     struct page *src_page, int src_offset, int size,
+			     unsigned char *iv);
+int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
+			   struct file *lower_file);
+int ecryptfs_write_headers_virt(char *page_virt, 
+				struct ecryptfs_crypt_stat *crypt_stat,
+				struct dentry *ecryptfs_dentry);
+int ecryptfs_read_headers(struct dentry *ecryptfs_dentry,
+			  struct file *lower_file);
+int ecryptfs_new_file_context(struct dentry *ecryptfs_dentry);
+int contains_ecryptfs_marker(char *data);
+int ecryptfs_read_header_region(char *data, struct dentry *dentry,
+				struct nameidata *nd);
+u16 ecryptfs_code_for_cipher_string(char *str);
+int ecryptfs_cipher_code_to_string(char *str, u16 cipher_code);
+void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat);
+int ecryptfs_generate_key_packet_set(char *dest_base,
+				     struct ecryptfs_crypt_stat *crypt_stat,
+				     struct dentry *ecryptfs_dentry, int *len);
+int process_request_key_err(long err_code);
+int
+ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
+			  unsigned char *src, struct dentry *ecryptfs_dentry);
+int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
+
+#endif /* #ifndef ECRYPTFS_KERNEL_H */
