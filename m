Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E5C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 05:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336821848
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 05:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfKIFiA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 00:38:00 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:53358 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfKIFiA (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sat, 9 Nov 2019 00:38:00 -0500
X-QQ-mid: bizesmtp17t1573277873tdi03k9k
Received: from JackieLiu-PC.localdomain (unknown [113.240.168.246])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 09 Nov 2019 13:37:07 +0800 (CST)
X-QQ-SSF: 01400000002000T0ZU90000A0000000
X-QQ-FEAT: JtFveLzs4P+cUUxaChqzc09Lq8TkQkAPHLG2C5ECp5El6dKW3k/3ggnyXZSo7
        hvE0fxM8osv0C5S4D5mGPkRcf0RPkkwqn74mSRyrKNPYp7zyHZIyb3KarK08fOSwy+TPR5z
        iH8fMFQIAqHTcnkV5izcPZaqg2ugaWbl8f2Yk9ZOdfB+E5T/w7QtmnnyzvNI/vXF62sTFqR
        65IuWvtDI4pIFQSSD05s22k5NBuSAD4GQgO4OOKiQCT+WGVjv1IPUh/qAM7uDmU9lV5F1n9
        HCvgBsjglLmlJRYtvTIavDIHczME8VQoW+N4KYUelyPJG0X4cFdDDqglaUFka2C9vGWMfcU
        L8Q0vc/ovcS3YuEngMVDra3Q3OPNw==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2] liburing: Add regression test case for link with drain
Date:   Sat,  9 Nov 2019 13:36:56 +0800
Message-Id: <1573277816-3807-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
V2:                                                                                                                                                                                                                                                                             - Fix loop iterators                                                                                                                                                                                                                                                           - close fd  

 test/Makefile     |   4 +-
 test/link_drain.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100644 test/link_drain.c

diff --git a/test/Makefile b/test/Makefile
index a3a2556..ddbcc6a 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -9,7 +9,7 @@ all_targets += poll poll-cancel ring-leak fsync io_uring_setup io_uring_register
 		sq-space_left stdout cq-ready cq-peek-batch file-register \
 		cq-size 8a9973408177-test a0908ae19763-test 232c93d07b74-test \
 		socket-rw accept timeout-overflow defer read-write io-cancel \
-		link-timeout cq-overflow
+		link-timeout cq-overflow link_drain
 
 include ../Makefile.quiet
 
@@ -26,7 +26,7 @@ test_srcs := poll.c poll-cancel.c ring-leak.c fsync.c io_uring_setup.c \
 	cq-peek-batch.c file-register.c cq-size.c 8a9973408177-test.c \
 	a0908ae19763-test.c 232c93d07b74-test.c socket-rw.c accept.c \
 	timeout-overflow.c defer.c read-write.c io-cancel.c link-timeout.c \
-	cq-overflow.c
+	cq-overflow.c link_drain.c
 
 test_objs := $(patsubst %.c,%.ol,$(test_srcs))
 
diff --git a/test/link_drain.c b/test/link_drain.c
new file mode 100644
index 0000000..c192a5d
--- /dev/null
+++ b/test/link_drain.c
@@ -0,0 +1,123 @@
+/*
+ * Description: test io_uring link io with drain io
+ *
+ */
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+
+#include "liburing.h"
+
+char expect[3][5] = {
+	{ 0, 1, 2, 3, 4 },
+	{ 0, 1, 2, 4, 3 },
+	{ 0, 1, 4, 2, 3 }
+};
+
+static int test_link_drain(struct io_uring *ring)
+{
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe[5];
+	struct iovec iovecs;
+	int i, fd, ret;
+	off_t off = 0;
+	char data[5] = {0};
+
+	fd = open("testfile", O_WRONLY | O_CREAT, 0644);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	iovecs.iov_base = malloc(4096);
+	iovecs.iov_len = 4096;
+
+	for (i = 0; i < 5; i++) {
+		sqe[i] = io_uring_get_sqe(ring);
+		if (!sqe[i]) {
+			printf("get sqe failed\n");
+			goto err;
+		}
+	}
+
+	/* normal heavy io */
+	io_uring_prep_writev(sqe[0], fd, &iovecs, 1, off);
+	sqe[0]->user_data = 0;
+
+	/* link io */
+	io_uring_prep_nop(sqe[1]);
+	sqe[1]->flags |= IOSQE_IO_LINK;
+	sqe[1]->user_data = 1;
+
+	/* link drain io */
+	io_uring_prep_nop(sqe[2]);
+	sqe[2]->flags |= (IOSQE_IO_LINK | IOSQE_IO_DRAIN);
+	sqe[2]->user_data = 2;
+
+	/* link io */
+	io_uring_prep_nop(sqe[3]);
+	sqe[3]->user_data = 3;
+
+	/* normal nop io */
+	io_uring_prep_nop(sqe[4]);
+	sqe[4]->user_data = 4;
+
+	ret = io_uring_submit(ring);
+	if (ret < 5) {
+		printf("Submitted only %d\n", ret);
+		goto err;
+	} else if (ret < 0) {
+		printf("sqe submit failed\n");
+		goto err;
+	}
+
+	for (i = 0; i < 5; i++) {
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
+	free(iovecs.iov_base);
+	close(fd);
+
+	for (i = 0; i < 3; i++) {
+		if (memcmp(data, expect[i], 5) == 0)
+			break;
+	}
+	if (i == 3)
+		goto err;
+
+	unlink("testfile");
+	return 0;
+err:
+	unlink("testfile");
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	struct io_uring ring;
+	int i, ret;
+
+	ret = io_uring_queue_init(5, &ring, 0);
+	if (ret) {
+		printf("ring setup failed\n");
+		return 1;
+	}
+
+	for (i = 0; i < 1000; i++)
+		ret |= test_link_drain(&ring);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
-- 
2.7.4



