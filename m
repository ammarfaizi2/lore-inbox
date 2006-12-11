Return-Path: <linux-kernel-owner+w=401wt.eu-S937560AbWLKTDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937560AbWLKTDw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937106AbWLKTDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:03:52 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:52226 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937560AbWLKTDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:03:51 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] constify pipe_buf_operations
Date: Mon, 11 Dec 2006 20:04:03 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <200612111152.56945.dada1@cosmosbay.com> <200612111450.07722.dada1@cosmosbay.com>
In-Reply-To: <200612111450.07722.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kuafFtYYE0vCWsI"
Message-Id: <200612112004.04402.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kuafFtYYE0vCWsI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

pipe/splice should use const pipe_buf_operations and file_operations

struct pipe_inode_info has an unused field "start" : get rid of it.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_kuafFtYYE0vCWsI
Content-Type: text/plain;
  charset="utf-8";
  name="constify_pipe_buf_operations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="constify_pipe_buf_operations.patch"

--- linux-2.6.19/include/linux/pipe_fs_i.h	2006-12-11 17:00:21.000000000 +0100
+++ linux-2.6.19-ed/include/linux/pipe_fs_i.h	2006-12-11 17:09:24.000000000 +0100
@@ -12,7 +12,7 @@
 struct pipe_buffer {
 	struct page *page;
 	unsigned int offset, len;
-	struct pipe_buf_operations *ops;
+	const struct pipe_buf_operations *ops;
 	unsigned int flags;
 };
 
@@ -43,7 +43,6 @@ struct pipe_inode_info {
 	unsigned int nrbufs, curbuf;
 	struct pipe_buffer bufs[PIPE_BUFFERS];
 	struct page *tmp_page;
-	unsigned int start;
 	unsigned int readers;
 	unsigned int writers;
 	unsigned int waiting_writers;
--- linux-2.6.19/fs/pipe.c	2006-12-11 17:04:00.000000000 +0100
+++ linux-2.6.19-ed/fs/pipe.c	2006-12-11 17:14:04.000000000 +0100
@@ -207,7 +207,7 @@ int generic_pipe_buf_pin(struct pipe_ino
 	return 0;
 }
 
-static struct pipe_buf_operations anon_pipe_buf_ops = {
+static const struct pipe_buf_operations anon_pipe_buf_ops = {
 	.can_merge = 1,
 	.map = generic_pipe_buf_map,
 	.unmap = generic_pipe_buf_unmap,
@@ -243,7 +243,7 @@ pipe_read(struct kiocb *iocb, const stru
 		if (bufs) {
 			int curbuf = pipe->curbuf;
 			struct pipe_buffer *buf = pipe->bufs + curbuf;
-			struct pipe_buf_operations *ops = buf->ops;
+			const struct pipe_buf_operations *ops = buf->ops;
 			void *addr;
 			size_t chars = buf->len;
 			int error, atomic;
@@ -365,7 +365,7 @@ pipe_write(struct kiocb *iocb, const str
 		int lastbuf = (pipe->curbuf + pipe->nrbufs - 1) &
 							(PIPE_BUFFERS-1);
 		struct pipe_buffer *buf = pipe->bufs + lastbuf;
-		struct pipe_buf_operations *ops = buf->ops;
+		const struct pipe_buf_operations *ops = buf->ops;
 		int offset = buf->offset + buf->len;
 
 		if (ops->can_merge && offset + chars <= PAGE_SIZE) {
@@ -756,7 +756,7 @@ const struct file_operations rdwr_fifo_f
 	.fasync		= pipe_rdwr_fasync,
 };
 
-static struct file_operations read_pipe_fops = {
+static const struct file_operations read_pipe_fops = {
 	.llseek		= no_llseek,
 	.read		= do_sync_read,
 	.aio_read	= pipe_read,
@@ -768,7 +768,7 @@ static struct file_operations read_pipe_
 	.fasync		= pipe_read_fasync,
 };
 
-static struct file_operations write_pipe_fops = {
+static const struct file_operations write_pipe_fops = {
 	.llseek		= no_llseek,
 	.read		= bad_pipe_r,
 	.write		= do_sync_write,
@@ -780,7 +780,7 @@ static struct file_operations write_pipe
 	.fasync		= pipe_write_fasync,
 };
 
-static struct file_operations rdwr_pipe_fops = {
+static const struct file_operations rdwr_pipe_fops = {
 	.llseek		= no_llseek,
 	.read		= do_sync_read,
 	.aio_read	= pipe_read,
--- linux-2.6.19/fs/splice.c	2006-12-11 17:04:00.000000000 +0100
+++ linux-2.6.19-ed/fs/splice.c	2006-12-11 17:09:24.000000000 +0100
@@ -42,7 +42,7 @@ struct splice_pipe_desc {
 	struct partial_page *partial;	/* pages[] may not be contig */
 	int nr_pages;			/* number of pages in map */
 	unsigned int flags;		/* splice flags */
-	struct pipe_buf_operations *ops;/* ops associated with output pipe */
+	const struct pipe_buf_operations *ops;/* ops associated with output pipe */
 };
 
 /*
@@ -139,7 +139,7 @@ error:
 	return err;
 }
 
-static struct pipe_buf_operations page_cache_pipe_buf_ops = {
+static const struct pipe_buf_operations page_cache_pipe_buf_ops = {
 	.can_merge = 0,
 	.map = generic_pipe_buf_map,
 	.unmap = generic_pipe_buf_unmap,
@@ -159,7 +159,7 @@ static int user_page_pipe_buf_steal(stru
 	return generic_pipe_buf_steal(pipe, buf);
 }
 
-static struct pipe_buf_operations user_page_pipe_buf_ops = {
+static const struct pipe_buf_operations user_page_pipe_buf_ops = {
 	.can_merge = 0,
 	.map = generic_pipe_buf_map,
 	.unmap = generic_pipe_buf_unmap,
@@ -724,7 +724,7 @@ static ssize_t __splice_from_pipe(struct
 	for (;;) {
 		if (pipe->nrbufs) {
 			struct pipe_buffer *buf = pipe->bufs + pipe->curbuf;
-			struct pipe_buf_operations *ops = buf->ops;
+			const struct pipe_buf_operations *ops = buf->ops;
 
 			sd.len = buf->len;
 			if (sd.len > sd.total_len)

--Boundary-00=_kuafFtYYE0vCWsI--
