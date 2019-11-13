Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FDC17449
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 10:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6A22245B
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 10:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nk4nRMoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKMKHA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:07:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38854 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfKMKHA (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 05:07:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADA4ttf054710;
        Wed, 13 Nov 2019 10:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=B3yR34pcNWGb75lTikQ66jB5OHl8cgbjoFgPMFXfraY=;
 b=Nk4nRMoRCSastXCpniC2FrmBZak7dXnb6lw6kHUN4l+8XmL+U6zLiLcCkMyS99G4lhTF
 Pok9KtyIPZZc0F2tewO55oVZo2RjUYcVeCYA8lavN/7nNRlLoqD7fmHHkvUflMvKG8wf
 KsGvtW4sjf/oStely4iAEtKbHjzzJEA2UBL3LpjgQcqQinC3OIPIr5AdwuQ26eUyDsV0
 qN3gmKbZaV7HZxeEdbLwKeSqIEbPWM/82kKxGxIiSCZDRyKU34vmhPCkvySTFTpkeqKJ
 jy5p/Ptwn04yXM53Wyf5lUN22TdccugheXEl4a8Mv7W3Dnxm1bewiIdnjvA2Jbrfa2kh sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w5ndqbadm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 10:06:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADA3mED061621;
        Wed, 13 Nov 2019 10:06:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w7j06ddgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 10:06:56 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xADA6upS013983;
        Wed, 13 Nov 2019 10:06:56 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 02:06:55 -0800
From:   Bob Liu <bob.liu@oracle.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH 1/2] fs:io_uring: clean up io_uring_cancel_files
Date:   Wed, 13 Nov 2019 18:06:24 +0800
Message-Id: <20191113100625.10774-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130095
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

return val is not used, drop it.
Also drop unnecessary if (cancel_req).

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 fs/io_uring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 247e5e1..5781bfe 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4286,7 +4286,6 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 	DEFINE_WAIT(wait);
 
 	while (!list_empty_careful(&ctx->inflight_list)) {
-		enum io_wq_cancel ret = IO_WQ_CANCEL_NOTFOUND;
 		struct io_kiocb *cancel_req = NULL;
 
 		spin_lock_irq(&ctx->inflight_lock);
@@ -4304,14 +4303,12 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 						TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(&ctx->inflight_lock);
 
-		if (cancel_req) {
-			ret = io_wq_cancel_work(ctx->io_wq, &cancel_req->work);
-			io_put_req(cancel_req);
-		}
-
 		/* We need to keep going until we don't find a matching req */
 		if (!cancel_req)
 			break;
+
+		io_wq_cancel_work(ctx->io_wq, &cancel_req->work);
+		io_put_req(cancel_req);
 		schedule();
 	}
 	finish_wait(&ctx->inflight_wait, &wait);
-- 
2.9.5

