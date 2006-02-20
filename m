Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWBTMtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWBTMtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWBTMtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:49:13 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:42115 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030189AbWBTMtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:49:12 -0500
Date: Mon, 20 Feb 2006 13:49:07 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Frank Pavlic <fpavlic@de.ibm.com>
Subject: [patch 1/3] s390: V=V qdio fixes
Message-ID: <20060220124907.GF12039@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Pavlic <fpavlic@de.ibm.com>

Using FCP devices with V=V support, the input queue stalled when CCQ 97 had
been returned in qdio_do_eqbs. When this happen we have to reissue the eqbs
instruction.
Another bug was when V=V was enabled we checked if hardware has SIGA-sync
support. If not we returned with 0 from tiqdio_is_inbound_q_done. Thus qdio
lost initiative on FCP devices and input queue stalled. Running devices in
V=V there is no SIGA-sync support but nevertheless we have to process
tiqdio_is_inbound_q_done either.

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-02-20 10:33:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-02-20 10:33:13.000000000 +0100
@@ -165,8 +165,13 @@ qdio_do_eqbs(struct qdio_q *q, unsigned 
 	q_no = q->q_no;
 	if(!q->is_input_q)
 		q_no += irq->no_input_qs;
+again:
 	ccq = do_eqbs(irq->sch_token, state, q_no, start, cnt);
 	rc = qdio_check_ccq(q, ccq);
+	if (rc == 1) {
+		QDIO_DBF_TEXT5(1,trace,"eqAGAIN");
+		goto again;
+	}
 	if (rc < 0) {
                 QDIO_DBF_TEXT2(1,trace,"eqberr");
                 sprintf(dbf_text,"%2x,%2x,%d,%d",tmp_cnt, *cnt, ccq, q_no);
@@ -195,8 +200,13 @@ qdio_do_sqbs(struct qdio_q *q, unsigned 
 	q_no = q->q_no;
 	if(!q->is_input_q)
 		q_no += irq->no_input_qs;
+again:
 	ccq = do_sqbs(irq->sch_token, state, q_no, start, cnt);
 	rc = qdio_check_ccq(q, ccq);
+	if (rc == 1) {
+		QDIO_DBF_TEXT5(1,trace,"sqAGAIN");
+		goto again;
+	}
 	if (rc < 0) {
                 QDIO_DBF_TEXT3(1,trace,"sqberr");
                 sprintf(dbf_text,"%2x,%2x,%d,%d",tmp_cnt,*cnt,ccq,q_no);
@@ -1187,8 +1197,7 @@ tiqdio_is_inbound_q_done(struct qdio_q *
 
 	if (!no_used)
 		return 1;
-
-	if (!q->siga_sync)
+	if (!q->siga_sync && !irq->is_qebsm)
 		/* we'll check for more primed buffers in qeth_stop_polling */
 		return 0;
 	if (irq->is_qebsm) {
