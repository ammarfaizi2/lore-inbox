Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVGFEAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVGFEAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVGFD5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:57:24 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:11417 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262079AbVGFCTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:33 -0400
Subject: [PATCH] [32/48] Suspend2 2.1.9.8 for 2.6.12: 609-driver-model.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <11206164423660@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 610-encryption.patch-old/kernel/power/suspend2_core/encryption.c 610-encryption.patch-new/kernel/power/suspend2_core/encryption.c
--- 610-encryption.patch-old/kernel/power/suspend2_core/encryption.c	1970-01-01 10:00:00.000000000 +1000
+++ 610-encryption.patch-new/kernel/power/suspend2_core/encryption.c	2005-07-05 23:54:31.000000000 +1000
@@ -0,0 +1,598 @@
+/*
+ * kernel/power/suspend2_core/encryption.c
+ *
+ * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains data encryption routines for suspend,
+ * using cryptoapi transforms.
+ *
+ * ToDo:
+ * - Apply min/max_keysize the cipher changes.
+ * - Test.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+
+#include "suspend.h"
+#include "plugins.h"
+#include "proc.h"
+#include "suspend2_common.h"
+#include "utility.h"
+#include "io.h"
+
+#define S2C_WRITE 0
+#define S2C_READ 1
+
+static struct suspend_plugin_ops s2_encryption_ops;
+static struct suspend_plugin_ops * next_driver;
+
+static char s2_encryptor_name[32];
+static struct crypto_tfm * s2_encryptor_transform;
+static char s2_encryptor_key[256];
+static int s2_key_len;
+static char s2_encryptor_iv[256];
+static int s2_encryptor_mode;
+static int s2_encryptor_save_key_and_iv;
+
+static u8 *page_buffer = NULL;
+static unsigned int bufofs;
+
+static struct scatterlist s2_crypt_sg[PAGE_SIZE/8];
+
+/* ---- Local buffer management ---- */
+
+/* allocate_local_buffer
+ *
+ * Description:	Allocates a page of memory for buffering output.
+ * Returns:	Int: Zero if successful, -ENONEM otherwise.
+ */
+
+static int allocate_local_buffer(void)
+{
+	if (!page_buffer) {
+		int i;
+		
+		page_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	
+		if (!page_buffer) {
+			printk(KERN_ERR
+				"Failed to allocate the page buffer for "
+				"suspend2 encryption driver.\n");
+			return -ENOMEM;
+		}
+
+		for (i=0; i < (PAGE_SIZE / s2_key_len); i++) {
+			s2_crypt_sg[i].page = virt_to_page(page_buffer);
+			s2_crypt_sg[i].offset = s2_key_len * i;
+			s2_crypt_sg[i].length = s2_key_len;
+		}
+	}
+
+	return 0;
+}
+
+/* free_local_buffer
+ *
+ * Description:	Frees memory allocated for buffering output.
+ */
+
+static inline void free_local_buffer(void)
+{
+	if (page_buffer)
+		free_pages((unsigned long) page_buffer, 0);
+
+	page_buffer = NULL;
+}
+
+/* suspend2_crypto_cleanup
+ *
+ * Description:	Frees memory allocated for our labours.
+ */
+
+static void suspend2_crypto_cleanup(void)
+{
+	if (s2_encryptor_transform) {
+		crypto_free_tfm(s2_encryptor_transform);
+		s2_encryptor_transform = NULL;
+	}
+}
+
+/* suspend2_crypto_prepare
+ *
+ * Description:	Prepare to do some work by allocating buffers and transforms.
+ * Returns:	Int: Zero if successful, -ENONEM otherwise.
+ */
+
+static int s2_encrypt_crypto_prepare(int mode)
+{
+	if (!*s2_encryptor_name) {
+		printk("Suspend2: Encryptor enabled but no name set.\n");
+		return 1;
+	}
+
+	if (!(s2_encryptor_transform = crypto_alloc_tfm(s2_encryptor_name,
+					1 << s2_encryptor_mode))) {
+		printk("Suspend2: Failed to initialise the encryption transform (%s, mode %d).\n",
+				s2_encryptor_name, s2_encryptor_mode);
+		return 1;
+	}
+
+	if (mode)
+		bufofs = PAGE_SIZE;
+	else
+		bufofs = 0;
+
+	s2_key_len = strlen(s2_encryptor_key);
+
+	if (crypto_cipher_setkey(s2_encryptor_transform, s2_encryptor_key, 
+				s2_key_len)) {
+		printk("%d is an invalid key length for cipher %s.\n",
+					s2_key_len,
+					s2_encryptor_name);
+		return 1;
+	}
+	
+	if (!mode) {
+		crypto_cipher_set_iv(s2_encryptor_transform,
+				s2_encryptor_iv,
+				crypto_tfm_alg_ivsize(s2_encryptor_transform));
+	}
+		
+	return 0;
+}
+
+/* ---- Exported functions ---- */
+
+/* write_init()
+ *
+ * Description:	Allocate buffers and prepare to encrypt data.
+ * Arguments:	Stream_number:	Ignored.
+ * Returns:	Zero on success, -ENOMEM if unable to vmalloc.
+ */
+
+static int s2_encrypt_write_init(int stream_number)
+{
+	int result;
+	
+	next_driver = get_next_filter(&s2_encryption_ops);
+
+	if (!next_driver) {
+		printk("Encryption Driver: Argh! No one wants my output!");
+		return -ECHILD;
+	}
+
+	if ((result = s2_encrypt_crypto_prepare(S2C_WRITE))) {
+		SET_RESULT_STATE(SUSPEND_ENCRYPTION_SETUP_FAILED);
+		suspend2_crypto_cleanup();
+		return result;
+	}
+	
+	if ((result = allocate_local_buffer()))
+		return result;
+
+	/* Only reset the stats if starting to write an image */
+	if (stream_number == 2)
+		bytes_in = bytes_out = 0;
+	
+	bufofs = 0;
+
+	return 0;
+}
+
+/* s2_encrypt_write_chunk()
+ *
+ * Description:	Encrypt a page of data, buffering output and passing on
+ * 		filled pages to the next plugin in the pipeline.
+ * Arguments:	Buffer_page:	Pointer to a buffer of size PAGE_SIZE, 
+ * 				containing data to be encrypted.
+ * Returns:	0 on success. Otherwise the error is that returned by later
+ * 		plugins, -ECHILD if we have a broken pipeline or -EIO if
+ * 		zlib errs.
+ */
+
+static int s2_encrypt_write_chunk(struct page * buffer_page)
+{
+	int ret; 
+	unsigned int len;
+	u16 len_written;
+	char * buffer_start;
+	
+	if (!s2_encryptor_transform)
+		return next_driver->ops.filter.write_chunk(buffer_page);
+
+	buffer_start = kmap(buffer_page);
+	memcpy(page_buffer, buffer_start, PAGE_SIZE);
+	kunmap(buffer_page);
+	
+	bytes_in += PAGE_SIZE;
+
+	len = PAGE_SIZE;
+
+	ret = crypto_cipher_encrypt(s2_encryptor_transform,
+			s2_crypt_sg, s2_crypt_sg, PAGE_SIZE);
+	
+	if (ret) {
+		printk("Encryption failed.\n");
+		return -EIO;
+	}
+	
+	len_written = (u16) len;
+
+	ret = next_driver->ops.filter.write_chunk(virt_to_page(page_buffer));
+
+	return ret;
+}
+
+/* write_cleanup()
+ *
+ * Description: Write unflushed data and free workspace.
+ * Returns:	Result of writing last page.
+ */
+
+static int s2_encrypt_write_cleanup(void)
+{
+	suspend2_crypto_cleanup();
+	free_local_buffer();
+
+	return 0;
+}
+
+/* read_init()
+ *
+ * Description:	Prepare to read a new stream of data.
+ * Arguments:	int: Section of image about to be read.
+ * Returns:	int: Zero on success, error number otherwise.
+ */
+
+static int s2_encrypt_read_init(int stream_number)
+{
+	int result;
+
+	next_driver = get_next_filter(&s2_encryption_ops);
+
+	if (!next_driver) {
+		printk("Encryption Driver: Argh! No one wants "
+				"to feed me data!");
+		return -ECHILD;
+	}
+	
+	if ((result = s2_encrypt_crypto_prepare(S2C_READ))) {
+		SET_RESULT_STATE(SUSPEND_ENCRYPTION_SETUP_FAILED);
+		suspend2_crypto_cleanup();
+		return result;
+	}
+	
+	if ((result = allocate_local_buffer()))
+		return result;
+
+	bufofs = PAGE_SIZE;
+
+	return 0;
+}
+
+/* s2_encrypt_read_chunk()
+ *
+ * Description:	Retrieve data from later plugins and deencrypt it until the
+ * 		input buffer is filled.
+ * Arguments:	Buffer_start: 	Pointer to a buffer of size PAGE_SIZE.
+ * 		Sync:		Whether the previous plugin (or core) wants its
+ * 				data synchronously.
+ * Returns:	Zero if successful. Error condition from me or from downstream
+ * 		on failure.
+ */
+
+static int s2_encrypt_read_chunk(struct page * buffer_page, int sync)
+{
+	int ret; 
+	char * buffer_start;
+
+	if (!s2_encryptor_transform)
+		return next_driver->ops.filter.read_chunk(buffer_page, sync);
+
+	/* 
+	 * All our reads must be synchronous - we can't deencrypt
+	 * data that hasn't been read yet.
+	 */
+
+	if ((ret = next_driver->ops.filter.read_chunk(
+			virt_to_page(page_buffer), SUSPEND_SYNC)) < 0) {
+		printk("Failed to read an encrypted block.\n");
+		return ret;
+	}
+
+	ret = crypto_cipher_decrypt(s2_encryptor_transform,
+			s2_crypt_sg, s2_crypt_sg, PAGE_SIZE);
+
+	if (ret)
+		printk("Decrypt function returned %d.\n", ret);
+
+	buffer_start = kmap(buffer_page);
+	memcpy(buffer_start, page_buffer, PAGE_SIZE);
+	kunmap(buffer_page);
+	return ret;
+}
+
+/* read_cleanup()
+ *
+ * Description:	Clean up after reading part or all of a stream of data.
+ * Returns:	int: Always zero. Never fails.
+ */
+
+static int s2_encrypt_read_cleanup(void)
+{
+	suspend2_crypto_cleanup();
+	free_local_buffer();
+	return 0;
+}
+
+/* s2_encrypt_print_debug_stats
+ *
+ * Description:	Print information to be recorded for debugging purposes into a
+ * 		buffer.
+ * Arguments:	buffer: Pointer to a buffer into which the debug info will be
+ * 			printed.
+ * 		size:	Size of the buffer.
+ * Returns:	Number of characters written to the buffer.
+ */
+
+static int s2_encrypt_print_debug_stats(char * buffer, int size)
+{
+	int len;
+	
+	len = suspend_snprintf(buffer, size, "- Encryptor %s enabled.\n",
+			s2_encryptor_name);
+	return len;
+}
+
+/* encryption_memory_needed
+ *
+ * Description:	Tell the caller how much memory we need to operate during
+ * 		suspend/resume.
+ * Returns:	Unsigned long. Maximum number of bytes of memory required for
+ * 		operation.
+ */
+
+static unsigned long s2_encrypt_memory_needed(void)
+{
+	return PAGE_SIZE;
+}
+
+static unsigned long s2_encrypt_storage_needed(void)
+{
+	return 2 * sizeof(unsigned long) + sizeof(int);
+}
+
+/* s2_encrypt_save_config_info
+ *
+ * Description:	Save informaton needed when reloading the image at resume time.
+ * Arguments:	Buffer:		Pointer to a buffer of size PAGE_SIZE.
+ * Returns:	Number of bytes used for saving our data.
+ */
+
+static int s2_encrypt_save_config_info(char * buffer)
+{
+	int buf_offset, str_size;
+
+	str_size = strlen(s2_encryptor_name);
+	*buffer = (char) str_size;
+	strncpy(buffer + 1, s2_encryptor_name, str_size + 1);
+	buf_offset = str_size + 2;
+
+	*(buffer + buf_offset) = (char) s2_encryptor_mode;
+	buf_offset++;
+
+	*(buffer + buf_offset) = (char) s2_encryptor_save_key_and_iv;
+	buf_offset++;
+
+	if (s2_encryptor_save_key_and_iv) {
+		
+		str_size = strlen(s2_encryptor_key);
+		*(buffer + buf_offset) = (char) str_size;
+		strncpy(buffer + buf_offset + 1, s2_encryptor_key, str_size + 1);
+
+		buf_offset+= str_size + 2;
+
+		str_size = strlen(s2_encryptor_iv);
+		*(buffer + buf_offset) = (char) str_size;
+		strncpy(buffer + buf_offset + 1, s2_encryptor_iv, str_size + 1);
+
+		buf_offset += str_size + 2;
+	}
+
+	return buf_offset;
+}
+
+/* s2_encrypt_load_config_info
+ *
+ * Description:	Reload information needed for deencrypting the image at 
+ * 		resume time.
+ * Arguments:	Buffer:		Pointer to the start of the data.
+ *		Size:		Number of bytes that were saved.
+ */
+
+static void s2_encrypt_load_config_info(char * buffer, int size)
+{
+	int buf_offset, str_size;
+
+	str_size = (int) *buffer;
+	strncpy(s2_encryptor_name, buffer + 1, str_size + 1);
+	buf_offset = str_size + 2;
+	
+	s2_encryptor_mode = (int) *(buffer + buf_offset);
+	buf_offset++;
+
+	s2_encryptor_save_key_and_iv = (int) *(buffer + buf_offset);
+	buf_offset++;
+
+	if (s2_encryptor_save_key_and_iv) {
+		str_size = (int) *(buffer + buf_offset);
+		strncpy(s2_encryptor_key, buffer + buf_offset + 1, str_size + 1);
+
+		buf_offset+= str_size + 2;
+
+		str_size = (int) *(buffer + buf_offset);
+		strncpy(s2_encryptor_iv, buffer + buf_offset + 1, str_size + 1);
+
+		buf_offset += str_size + 2;
+	} else {
+		*s2_encryptor_key = 0;
+		*s2_encryptor_iv = 0;
+	}
+	
+	if (buf_offset != size) {
+		printk("Suspend Encryptor config info size mismatch (%d != %d): settings ignored.\n",
+				buf_offset, size);
+		*s2_encryptor_key = 0;
+		*s2_encryptor_iv = 0;
+	}
+	return;
+}
+
+static void s2_encryptor_disable_if_empty(void)
+{
+	s2_encryption_ops.disabled = !(*s2_encryptor_name);
+}
+
+static int s2_encrypt_initialise(int starting_cycle)
+{
+	if (starting_cycle)
+		s2_encryptor_disable_if_empty();
+
+	return 0;
+}
+/*
+ * data for our proc entries.
+ */
+
+static struct suspend_proc_data proc_params[] = {
+	{
+		.filename			= "encryptor",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_STRING,
+		.data = {
+			.string = {
+				.variable	= s2_encryptor_name,
+				.max_length	= 31,
+			}
+		},
+		.write_proc			= s2_encryptor_disable_if_empty,
+	},
+
+	{
+		.filename			= "encryption_mode",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_INTEGER,
+		.data = {
+			.integer = {
+				.variable	= &s2_encryptor_mode,
+				.minimum	= 0,
+				.maximum	= 3,
+			}
+		}
+	},
+
+	{
+		.filename			= "encryption_save_key_and_iv",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_INTEGER,
+		.data = {
+			.integer = {
+				.variable	= &s2_encryptor_save_key_and_iv,
+				.minimum	= 0,
+				.maximum	= 1,
+			}
+		}
+	},
+
+	{
+		.filename			= "encryption_key",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_STRING,
+		.data = {
+			.string = {
+				.variable	= s2_encryptor_key,
+				.max_length	= 255,
+			}
+		}
+	},
+
+	{
+		.filename			= "encryption_iv",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_STRING,
+		.data = {
+			.string = {
+				.variable	= s2_encryptor_iv,
+				.max_length	= 255,
+			}
+		}
+	},
+
+	{
+		.filename			= "disable_encryption",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_INTEGER,
+		.data = {
+			.integer = {
+				.variable	= &s2_encryption_ops.disabled,
+				.minimum	= 0,
+				.maximum	= 1,
+			}
+		}
+	},
+	
+};
+
+/*
+ * Ops structure.
+ */
+
+static struct suspend_plugin_ops s2_encryption_ops = {
+	.type			= FILTER_PLUGIN,
+	.name			= "Encryptor",
+	.module			= THIS_MODULE,
+	.memory_needed 		= s2_encrypt_memory_needed,
+	.print_debug_info	= s2_encrypt_print_debug_stats,
+	.save_config_info	= s2_encrypt_save_config_info,
+	.load_config_info	= s2_encrypt_load_config_info,
+	.storage_needed		= s2_encrypt_storage_needed,
+	
+	.initialise		= s2_encrypt_initialise,
+	
+	.write_init		= s2_encrypt_write_init,
+	.write_cleanup		= s2_encrypt_write_cleanup,
+	.read_init		= s2_encrypt_read_init,
+	.read_cleanup		= s2_encrypt_read_cleanup,
+
+	.ops = {
+		.filter = {
+			.write_chunk		= s2_encrypt_write_chunk,
+			.read_chunk		= s2_encrypt_read_chunk,
+		}
+	}
+};
+
+/* ---- Registration ---- */
+
+static __init int s2_encrypt_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend Encryption Driver loading.\n");
+	if (!(result = suspend_register_plugin(&s2_encryption_ops))) {
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+	} else
+		printk("Software Suspend Encryption Driver unable to register!\n");
+	return result;
+}
+
+late_initcall(s2_encrypt_load);

