Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVKKQwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVKKQwx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVKKQwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:52:53 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:4316 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750909AbVKKQww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:52:52 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52288.86985.30978@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:52:16 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 9/12] relayfs: add support for global relay buffers
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the optional is_global outparam to the
create_buf_file() callback.  This can be used by clients to create a
single global relayfs buffer instead of the default per-cpu buffers.
This was suggested as being useful for certain debugging applications
where it's more convenient to be able to get all the data from a
single channel without having to go to the bother of dealing with
per-cpu files.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/relay.c         |   35 +++++++++++++++++++++++++----------
 include/linux/relayfs_fs.h |    8 +++++++-
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -86,7 +86,8 @@ static void buf_unmapped_default_callbac
 static struct dentry *create_buf_file_default_callback(const char *filename,
 						       struct dentry *parent,
 						       int mode,
-						       struct rchan_buf *buf)
+						       struct rchan_buf *buf,
+						       int *is_global)
 {
 	return relayfs_create_file(filename, parent, mode,
 				   &relayfs_file_operations, buf);
@@ -170,14 +171,16 @@ static inline void __relay_reset(struct 
 void relay_reset(struct rchan *chan)
 {
 	unsigned int i;
+	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i])
-			continue;
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
 		__relay_reset(chan->buf[i], 0);
+		prev = chan->buf[i];
 	}
 }
 
@@ -188,18 +191,22 @@ void relay_reset(struct rchan *chan)
  */
 static struct rchan_buf *relay_open_buf(struct rchan *chan,
 					const char *filename,
-					struct dentry *parent)
+					struct dentry *parent,
+					int *is_global)
 {
 	struct rchan_buf *buf;
 	struct dentry *dentry;
 
+	if (*is_global)
+		return chan->buf[0];
+ 	
  	buf = relay_create_buf(chan);
  	if (!buf)
  		return NULL;
 
 	/* Create file in fs */
  	dentry = chan->cb->create_buf_file(filename, parent, S_IRUSR,
- 					   buf);
+ 					   buf, is_global);
  	if (!dentry) {
  		relay_destroy_buf(buf);
 		return NULL;
@@ -273,6 +280,7 @@ struct rchan *relay_open(const char *bas
 	unsigned int i;
 	struct rchan *chan;
 	char *tmpname;
+	int is_global = 0;
 
 	if (!base_filename)
 		return NULL;
@@ -297,7 +305,8 @@ struct rchan *relay_open(const char *bas
 
 	for_each_online_cpu(i) {
 		sprintf(tmpname, "%s%d", base_filename, i);
-		chan->buf[i] = relay_open_buf(chan, tmpname, parent);
+		chan->buf[i] = relay_open_buf(chan, tmpname, parent,
+					      &is_global);
 		chan->buf[i]->cpu = i;
 		if (!chan->buf[i])
 			goto free_bufs;
@@ -311,6 +320,8 @@ free_bufs:
 		if (!chan->buf[i])
 			break;
 		relay_close_buf(chan->buf[i]);
+		if (is_global)
+			break;
 	}
 	kfree(tmpname);
 
@@ -421,14 +432,16 @@ void relay_destroy_channel(struct kref *
 void relay_close(struct rchan *chan)
 {
 	unsigned int i;
+	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i])
-			continue;
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
 		relay_close_buf(chan->buf[i]);
+		prev = chan->buf[i];
 	}
 
 	kref_put(&chan->kref, relay_destroy_channel);
@@ -443,14 +456,16 @@ void relay_close(struct rchan *chan)
 void relay_flush(struct rchan *chan)
 {
 	unsigned int i;
+	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i])
-			continue;
+		if (!chan->buf[i] || chan->buf[i] == prev)
+			break;
 		relay_switch_subbuf(chan->buf[i], 0);
+		prev = chan->buf[i];
 	}
 }
 
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -115,6 +115,7 @@ struct rchan_callbacks
 	 * @parent: the parent of the file to create
 	 * @mode: the mode of the file to create
 	 * @buf: the channel buffer
+	 * @is_global: outparam - set non-zero if the buffer should be global
 	 *
 	 * Called during relay_open(), once for each per-cpu buffer,
 	 * to allow the client to create a file to be used to
@@ -125,12 +126,17 @@ struct rchan_callbacks
 	 * The callback should return the dentry of the file created
 	 * to represent the relay buffer.
 	 *
+	 * Setting the is_global outparam to a non-zero value will
+	 * cause relay_open() to create a single global buffer rather
+	 * than the default set of per-cpu buffers.
+	 *
 	 * See Documentation/filesystems/relayfs.txt for more info.
 	 */
 	struct dentry *(*create_buf_file)(const char *filename,
 					  struct dentry *parent,
 					  int mode,
-					  struct rchan_buf *buf);
+					  struct rchan_buf *buf,
+					  int *is_global);
 
 	/*
 	 * remove_buf_file - remove file representing a relayfs channel buffer


