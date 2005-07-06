Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVGFDLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVGFDLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVGFDLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:11:14 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:8345 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262066AbVGFCT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:27 -0400
Subject: [PATCH] [30/48] Suspend2 2.1.9.8 for 2.6.12: 607-atomic-copy.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <11206164423235@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 608-compression.patch-old/kernel/power/suspend2_core/compression.c 608-compression.patch-new/kernel/power/suspend2_core/compression.c
--- 608-compression.patch-old/kernel/power/suspend2_core/compression.c	1970-01-01 10:00:00.000000000 +1000
+++ 608-compression.patch-new/kernel/power/suspend2_core/compression.c	2005-07-05 23:52:59.000000000 +1000
@@ -0,0 +1,636 @@
+/*
+ * kernel/power/suspend2_core/compression.c
+ *
+ * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains data compression routines for suspend,
+ * using LZH compression.
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+#include <linux/crypto.h>
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
+static int s2_expected_compression = 0;
+
+static struct suspend_plugin_ops s2_compression_ops;
+static struct suspend_plugin_ops * next_driver;
+
+static char s2_compressor_name[32];
+static struct crypto_tfm * s2_compressor_transform;
+
+static u8 *local_buffer = NULL;
+static u8 *page_buffer = NULL;
+static unsigned int bufofs;
+
+static int position = 0;
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
+	if (!local_buffer) {
+		local_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	
+		if (!local_buffer) {
+			printk(KERN_ERR
+				"Failed to allocate the local buffer for "
+				"suspend2 compression driver.\n");
+			return -ENOMEM;
+		}
+	}
+
+	if (!page_buffer) {
+		page_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	
+		if (!page_buffer) {
+			printk(KERN_ERR
+				"Failed to allocate the page buffer for "
+				"suspend2 compression driver.\n");
+			return -ENOMEM;
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
+	if (local_buffer)
+		free_pages((unsigned long) local_buffer, 0);
+
+	local_buffer = NULL;
+
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
+	if (s2_compressor_transform) {
+		crypto_free_tfm(s2_compressor_transform);
+		s2_compressor_transform = NULL;
+	}
+}
+
+/* suspend2_crypto_prepare
+ *
+ * Description:	Prepare to do some work by allocating buffers and transforms.
+ * Returns:	Int: Zero if successful, -ENONEM otherwise.
+ */
+
+static int s2_compress_crypto_prepare(int mode)
+{
+	if (!*s2_compressor_name) {
+		printk("Suspend2: Compression enabled but no compressor name set.\n");
+		return 1;
+	}
+
+	if (!(s2_compressor_transform = crypto_alloc_tfm(s2_compressor_name, 0))) {
+		printk("Suspend2: Failed to initialise the compression transform.\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+/* ---- Exported functions ---- */
+
+/* write_init()
+ *
+ * Description:	Allocate buffers and prepare to compress data.
+ * Arguments:	Stream_number:	Ignored.
+ * Returns:	Zero on success, -ENOMEM if unable to vmalloc.
+ */
+
+static int s2_compress_write_init(int stream_number)
+{
+	int result;
+	
+	next_driver = get_next_filter(&s2_compression_ops);
+
+	if (!next_driver) {
+		printk("Compression Driver: Argh! No one wants my output!");
+		return -ECHILD;
+	}
+
+	if ((result = s2_compress_crypto_prepare(S2C_WRITE))) {
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
+	position = 0;
+
+	return 0;
+}
+
+/* s2_compress_write()
+ *
+ * Description:	Helper function for write_chunk. Write the compressed data.
+ * Arguments:	u8*:		Output buffer to be written.
+ * 		unsigned int:	Length of buffer.
+ * Return:	int:		Result to be passed back to caller.
+ */
+
+static int s2_compress_write (u8 *buffer, unsigned int len)
+{
+	int ret;
+
+	bytes_out += len;
+
+	while (len + bufofs > PAGE_SIZE) {
+		unsigned int chunk = PAGE_SIZE - bufofs;
+		memcpy (local_buffer + bufofs, buffer, chunk);
+		buffer += chunk;
+		len -= chunk;
+		bufofs = 0;
+		if ((ret = next_driver->ops.filter.write_chunk(virt_to_page(local_buffer))) < 0)
+			return ret;
+	}
+	memcpy (local_buffer + bufofs, buffer, len);
+	bufofs += len;
+	return 0;
+}
+
+/* s2_compress_write_chunk()
+ *
+ * Description:	Compress a page of data, buffering output and passing on
+ * 		filled pages to the next plugin in the pipeline.
+ * Arguments:	Buffer_page:	Pointer to a buffer of size PAGE_SIZE, 
+ * 				containing data to be compressed.
+ * Returns:	0 on success. Otherwise the error is that returned by later
+ * 		plugins, -ECHILD if we have a broken pipeline or -EIO if
+ * 		zlib errs.
+ */
+
+static int s2_compress_write_chunk(struct page * buffer_page)
+{
+	int ret; 
+	unsigned int len;
+	u16 len_written;
+	char * buffer_start;
+	
+	if (!s2_compressor_transform)
+		return next_driver->ops.filter.write_chunk(buffer_page);
+
+	buffer_start = kmap(buffer_page);
+
+	bytes_in += PAGE_SIZE;
+
+	len = PAGE_SIZE;
+
+	ret = crypto_comp_compress(s2_compressor_transform,
+			buffer_start, PAGE_SIZE,
+			page_buffer, &len);
+	
+	if (ret) {
+		printk("Compression failed.\n");
+		goto failure;
+	}
+	
+	len_written = (u16) len;
+		
+	if ((ret = s2_compress_write((u8 *)&len_written, 2)) >= 0) {
+		if ((ret = s2_compress_write((u8 *) &position, sizeof(position))))
+			return -EIO;
+		if (len < PAGE_SIZE) { // some compression
+			position += len;
+			ret = s2_compress_write(page_buffer, len);
+		} else {
+			ret = s2_compress_write(buffer_start, PAGE_SIZE);
+			position += PAGE_SIZE;
+		}
+	}
+	position += 2 + sizeof(int);
+
+
+failure:
+	kunmap(buffer_page);
+	return ret;
+}
+
+/* write_cleanup()
+ *
+ * Description: Write unflushed data and free workspace.
+ * Returns:	Result of writing last page.
+ */
+
+static int s2_compress_write_cleanup(void)
+{
+	int ret = 0;
+	
+	if (s2_compressor_transform)
+		ret = next_driver->ops.filter.write_chunk(virt_to_page(local_buffer));
+
+	suspend2_crypto_cleanup();
+	free_local_buffer();
+
+	return ret;
+}
+
+/* read_init()
+ *
+ * Description:	Prepare to read a new stream of data.
+ * Arguments:	int: Section of image about to be read.
+ * Returns:	int: Zero on success, error number otherwise.
+ */
+
+static int s2_compress_read_init(int stream_number)
+{
+	int result;
+
+	next_driver = get_next_filter(&s2_compression_ops);
+
+	if (!next_driver) {
+		printk("Compression Driver: Argh! No one wants "
+				"to feed me data!");
+		return -ECHILD;
+	}
+	
+	if ((result = s2_compress_crypto_prepare(S2C_READ)))
+		return result;
+	
+	if ((result = allocate_local_buffer()))
+		return result;
+
+	bufofs = PAGE_SIZE;
+
+	position = 0;
+
+	return 0;
+}
+
+/* s2_compress_read()
+ *
+ * Description:	Read data into compression buffer.
+ * Arguments:	u8 *:		Address of the buffer.
+ * 		unsigned int:	Length
+ * Returns:	int:		Result of reading the image chunk.
+ */
+
+static int s2_compress_read (u8 * buffer, unsigned int len)
+{
+	int ret;
+
+	while (len + bufofs > PAGE_SIZE) {
+		unsigned int chunk = PAGE_SIZE - bufofs;
+		memcpy(buffer, local_buffer + bufofs, chunk);
+		buffer += chunk;
+		len -= chunk;
+		bufofs = 0;
+		if ((ret = next_driver->ops.filter.read_chunk(
+				virt_to_page(local_buffer), SUSPEND_SYNC)) < 0) {
+			return ret;
+		}
+	}
+	memcpy (buffer, local_buffer + bufofs, len);
+	bufofs += len;
+	return 0;
+}
+
+/* s2_compress_read_chunk()
+ *
+ * Description:	Retrieve data from later plugins and decompress it until the
+ * 		input buffer is filled.
+ * Arguments:	Buffer_start: 	Pointer to a buffer of size PAGE_SIZE.
+ * 		Sync:		Whether the previous plugin (or core) wants its
+ * 				data synchronously.
+ * Returns:	Zero if successful. Error condition from me or from downstream
+ * 		on failure.
+ */
+
+static int s2_compress_read_chunk(struct page * buffer_page, int sync)
+{
+	int ret, position_saved; 
+	unsigned int len;
+	u16 len_written;
+	char * buffer_start;
+
+	if (!s2_compressor_transform)
+		return next_driver->ops.filter.read_chunk(buffer_page, SUSPEND_ASYNC);
+
+	/* 
+	 * All our reads must be synchronous - we can't decompress
+	 * data that hasn't been read yet.
+	 */
+
+	buffer_start = kmap(buffer_page);
+
+	if ((ret = s2_compress_read ((u8 *)&len_written, 2)) >= 0) {
+		len = (unsigned int) len_written;
+		ret = s2_compress_read((u8 *) &position_saved, sizeof(position_saved));
+		if (ret)
+			return ret;
+
+		if (position != position_saved) {
+			printk("Position saved (%d) != position I'm at now (%d).\n",
+					position_saved, position);
+			BUG_ON(1);
+		}
+		if (len >= PAGE_SIZE) { // uncompressed
+			ret = s2_compress_read(buffer_start, PAGE_SIZE);
+			if (ret)
+				return ret;
+
+			position += PAGE_SIZE;
+		} else { // compressed
+			if ((ret = s2_compress_read(page_buffer, len)) >= 0) {
+				int outlen = PAGE_SIZE;
+				/* Important note.
+				 *
+				 * For Deflate, decompression return values may represent
+				 * errors. Deflate complains when everything is alright, so
+				 * we ignore the errors unless the number of output bytes is
+				 * not PAGE_SIZE.
+				 */
+				crypto_comp_decompress(s2_compressor_transform, 
+						page_buffer, len,
+						buffer_start, &outlen);
+				if (outlen != PAGE_SIZE) {
+					printk("Decompression yielded %ld bytes instead of %d.\n", PAGE_SIZE, outlen);
+					ret = -EIO;
+				} else
+					ret = 0;
+			}
+			position += len;
+		}
+		position += 2 + sizeof(int);
+	} else
+		printk("Compress_read returned %d.", ret);
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
+static int s2_compress_read_cleanup(void)
+{ 
+	suspend2_crypto_cleanup();
+	free_local_buffer();
+	return 0;
+}
+
+/* s2_compress_print_debug_stats
+ *
+ * Description:	Print information to be recorded for debugging purposes into a
+ * 		buffer.
+ * Arguments:	buffer: Pointer to a buffer into which the debug info will be
+ * 			printed.
+ * 		size:	Size of the buffer.
+ * Returns:	Number of characters written to the buffer.
+ */
+
+static int s2_compress_print_debug_stats(char * buffer, int size)
+{
+	int pages_in = bytes_in >> PAGE_SHIFT, 
+		pages_out = bytes_out >> PAGE_SHIFT;
+	int len;
+	
+	/* Output the compression ratio achieved. */
+	len = suspend_snprintf(buffer, size, "- Compressor %s enabled.\n",
+			s2_compressor_name);
+	if (pages_in)
+		len+= suspend_snprintf(buffer+len, size - len,
+		  "  Compressed %ld bytes into %ld (%d percent compression).\n",
+		  bytes_in, bytes_out, (pages_in - pages_out) * 100 / pages_in);
+	return len;
+}
+
+/* compression_memory_needed
+ *
+ * Description:	Tell the caller how much memory we need to operate during
+ * 		suspend/resume.
+ * Returns:	Unsigned long. Maximum number of bytes of memory required for
+ * 		operation.
+ */
+
+static unsigned long s2_compress_memory_needed(void)
+{
+	return PAGE_SIZE;
+}
+
+static unsigned long s2_compress_storage_needed(void)
+{
+	return 2 * sizeof(unsigned long) + sizeof(int);
+}
+
+/* s2_compress_save_config_info
+ *
+ * Description:	Save informaton needed when reloading the image at resume time.
+ * Arguments:	Buffer:		Pointer to a buffer of size PAGE_SIZE.
+ * Returns:	Number of bytes used for saving our data.
+ */
+
+static int s2_compress_save_config_info(char * buffer)
+{
+	int namelen = strlen(s2_compressor_name) + 1;
+	int total_len;
+	
+	*((unsigned long *) buffer) = bytes_in;
+	*((unsigned long *) (buffer + sizeof(unsigned long))) = bytes_out;
+	*((int *) (buffer + 2 * sizeof(unsigned long))) = s2_expected_compression;
+	*((int *) (buffer + 3 * sizeof(unsigned long))) = namelen;
+	strncpy(buffer + 4 * sizeof(unsigned long), s2_compressor_name, namelen);
+	total_len = 2 * sizeof(unsigned long) + 2 * sizeof(int) + namelen;
+	return total_len;
+}
+
+/* s2_compress_load_config_info
+ *
+ * Description:	Reload information needed for decompressing the image at 
+ * 		resume time.
+ * Arguments:	Buffer:		Pointer to the start of the data.
+ *		Size:		Number of bytes that were saved.
+ */
+
+static void s2_compress_load_config_info(char * buffer, int size)
+{
+	int namelen;
+	
+	bytes_in = *((unsigned long *) buffer);
+	bytes_out = *((unsigned long *) (buffer + sizeof(unsigned long)));
+	s2_expected_compression = *((int *) (buffer + 2 * sizeof(unsigned long)));
+	namelen = *((int *) (buffer + 3 * sizeof(unsigned long)));
+	strncpy(s2_compressor_name, buffer + 4 * sizeof(unsigned long), namelen);
+	return;
+}
+
+/* s2_compress_get_expected_compression
+ * 
+ * Description:	Returns the expected ratio between data passed into this plugin
+ * 		and the amount of data output when writing.
+ * Returns:	100 if the plugin is disabled. Otherwise the value set by the
+ * 		user via our proc entry.
+ */
+
+static int s2_compress_get_expected_compression(void)
+{
+	return 100 - s2_expected_compression;
+}
+
+static void s2_compressor_disable_if_empty(void)
+{
+	s2_compression_ops.disabled = !(*s2_compressor_name);
+}
+
+static int s2_compress_initialise(int starting_cycle)
+{
+	if (starting_cycle)
+		s2_compressor_disable_if_empty();
+
+	return 0;
+}
+/*
+ * data for our proc entries.
+ */
+
+static struct suspend_proc_data proc_params[] = {
+	{
+		.filename			= "expected_compression",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_INTEGER,
+		.data = {
+			.integer = {
+				.variable	= &s2_expected_compression,
+				.minimum	= 0,
+				.maximum	= 99,
+			}
+		}
+	},
+
+	{
+		.filename			= "disable_compression",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_INTEGER,
+		.data = {
+			.integer = {
+				.variable	= &s2_compression_ops.disabled,
+				.minimum	= 0,
+				.maximum	= 1,
+			}
+		}
+	},
+
+	{
+		.filename			= "compressor",
+		.permissions			= PROC_RW,
+		.type				= SUSPEND_PROC_DATA_STRING,
+		.data = {
+			.string = {
+				.variable	= s2_compressor_name,
+				.max_length	= 31,
+			}
+		},
+		.write_proc			= &s2_compressor_disable_if_empty,
+	}
+};
+
+/*
+ * Ops structure.
+ */
+
+static struct suspend_plugin_ops s2_compression_ops = {
+	.type			= FILTER_PLUGIN,
+	.name			= "Suspend2 Compressor",
+	.module			= THIS_MODULE,
+	.memory_needed 		= s2_compress_memory_needed,
+	.print_debug_info	= s2_compress_print_debug_stats,
+	.save_config_info	= s2_compress_save_config_info,
+	.load_config_info	= s2_compress_load_config_info,
+	.storage_needed		= s2_compress_storage_needed,
+	
+	.initialise		= s2_compress_initialise,
+	
+	.write_init		= s2_compress_write_init,
+	.write_cleanup		= s2_compress_write_cleanup,
+	.read_init		= s2_compress_read_init,
+	.read_cleanup		= s2_compress_read_cleanup,
+
+	.ops = {
+		.filter = {
+			.write_chunk		= s2_compress_write_chunk,
+			.read_chunk		= s2_compress_read_chunk,
+			.expected_compression	= s2_compress_get_expected_compression,
+		}
+	}
+};
+
+/* ---- Registration ---- */
+
+static __init int s2_compress_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend Compression Driver loading.\n");
+	if (!(result = suspend_register_plugin(&s2_compression_ops))) {
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+	} else
+		printk("Software Suspend Compression Driver unable to register!\n");
+	return result;
+}
+
+#ifdef MODULE
+static __exit void s2_compress_unload(void)
+{
+	printk("Software Suspend Compression Driver unloading.\n");
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&proc_params[i]);
+	suspend_unregister_plugin(&s2_compression_ops);
+}
+
+
+module_init(s2_compress_load);
+module_exit(s2_compress_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Compression Support for Suspend2");
+#else
+late_initcall(s2_compress_load);
+#endif

