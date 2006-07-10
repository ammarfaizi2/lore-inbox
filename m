Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbWGJVdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbWGJVdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWGJVdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:33:14 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:59344 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965243AbWGJVdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:33:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/2] swsusp: struct snapshot_handle cleanup
Date: Mon, 10 Jul 2006 23:16:48 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200607102240.45365.rjw@sisk.pl>
In-Reply-To: <200607102240.45365.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607102316.48641.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments describing struct snapshot_handle and its members,
change the confusing name of its member 'page' to 'cur'.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/power.h    |   64 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/power/snapshot.c |   40 +++++++++++++++---------------
 2 files changed, 76 insertions(+), 28 deletions(-)

Index: linux-2.6.18-rc1-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.18-rc1-mm1.orig/kernel/power/power.h
+++ linux-2.6.18-rc1-mm1/kernel/power/power.h
@@ -50,17 +50,65 @@ extern asmlinkage int swsusp_arch_resume
 
 extern unsigned int count_data_pages(void);
 
+/**
+ *	Auxiliary structure used for reading the snapshot image data and
+ *	metadata from and writing them to the list of page backup entries
+ *	(PBEs) which is the main data structure of swsusp.
+ *
+ *	Using struct snapshot_handle we can transfer the image, including its
+ *	metadata, as a continuous sequence of bytes with the help of
+ *	snapshot_read_next() and snapshot_write_next().
+ *
+ *	The code that writes the image to a storage or transfers it to
+ *	the user land is required to use snapshot_read_next() for this
+ *	purpose and it should not make any assumptions regarding the internal
+ *	structure of the image.  Similarly, the code that reads the image from
+ *	a storage or transfers it from the user land is required to use
+ *	snapshot_write_next().
+ *
+ *	This may allow us to change the internal structure of the image
+ *	in the future with considerably less effort.
+ */
+
 struct snapshot_handle {
-	loff_t		offset;
-	unsigned int	page;
-	unsigned int	page_offset;
-	unsigned int	prev;
-	struct pbe	*pbe, *last_pbe;
-	void		*buffer;
-	unsigned int	buf_offset;
-	int		sync_read;
+	loff_t		offset;	/* number of the last byte ready for reading
+				 * or writing in the sequence
+				 */
+	unsigned int	cur;	/* number of the block of PAGE_SIZE bytes the
+				 * next operation will refer to (ie. current)
+				 */
+	unsigned int	cur_offset;	/* offset with respect to the current
+					 * block (for the next operation)
+					 */
+	unsigned int	prev;	/* number of the block of PAGE_SIZE bytes that
+				 * was the current one previously
+				 */
+	struct pbe	*pbe;	/* PBE that corresponds to 'buffer' */
+	struct pbe	*last_pbe;	/* When the image is restored (eg. read
+					 * from disk) we can store some image
+					 * data directly in the page frames
+					 * in which they were before suspend.
+					 * In such a case the PBEs that
+					 * correspond to them will be unused.
+					 * This is the last PBE, so far, that
+					 * does not correspond to such data.
+					 */
+	void		*buffer;	/* address of the block to read from
+					 * or write to
+					 */
+	unsigned int	buf_offset;	/* location to read from or write to,
+					 * given as a displacement from 'buffer'
+					 */
+	int		sync_read;	/* Set to one to notify the caller of
+					 * snapshot_write_next() that it may
+					 * need to call wait_on_bio_chain()
+					 */
 };
 
+/* This macro returns the address from/to which the caller of
+ * snapshot_read_next()/snapshot_write_next() is allowed to
+ * read/write data after the function returns
+ */
 #define data_of(handle)	((handle).buffer + (handle).buf_offset)
 
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
Index: linux-2.6.18-rc1-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc1-mm1.orig/kernel/power/snapshot.c
+++ linux-2.6.18-rc1-mm1/kernel/power/snapshot.c
@@ -555,7 +555,7 @@ static inline struct pbe *pack_orig_addr
 
 int snapshot_read_next(struct snapshot_handle *handle, size_t count)
 {
-	if (handle->page > nr_meta_pages + nr_copy_pages)
+	if (handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 	if (!buffer) {
 		/* This makes the buffer be freed by swsusp_free() */
@@ -568,8 +568,8 @@ int snapshot_read_next(struct snapshot_h
 		handle->buffer = buffer;
 		handle->pbe = pagedir_nosave;
 	}
-	if (handle->prev < handle->page) {
-		if (handle->page <= nr_meta_pages) {
+	if (handle->prev < handle->cur) {
+		if (handle->cur <= nr_meta_pages) {
 			handle->pbe = pack_orig_addresses(buffer, handle->pbe);
 			if (!handle->pbe)
 				handle->pbe = pagedir_nosave;
@@ -577,15 +577,15 @@ int snapshot_read_next(struct snapshot_h
 			handle->buffer = (void *)handle->pbe->address;
 			handle->pbe = handle->pbe->next;
 		}
-		handle->prev = handle->page;
+		handle->prev = handle->cur;
 	}
-	handle->buf_offset = handle->page_offset;
-	if (handle->page_offset + count >= PAGE_SIZE) {
-		count = PAGE_SIZE - handle->page_offset;
-		handle->page_offset = 0;
-		handle->page++;
+	handle->buf_offset = handle->cur_offset;
+	if (handle->cur_offset + count >= PAGE_SIZE) {
+		count = PAGE_SIZE - handle->cur_offset;
+		handle->cur_offset = 0;
+		handle->cur++;
 	} else {
-		handle->page_offset += count;
+		handle->cur_offset += count;
 	}
 	handle->offset += count;
 	return count;
@@ -820,7 +820,7 @@ int snapshot_write_next(struct snapshot_
 {
 	int error = 0;
 
-	if (handle->prev && handle->page > nr_meta_pages + nr_copy_pages)
+	if (handle->prev && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 	if (!buffer) {
 		/* This makes the buffer be freed by swsusp_free() */
@@ -831,7 +831,7 @@ int snapshot_write_next(struct snapshot_
 	if (!handle->offset)
 		handle->buffer = buffer;
 	handle->sync_read = 1;
-	if (handle->prev < handle->page) {
+	if (handle->prev < handle->cur) {
 		if (!handle->prev) {
 			error = load_header(handle,
 					(struct swsusp_info *)buffer);
@@ -854,15 +854,15 @@ int snapshot_write_next(struct snapshot_
 			handle->buffer = get_buffer(handle);
 			handle->sync_read = 0;
 		}
-		handle->prev = handle->page;
+		handle->prev = handle->cur;
 	}
-	handle->buf_offset = handle->page_offset;
-	if (handle->page_offset + count >= PAGE_SIZE) {
-		count = PAGE_SIZE - handle->page_offset;
-		handle->page_offset = 0;
-		handle->page++;
+	handle->buf_offset = handle->cur_offset;
+	if (handle->cur_offset + count >= PAGE_SIZE) {
+		count = PAGE_SIZE - handle->cur_offset;
+		handle->cur_offset = 0;
+		handle->cur++;
 	} else {
-		handle->page_offset += count;
+		handle->cur_offset += count;
 	}
 	handle->offset += count;
 	return count;
@@ -871,5 +871,5 @@ int snapshot_write_next(struct snapshot_
 int snapshot_image_loaded(struct snapshot_handle *handle)
 {
 	return !(!handle->pbe || handle->pbe->next || !nr_copy_pages ||
-		handle->page <= nr_meta_pages + nr_copy_pages);
+		handle->cur <= nr_meta_pages + nr_copy_pages);
 }
