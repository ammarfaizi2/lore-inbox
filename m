Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWHVT2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWHVT2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHVT2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:28:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:15798 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751242AbWHVT2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:28:16 -0400
Date: Tue, 22 Aug 2006 12:28:13 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.10
Message-ID: <20060822192813.GB8579@kroah.com>
References: <20060822192727.GA8579@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822192727.GA8579@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 505c55f..ed01727 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .9
+EXTRAVERSION = .10
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/block/elevator.c b/block/elevator.c
index a0afdd3..7be96bb 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -766,7 +766,8 @@ void elv_unregister(struct elevator_type
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			task_lock(p);
-			e->ops.trim(p->io_context);
+			if (p->io_context)
+				e->ops.trim(p->io_context);
 			task_unlock(p);
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index e45789f..73fc0d8 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1653,7 +1653,7 @@ #endif
 		iput(inode);
 		goto error_out;
 	}
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_maxbytes = 1<<30;
 	return 0;
 
 error_out:
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index e1b0e8c..0abd66c 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -239,37 +239,51 @@ void udf_truncate_extents(struct inode *
 	{
 		if (offset)
 		{
-			extoffset -= adsize;
-			etype = udf_next_aext(inode, &bloc, &extoffset, &eloc, &elen, &bh, 1);
-			if (etype == (EXT_NOT_RECORDED_NOT_ALLOCATED >> 30))
-			{
-				extoffset -= adsize;
-				elen = EXT_NOT_RECORDED_NOT_ALLOCATED | (elen + offset);
-				udf_write_aext(inode, bloc, &extoffset, eloc, elen, bh, 0);
+			/*
+			 *  OK, there is not extent covering inode->i_size and
+			 *  no extent above inode->i_size => truncate is
+			 *  extending the file by 'offset'.
+			 */
+			if ((!bh && extoffset == udf_file_entry_alloc_offset(inode)) ||
+			    (bh && extoffset == sizeof(struct allocExtDesc))) {
+				/* File has no extents at all! */
+				memset(&eloc, 0x00, sizeof(kernel_lb_addr));
+				elen = EXT_NOT_RECORDED_NOT_ALLOCATED | offset;
+				udf_add_aext(inode, &bloc, &extoffset, eloc, elen, &bh, 1);
 			}
-			else if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30))
-			{
-				kernel_lb_addr neloc = { 0, 0 };
+			else {
 				extoffset -= adsize;
-				nelen = EXT_NOT_RECORDED_NOT_ALLOCATED |
-					((elen + offset + inode->i_sb->s_blocksize - 1) &
-					~(inode->i_sb->s_blocksize - 1));
-				udf_write_aext(inode, bloc, &extoffset, neloc, nelen, bh, 1);
-				udf_add_aext(inode, &bloc, &extoffset, eloc, (etype << 30) | elen, &bh, 1);
-			}
-			else
-			{
-				if (elen & (inode->i_sb->s_blocksize - 1))
+				etype = udf_next_aext(inode, &bloc, &extoffset, &eloc, &elen, &bh, 1);
+				if (etype == (EXT_NOT_RECORDED_NOT_ALLOCATED >> 30))
+				{
+					extoffset -= adsize;
+					elen = EXT_NOT_RECORDED_NOT_ALLOCATED | (elen + offset);
+					udf_write_aext(inode, bloc, &extoffset, eloc, elen, bh, 0);
+				}
+				else if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30))
 				{
+					kernel_lb_addr neloc = { 0, 0 };
 					extoffset -= adsize;
-					elen = EXT_RECORDED_ALLOCATED |
-						((elen + inode->i_sb->s_blocksize - 1) &
+					nelen = EXT_NOT_RECORDED_NOT_ALLOCATED |
+						((elen + offset + inode->i_sb->s_blocksize - 1) &
 						~(inode->i_sb->s_blocksize - 1));
-					udf_write_aext(inode, bloc, &extoffset, eloc, elen, bh, 1);
+					udf_write_aext(inode, bloc, &extoffset, neloc, nelen, bh, 1);
+					udf_add_aext(inode, &bloc, &extoffset, eloc, (etype << 30) | elen, &bh, 1);
+				}
+				else
+				{
+					if (elen & (inode->i_sb->s_blocksize - 1))
+					{
+						extoffset -= adsize;
+						elen = EXT_RECORDED_ALLOCATED |
+							((elen + inode->i_sb->s_blocksize - 1) &
+							~(inode->i_sb->s_blocksize - 1));
+						udf_write_aext(inode, bloc, &extoffset, eloc, elen, bh, 1);
+					}
+					memset(&eloc, 0x00, sizeof(kernel_lb_addr));
+					elen = EXT_NOT_RECORDED_NOT_ALLOCATED | offset;
+					udf_add_aext(inode, &bloc, &extoffset, eloc, elen, &bh, 1);
 				}
-				memset(&eloc, 0x00, sizeof(kernel_lb_addr));
-				elen = EXT_NOT_RECORDED_NOT_ALLOCATED | offset;
-				udf_add_aext(inode, &bloc, &extoffset, eloc, elen, &bh, 1);
 			}
 		}
 	}
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index aa6033c..225dcea 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -405,19 +405,6 @@ static inline int sctp_list_single_entry
 	return ((head->next != head) && (head->next == head->prev));
 }
 
-/* Calculate the size (in bytes) occupied by the data of an iovec.  */
-static inline size_t get_user_iov_size(struct iovec *iov, int iovlen)
-{
-	size_t retval = 0;
-
-	for (; iovlen > 0; --iovlen) {
-		retval += iov->iov_len;
-		iov++;
-	}
-
-	return retval;
-}
-
 /* Generate a random jitter in the range of -50% ~ +50% of input RTO. */
 static inline __s32 sctp_jitter(__u32 rto)
 {
diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
index 1eac3d0..de313de 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -221,8 +221,7 @@ struct sctp_chunk *sctp_make_abort_no_da
 				      const struct sctp_chunk *,
 				      __u32 tsn);
 struct sctp_chunk *sctp_make_abort_user(const struct sctp_association *,
-				   const struct sctp_chunk *,
-				   const struct msghdr *);
+					const struct msghdr *, size_t msg_len);
 struct sctp_chunk *sctp_make_abort_violation(const struct sctp_association *,
 				   const struct sctp_chunk *,
 				   const __u8 *,
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 5e0de3c..b9b9070 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -806,38 +806,26 @@ no_mem:
 
 /* Helper to create ABORT with a SCTP_ERROR_USER_ABORT error.  */
 struct sctp_chunk *sctp_make_abort_user(const struct sctp_association *asoc,
-				   const struct sctp_chunk *chunk,
-				   const struct msghdr *msg)
+					const struct msghdr *msg,
+					size_t paylen)
 {
 	struct sctp_chunk *retval;
-	void *payload = NULL, *payoff;
-	size_t paylen = 0;
-	struct iovec *iov = NULL;
-	int iovlen = 0;
-
-	if (msg) {
-		iov = msg->msg_iov;
-		iovlen = msg->msg_iovlen;
-		paylen = get_user_iov_size(iov, iovlen);
-	}
+	void *payload = NULL;
+	int err;
 
-	retval = sctp_make_abort(asoc, chunk, sizeof(sctp_errhdr_t) + paylen);
+	retval = sctp_make_abort(asoc, NULL, sizeof(sctp_errhdr_t) + paylen);
 	if (!retval)
 		goto err_chunk;
 
 	if (paylen) {
 		/* Put the msg_iov together into payload.  */
-		payload = kmalloc(paylen, GFP_ATOMIC);
+		payload = kmalloc(paylen, GFP_KERNEL);
 		if (!payload)
 			goto err_payload;
-		payoff = payload;
 
-		for (; iovlen > 0; --iovlen) {
-			if (copy_from_user(payoff, iov->iov_base,iov->iov_len))
-				goto err_copy;
-			payoff += iov->iov_len;
-			iov++;
-		}
+		err = memcpy_fromiovec(payload, msg->msg_iov, paylen);
+		if (err < 0)
+			goto err_copy;
 	}
 
 	sctp_init_cause(retval, SCTP_ERROR_USER_ABORT, payload, paylen);
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 9e58144..66e9c5b 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4026,18 +4026,12 @@ sctp_disposition_t sctp_sf_do_9_1_prm_ab
 	 * from its upper layer, but retransmits data to the far end
 	 * if necessary to fill gaps.
 	 */
-	struct msghdr *msg = arg;
-	struct sctp_chunk *abort;
+	struct sctp_chunk *abort = arg;
 	sctp_disposition_t retval;
 
 	retval = SCTP_DISPOSITION_CONSUME;
 
-	/* Generate ABORT chunk to send the peer.  */
-	abort = sctp_make_abort_user(asoc, NULL, msg);
-	if (!abort)
-		retval = SCTP_DISPOSITION_NOMEM;
-	else
-		sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(abort));
+	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(abort));
 
 	/* Even if we can't send the ABORT due to low memory delete the
 	 * TCB.  This is a departure from our typical NOMEM handling.
@@ -4161,8 +4155,7 @@ sctp_disposition_t sctp_sf_cookie_wait_p
 	void *arg,
 	sctp_cmd_seq_t *commands)
 {
-	struct msghdr *msg = arg;
-	struct sctp_chunk *abort;
+	struct sctp_chunk *abort = arg;
 	sctp_disposition_t retval;
 
 	/* Stop T1-init timer */
@@ -4170,12 +4163,7 @@ sctp_disposition_t sctp_sf_cookie_wait_p
 			SCTP_TO(SCTP_EVENT_TIMEOUT_T1_INIT));
 	retval = SCTP_DISPOSITION_CONSUME;
 
-	/* Generate ABORT chunk to send the peer */
-	abort = sctp_make_abort_user(asoc, NULL, msg);
-	if (!abort)
-		retval = SCTP_DISPOSITION_NOMEM;
-	else
-		sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(abort));
+	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(abort));
 
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
 			SCTP_STATE(SCTP_STATE_CLOSED));
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index b811691..600eb59 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1477,8 +1477,16 @@ SCTP_STATIC int sctp_sendmsg(struct kioc
 			goto out_unlock;
 		}
 		if (sinfo_flags & SCTP_ABORT) {
+			struct sctp_chunk *chunk;
+
+			chunk = sctp_make_abort_user(asoc, msg, msg_len);
+			if (!chunk) {
+				err = -ENOMEM;
+				goto out_unlock;
+			}
+
 			SCTP_DEBUG_PRINTK("Aborting association: %p\n", asoc);
-			sctp_primitive_ABORT(asoc, msg);
+			sctp_primitive_ABORT(asoc, chunk);
 			err = 0;
 			goto out_unlock;
 		}
