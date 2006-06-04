Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932204AbWFDIqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWFDIqj (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWFDIqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:46:38 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:33427 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932204AbWFDIqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:46:37 -0400
Message-ID: <44829E99.5070406@sw.ru>
Date: Sun, 04 Jun 2006 12:49:29 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: adam radford <aradford@gmail.com>, Adam Radford <linuxraid@amcc.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, devel@openvz.org,
        Andrew Morton <akpm@osdl.org>
Subject: [SCSI] 3w-9xxx: kmap_atomic in twa_scsiop_execute_scsi
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080100090004020508060203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080100090004020508060203
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Adam,

you have fixed recently potential memory corruption, kmap_atomic issue in
3w-9xxx driver, however it seems for me you have forgotten to fix the same issue
in yet another similar place, in twa_scsiop_execute_scsi() function.

Signed-off-by: Vasily Averin <vvs@sw.ru>

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

--------------080100090004020508060203
Content-Type: text/plain;
 name="diff-scsi-3w9xxx-kmap-20060604"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-scsi-3w9xxx-kmap-20060604"

--- a/drivers/scsi/3w-9xxx.c	2006-06-04 11:15:52.000000000 +0400
+++ b/drivers/scsi/3w-9xxx.c	2006-06-04 11:18:34.000000000 +0400
@@ -1864,9 +1864,13 @@ static int twa_scsiop_execute_scsi(TW_De
 			if ((tw_dev->srb[request_id]->use_sg == 1) && (tw_dev->srb[request_id]->request_bufflen < TW_MIN_SGL_LENGTH)) {
 				if (tw_dev->srb[request_id]->sc_data_direction == DMA_TO_DEVICE || tw_dev->srb[request_id]->sc_data_direction == DMA_BIDIRECTIONAL) {
 					struct scatterlist *sg = (struct scatterlist *)tw_dev->srb[request_id]->request_buffer;
-					char *buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+					unsigned long flags = 0;
+					char *buf;
+					local_irq_save(flags);
+					buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 					memcpy(tw_dev->generic_buffer_virt[request_id], buf, sg->length);
 					kunmap_atomic(buf - sg->offset, KM_IRQ0);
+					local_irq_restore(flags);
 				}
 				command_packet->sg_list[0].address = TW_CPU_TO_SGL(tw_dev->generic_buffer_phys[request_id]);
 				command_packet->sg_list[0].length = cpu_to_le32(TW_MIN_SGL_LENGTH);

--------------080100090004020508060203--
