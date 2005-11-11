Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVKKQvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVKKQvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVKKQvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:51:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:3221 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750901AbVKKQvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:51:37 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52213.571541.984505@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:51:01 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 7/12] relayfs: add support for relay files in other filesystems
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a couple of callback functions that allow a client to
hook into relay_open()/close() and supply the files that will be used
to represent the channel buffers; the default implementation if no
callbacks are defined is to create the files in relayfs.  This is to
support the creation and use of relay files in other filesystems such
as debugfs, as implied by the fact that relayfs_file_operations are
exported.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/buffers.c       |    2 +-
 fs/relayfs/relay.c         |   30 ++++++++++++++++++++++++++++--
 include/linux/relayfs_fs.h |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/fs/relayfs/buffers.c b/fs/relayfs/buffers.c
--- a/fs/relayfs/buffers.c
+++ b/fs/relayfs/buffers.c
@@ -185,6 +185,6 @@ void relay_destroy_buf(struct rchan_buf 
 void relay_remove_buf(struct kref *kref)
 {
 	struct rchan_buf *buf = container_of(kref, struct rchan_buf, kref);
-	relayfs_remove(buf->dentry);
+	buf->chan->cb->remove_buf_file(buf->dentry);
 	relay_destroy_buf(buf);
 }
diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -80,11 +80,33 @@ static void buf_unmapped_default_callbac
 {
 }
 
+/*
+ * create_buf_file_create() default callback.  Creates file to represent buf.
+ */
+static struct dentry *create_buf_file_default_callback(const char *filename,
+						       struct dentry *parent,
+						       int mode,
+						       struct rchan_buf *buf)
+{
+	return relayfs_create_file(filename, parent, mode,
+				   &relayfs_file_operations, buf);
+}
+
+/*
+ * remove_buf_file() default callback.  Removes file representing relay buffer.
+ */
+static int remove_buf_file_default_callback(struct dentry *dentry)
+{
+	return relayfs_remove(dentry);
+}
+
 /* relay channel default callbacks */
 static struct rchan_callbacks default_channel_callbacks = {
 	.subbuf_start = subbuf_start_default_callback,
 	.buf_mapped = buf_mapped_default_callback,
 	.buf_unmapped = buf_unmapped_default_callback,
+	.create_buf_file = create_buf_file_default_callback,
+	.remove_buf_file = remove_buf_file_default_callback,
 };
 
 /**
@@ -176,8 +198,8 @@ static struct rchan_buf *relay_open_buf(
  		return NULL;
 
 	/* Create file in fs */
-	dentry = relayfs_create_file(filename, parent, S_IRUSR,
-				     &relayfs_file_operations, buf);
+ 	dentry = chan->cb->create_buf_file(filename, parent, S_IRUSR,
+ 					   buf);
  	if (!dentry) {
  		relay_destroy_buf(buf);
 		return NULL;
@@ -220,6 +242,10 @@ static inline void setup_callbacks(struc
 		cb->buf_mapped = buf_mapped_default_callback;
 	if (!cb->buf_unmapped)
 		cb->buf_unmapped = buf_unmapped_default_callback;
+	if (!cb->create_buf_file)
+		cb->create_buf_file = create_buf_file_default_callback;
+	if (!cb->remove_buf_file)
+		cb->remove_buf_file = remove_buf_file_default_callback;
 	chan->cb = cb;
 }
 
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -109,6 +109,40 @@ struct rchan_callbacks
 	 */
         void (*buf_unmapped)(struct rchan_buf *buf,
 			     struct file *filp);
+	/*
+	 * create_buf_file - create file to represent a relayfs channel buffer
+	 * @filename: the name of the file to create
+	 * @parent: the parent of the file to create
+	 * @mode: the mode of the file to create
+	 * @buf: the channel buffer
+	 *
+	 * Called during relay_open(), once for each per-cpu buffer,
+	 * to allow the client to create a file to be used to
+	 * represent the corresponding channel buffer.  If the file is
+	 * created outside of relayfs, the parent must also exist in
+	 * that filesystem.
+	 *
+	 * The callback should return the dentry of the file created
+	 * to represent the relay buffer.
+	 *
+	 * See Documentation/filesystems/relayfs.txt for more info.
+	 */
+	struct dentry *(*create_buf_file)(const char *filename,
+					  struct dentry *parent,
+					  int mode,
+					  struct rchan_buf *buf);
+
+	/*
+	 * remove_buf_file - remove file representing a relayfs channel buffer
+	 * @dentry: the dentry of the file to remove
+	 *
+	 * Called during relay_close(), once for each per-cpu buffer,
+	 * to allow the client to remove a file used to represent a
+	 * channel buffer.
+	 *
+	 * The callback should return 0 if successful, negative if not.
+	 */
+	int (*remove_buf_file)(struct dentry *dentry);
 };
 
 /*


