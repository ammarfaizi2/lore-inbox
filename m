Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVKCD4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVKCD4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbVKCD4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:56:40 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:62446
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1030348AbVKCD4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:56:38 -0500
Date: Wed, 2 Nov 2005 20:56:59 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 12/12: eCryptfs] Crypto functions
Message-ID: <20051103035659.GL3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs crypto functions. Scatterlist abstraction functions. Page
encryption/decryption functions. Inode cryptographic context
initialization functions. Header region manipulation
functions. Functions in which filename encoding/decoding can be
implemented.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 crypto.c |  822 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 822 insertions(+)
--- linux-2.6.14-rc5-mm1/fs/ecryptfs/crypto.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/fs/ecryptfs/crypto.c	2005-11-01 15:55:57.000000000 -0600
@@ -0,0 +1,822 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (c) 1997-2004 Erez Zadok
+ * Copyright (c) 2001-2004 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
+ *   		Michael C. Thompson <mcthomps@us.ibm.com>
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
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/random.h>
+#include <linux/compiler.h>
+#include <linux/key.h>
+#include <linux/namei.h>
+#include <linux/crypto.h>
+#include <linux/file.h>
+#include <asm/scatterlist.h>
+#include "ecryptfs_kernel.h"
+
+/**
+ * Requirement:
+ *	Size of dst buffer needs to be atleast src_size * 2
+ */
+inline void ecryptfs_to_hex(char *dst, char *src, int src_size)
+{
+	int x;
+	for (x = 0; x < src_size; x++)
+		sprintf(&dst[x * 2], "%.2x", (unsigned char)src[x]);
+}
+
+/**
+ * Requirement:
+ * 	Size of src buffer needs to be atleast twice that of dst_size
+ */
+inline void ecryptfs_from_hex(char *dst, char *src, int dst_size)
+{
+	int x;
+	char tmp[3] = { 0, };
+	for (x = 0; x < dst_size; x++) {
+		tmp[0] = src[x * 2];
+		tmp[1] = src[x * 2 + 1];
+		dst[x] = (unsigned char)simple_strtol(tmp, NULL, 16);
+	}
+}
+
+static int iv_mixer;
+
+/**
+ * Rotate the initialization vector for an extent.  This stirs things
+ * up to help protect against linear cryptanalysis when an attacker
+ * may have access to several encryptions based on the same IV.
+ */
+void ecryptfs_rotate_iv(unsigned char *iv)
+{
+	int i = (ECRYPTFS_MAX_IV_BYTES - sizeof(iv_mixer));
+	int zero_test = 0;
+	while ((i -= sizeof(iv_mixer)) >= 0)
+		zero_test |= ((*((int *)(iv + i))) ^=
+			      (iv_mixer *= (*(int *)(iv + i))));
+	while (unlikely(!zero_test)) {
+		get_random_bytes(iv, ECRYPTFS_MAX_IV_BYTES);
+		zero_test = 0;
+		i = ECRYPTFS_MAX_IV_BYTES / sizeof(int);
+		while (i--)
+			zero_test |= *((int *)(iv + i));
+	}
+}
+
+/**
+ * Initialize the crypt_stats structure.  This involves setting an
+ * initial IV, indicating how many header pages we have on the file by
+ * default, initializing the list of raw authentication token packets
+ * (TODO: deprecated/replaced w/ auth_tok sigs pointing to keyring
+ * structures), setting the extent size (TODO: this is the page size;
+ * as it now stands, everything falls apart if the page size is
+ * anything but 4096), and finally setting a flag to indicate that the
+ * structure is initialized.
+ *
+ * @param crypt_stats Pointer to the crypt_stats struct to
+ *                    initialize.
+ */
+void ecryptfs_init_crypt_stats(struct ecryptfs_crypt_stats *crypt_stats)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	memset((void *)crypt_stats, 0, sizeof(struct ecryptfs_crypt_stats));
+	init_MUTEX(&crypt_stats->iv_sem);
+	down(&crypt_stats->iv_sem);
+	get_random_bytes(&crypt_stats->iv, ECRYPTFS_MAX_IV_BYTES);
+	up(&crypt_stats->iv_sem);
+	get_random_bytes(&iv_mixer, sizeof(iv_mixer));
+	crypt_stats->num_header_pages = 1;	/* TODO: Remove with policy */
+	crypt_stats->struct_initialized = 1;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * Releases all memory associated with a crypt_stats struct.
+ */
+void ecryptfs_destruct_crypt_stats(struct ecryptfs_crypt_stats *crypt_stats)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (crypt_stats->tfm) {
+		crypto_free_tfm(crypt_stats->tfm);
+		crypt_stats->tfm = NULL;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * Dump hexadecimal representation of char array
+ *
+ * @param data
+ * @param bytes
+ */
+void ecryptfs_dump_hex(char *data, int bytes)
+{
+	int i = 0;
+	int pretty_print = 1;
+	if (ecryptfs_verbosity < 1) {
+		return;
+	}
+	if (bytes != 0) {
+		printk(KERN_NOTICE "0x%.2x.", (unsigned char)data[i]);
+		i++;
+	}
+	while (i < bytes) {
+		printk("0x%.2x.", (unsigned char)data[i]);
+		i++;
+		if (i % 16 == 0) {
+			printk("\n");
+			pretty_print = 0;
+		} else {
+			pretty_print = 1;
+		}
+	}
+	if (pretty_print) {
+		printk("\n");
+	}
+}
+
+/**
+ * Fills in a scatterlist array with page references for a passed
+ * virtual address: James Morris
+ *
+ * @param addr Virtual address
+ * @param size Size of data; should be an even multiple of the block
+ *             size
+ * @param sg Pointer to scatterlist array
+ * @param sg_size Max array size
+ * @return Number of scatterlist structs in array used
+ */
+int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
+			int sg_size)
+{
+	int i = 0;
+	struct page *pg;
+	int offset;
+	int remainder_of_page;
+	while (size > 0 && i < sg_size) {
+		pg = virt_to_page(addr);
+		offset = offset_in_page(addr);
+		sg[i].page = pg;
+		sg[i].offset = offset;
+		remainder_of_page = PAGE_CACHE_SIZE - offset;
+		if (size >= remainder_of_page) {
+			sg[i].length = remainder_of_page;
+			addr += remainder_of_page;
+			size -= remainder_of_page;
+		} else {
+			sg[i].length = size;
+			addr += size;
+			size = 0;
+		}
+		i++;
+	}
+	if (size > 0) {
+		return -ENOMEM;
+	}
+	return i;
+}
+
+/**
+ * @return Number of bytes encrypted
+ */
+static int do_encrypt_scatterlist(struct ecryptfs_crypt_stats *crypt_stats,
+				  struct scatterlist *dest_sg,
+				  struct scatterlist *src_sg, int size,
+				  unsigned char *iv)
+{
+	if (!crypt_stats || !crypt_stats->tfm
+	    || !crypt_stats->struct_initialized) {
+		ecryptfs_printk(0, KERN_ERR,
+				"Called w/ invalid crypt_stats state\n");
+		size = -EINVAL;
+		BUG();
+		goto out;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Key size [%d]; key:\n",
+			crypt_stats->key_size_bits / 8);
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex(crypt_stats->key,
+				  crypt_stats->key_size_bits / 8);
+	}
+	crypto_cipher_setkey(crypt_stats->tfm, crypt_stats->key,
+			     crypt_stats->key_size_bits / 8);
+	ecryptfs_printk(1, KERN_NOTICE, "Encrypting [%d] bytes.\n", size);
+	if (crypt_stats->tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_ECB) {
+		crypt_stats->security_warning = 1;
+		crypto_cipher_encrypt(crypt_stats->tfm, dest_sg, src_sg, size);
+	} else if (crypt_stats->tfm->crt_cipher.cit_mode
+		   == CRYPTO_TFM_MODE_CFB
+		   || crypt_stats->tfm->crt_cipher.cit_mode
+		   == CRYPTO_TFM_MODE_CBC) {
+		crypto_cipher_encrypt_iv(crypt_stats->tfm, dest_sg, src_sg,
+					 size, iv);
+	} else {
+		ecryptfs_printk(0, KERN_ERR,
+				"Unsupported block cipher mode: [%d]\n",
+				crypt_stats->tfm->crt_cipher.cit_mode);
+		size = -ENOSYS;
+	}
+	/* TODO: crypt_stats->iv size must be equal to the block size */
+out:
+	return size;
+}
+
+int do_encrypt_page_offset(struct ecryptfs_crypt_stats *crypt_stats,
+			   struct page *dest_page, int dest_offset,
+			   struct page *src_page, int src_offset, int size,
+			   unsigned char *iv)
+{
+	int rc;
+	struct scatterlist src_sg[2], dest_sg[2];
+	ecryptfs_printk(1, KERN_NOTICE, "Called with dest_page->index = [%lu], "
+			"src_page->index = [%lu], dest_offset = [%d], "
+			"src_offset = [%d]\n", dest_page->index,
+			src_page->index, dest_offset, src_offset);
+	src_sg[0].page = src_page;
+	src_sg[0].offset = src_offset;
+	src_sg[0].length = size;
+	dest_sg[0].page = dest_page;
+	dest_sg[0].offset = dest_offset;
+	dest_sg[0].length = size;
+	rc = do_encrypt_scatterlist(crypt_stats, dest_sg, src_sg, size, iv);
+	return rc;
+}
+
+int
+do_encrypt_page(struct ecryptfs_crypt_stats *crypt_stats,
+		struct page *dest_page, struct page *src_page,
+		unsigned char *iv)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Called with dest_page->index = [%lu] "
+			"and src_page->index = [%lu]\n", dest_page->index,
+			src_page->index);
+	return do_encrypt_page_offset(crypt_stats, dest_page, 0, src_page, 0,
+				      PAGE_CACHE_SIZE, iv);
+}
+
+/**
+ * Encrypt from a virtual address to a virtual address.
+ * 
+ * @return 
+ */
+int do_encrypt_virt(struct ecryptfs_crypt_stats *crypt_stats,
+		    char *dest_virt_addr, const char *src_virt_addr,
+		    int size, unsigned char *iv)
+{
+	/* TODO: 32 is a magic number */
+	struct scatterlist src_sg[32];
+	struct scatterlist dest_sg[32];
+	int rc;
+	ecryptfs_printk(1, KERN_NOTICE, "Source:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex((char *)src_virt_addr, size);
+	}
+	if ((rc = virt_to_scatterlist(src_virt_addr, size, src_sg, 32))
+	    == -ENOMEM) {
+		ecryptfs_printk(0, KERN_ERR, "do_encrypt_virt: No memory for "
+				"this operation\n");
+		goto out;
+
+	}
+	if ((rc = virt_to_scatterlist(dest_virt_addr, size, dest_sg, 32))
+	    == -ENOMEM) {
+		ecryptfs_printk(0, KERN_ERR, "do_encrypt_virt: No memory for "
+				"this operation\n");
+		goto out;
+	}
+	rc = do_encrypt_scatterlist(crypt_stats, dest_sg, src_sg, size, iv);
+	ecryptfs_printk(1, KERN_NOTICE, "Destination:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex((char *)dest_virt_addr, size);
+	}
+out:
+	return rc;
+}
+
+/**
+ * @return Number of bytes decrypted
+ */
+static int do_decrypt_scatterlist(struct ecryptfs_crypt_stats *crypt_stats,
+				  struct scatterlist *dest_sg,
+				  struct scatterlist *src_sg, int size,
+				  unsigned char *iv)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	/* TODO: This should be done when the file is opened */
+	ecryptfs_printk(1, KERN_NOTICE, "Key size [%d]; key:\n",
+			crypt_stats->key_size_bits / 8);
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex(crypt_stats->key,
+				  crypt_stats->key_size_bits / 8);
+	}
+	crypto_cipher_setkey(crypt_stats->tfm, crypt_stats->key,
+			     crypt_stats->key_size_bits / 8);
+	ecryptfs_printk(1, KERN_NOTICE, "Decrypting [%d] bytes.\n", size);
+	if (crypt_stats->tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_ECB) {
+		crypto_cipher_decrypt(crypt_stats->tfm, dest_sg, src_sg, size);
+	} else if (crypt_stats->tfm->crt_cipher.cit_mode
+		   == CRYPTO_TFM_MODE_CFB
+		   || crypt_stats->tfm->crt_cipher.cit_mode
+		   == CRYPTO_TFM_MODE_CBC) {
+		crypto_cipher_decrypt_iv(crypt_stats->tfm, dest_sg, src_sg,
+					 size, iv);
+	} else {
+		ecryptfs_printk(0, KERN_ERR,
+				"Unsupported block cipher mode: [%d]\n",
+				crypt_stats->tfm->crt_cipher.cit_mode);
+		size = -ENOSYS;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; size = [%d]\n", size);
+	return size;
+}
+
+/**
+ * @return Number of bytes decrypted
+ */
+int do_decrypt_page_offset(struct ecryptfs_crypt_stats *crypt_stats,
+			   struct page *dest_page, int dest_offset,
+			   struct page *src_page, int src_offset, int size,
+			   unsigned char *iv)
+{
+	int rc;
+	struct scatterlist src_sg[2], dest_sg[2];
+	src_sg[0].page = src_page;
+	src_sg[0].offset = src_offset;
+	src_sg[0].length = size;
+	dest_sg[0].page = dest_page;
+	dest_sg[0].offset = dest_offset;
+	dest_sg[0].length = size;
+	rc = do_decrypt_scatterlist(crypt_stats, dest_sg, src_sg, size, iv);
+	return rc;
+}
+
+int
+do_decrypt_page(struct ecryptfs_crypt_stats *crypt_stats,
+		struct page *dest_page, struct page *src_page,
+		unsigned char *iv)
+{
+	return do_decrypt_page_offset(crypt_stats, dest_page, 0, src_page, 0,
+				      PAGE_CACHE_SIZE, iv);
+}
+
+int do_decrypt_virt(struct ecryptfs_crypt_stats *crypt_stats,
+		    char *dest_virt_addr, const char *src_virt_addr,
+		    int size, unsigned char *iv)
+{
+	/* TODO: 32 is a magic number; minimize stack usage here */
+	struct scatterlist src_sg[32];
+	struct scatterlist dest_sg[32];
+	int rc;
+	ecryptfs_printk(1, KERN_NOTICE, "Source:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex((char *)src_virt_addr, size);
+	}
+	if ((rc = virt_to_scatterlist(src_virt_addr, size, src_sg, 32))
+	    == -ENOMEM) {
+		ecryptfs_printk(0, KERN_ERR, "do_decrypt_virt: No memory for "
+				"this operation\n");
+		goto out;
+
+	}
+	if ((rc = virt_to_scatterlist(dest_virt_addr, size, dest_sg, 32))
+	    == -ENOMEM) {
+		ecryptfs_printk(0, KERN_ERR, "do_decrypt_virt: No memory for "
+				"this operation\n");
+		goto out;
+	}
+	rc = do_decrypt_scatterlist(crypt_stats, dest_sg, src_sg, size, iv);
+	ecryptfs_printk(1, KERN_NOTICE, "Destination:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex((char *)dest_virt_addr, size);
+	}
+out:
+	return rc;
+}
+
+/**
+ * Initialize the crypto context
+ *
+ * TODO: Performance: Keep a cache of initialized cipher contexts;
+ * only init if needed
+ */
+int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stats *crypt_stats)
+{
+	int rc = -EINVAL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (crypt_stats->cipher == NULL) {
+		ecryptfs_printk(1, KERN_NOTICE, "No cipher specified\n");
+		goto out;
+	}
+	ecryptfs_printk(1, KERN_NOTICE,
+			"Initializing cipher [%s]; strlen = [%d]\n",
+			crypt_stats->cipher, (int)strlen(crypt_stats->cipher));
+	if (crypt_stats->tfm != NULL) {
+		ecryptfs_printk(1, KERN_WARNING, "Crypto context already "
+				"initialized\n");
+		goto out;
+	}
+	crypt_stats->tfm = crypto_alloc_tfm(crypt_stats->cipher,
+					    CRYPTO_TFM_MODE_CBC);
+	if (crypt_stats->tfm == NULL) {
+		ecryptfs_printk(0, KERN_ERR, "cryptfs: init_crypt_ctx(): Error "
+				"initializing cipher [%s]\n",
+				crypt_stats->cipher);
+		goto out;
+	}
+	rc = 0;
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static void generate_random_key(unsigned char *key, int num_bytes)
+{
+	get_random_bytes(key, num_bytes);
+}
+
+void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stats *crypt_stats)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	/* Default values; may be overwritten as we are parsing the
+	 * packets. */
+	crypt_stats->extent_size = PAGE_SIZE;
+	crypt_stats->iv_bytes = ECRYPTFS_DEFAULT_IV_BYTES;
+	crypt_stats->records_per_page = RECORDS_PER_PAGE(crypt_stats);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * Default values in the event that policy does not override them.
+ */
+static void
+ecryptfs_set_default_crypt_stats_vals(struct ecryptfs_crypt_stats *crypt_stats)
+{
+	int key_size_bits = ECRYPTFS_DEFAULT_KEY_BYTES * 8;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	strcpy(crypt_stats->cipher, ECRYPTFS_DEFAULT_CIPHER);
+	generate_random_key(crypt_stats->key, key_size_bits / 8);
+	crypt_stats->key_size_bits = key_size_bits;
+	crypt_stats->key_valid = 1;
+	ecryptfs_printk(1, KERN_NOTICE, "Generated new session key:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex(crypt_stats->key,
+				  crypt_stats->key_size_bits / 8);
+	}
+	ecryptfs_set_default_sizes(crypt_stats);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * If the crypto context for the file has not yet been established,
+ * this is where we do that.  Establishing a new crypto context
+ * involves the following decisions:
+ *  - What cipher to use?
+ *  - What set of authentication tokens to use?
+ * Here we just worry about getting enough information into the
+ * authentication tokens so that we know that they are available.
+ * We associate the available authentication tokens with the new file
+ * via the set of signatures in the crypt_stats struct.  Later, when
+ * the headers are actually written out, we may again defer to
+ * userspace to perform the encryption of the session key; for the
+ * foreseeable future, this will be the case with public key packets.
+ *
+ * @param ecryptfs_dentry
+ * @return Zero on success; non-zero otherwise
+ */
+/* Associate an authentication token(s) with the file */
+int ecryptfs_new_file_context(struct dentry *ecryptfs_dentry)
+{
+	int rc = 0;
+	struct ecryptfs_crypt_stats *crypt_stats =
+	    &INODE_TO_PRIVATE(ecryptfs_dentry->d_inode)->crypt_stats;
+	struct ecryptfs_mount_crypt_stats *mount_crypt_stats =
+	    &(SUPERBLOCK_TO_PRIVATE(ecryptfs_dentry->d_sb)->mount_crypt_stats);
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	ecryptfs_set_default_crypt_stats_vals(crypt_stats);
+	/* See if there are mount crypt options */
+	if (mount_crypt_stats->global_auth_tok) {
+		int cipher_name_len;
+		ecryptfs_printk(1, KERN_NOTICE, "Initializing context for new "
+				"file using mount_crypt_stats\n");
+		crypt_stats->encrypted = 1;
+		crypt_stats->key_valid = 1;
+		memcpy(crypt_stats->keysigs[crypt_stats->num_keysigs++],
+		       mount_crypt_stats->global_auth_tok_sig,
+		       ECRYPTFS_SIG_SIZE_HEX);
+		cipher_name_len =
+		    strlen(mount_crypt_stats->global_default_cipher_name);
+		memcpy(crypt_stats->cipher,
+		       mount_crypt_stats->global_default_cipher_name,
+		       cipher_name_len);
+		crypt_stats->cipher[cipher_name_len] = '\0';
+	} else {
+		/* We should not encounter this scenario since we
+		 * should detect lack of global_auth_tok at mount time
+		 * TODO: Applies to 0.1 release only; remember to
+		 * remove in future release */
+		BUG();
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * @return One if marker found; zero if not found
+ */
+int contains_ecryptfs_marker(char *data)
+{
+	u32 num;
+	u32 marker;
+	memcpy(&num, (data + ECRYPTFS_FILE_SIZE_BYTES), 4);
+	num ^= MAGIC_ECRYPTFS_MARKER;
+	memcpy(&marker, (data + ECRYPTFS_FILE_SIZE_BYTES + 4), 4);
+	return (num == marker);
+}
+
+static int write_ecryptfs_marker(char *page_virt, int start_offset)
+{
+	u32 marker;
+	/* Generate the eCryptfs marker, which is a 4-byte random
+	 * value, followed by another 4-byte random value that is
+	 * formed by xor'ing the first value by 0x3c81b7f5. This could
+	 * also be just the 0x3c81b7f5 value, but that is more likely
+	 * to cause a misread; especially, for example, with the
+	 * crypto.o object file, which has that number in its text
+	 * area. */
+	get_random_bytes(&marker, (MAGIC_ECRYPTFS_MARKER_SIZE_BYTES / 2));
+	memcpy(page_virt + start_offset, &marker,
+	       (MAGIC_ECRYPTFS_MARKER_SIZE_BYTES / 2));
+	ecryptfs_printk(1, KERN_NOTICE, "Wrote first val:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex(page_virt + start_offset,
+				  (MAGIC_ECRYPTFS_MARKER_SIZE_BYTES / 2));
+	}
+	marker ^= MAGIC_ECRYPTFS_MARKER;
+	memcpy(page_virt + start_offset +
+	       (MAGIC_ECRYPTFS_MARKER_SIZE_BYTES / 2), &marker,
+	       (MAGIC_ECRYPTFS_MARKER_SIZE_BYTES / 2));
+	ecryptfs_printk(1, KERN_NOTICE, "Wrote second val:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex(page_virt + start_offset
+				  + (MAGIC_ECRYPTFS_MARKER_SIZE_BYTES / 2),
+				  (MAGIC_ECRYPTFS_MARKER_SIZE_BYTES / 2));
+	}
+	return MAGIC_ECRYPTFS_MARKER_SIZE_BYTES;
+}
+
+/**
+ * @return Zero on success; non-zero otherwise
+ */
+int ecryptfs_read_header_region(char *data, struct dentry *dentry,
+				struct nameidata *nd)
+{
+	int rc = 0;
+	struct vfsmount *mnt = NULL;
+	struct file *file = NULL;
+	mm_segment_t oldfs;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	/* TODO: Do we really need to grab the mount here? */
+	mnt = mntget(nd->mnt);
+	file = dentry_open(dentry, mnt, O_RDONLY);
+	if (IS_ERR(file)) {
+		ecryptfs_printk(1, KERN_NOTICE, "Error opening file to "
+				"determine interpolated filesize\n");
+		mntput(mnt);
+		rc = PTR_ERR(file);
+		goto out;
+	}
+	if (!file || !file->f_op || !file->f_op->read) {
+		ecryptfs_printk(1, KERN_NOTICE, "File has no read op\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	file->f_pos = 0;
+	oldfs = get_fs();
+	set_fs(get_ds());
+	rc = file->f_op->read(file, (char __user *)data,
+			      PAGE_CACHE_SIZE, &file->f_pos);
+	set_fs(oldfs);
+	fput(file);
+	rc = 0;
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n",rc);
+	return rc;
+}
+
+kmem_cache_t *ecryptfs_header_cache_0;
+kmem_cache_t *ecryptfs_header_cache_1;
+kmem_cache_t *ecryptfs_header_cache_2;
+
+/**
+ * Write the file headers out.  This will likely involve a userspace
+ * callout, in which the session key is encrypted with one or more
+ * public keys and/or the passphrase necessary to do the encryption is
+ * retrieved via a prompt.  Exactly what happens at this point should
+ * be policy-dependent.
+ *
+ * @param lower_file The lower file struct, which was returned from
+ * dentry_open
+ * @return Zero on success; non-zero on error
+ */
+int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
+			   struct file *lower_file)
+{
+	int rc = 0;
+	char *page_virt;
+	struct ecryptfs_crypt_stats *crypt_stats;
+	mm_segment_t oldfs;
+	int ecryptfs_marker_len;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	crypt_stats = &INODE_TO_PRIVATE(ecryptfs_dentry->d_inode)->crypt_stats;
+	if (likely(1 == crypt_stats->encrypted)) {
+		if (!crypt_stats->key_valid) {
+			ecryptfs_printk(1, KERN_NOTICE, "Key is "
+					"invalid; bailing out\n");
+			rc = -EINVAL;
+			goto out;
+		}
+	} else {
+		rc = -EINVAL;
+		ecryptfs_printk(0, KERN_WARNING,
+				"Called with crypt_stats->encrypted == 0\n");
+		goto out;
+	}
+	/* Released in this function */
+	page_virt =
+	    ecryptfs_kmem_cache_alloc(ecryptfs_header_cache_0, SLAB_USER);
+	if (!page_virt) {
+		ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
+		return -ENOMEM;
+	}
+	ecryptfs_marker_len = write_ecryptfs_marker(page_virt,
+						    ECRYPTFS_FILE_SIZE_BYTES);
+	rc = ecryptfs_generate_key_packet_set(page_virt,
+					      (ECRYPTFS_FILE_SIZE_BYTES
+					       + ecryptfs_marker_len),
+					      crypt_stats, ecryptfs_dentry);
+	if (unlikely(rc == 0)) {
+		rc = -EIO;
+		ecryptfs_printk(0, KERN_ERR, "Error whilst generating the key "
+				"packet set; writing zero's\n");
+		goto out_free;
+	}
+	rc = 0;
+	ecryptfs_printk(1, KERN_NOTICE,
+			"Writing key packet set to underlying file\n");
+	lower_file->f_pos = 0;
+	oldfs = get_fs();
+	set_fs(get_ds());
+	lower_file->f_op->write(lower_file, (char __user *)page_virt,
+				PAGE_CACHE_SIZE, &lower_file->f_pos);
+	set_fs(oldfs);
+	ecryptfs_fput(lower_file);
+	ecryptfs_printk(1, KERN_NOTICE,
+			"Done writing key packet set to underlying file.\n");
+out_free:
+	ecryptfs_kmem_cache_free(ecryptfs_header_cache_0, page_virt);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * @return	Zero if valid headers found and parsed; non-zero otherwise
+ */
+int ecryptfs_read_headers(struct dentry *ecryptfs_dentry,
+			  struct file *lower_file)
+{
+	int rc = 0;
+	char *page_virt;
+	mm_segment_t oldfs;
+	ssize_t bytes_read;
+	struct ecryptfs_crypt_stats *crypt_stats =
+	    &INODE_TO_PRIVATE(ecryptfs_dentry->d_inode)->crypt_stats;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	/* Read the first page from the underlying file */
+	page_virt =
+	    ecryptfs_kmem_cache_alloc(ecryptfs_header_cache_1, SLAB_USER);
+	if (IS_ERR(page_virt)) {
+		rc = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Unable to allocate page_virt\n");
+		goto out;
+	}
+	lower_file->f_pos = 0;
+	oldfs = get_fs();
+	set_fs(get_ds());
+	bytes_read =
+	    lower_file->f_op->read(lower_file, (char __user *)page_virt,
+				   PAGE_CACHE_SIZE, &lower_file->f_pos);
+	set_fs(oldfs);
+	if (bytes_read != PAGE_CACHE_SIZE) {
+		rc = -EINVAL;
+		ecryptfs_printk(0, KERN_ERR, "Expected size of header not read."
+				"Instead [%d] bytes were read\n", bytes_read);
+		goto out;
+	}
+	rc = ecryptfs_parse_packet_set(page_virt, crypt_stats, ecryptfs_dentry);
+	ecryptfs_kmem_cache_free(ecryptfs_header_cache_1, page_virt);
+	if (rc) {
+		ecryptfs_printk(1, KERN_NOTICE, "File not encrypted\n");
+		rc = -EINVAL;
+		goto out;
+	}
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * N.B. The concept of encoded filenames does not apply for 0.1 release
+ *
+ * Encrypts and encodes a filename into something that constitutes a
+ * valid filename for a filesystem, with printable characters.
+ *
+ * We assume that we have a properly initialized crypto context,
+ * pointed to by crypt_stats->tfm.
+ *
+ * TODO: Implement filename encryption and encoding here, in place of
+ * memcpy.
+ *
+ * @return	Length of encoded filename; negative if error
+ */
+int
+ecryptfs_encode_filename(const char *name, int length, char **encoded_name,
+			 int skip_dots,
+			 struct ecryptfs_crypt_stats *crypt_stats)
+{
+	int error = 0;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; length = [%d]\n", length);
+	(*encoded_name) = ecryptfs_kmalloc(length + 2, GFP_KERNEL);
+	if (!(*encoded_name)) {
+		error = -ENOMEM;
+		goto out;
+	}
+	memcpy((void *)(*encoded_name), (void *)name, length);
+	(*encoded_name)[length] = '\0';
+	error = length + 1;
+      out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; error = [%d]\n", error);
+	return error;
+}
+
+/**
+ * N.B. The concept of encoded filenames does not apply for 0.1 release
+ *
+ * Decrypts and decodes the filename
+ *
+ * TODO: Implement filename decoding and decryption here, in place of
+ * memcpy.
+ *
+ * @return	Length of decoded filename; negative if error
+ */
+int
+ecryptfs_decode_filename(const char *name, int length, char **decrypted_name,
+			 int skip_dots,
+			 struct ecryptfs_crypt_stats *crypt_stats)
+{
+	int error = 0;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; length = [%d]\n", length);
+	/* Make sure we are called correctly */
+	BUG_ON(length < 0);
+	(*decrypted_name) = ecryptfs_kmalloc(length + 2, GFP_KERNEL);
+	if (!(*decrypted_name)) {
+		error = -ENOMEM;
+		goto out;
+	}
+	memcpy((void *)(*decrypted_name), (void *)name, length);
+	(*decrypted_name)[length + 1] = '\0';	/* Only for convenience
+						 * in printing out the
+						 * string in debug
+						 * messages */
+	error = length;
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; error = [%d]\n", error);
+	return error;
+}
