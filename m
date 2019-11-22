Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F2C432C0
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 08:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD9F2070E
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 08:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfKVI1O (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:27:14 -0500
Received: from smtpbg518.qq.com ([203.205.250.104]:44312 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbfKVI1M (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 22 Nov 2019 03:27:12 -0500
X-QQ-mid: Xesmtp6t1574410686t3z396zsu
Received: from byteisland.com (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 22 Nov 2019 16:18:04 +0800 (CST)
X-QQ-SSF: 01000000000000B0SF101F00000000K
X-QQ-FEAT: TSAZtYu/fxMifg85IMqXPdkoT+HpjgoyycxI44SGiowl1z5dTB7uvQTbR57Ex
        ssuUIX2M/iI6F98UtpL45g3ewWqiCl0pFeBEgaaxBdvqN0sGzuFANDtj2It71AF6uzohSP1
        1xyHzniivU3CyZgrAc1QVr/kdDBDfx9aVlcg1nAT8lBY2HaqbR/s4UmYuvEmdA3UdCDpBKR
        k+xypk9ZHOSTl/uAI8qyUfJJxqNfytPrW60L2L2wILDcdeJN4p8f/ox6SkUcuPz9xutGMRG
        r83GYi4xeaDry1F5o4WJWYDY+VpOEYhiG/RWVvO2Hdc66M
X-QQ-GoodBg: 0
From:   Jackie Liu <jackieliu@byteisland.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        liuyun01@kylinos.cn
Subject: [PATCH liburing v2] Update link_drain with new kernel method
Date:   Fri, 22 Nov 2019 16:18:04 +0800
Message-Id: <20191122081804.41292-1-jackieliu@byteisland.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgweb:bgweb5
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Now we are dealing with link-drain in a much simpler way,
so the test program is updated as well.

Also fixed a bug that did not close fd when an error occurred.
and some dead code has been modified, like commit e1420b89c do.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 v2: fix miss dead code.

 test/link_drain.c | 133 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 18 deletions(-)

diff --git a/test/link_drain.c b/test/link_drain.c
index c192a5d..cc6f73f 100644
--- a/test/link_drain.c
+++ b/test/link_drain.c
@@ -11,13 +11,7 @@
 
 #include "liburing.h"
 
-char expect[3][5] = {
-	{ 0, 1, 2, 3, 4 },
-	{ 0, 1, 2, 4, 3 },
-	{ 0, 1, 4, 2, 3 }
-};
-
-static int test_link_drain(struct io_uring *ring)
+static int test_link_drain_one(struct io_uring *ring)
 {
 	struct io_uring_cqe *cqe;
 	struct io_uring_sqe *sqe[5];
@@ -25,6 +19,7 @@ static int test_link_drain(struct io_uring *ring)
 	int i, fd, ret;
 	off_t off = 0;
 	char data[5] = {0};
+	char expect[5] = {0, 1, 2, 3, 4};
 
 	fd = open("testfile", O_WRONLY | O_CREAT, 0644);
 	if (fd < 0) {
@@ -66,12 +61,12 @@ static int test_link_drain(struct io_uring *ring)
 	sqe[4]->user_data = 4;
 
 	ret = io_uring_submit(ring);
-	if (ret < 5) {
-		printf("Submitted only %d\n", ret);
-		goto err;
-	} else if (ret < 0) {
+	if (ret < 0) {
 		printf("sqe submit failed\n");
 		goto err;
+	} else if (ret < 5) {
+		printf("Submitted only %d\n", ret);
+		goto err;
 	}
 
 	for (i = 0; i < 5; i++) {
@@ -85,21 +80,121 @@ static int test_link_drain(struct io_uring *ring)
 		io_uring_cqe_seen(ring, cqe);
 	}
 
+	if (memcmp(data, expect, 5) != 0)
+		goto err;
+
 	free(iovecs.iov_base);
 	close(fd);
+	unlink("testfile");
+	return 0;
+err:
+	free(iovecs.iov_base);
+	close(fd);
+	unlink("testfile");
+	return 1;
+}
+
+int test_link_drain_multi(struct io_uring *ring)
+{
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe[9];
+	struct iovec iovecs;
+	int i, fd, ret;
+	off_t off = 0;
+	char data[9] = {0};
+	char expect[9] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
 
-	for (i = 0; i < 3; i++) {
-		if (memcmp(data, expect[i], 5) == 0)
-			break;
+	fd = open("testfile", O_WRONLY | O_CREAT, 0644);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	iovecs.iov_base = malloc(4096);
+	iovecs.iov_len = 4096;
+
+	for (i = 0; i < 9; i++) {
+		sqe[i] = io_uring_get_sqe(ring);
+		if (!sqe[i]) {
+			printf("get sqe failed\n");
+			goto err;
+		}
 	}
-	if (i == 3)
+
+	/* normal heavy io */
+	io_uring_prep_writev(sqe[0], fd, &iovecs, 1, off);
+	sqe[0]->user_data = 0;
+
+	/* link1 io head */
+	io_uring_prep_nop(sqe[1]);
+	sqe[1]->flags |= IOSQE_IO_LINK;
+	sqe[1]->user_data = 1;
+
+	/* link1 drain io */
+	io_uring_prep_nop(sqe[2]);
+	sqe[2]->flags |= (IOSQE_IO_LINK | IOSQE_IO_DRAIN);
+	sqe[2]->user_data = 2;
+
+	/* link1 io end*/
+	io_uring_prep_nop(sqe[3]);
+	sqe[3]->user_data = 3;
+
+	/* link2 io head */
+	io_uring_prep_nop(sqe[4]);
+	sqe[4]->flags |= IOSQE_IO_LINK;
+	sqe[4]->user_data = 4;
+
+	/* link2 io */
+	io_uring_prep_nop(sqe[5]);
+	sqe[5]->flags |= IOSQE_IO_LINK;
+	sqe[5]->user_data = 5;
+
+	/* link2 drain io */
+	io_uring_prep_writev(sqe[6], fd, &iovecs, 1, off);
+	sqe[6]->flags |= (IOSQE_IO_LINK | IOSQE_IO_DRAIN);
+	sqe[6]->user_data = 6;
+
+	/* link2 io end */
+	io_uring_prep_nop(sqe[7]);
+	sqe[7]->user_data = 7;
+
+	/* normal io */
+	io_uring_prep_nop(sqe[8]);
+	sqe[8]->user_data = 8;
+
+	ret = io_uring_submit(ring);
+	if (ret < 0) {
+		printf("sqe submit failed\n");
+		goto err;
+	} else if (ret < 9) {
+		printf("Submitted only %d\n", ret);
+		goto err;
+	}
+
+	for (i = 0; i < 9; i++) {
+		ret = io_uring_wait_cqe(ring, &cqe);
+		if (ret < 0) {
+			printf("child: wait completion %d\n", ret);
+			goto err;
+		}
+
+		data[i] = cqe->user_data;
+		io_uring_cqe_seen(ring, cqe);
+	}
+
+	if (memcmp(data, expect, 9) != 0)
 		goto err;
 
+	free(iovecs.iov_base);
+	close(fd);
 	unlink("testfile");
 	return 0;
 err:
+	free(iovecs.iov_base);
+	close(fd);
 	unlink("testfile");
 	return 1;
+
 }
 
 int main(int argc, char *argv[])
@@ -107,14 +202,16 @@ int main(int argc, char *argv[])
 	struct io_uring ring;
 	int i, ret;
 
-	ret = io_uring_queue_init(5, &ring, 0);
+	ret = io_uring_queue_init(100, &ring, 0);
 	if (ret) {
 		printf("ring setup failed\n");
 		return 1;
 	}
 
-	for (i = 0; i < 1000; i++)
-		ret |= test_link_drain(&ring);
+	for (i = 0; i < 1000; i++) {
+		ret |= test_link_drain_one(&ring);
+		ret |= test_link_drain_multi(&ring);
+	}
 
 	if (ret)
 		return ret;
-- 
2.17.1

