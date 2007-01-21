Return-Path: <linux-kernel-owner+w=401wt.eu-S1751770AbXAUX1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbXAUX1g (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXAUX1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:27:35 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:47407 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751770AbXAUX1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:27:34 -0500
Message-ID: <45B3F6A4.1060507@panasas.com>
Date: Mon, 22 Jan 2007 01:26:28 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       open-iscsi@googlegroups.com, Daniel.E.Messinger@seagate.com,
       Liran Schour <LIRANS@il.ibm.com>, Benny Halevy <bhalevy@panasas.com>
Subject: [RFC 4/6] bidi support: bidirectional SCSI layer
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2007 23:26:06.0508 (UTC) FILETIME=[864E7EC0:01C73DB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add bidi members to struct scsi_cmnd.
- Add API at the SCSI level for bidirectional commands.
- Implement support for BIDI requests in scsi_setup_blk_pc_cmnd() and
  scsi_io_completion().

Signed-off-by: Benny Halevy <bhalevy@panasas.com>
Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>

---
 drivers/scsi/scsi_lib.c    |  324 +++++++++++++++++++++++++++++++++++---------
 include/scsi/scsi_cmnd.h   |   55 +++++++-
 include/scsi/scsi_device.h |   16 ++
 3 files changed, 330 insertions(+), 65 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9c21025..92d3d44 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -246,27 +246,28 @@ static void scsi_end_async(struct reques
 {
 	struct scsi_io_context *sioc = req->end_io_data;

-	if (sioc->done)
-		sioc->done(sioc->data, sioc->sense, req->errors, rq_uni(req)->data_len);
+	if (sioc->done) /* FIXME: API of done needs to change for bidi requests*/
+		sioc->done(sioc->data, sioc->sense, req->errors, req->uni.data_len);

 	kmem_cache_free(scsi_io_context_cache, sioc);
 	__blk_put_request(req->q, req);
 }

-static int scsi_merge_bio(struct request *rq, struct bio *bio)
+static int scsi_merge_bio(struct request *rq, struct bio *bio,
+                          enum dma_data_direction dir)
 {
 	struct request_queue *q = rq->q;
-	struct request_io_part* req_io = rq_uni(rq);
+	struct request_io_part* req_io = rq_io(rq, dir);

 	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
-	if (rq_uni_write_dir(rq))
+	if (dir == DMA_TO_DEVICE)
 		bio->bi_rw |= (1 << BIO_RW);
 	else
 		bio->bi_rw &= ~(1 << BIO_RW);
 	blk_queue_bounce(q, &bio);

-	if (!rq_uni(rq)->bio)
-		blk_rq_bio_prep(q, rq, bio);
+	if (!req_io->bio)
+		blk_rq_bio_prep_bidi(q, rq, bio, dir);
 	else if (!ll_back_merge_fn(q, rq, bio))
 		return -EINVAL;
 	else {
@@ -299,7 +300,7 @@ static int scsi_bi_endio(struct bio *bio
  * sent to use, as some ULDs use that struct to only organize the pages.
  */
 static int scsi_req_map_sg(struct request *rq, struct scatterlist *sgl,
-			   int nsegs, unsigned bufflen, gfp_t gfp)
+	int nsegs, unsigned bufflen, gfp_t gfp, enum dma_data_direction dir)
 {
 	struct request_queue *q = rq->q;
 	int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -337,7 +338,7 @@ static int scsi_req_map_sg(struct reques
 			}

 			if (bio->bi_vcnt >= nr_vecs) {
-				err = scsi_merge_bio(rq, bio);
+				err = scsi_merge_bio(rq, bio ,dir);
 				if (err) {
 					bio_endio(bio, bio->bi_size, 0);
 					goto free_bios;
@@ -352,12 +353,12 @@ static int scsi_req_map_sg(struct reques
 	}

 	rq->buffer = rq->data = NULL;
-	rq_uni(rq)->data_len = data_len;
+	rq_io(rq,dir)->data_len = data_len;
 	return 0;

 free_bios:
-	while ((bio = rq_uni(rq)->bio) != NULL) {
-		rq_uni(rq)->bio = bio->bi_next;
+	while ((bio = rq_io(rq,dir)->bio) != NULL) {
+		rq_io(rq,dir)->bio = bio->bi_next;
 		/*
 		 * call endio instead of bio_put incase it was bounced
 		 */
@@ -385,31 +386,89 @@ int scsi_execute_async(struct scsi_devic
 		       int use_sg, int timeout, int retries, void *privdata,
 		       void (*done)(void *, char *, int, int), gfp_t gfp)
 {
+	struct scsi_cmnd_buff buff;
+
+	buff.use_sg = use_sg;
+	buff.buffer = buffer;
+	buff.bufflen = bufflen;
+
+	return scsi_execute_bidi_async(
+		sdev, (unsigned char *)cmd, cmd_len, data_direction,
+		&buff, NULL,
+		timeout, retries, privdata, done, gfp );
+}
+EXPORT_SYMBOL_GPL(scsi_execute_async);
+
+/**
+ * scsi_execute_bidi_async - insert bidi request, don't wait
+ * @sdev:	scsi device
+ * @cmd:	scsi command
+ * @cmd_len:	length of scsi cdb
+ * @data_direction: data direction
+ * @bidi_write_buff.buffer:	data buffer (this can be a kernel buffer or scatterlist)
+ * @bidi_write_buff.bufflen:	len of buffer
+ * @bidi_write_buff.use_sg:	if buffer is a scatterlist this is the number of elements
+ * @bidi_read_buff: same as above bidi_write_buff but for the bidi read part
+ * @timeout:	request timeout in jiffies
+ * @retries:	number of times to retry request
+ * @privdata:   user data passed to done function
+ * @done:       pointer to done function called at io completion.
+ *              signature: void done(void *user_data, char *sence, int errors, int data_bytes_advanced)
+ * @gfp:	gfp allocation flags
+ **/
+int scsi_execute_bidi_async(struct scsi_device *sdev,
+	unsigned char *cmd, int cmd_len, int data_direction,
+	struct scsi_cmnd_buff *buff, struct scsi_cmnd_buff *bidi_read_buff,
+	int timeout, int retries, void *privdata,
+	void (*done)(void *, char *, int, int), gfp_t gfp)
+{
 	struct request *req;
 	struct scsi_io_context *sioc;
 	int err = 0;
+	int is_bidi;

 	sioc = kmem_cache_alloc(scsi_io_context_cache, gfp);
 	if (!sioc)
 		return DRIVER_ERROR << 24;
 	memset(sioc, 0, sizeof(*sioc));

+	WARN_ON( (data_direction==DMA_NONE) && buff->bufflen);
+	WARN_ON( (data_direction!=DMA_NONE) && !buff->bufflen);
+	WARN_ON( (data_direction==DMA_BIDIRECTIONAL) && !bidi_read_buff);
 	req = blk_get_request(sdev->request_queue, data_direction, gfp);
 	if (!req)
 		goto free_sense;
 	req->cmd_type = REQ_TYPE_BLOCK_PC;
 	req->cmd_flags |= REQ_QUIET;
-
-	if (use_sg)
-		err = scsi_req_map_sg(req, buffer, use_sg, bufflen, gfp);
-	else if (bufflen)
-		err = blk_rq_map_kern(req->q, req, buffer, bufflen, gfp);
-
+	is_bidi = (data_direction == DMA_BIDIRECTIONAL);
+	if (buff->use_sg)
+		err = scsi_req_map_sg(
+			req, buff->buffer, buff->use_sg, buff->bufflen, gfp,
+			is_bidi ? DMA_TO_DEVICE : data_direction);
+	else if (buff->bufflen)
+		err = blk_rq_map_kern_bidi(
+			req->q, req, buff->buffer, buff->bufflen, gfp,
+			is_bidi ? DMA_TO_DEVICE : data_direction);
 	if (err)
 		goto free_req;

 	req->cmd_len = cmd_len;
 	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
+	if (is_bidi) {
+		if (bidi_read_buff->use_sg)
+			err = scsi_req_map_sg(
+				req, bidi_read_buff->buffer, bidi_read_buff->use_sg,
+				bidi_read_buff->bufflen, gfp, DMA_FROM_DEVICE);
+		else if (buff->bufflen)
+			err = blk_rq_map_kern_bidi(
+				req->q, req, bidi_read_buff->buffer,
+				bidi_read_buff->bufflen, gfp, DMA_FROM_DEVICE);
+		if (err) {
+			end_that_request_block(req ,0);/* free up the write part */
+			goto free_req;
+		}
+	}
+
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sioc->sense;
 	req->sense_len = 0;
@@ -429,7 +488,60 @@ free_sense:
 	kmem_cache_free(scsi_io_context_cache, sioc);
 	return DRIVER_ERROR << 24;
 }
-EXPORT_SYMBOL_GPL(scsi_execute_async);
+EXPORT_SYMBOL_GPL(scsi_execute_bidi_async);
+
+struct scsi_execute_bidi_done_t {
+	struct completion *waiting;
+	char* sense;
+	int errors;
+} ;
+
+static void scsi_execute_bidi_done(void *user_data, char *sense, int errors, int data_len)
+{
+	struct scsi_execute_bidi_done_t *sebd = user_data;
+	sebd->errors = errors;
+	if (sebd->sense) {
+		memcpy(sebd->sense, sense, SCSI_SENSE_BUFFERSIZE);
+	}
+	complete(sebd->waiting);
+}
+
+/**
+ * scsi_execute_bidi - insert a bidi request
+ * @sdev:	scsi device
+ * @cmd:	scsi command
+ * @cmd_len:	length of scsi cdb
+ * @data_direction: data direction
+ * @bidi_write_buff.buffer:	data buffer (this can be a kernel buffer or scatterlist)
+ * @bidi_write_buff.bufflen:	len of buffer
+ * @bidi_write_buff.use_sg:	if buffer is a scatterlist this is the number of elements
+ * @bidi_read_buff: same as above bidi_write_buff but for the bidi read part. can be NULL
+ * @sense:	optional sense buffer
+ * @timeout:	request timeout in jiffies
+ * @retries:	number of times to retry request
+ **/
+int scsi_execute_bidi(struct scsi_device *sdev,
+	unsigned char *cmd, int cmd_len, int data_direction,
+	struct scsi_cmnd_buff *buff, struct scsi_cmnd_buff *bidi_read_buff,
+	char* sense, int timeout, int retries)
+{
+	int ret;
+	struct scsi_execute_bidi_done_t sebd;
+	DECLARE_COMPLETION_ONSTACK(wait);
+	sebd.sense = sense;
+	sebd.waiting = &wait;
+
+	ret = scsi_execute_bidi_async(sdev,cmd, cmd_len, data_direction,
+		buff, bidi_read_buff,timeout, retries,
+		&sebd, scsi_execute_bidi_done, __GFP_WAIT);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&wait);
+
+	return sebd.errors;
+}
+EXPORT_SYMBOL_GPL(scsi_execute_bidi);

 /*
  * Function:    scsi_init_cmd_errh()
@@ -660,6 +772,16 @@ static struct scsi_cmnd *scsi_end_reques
 	struct request *req = cmd->request;
 	unsigned long flags;

+	if (is_bidi_cmnd(cmd)) {
+		if ( end_io_error(uptodate) && requeue ) {
+			WARN_ON(bytes);
+			scsi_requeue_command(q, cmd);
+			return NULL;
+		}
+		end_that_request_block(req, uptodate);
+		goto common_code;
+	}
+
 	/*
 	 * If there are blocks left over at the end, set up the command
 	 * to queue the remainder of them.
@@ -687,6 +809,7 @@ static struct scsi_cmnd *scsi_end_reques
 		}
 	}

+common_code:
 	add_disk_randomness(req->rq_disk);

 	spin_lock_irqsave(q->queue_lock, flags);
@@ -703,34 +826,34 @@ static struct scsi_cmnd *scsi_end_reques
 	return NULL;
 }

-struct scatterlist *scsi_alloc_sgtable(struct scsi_cmnd *cmd, gfp_t gfp_mask)
+static struct scatterlist *__scsi_alloc_sgtable(struct scsi_data_buffer *sdb, gfp_t gfp_mask)
 {
 	struct scsi_host_sg_pool *sgp;
 	struct scatterlist *sgl;

-	BUG_ON(!cmd->use_sg);
+	BUG_ON(!sdb->use_sg);

-	switch (cmd->use_sg) {
+	switch (sdb->use_sg) {
 	case 1 ... 8:
-		cmd->sglist_len = 0;
+		sdb->sglist_len = 0;
 		break;
 	case 9 ... 16:
-		cmd->sglist_len = 1;
+		sdb->sglist_len = 1;
 		break;
 	case 17 ... 32:
-		cmd->sglist_len = 2;
+		sdb->sglist_len = 2;
 		break;
 #if (SCSI_MAX_PHYS_SEGMENTS > 32)
 	case 33 ... 64:
-		cmd->sglist_len = 3;
+		sdb->sglist_len = 3;
 		break;
 #if (SCSI_MAX_PHYS_SEGMENTS > 64)
 	case 65 ... 128:
-		cmd->sglist_len = 4;
+		sdb->sglist_len = 4;
 		break;
 #if (SCSI_MAX_PHYS_SEGMENTS  > 128)
 	case 129 ... 256:
-		cmd->sglist_len = 5;
+		sdb->sglist_len = 5;
 		break;
 #endif
 #endif
@@ -739,11 +862,25 @@ #endif
 		return NULL;
 	}

-	sgp = scsi_sg_pools + cmd->sglist_len;
+	sgp = scsi_sg_pools + sdb->sglist_len;
 	sgl = mempool_alloc(sgp->pool, gfp_mask);
 	return sgl;
 }

+struct scatterlist *scsi_alloc_sgtable(struct scsi_cmnd *cmd, gfp_t gfp_mask)
+{
+	struct scsi_data_buffer uni_sdb;
+	struct scatterlist *ret = __scsi_alloc_sgtable(&uni_sdb, gfp_mask);
+
+	if (likely(ret)) {
+		cmd->request_bufflen = uni_sdb.request_bufflen;
+		cmd->request_buffer = uni_sdb.request_buffer;
+		cmd->use_sg = uni_sdb.use_sg;
+		cmd->sglist_len = uni_sdb.sglist_len;
+	}
+	return ret;
+}
+
 EXPORT_SYMBOL(scsi_alloc_sgtable);

 void scsi_free_sgtable(struct scatterlist *sgl, int index)
@@ -777,7 +914,7 @@ EXPORT_SYMBOL(scsi_free_sgtable);
  */
 static void scsi_release_buffers(struct scsi_cmnd *cmd)
 {
-	if (cmd->use_sg)
+	if (cmd->use_sg && cmd->request_buffer)
 		scsi_free_sgtable(cmd->request_buffer, cmd->sglist_len);

 	/*
@@ -786,6 +923,15 @@ static void scsi_release_buffers(struct
 	 */
 	cmd->request_buffer = NULL;
 	cmd->request_bufflen = 0;
+
+	if (is_bidi_cmnd(cmd) && cmd->bidi_read_sdb.request_buffer) {
+		if (cmd->bidi_read_sdb.use_sg)
+			scsi_free_sgtable(
+				cmd->bidi_read_sdb.request_buffer,
+				cmd->bidi_read_sdb.sglist_len);
+		cmd->bidi_read_sdb.request_buffer = NULL;
+		cmd->bidi_read_sdb.request_bufflen = 0;
+	}
 }

 /*
@@ -850,17 +996,19 @@ void scsi_io_completion(struct scsi_cmnd
 				memcpy(req->sense, cmd->sense_buffer,  len);
 				req->sense_len = len;
 			}
-		} else
-			rq_uni(req)->data_len = cmd->resid;
+		} else {
+			/* FIXME: implement bidi resid */
+			req->uni.data_len = cmd->resid;
+		}
 	}

 	/*
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
 	 */
-	SCSI_LOG_HLCOMPLETE(1, printk("%ld sectors total, "
-				      "%d bytes done.\n",
-				      rq_uni(req)->nr_sectors, good_bytes));
+	SCSI_LOG_HLCOMPLETE(1, printk(
+		"%ld(in) sectors %ld(out) sectors total, %d bytes done.\n",
+		rq_in(req)->nr_sectors, rq_out(req)->nr_sectors, good_bytes));
 	SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n", cmd->use_sg));

 	if (clear_errors)
@@ -873,6 +1021,8 @@ void scsi_io_completion(struct scsi_cmnd
 	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
 		return;

+	BUG_ON(is_bidi_cmnd(cmd));
+
 	/* good_bytes = 0, or (inclusive) there were leftovers and
 	 * result = 0, so scsi_end_request couldn't retry.
 	 */
@@ -982,19 +1132,24 @@ void scsi_io_completion(struct scsi_cmnd
 EXPORT_SYMBOL(scsi_io_completion);

 /*
- * Function:    scsi_init_io()
+ * Function:    scsi_init_data_buf()
  *
- * Purpose:     SCSI I/O initialize function.
+ * Purpose:     SCSI I/O initialize helper.
+ *              maps the request buffers into the given sdb.
  *
- * Arguments:   cmd   - Command descriptor we wish to initialize
+ * Arguments:   sdb     - Command data buff we wish to initialize
+ *              req     - request to map from
+ *              dir     - which part of the request to map
  *
  * Returns:     0 on success
  *		BLKPREP_DEFER if the failure is retryable
  *		BLKPREP_KILL if the failure is fatal
  */
-static int scsi_init_io(struct scsi_cmnd *cmd)
+static int scsi_init_data_buff(
+	struct scsi_data_buffer *sdb, struct request* req,
+	enum dma_data_direction dir)
 {
-	struct request     *req = cmd->request;
+	struct request_io_part *req_io = rq_io(req, dir);
 	struct scatterlist *sgpnt;
 	int		   count;

@@ -1003,45 +1158,87 @@ static int scsi_init_io(struct scsi_cmnd
 	 * but now we do (it makes highmem I/O easier to support without
 	 * kmapping pages)
 	 */
-	cmd->use_sg = rq_uni(req)->nr_phys_segments;
+	sdb->use_sg = req_io->nr_phys_segments;

 	/*
 	 * If sg table allocation fails, requeue request later.
 	 */
-	sgpnt = scsi_alloc_sgtable(cmd, GFP_ATOMIC);
+	sgpnt = __scsi_alloc_sgtable(sdb, GFP_ATOMIC);
 	if (unlikely(!sgpnt)) {
 		scsi_unprep_request(req);
 		return BLKPREP_DEFER;
 	}

-	req->buffer = NULL;
-	cmd->request_buffer = (char *) sgpnt;
+	sdb->request_buffer = (char *) sgpnt;
 	if (blk_pc_request(req))
-		cmd->request_bufflen = rq_uni(req)->data_len;
+		sdb->request_bufflen = req_io->data_len;
 	else
-		cmd->request_bufflen = rq_uni(req)->nr_sectors << 9;
+		sdb->request_bufflen = req_io->nr_sectors << 9;

 	/*
 	 * Next, walk the list, and fill in the addresses and sizes of
 	 * each segment.
 	 */
-	count = blk_rq_map_sg(req->q, req, cmd->request_buffer);
-	if (likely(count <= cmd->use_sg)) {
-		cmd->use_sg = count;
+	count = blk_rq_map_sg_bidi(req->q, req, sdb->request_buffer, dir);
+	if (likely(count <= sdb->use_sg)) {
+		sdb->use_sg = count;
 		return BLKPREP_OK;
 	}

 	printk(KERN_ERR "Incorrect number of segments after building list\n");
-	printk(KERN_ERR "counted %d, received %d\n", count, cmd->use_sg);
-	printk(KERN_ERR "req nr_sec %lu, cur_nr_sec %u\n", rq_uni(req)->nr_sectors,
-			rq_uni(req)->current_nr_sectors);
+	printk(KERN_ERR "counted %d, received %d\n", count, sdb->use_sg);
+	printk(KERN_ERR "req nr_sec %lu, cur_nr_sec %u\n", req_io->nr_sectors,
+			req_io->current_nr_sectors);

-	/* release the command and kill it */
-	scsi_release_buffers(cmd);
-	scsi_put_command(cmd);
 	return BLKPREP_KILL;
 }

+/*
+ * Function:    scsi_init_io()
+ *
+ * Purpose:     SCSI I/O initialize function.
+ *
+ * Arguments:   cmd   - Command descriptor we wish to initialize
+ *
+ * Returns:     0 on success
+ *		BLKPREP_DEFER if the failure is retryable
+ *		BLKPREP_KILL if the failure is fatal
+ */
+static int scsi_init_io(struct scsi_cmnd *cmd)
+{
+	struct scsi_data_buffer uni_sdb;
+	struct request *req = cmd->request;
+	int error;
+	int is_bidi = is_bidi_cmnd(cmd);
+
+	error = scsi_init_data_buff(&uni_sdb, req,
+		is_bidi ? DMA_TO_DEVICE : rq_dma_dir(req) );
+	if (error)
+		goto err_exit;
+
+	cmd->request_bufflen = uni_sdb.request_bufflen;
+	cmd->request_buffer = uni_sdb.request_buffer;
+	cmd->use_sg = uni_sdb.use_sg;
+	cmd->sglist_len = uni_sdb.sglist_len;
+
+	if (is_bidi) {
+		error = scsi_init_data_buff(&cmd->bidi_read_sdb, req, DMA_FROM_DEVICE);
+		if (error)
+			goto err_exit;
+	}
+
+	req->buffer = NULL;
+	return 0 ;
+
+err_exit:
+	scsi_release_buffers(cmd);
+	if (error == BLKPREP_KILL) {
+		/* release the command and kill it */
+		scsi_put_command(cmd);
+	}
+	return error;
+}
+
 static int scsi_issue_flush_fn(request_queue_t *q, struct gendisk *disk,
 			       sector_t *error_sector)
 {
@@ -1094,6 +1291,7 @@ static void scsi_blk_pc_done(struct scsi
 static int scsi_setup_blk_pc_cmnd(struct scsi_device *sdev, struct request *req)
 {
 	struct scsi_cmnd *cmd;
+	int has_data;

 	cmd = scsi_get_cmd_from_req(sdev, req);
 	if (unlikely(!cmd))
@@ -1105,22 +1303,22 @@ static int scsi_setup_blk_pc_cmnd(struct
 	 * that does not transfer data, in which case they may optionally
 	 * submit a request without an attached bio.
 	 */
-	if (rq_uni(req)->bio) {
-		int ret;
-
-		BUG_ON(!rq_uni(req)->nr_phys_segments);
+	has_data = rq_out(req)->bio || rq_in(req)->bio;

+	if (has_data) {
+		int ret;
+		BUG_ON(rq_bidi_dir(req) && (!rq_out(req)->bio || !rq_in(req)->bio));
 		ret = scsi_init_io(cmd);
 		if (unlikely(ret))
 			return ret;
 	} else {
-		BUG_ON(rq_uni(req)->data_len);
-		BUG_ON(req->data);
+		WARN_ON(rq_uni_dir(req) && rq_uni(req)->data_len);
+		WARN_ON(rq_bidi_dir(req));
+		/* FIXME: WARN_ON(rq_dma_dir!=DMA_NONE) */

 		cmd->request_bufflen = 0;
 		cmd->request_buffer = NULL;
 		cmd->use_sg = 0;
-		req->buffer = NULL;
 		req->data_dir = DMA_NONE;
 	}

@@ -1129,7 +1327,7 @@ static int scsi_setup_blk_pc_cmnd(struct
 	cmd->cmd_len = req->cmd_len;
 	cmd->sc_data_direction = rq_dma_dir(req);
 	
-	cmd->transfersize = rq_uni(req)->data_len;
+	cmd->transfersize = is_bidi_cmnd(cmd) ? 0 : rq_uni(req)->data_len;
 	cmd->allowed = req->retries;
 	cmd->timeout_per_command = req->timeout;
 	cmd->done = scsi_blk_pc_done;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index d6948d0..78ae417 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -1,16 +1,34 @@
 #ifndef _SCSI_SCSI_CMND_H
 #define _SCSI_SCSI_CMND_H

-#include <linux/dma-mapping.h>
+#include <linux/blkdev.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/timer.h>
+#include <scsi/scsi_device.h>

-struct request;
 struct scatterlist;
 struct Scsi_Host;
 struct scsi_device;

+/*
+ * This structure maps data buffers into a scatter-gather list for DMA purposes.
+ * Embedded in struct scsi_cmnd.
+ *
+ * FIXME: We currently embed this structure in scsi_cmnd only for
+ * bidi read buffers.  Buffers for uni-directional commands and write
+ * buffers of bidi commands are mapped in a backward compatible way by an
+ * equivalent set of fields, scattered in the scsi_cmnd.
+ * These should be incorporated into an instance of scsi_cmn_sgl.
+ * This will require a major rework of most scsi LLDDs.
+ */
+
+struct scsi_data_buffer {
+	unsigned short use_sg;       /* Number of pieces of scatter-gather */
+	unsigned short sglist_len;   /* size of malloc'd scatter-gather list */
+	void *request_buffer;        /* Actual requested buffer */
+	unsigned request_bufflen;    /* Actual request size */
+};

 /* embedded in scsi_cmnd */
 struct scsi_pointer {
@@ -120,8 +138,41 @@ #define SCSI_SENSE_BUFFERSIZE 	96

 	unsigned char tag;	/* SCSI-II queued command tag */
 	unsigned long pid;	/* Process ID, starts at 0. Unique per host. */
+
+	/*
+	 * map read buffers of bi-directional commands
+	 *  iff sc_data_direction==DMA_BIDIRECTIONAL
+	 */
+	struct scsi_data_buffer bidi_read_sdb;
 };

+#define is_bidi_cmnd(cmd) rq_bidi_dir((cmd)->request)
+
+/*
+ * these inline helpers take into account the scsi cmnd's data direction
+ * to correctly find sg maps for uni-directional and bi-directional commands
+ */
+static inline void
+scsi_get_out_buff(struct scsi_cmnd *sc, struct scsi_cmnd_buff *scb)
+{
+	scb->use_sg = sc->use_sg;
+	scb->buffer = sc->request_buffer;
+	scb->bufflen = sc->request_bufflen;
+}
+
+static inline void
+scsi_get_in_buff(struct scsi_cmnd *sc, struct scsi_cmnd_buff *scb)
+{
+	if (!is_bidi_cmnd(sc)) {
+		scsi_get_out_buff(sc, scb);
+		return;
+	}
+
+	scb->use_sg = sc->bidi_read_sdb.use_sg;
+	scb->buffer = sc->bidi_read_sdb.request_buffer;
+	scb->bufflen = sc->bidi_read_sdb.request_bufflen;
+}
+
 extern struct scsi_cmnd *scsi_get_command(struct scsi_device *, gfp_t);
 extern struct scsi_cmnd *__scsi_get_command(struct Scsi_Host *, gfp_t);
 extern void scsi_put_command(struct scsi_cmnd *);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index ebf31b1..a10989c 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -198,6 +198,13 @@ #define transport_class_to_starget(class
 #define starget_printk(prefix, starget, fmt, a...)	\
 	dev_printk(prefix, &(starget)->dev, fmt, ##a)

+/* used by APIs as a shorthand for <use_sg, sg, bufflen> */
+struct scsi_cmnd_buff {
+	unsigned short use_sg;      /* Number of pieces of scatter-gather */
+	void *buffer;       /* if use_sg==0 requested buffer else an sg list */
+	unsigned bufflen;   /* Actual request size */
+};
+
 extern struct scsi_device *__scsi_add_device(struct Scsi_Host *,
 		uint, uint, uint, void *hostdata);
 extern int scsi_add_device(struct Scsi_Host *host, uint channel,
@@ -297,6 +304,15 @@ extern int scsi_execute_async(struct scs
 			      int timeout, int retries, void *privdata,
 			      void (*done)(void *, char *, int, int),
 			      gfp_t gfp);
+extern int scsi_execute_bidi_async(struct scsi_device *sdev,
+	unsigned char *cmd, int cmd_len, int data_direction,
+	struct scsi_cmnd_buff *buff, struct scsi_cmnd_buff *bidi_read_buff,
+	int timeout, int retries, void *privdata,
+	void (*done)(void *, char *, int, int), gfp_t gfp);
+extern int scsi_execute_bidi(struct scsi_device *sdev,
+	unsigned char *cmd, int cmd_len, int data_direction,
+	struct scsi_cmnd_buff *buff, struct scsi_cmnd_buff *bidi_read_buff,
+	char* sense, int timeout, int retries);

 static inline int __must_check scsi_device_reprobe(struct scsi_device *sdev)
 {
-- 
