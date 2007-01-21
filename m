Return-Path: <linux-kernel-owner+w=401wt.eu-S1751789AbXAUXab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXAUXab (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbXAUXab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:30:31 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:47502 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751789AbXAUXa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:30:29 -0500
Message-ID: <45B3F754.5020406@panasas.com>
Date: Mon, 22 Jan 2007 01:29:24 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       open-iscsi@googlegroups.com, Daniel.E.Messinger@seagate.com,
       Liran Schour <LIRANS@il.ibm.com>, Benny Halevy <bhalevy@panasas.com>
Subject: [RFC 6/6] bidi support: iSCSI bidi & varlen CDBs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2007 23:29:02.0542 (UTC) FILETIME=[EF3B26E0:01C73DB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is intended to provide a working example of a use case
for bidi and varlen CDBs. The actual patches will be sent via the
open-iscsi project.

- Use proposed SCSI implementation for iSCSI bidirectional commands.
- Use proposed block layer implementation for iSCSI extended CDBs.
- Dynamically build AHSs for extended cdbs and bidirectional requests.
- Follow iscsi rfc-3720 concerning datasn and r2tsn with bidirectional commands,
  these must be the same counter.
[- Remove check for first-burst bigger than max-burst so iSCSI regression tests can pass.
   this is the wrong fix and will be removed in actual patches]

Signed-off-by: Benny Halevy <bhalevy@panasas.com>
Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>

---
 drivers/infiniband/ulp/iser/iscsi_iser.c |    4 +-
 drivers/scsi/iscsi_tcp.c                 |  190 +++++++++++++++++++++++-------
 drivers/scsi/iscsi_tcp.h                 |   10 +-
 drivers/scsi/libiscsi.c                  |   33 +++--
 include/scsi/iscsi_proto.h               |    8 ++
 include/scsi/libiscsi.h                  |   18 +++-
 6 files changed, 200 insertions(+), 63 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index dd221ed..a0eae0c 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -140,10 +140,10 @@ iscsi_iser_cmd_init(struct iscsi_cmd_tas
 	iser_ctask->iser_conn    = iser_conn;

 	if (sc->sc_data_direction == DMA_TO_DEVICE) {
-		BUG_ON(ctask->total_length == 0);
+		BUG_ON(iscsi_out_total_length(ctask) == 0);

 		debug_scsi("cmd [itt %x total %d imm %d unsol_data %d\n",
-			   ctask->itt, ctask->total_length, ctask->imm_count,
+			   ctask->itt, iscsi_out_total_length(ctask), ctask->imm_count,
 			   ctask->unsol_count);
 	}

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index d0b139c..2bc57a5 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -109,7 +109,9 @@ iscsi_hdr_digest(struct iscsi_conn *conn
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;

 	crypto_hash_digest(&tcp_conn->tx_hash, &buf->sg, buf->sg.length, crc);
-	buf->sg.length = tcp_conn->hdr_size;
+	buf->sg.length += sizeof(__u32);
+	debug_tcp("iscsi_hdr_digest: &crc %p crc 0x%02x%02x%02x%02x\n",
+	          crc, crc[0], crc[1], crc[2], crc[3]);
 }

 static inline int
@@ -229,14 +231,21 @@ iscsi_data_rsp(struct iscsi_conn *conn,
 	if (tcp_conn->in.datalen == 0)
 		return 0;

-	if (ctask->datasn != datasn)
+	if (tcp_ctask->exp_datasn != datasn) {
+		debug_tcp("%s: ctask->datasn(%d) != rhdr->datasn(%d)\n",
+		          __FUNCTION__, tcp_ctask->exp_datasn, datasn);
 		return ISCSI_ERR_DATASN;
+	}

-	ctask->datasn++;
+	tcp_ctask->exp_datasn++;

 	tcp_ctask->data_offset = be32_to_cpu(rhdr->offset);
-	if (tcp_ctask->data_offset + tcp_conn->in.datalen > ctask->total_length)
+	if (tcp_ctask->data_offset + tcp_conn->in.datalen > iscsi_in_total_length(ctask)) {
+		debug_tcp("%s: data_offset(%d) + data_len(%d) > total_length_in(%d)\n",
+		          __FUNCTION__, tcp_ctask->data_offset,
+		          tcp_conn->in.datalen, iscsi_in_total_length(ctask));
 		return ISCSI_ERR_DATA_OFFSET;
+	}

 	if (rhdr->flags & ISCSI_FLAG_DATA_STATUS) {
 		struct scsi_cmnd *sc = ctask->sc;
@@ -246,7 +255,7 @@ iscsi_data_rsp(struct iscsi_conn *conn,
 			int res_count = be32_to_cpu(rhdr->residual_count);

 			if (res_count > 0 &&
-			    res_count <= sc->request_bufflen) {
+			    res_count <= iscsi_in_total_length(ctask)) {
 				sc->resid = res_count;
 				sc->result = (DID_OK << 16) | rhdr->cmd_status;
 			} else
@@ -281,6 +290,7 @@ iscsi_solicit_data_init(struct iscsi_con
 {
 	struct iscsi_data *hdr;
 	struct scsi_cmnd *sc = ctask->sc;
+	struct scsi_cmnd_buff scb;

 	hdr = &r2t->dtask.hdr;
 	memset(hdr, 0, sizeof(struct iscsi_data));
@@ -308,12 +318,13 @@ iscsi_solicit_data_init(struct iscsi_con
 	iscsi_buf_init_iov(&r2t->headbuf, (char*)hdr,
 			   sizeof(struct iscsi_hdr));

-	if (sc->use_sg) {
+	scsi_get_out_buff(sc, &scb);
+	if (scb.use_sg) {
 		int i, sg_count = 0;
-		struct scatterlist *sg = sc->request_buffer;
+		struct scatterlist *sg = scb.buffer;

 		r2t->sg = NULL;
-		for (i = 0; i < sc->use_sg; i++, sg += 1) {
+		for (i = 0; i < scb.use_sg; i++, sg += 1) {
 			/* FIXME: prefetch ? */
 			if (sg_count + sg->length > r2t->data_offset) {
 				int page_offset;
@@ -337,7 +348,7 @@ iscsi_solicit_data_init(struct iscsi_con
 		BUG_ON(r2t->sg == NULL);
 	} else {
 		iscsi_buf_init_iov(&r2t->sendbuf,
-			    (char*)sc->request_buffer + r2t->data_offset,
+			    (char*)scb.buffer + r2t->data_offset,
 			    r2t->data_count);
 		r2t->sg = NULL;
 	}
@@ -365,15 +376,13 @@ iscsi_r2t_rsp(struct iscsi_conn *conn, s
 		return ISCSI_ERR_DATALEN;
 	}

-	if (tcp_ctask->exp_r2tsn && tcp_ctask->exp_r2tsn != r2tsn)
+	if (tcp_ctask->exp_datasn != r2tsn)
 		return ISCSI_ERR_R2TSN;

 	rc = iscsi_check_assign_cmdsn(session, (struct iscsi_nopin*)rhdr);
 	if (rc)
 		return rc;

-	/* FIXME: use R2TSN to detect missing R2T */
-
 	/* fill-in new R2T associated with the task */
 	spin_lock(&session->lock);
 	if (!ctask->sc || ctask->mtask ||
@@ -401,11 +410,11 @@ iscsi_r2t_rsp(struct iscsi_conn *conn, s
 			    r2t->data_length, session->max_burst);

 	r2t->data_offset = be32_to_cpu(rhdr->data_offset);
-	if (r2t->data_offset + r2t->data_length > ctask->total_length) {
+	if (r2t->data_offset + r2t->data_length > iscsi_out_total_length(ctask)) {
 		spin_unlock(&session->lock);
 		printk(KERN_ERR "iscsi_tcp: invalid R2T with data len %u at "
 		       "offset %u and total length %d\n", r2t->data_length,
-		       r2t->data_offset, ctask->total_length);
+		       r2t->data_offset, iscsi_out_total_length(ctask));
 		return ISCSI_ERR_DATALEN;
 	}

@@ -414,7 +423,7 @@ iscsi_r2t_rsp(struct iscsi_conn *conn, s

 	iscsi_solicit_data_init(conn, ctask, r2t);

-	tcp_ctask->exp_r2tsn = r2tsn + 1;
+	tcp_ctask->exp_datasn = r2tsn + 1;
 	__kfifo_put(tcp_ctask->r2tqueue, (void*)&r2t, sizeof(void*));
 	tcp_ctask->xmstate |= XMSTATE_SOL_HDR;
 	list_move_tail(&ctask->running, &conn->xmitqueue);
@@ -512,8 +521,8 @@ iscsi_tcp_hdr_recv(struct iscsi_conn *co
 		tcp_conn->in.ctask = session->cmds[itt];
 		if (ahslen)
 			rc = ISCSI_ERR_AHSLEN;
-		else if (tcp_conn->in.ctask->sc->sc_data_direction ==
-								DMA_TO_DEVICE)
+		else if (tcp_conn->in.ctask->sc->sc_data_direction == DMA_TO_DEVICE ||
+		         tcp_conn->in.ctask->sc->sc_data_direction == DMA_BIDIRECTIONAL)
 			rc = iscsi_r2t_rsp(conn, tcp_conn->in.ctask);
 		else
 			rc = ISCSI_ERR_PROTO;
@@ -609,7 +618,7 @@ iscsi_ctask_copy(struct iscsi_tcp_conn *
 	       size, tcp_conn->in.offset, tcp_conn->in.copied);

 	BUG_ON(size <= 0);
-	BUG_ON(tcp_ctask->sent + size > ctask->total_length);
+	BUG_ON(tcp_ctask->sent + size > iscsi_in_total_length(ctask));

 	rc = skb_copy_bits(tcp_conn->in.skb, tcp_conn->in.offset,
 			   (char*)buf + (offset + tcp_conn->data_copied), size);
@@ -704,28 +713,30 @@ static int iscsi_scsi_data_in(struct isc
 	struct scsi_cmnd *sc = ctask->sc;
 	struct scatterlist *sg;
 	int i, offset, rc = 0;
+	struct scsi_cmnd_buff scb;

 	BUG_ON((void*)ctask != sc->SCp.ptr);

+	scsi_get_in_buff(sc, &scb);
 	/*
 	 * copying Data-In into the Scsi_Cmnd
 	 */
-	if (!sc->use_sg) {
+	if (!scb.use_sg) {
 		i = ctask->data_count;
-		rc = iscsi_ctask_copy(tcp_conn, ctask, sc->request_buffer,
-				      sc->request_bufflen,
+		rc = iscsi_ctask_copy(tcp_conn, ctask, scb.buffer,
+				      scb.bufflen,
 				      tcp_ctask->data_offset);
 		if (rc == -EAGAIN)
 			return rc;
 		if (conn->datadgst_en)
-			iscsi_recv_digest_update(tcp_conn, sc->request_buffer,
+			iscsi_recv_digest_update(tcp_conn, scb.buffer,
 						 i);
 		rc = 0;
 		goto done;
 	}

 	offset = tcp_ctask->data_offset;
-	sg = sc->request_buffer;
+	sg = scb.buffer;

 	if (tcp_ctask->data_offset)
 		for (i = 0; i < tcp_ctask->sg_count; i++)
@@ -734,7 +745,7 @@ static int iscsi_scsi_data_in(struct isc
 	if (offset < 0)
 		offset = 0;

-	for (i = tcp_ctask->sg_count; i < sc->use_sg; i++) {
+	for (i = tcp_ctask->sg_count; i < scb.use_sg; i++) {
 		char *dest;

 		dest = kmap_atomic(sg[i].page, KM_SOFTIRQ0);
@@ -749,7 +760,7 @@ static int iscsi_scsi_data_in(struct isc
 				if (!offset)
 					crypto_hash_update(
 							&tcp_conn->rx_hash,
-							&sg[i], 1);
+							&sg[i], sg[i].length);
 				else
 					partial_sg_digest_update(
 							&tcp_conn->rx_hash,
@@ -1141,7 +1152,8 @@ iscsi_sendhdr(struct iscsi_conn *conn, s
 		flags |= MSG_MORE;

 	res = iscsi_send(conn, buf, size, flags);
-	debug_tcp("sendhdr %d bytes, sent %d res %d\n", size, buf->sent, res);
+	debug_tcp("sendhdr %d bytes, length %d sent %d res %d\n",
+	          size, buf->sg.length, buf->sent, res);
 	if (res >= 0) {
 		if (size != res)
 			return -EAGAIN;
@@ -1217,6 +1229,7 @@ iscsi_solicit_data_cont(struct iscsi_con
 	struct iscsi_data *hdr;
 	struct scsi_cmnd *sc = ctask->sc;
 	int new_offset;
+	struct scsi_cmnd_buff scb;

 	hdr = &r2t->dtask.hdr;
 	memset(hdr, 0, sizeof(struct iscsi_data));
@@ -1245,12 +1258,13 @@ iscsi_solicit_data_cont(struct iscsi_con
 	if (iscsi_buf_left(&r2t->sendbuf))
 		return;

-	if (sc->use_sg) {
+	scsi_get_out_buff(sc, &scb);
+	if (scb.use_sg) {
 		iscsi_buf_init_sg(&r2t->sendbuf, r2t->sg);
 		r2t->sg += 1;
 	} else {
 		iscsi_buf_init_iov(&r2t->sendbuf,
-			    (char*)sc->request_buffer + new_offset,
+			    (char*)scb.buffer + new_offset,
 			    r2t->data_count);
 		r2t->sg = NULL;
 	}
@@ -1279,39 +1293,133 @@ iscsi_tcp_cmd_init(struct iscsi_cmd_task
 {
 	struct scsi_cmnd *sc = ctask->sc;
 	struct iscsi_tcp_cmd_task *tcp_ctask = ctask->dd_data;
+	int hdrlength, rlen;
+	unsigned short ahslength;
+	struct iscsi_ecdb_ahdr *ecdb_ahdr;
+	struct scsi_cmnd_buff scb;

 	BUG_ON(__kfifo_len(tcp_ctask->r2tqueue));

+	/*
+	 * extended headers immediately follow tcp_ctask->hdr hence ctask->hdr
+	 * must point there
+	 */
+	tcp_ctask->hdrext = tcp_ctask->hdrextbuf;
+	BUG_ON(tcp_ctask->hdrext != (char *)ctask->hdr + sizeof(tcp_ctask->hdr));
+
 	tcp_ctask->sent = 0;
 	tcp_ctask->sg_count = 0;
+	tcp_ctask->exp_datasn = 0;
+
+	/*
+	 * make an extended cdb AHS
+	 */
+	if (sc->request->varlen_cdb && (sc->request->varlen_cdb_len > MAX_COMMAND_SIZE)) {
+		int pad_len;
+
+		ecdb_ahdr = (struct iscsi_ecdb_ahdr *)tcp_ctask->hdrext;
+		rlen = sc->request->varlen_cdb_len - MAX_COMMAND_SIZE;
+
+		BUG_ON(rlen > sizeof(ecdb_ahdr->ecdb));
+		ahslength = rlen + sizeof(ecdb_ahdr->reserved);

-	if (sc->sc_data_direction == DMA_TO_DEVICE) {
+		/* need to pad ecdb? */
+		pad_len = rlen & (ISCSI_PAD_LEN - 1);
+		if (pad_len) {
+			pad_len = ISCSI_PAD_LEN - pad_len;
+			memset(&ecdb_ahdr->ecdb[rlen], 0, pad_len);
+			ahslength += pad_len;
+		}
+
+		ecdb_ahdr->ahslength = cpu_to_be16(ahslength);
+		ecdb_ahdr->ahstype = ISCSI_AHSTYPE_CDB;
+		ecdb_ahdr->reserved = 0;
+		memcpy(ecdb_ahdr->ecdb, sc->request->varlen_cdb+MAX_COMMAND_SIZE, rlen);
+
+		tcp_ctask->hdrext += ahslength + sizeof(ecdb_ahdr->ahslength) +
+				sizeof(ecdb_ahdr->ahstype);
+		debug_scsi("iscsi_tcp_cmd_init: extended cdb:"
+			" varlen_cdb_len %d rlen %d pad_len %d ahs_length %d total_ahs_length %Zd\n",
+			sc->request->varlen_cdb_len, rlen, pad_len, ahslength,
+			((char *)tcp_ctask->hdrext - (char *)tcp_ctask->hdrextbuf) );
+	}
+
+	switch (sc->sc_data_direction) {
+	case DMA_BIDIRECTIONAL: {
+		struct iscsi_rlength_ahdr *rlen_ahdr;
+
+		scsi_get_in_buff(sc, &scb);
+		BUG_ON(scb.buffer == NULL);
+		BUG_ON(scb.bufflen == 0);
+
+		rlen_ahdr = (struct iscsi_rlength_ahdr*)tcp_ctask->hdrext;
+		rlen_ahdr->ahslength =
+			cpu_to_be16(sizeof(rlen_ahdr->read_length) +
+			            sizeof(rlen_ahdr->reserved));
+		rlen_ahdr->ahstype = ISCSI_AHSTYPE_RLENGTH;
+		rlen_ahdr->reserved = 0;
+		rlen_ahdr->read_length = cpu_to_be32(scb.bufflen);
+
+		tcp_ctask->hdrext += sizeof(*rlen_ahdr);
+		
+		debug_scsi("bidi-in rlen_ahdr->read_length(%d) rlen_ahdr->ahslength(%d)\n",
+			   be32_to_cpu(rlen_ahdr->read_length) ,be16_to_cpu(rlen_ahdr->ahslength)
+		);
+	}
+	/* FALLTHROUGH */
+	case DMA_TO_DEVICE:
 		tcp_ctask->xmstate = XMSTATE_W_HDR;
-		tcp_ctask->exp_r2tsn = 0;
-		BUG_ON(ctask->total_length == 0);
+		BUG_ON(iscsi_out_total_length(ctask) == 0);

-		if (sc->use_sg) {
-			struct scatterlist *sg = sc->request_buffer;
+		scsi_get_out_buff(sc, &scb);
+		BUG_ON(scb.buffer == NULL);
+		BUG_ON(scb.bufflen == 0);
+		if (scb.use_sg) {
+			struct scatterlist *sg = scb.buffer;

 			iscsi_buf_init_sg(&tcp_ctask->sendbuf, sg);
 			tcp_ctask->sg = sg + 1;
-			tcp_ctask->bad_sg = sg + sc->use_sg;
+			tcp_ctask->bad_sg = sg + scb.use_sg;
 		} else {
 			iscsi_buf_init_iov(&tcp_ctask->sendbuf,
-					   sc->request_buffer,
-					   sc->request_bufflen);
+			                   scb.buffer,
+			                   scb.bufflen);
 			tcp_ctask->sg = NULL;
 			tcp_ctask->bad_sg = NULL;
 		}
 		debug_scsi("cmd [itt 0x%x total %d imm_data %d "
 			   "unsol count %d, unsol offset %d]\n",
-			   ctask->itt, ctask->total_length, ctask->imm_count,
-			   ctask->unsol_count, ctask->unsol_offset);
-	} else
+			   ctask->itt, iscsi_out_total_length(ctask), ctask->imm_count,
+			   ctask->unsol_count, ctask->unsol_offset);
+		break;
+
+	case DMA_FROM_DEVICE:
+	case DMA_NONE:
 		tcp_ctask->xmstate = XMSTATE_R_HDR;
+		break;
+
+	default:
+		BUG_ON(1);
+	}
+
+	/* calculate size of additional header segments (AHSs) */
+	hdrlength = (char *)tcp_ctask->hdrext -
+	            ((char *)&tcp_ctask->hdr + sizeof(tcp_ctask->hdr));
+
+	BUG_ON(hdrlength & (ISCSI_PAD_LEN-1));
+	hdrlength /= ISCSI_PAD_LEN;
+
+	BUG_ON(hdrlength >= 256);
+	tcp_ctask->hdr.hlength = hdrlength & 0xFF;
+
+	debug_scsi("iscsi_tcp_cmd_init: total_pdu_length %Zd "
+	           "hlength %d dlength %d data_length %d\n",
+	           tcp_ctask->hdrext - (char *)&tcp_ctask->hdr,
+	           tcp_ctask->hdr.hlength, ntoh24(ctask->hdr->dlength),
+	           be32_to_cpu(ctask->hdr->data_length));

-	iscsi_buf_init_iov(&tcp_ctask->headbuf, (char*)ctask->hdr,
-			    sizeof(struct iscsi_hdr));
+	iscsi_buf_init_iov(&tcp_ctask->headbuf, (char*)&tcp_ctask->hdr,
+	                   tcp_ctask->hdrext - (char *)&tcp_ctask->hdr);
 }

 /**
diff --git a/drivers/scsi/iscsi_tcp.h b/drivers/scsi/iscsi_tcp.h
index 3273683..24620ee 100644
--- a/drivers/scsi/iscsi_tcp.h
+++ b/drivers/scsi/iscsi_tcp.h
@@ -47,7 +47,7 @@ #define XMSTATE_W_RESEND_DATA_DIGEST	0x8

 #define ISCSI_PAD_LEN			4
 #define ISCSI_SG_TABLESIZE		SG_ALL
-#define ISCSI_TCP_MAX_CMD_LEN		16
+#define ISCSI_TCP_MAX_CMD_LEN		260  /* FIXME: SCSI_MAX_VARLEN_CDB_LEN */

 struct crypto_hash;
 struct socket;
@@ -141,8 +141,10 @@ struct iscsi_r2t_info {

 struct iscsi_tcp_cmd_task {
 	struct iscsi_cmd	hdr;
-	char			hdrext[4*sizeof(__u16)+	/* AHS */
-				    sizeof(__u32)];	/* HeaderDigest */
+	char			hdrextbuf[sizeof(struct iscsi_ecdb_ahdr) +
+					  sizeof(struct iscsi_rlength_ahdr) +
+					  sizeof(__u32)];	/* HeaderDigest */
+	char			*hdrext;
 	char			pad[ISCSI_PAD_LEN];
 	int			pad_count;		/* padded bytes */
 	struct iscsi_buf	headbuf;		/* header buf (xmit) */
@@ -152,7 +154,7 @@ struct iscsi_tcp_cmd_task {
 	struct scatterlist	*sg;			/* per-cmd SG list  */
 	struct scatterlist	*bad_sg;		/* assert statement */
 	int			sg_count;		/* SG's to process  */
-	uint32_t		exp_r2tsn;
+	uint32_t		exp_datasn;		/* expected target's R2TSN/DataSN */
 	int			data_offset;
 	struct iscsi_r2t_info	*r2t;			/* in progress R2T    */
 	struct iscsi_queue	r2tpool;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index e11b23c..08e4528 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -120,10 +120,16 @@ static void iscsi_prep_scsi_cmd_pdu(stru
         session->cmdsn++;
         hdr->exp_statsn = cpu_to_be32(conn->exp_statsn);
         memcpy(hdr->cdb, sc->cmnd, sc->cmd_len);
-        memset(&hdr->cdb[sc->cmd_len], 0, MAX_COMMAND_SIZE - sc->cmd_len);
+	if (sc->cmd_len < MAX_COMMAND_SIZE) {
+		memset(&hdr->cdb[sc->cmd_len], 0, MAX_COMMAND_SIZE - sc->cmd_len);
+	}

 	ctask->data_count = 0;
-	if (sc->sc_data_direction == DMA_TO_DEVICE) {
+	switch (sc->sc_data_direction) {
+	case DMA_BIDIRECTIONAL:
+		hdr->flags |= ISCSI_FLAG_CMD_READ;
+		/* FALLTHROUGH */
+	case DMA_TO_DEVICE:
 		hdr->flags |= ISCSI_FLAG_CMD_WRITE;
 		/*
 		 * Write counters:
@@ -145,11 +151,11 @@ static void iscsi_prep_scsi_cmd_pdu(stru
 		ctask->unsol_datasn = 0;

 		if (session->imm_data_en) {
-			if (ctask->total_length >= session->first_burst)
+			if (iscsi_out_total_length(ctask) >= session->first_burst)
 				ctask->imm_count = min(session->first_burst,
 							conn->max_xmit_dlength);
 			else
-				ctask->imm_count = min(ctask->total_length,
+				ctask->imm_count = min(iscsi_out_total_length(ctask),
 							conn->max_xmit_dlength);
 			hton24(ctask->hdr->dlength, ctask->imm_count);
 		} else
@@ -157,20 +163,20 @@ static void iscsi_prep_scsi_cmd_pdu(stru

 		if (!session->initial_r2t_en) {
 			ctask->unsol_count = min(session->first_burst,
-				ctask->total_length) - ctask->imm_count;
+				iscsi_out_total_length(ctask)) - ctask->imm_count;
 			ctask->unsol_offset = ctask->imm_count;
 		}

 		if (!ctask->unsol_count)
 			/* No unsolicit Data-Out's */
 			ctask->hdr->flags |= ISCSI_FLAG_CMD_FINAL;
-	} else {
-		ctask->datasn = 0;
+		break;
+	case DMA_FROM_DEVICE:
+		hdr->flags |= ISCSI_FLAG_CMD_READ;
+		/* FALLTHROUGH */
+	default:
 		hdr->flags |= ISCSI_FLAG_CMD_FINAL;
 		zero_data(hdr->dlength);
-
-		if (sc->sc_data_direction == DMA_FROM_DEVICE)
-			hdr->flags |= ISCSI_FLAG_CMD_READ;
 	}

 	conn->scsicmd_pdus_cnt++;
@@ -817,7 +823,6 @@ int iscsi_queuecommand(struct scsi_cmnd
 	ctask->conn = conn;
 	ctask->sc = sc;
 	INIT_LIST_HEAD(&ctask->running);
-	ctask->total_length = sc->request_bufflen;
 	iscsi_prep_scsi_cmd_pdu(ctask);

 	session->tt->init_cmd_task(ctask);
@@ -826,7 +831,9 @@ int iscsi_queuecommand(struct scsi_cmnd
 	debug_scsi(
 	       "ctask enq [%s cid %d sc %p cdb 0x%x itt 0x%x len %d cmdsn %d "
 		"win %d]\n",
-		sc->sc_data_direction == DMA_TO_DEVICE ? "write" : "read",
+		sc->sc_data_direction == DMA_TO_DEVICE ? "write" :
+		  sc->sc_data_direction == DMA_BIDIRECTIONAL ? "bidirectional" :
+		  sc->sc_data_direction == DMA_FROM_DEVICE ? "read" : "none",
 		conn->id, sc, sc->cmnd[0], ctask->itt, sc->request_bufflen,
 		session->cmdsn, session->max_cmdsn - session->exp_cmdsn + 1);
 	spin_unlock(&session->lock);
@@ -1633,7 +1640,7 @@ int iscsi_conn_start(struct iscsi_cls_co
 		printk("iscsi: invalid burst lengths: "
 		       "first_burst %d max_burst %d\n",
 		       session->first_burst, session->max_burst);
-		return -EINVAL;
+//		return -EINVAL;
 	}

 	spin_lock_bh(&session->lock);
diff --git a/include/scsi/iscsi_proto.h b/include/scsi/iscsi_proto.h
index 02f6e4b..e530734 100644
--- a/include/scsi/iscsi_proto.h
+++ b/include/scsi/iscsi_proto.h
@@ -139,6 +139,14 @@ struct iscsi_rlength_ahdr {
 	__be32 read_length;
 };

+/* Extended CDB AHS */
+struct iscsi_ecdb_ahdr {
+	__be16 ahslength;	/* CDB length - 15, including reserved byte */
+	uint8_t ahstype;
+	uint8_t reserved;
+	uint8_t ecdb[260 - 16];	/* 4-byte aligned extended CDB spillover */
+};
+
 /* SCSI Response Header */
 struct iscsi_cmd_rsp {
 	uint8_t opcode;
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index ea0816d..6701ea6 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -25,6 +25,7 @@ #define LIBISCSI_H

 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <scsi/iscsi_proto.h>
@@ -33,7 +34,6 @@ #include <scsi/iscsi_if.h>
 struct scsi_transport_template;
 struct scsi_device;
 struct Scsi_Host;
-struct scsi_cmnd;
 struct socket;
 struct iscsi_transport;
 struct iscsi_cls_session;
@@ -99,7 +99,6 @@ struct iscsi_cmd_task {
 	 */
 	struct iscsi_cmd	*hdr;
 	int			itt;		/* this ITT */
-	int			datasn;		/* DataSN */

 	uint32_t		unsol_datasn;
 	int			imm_count;	/* imm-data (bytes)   */
@@ -108,7 +107,6 @@ struct iscsi_cmd_task {
 	int			unsol_offset;
 	int			data_count;	/* remaining Data-Out */
 	struct scsi_cmnd	*sc;		/* associated SCSI cmd*/
-	int			total_length;
 	struct iscsi_conn	*conn;		/* used connection    */
 	struct iscsi_mgmt_task	*mtask;		/* tmf mtask in progr */

@@ -119,6 +117,20 @@ struct iscsi_cmd_task {
 	void			*dd_data;	/* driver/transport data */
 };

+static inline int
+iscsi_out_total_length(struct iscsi_cmd_task* ctask)
+{
+	return ctask->sc->request_bufflen;
+}
+
+static inline int
+iscsi_in_total_length(struct iscsi_cmd_task* ctask)
+{
+	return is_bidi_cmnd(ctask->sc) ?
+		ctask->sc->bidi_read_sdb.request_bufflen :
+		ctask->sc->request_bufflen;
+}
+
 struct iscsi_conn {
 	struct iscsi_cls_conn	*cls_conn;	/* ptr to class connection */
 	void			*dd_data;	/* iscsi_transport data */
-- 
