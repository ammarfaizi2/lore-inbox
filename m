Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72FDC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995272073B
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 09:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r0oIWqAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKOJiB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:38:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKOJiB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 04:38:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF9YQix176778;
        Fri, 15 Nov 2019 09:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=ym4O2zYhDbJC8bmdjKxgB3r62TXhmYMVIXTuLFRvCLs=;
 b=r0oIWqAxGwew9zNzty+yYZUAgVlJl8NQQlEhkWZEUVPa67a9psEbx7P0epWWPDChI1KL
 i6gCuA8Ys1I2rRVIyxc1PtcP4v26Q1801it+VL1R5YnrKXBd6db8SCfFuYhm3Iw+igvR
 Rm+ECmJBD53zTwYMaP3p47eNBaDulvWEZCgOLDk+IV+xh6PJUW4oWBCU7vHQENm1bOKv
 Ec6E2qRKYUB8WDaA9fc6CvL8Lnxdqh0jnAdFfpB3MB8oAan9p1TXhv5KOFVN5GqvPWQb
 Uq8WqcvCD07Nox484gfTjjc4V07QVqVgOKIe1QLPhx15kiXRL4gqdmIJVuix3X4acm2w Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w9gxpj4w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 09:37:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF9XqJx112489;
        Fri, 15 Nov 2019 09:37:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w9h146t87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 09:37:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAF9btGL013466;
        Fri, 15 Nov 2019 09:37:55 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 01:37:54 -0800
From:   Bob Liu <bob.liu@oracle.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH] io_uring: fix duplicated increase of cached_cq_overflow
Date:   Fri, 15 Nov 2019 17:37:33 +0800
Message-Id: <20191115093733.18396-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=896
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=981 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150090
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

cached_cq_overflow already be increased in function
io_cqring_overflow_flush().

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 55f8b1d..eb23451 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -701,7 +701,7 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
 		WRITE_ONCE(cqe->flags, 0);
 	} else if (ctx->cq_overflow_flushed) {
 		WRITE_ONCE(ctx->rings->cq_overflow,
-				atomic_inc_return(&ctx->cached_cq_overflow));
+				atomic_read(&ctx->cached_cq_overflow));
 	} else {
 		refcount_inc(&req->refs);
 		req->result = res;
-- 
2.9.5

