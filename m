Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DFBC17441
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644921019
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 03:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfKIDAV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:00:21 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:45084 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfKIDAU (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 8 Nov 2019 22:00:20 -0500
X-QQ-mid: bizesmtp21t1573268412tpgkorvc
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 09 Nov 2019 11:00:12 +0800 (CST)
X-QQ-SSF: 01400000000000T0ZU90B00A0000000
X-QQ-FEAT: 2HIwkBI2/ezadHaPkQT6uRrkkTkOiXv/0CrcmswpzcFQku1U4wXtMVDnKaeXm
        cUAlWReIWgNTOLP7NuFf9tK3dCm/vcGUT9zD2jtnDhK+bLruRbeDn9edkciZoTYG4Ria3RE
        /A76M41s12lKBqtbexCR5S7K7MHwQo3JaBrnROKRXxh+xhIl/fe1F9IsHhLhanuc5H/NioE
        e8J7oWg6NAkznfBY++YU2Cd+VGLbw4TQGlUehDYqu4gMyH/8KeFooB9RtiX7BJaOhnYSvE5
        w08xzvwVs3YAthR/j1QmYWFHZqXtlxUf0WRRhR1RpuW7awoOnTCgrtwqXbg3x/z4c045BZ+
        ENXuv0xroyKwrZRVzs=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] liburing: Add regression test case for link with drain
Date:   Sat,  9 Nov 2019 11:00:09 +0800
Message-Id: <1573268409-86058-2-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573268409-86058-1-git-send-email-liuyun01@kylinos.cn>
References: <1573268409-86058-1-git-send-email-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 test/Makefile     |   5 ++-
 test/link_drain.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100644 test/link_drain.c

diff --git a/test/Makefile b/test/Makefile
index 345e663..f7310cf 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -9,7 +9,7 @@ all_targets += poll poll-cancel ring-leak fsync io_uring_setup io_uring_register
 		sq-space_left stdout cq-ready cq-peek-batch file-register \
 		cq-size 8a9973408177-test a0908ae19763-test 232c93d07b74-test \
 		socket-rw accept timeout-overflow defer read-write io-cancel \
-		link-timeout
+		link-timeout link_drain
 
 include ../Makefile.quiet
 
@@ -25,7 +25,8 @@ test_srcs := poll.c poll-cancel.c ring-leak.c fsync.c io_uring_setup.c \
 	500f9fbadef8-test.c timeout.c sq-space_left.c stdout.c cq-ready.c\
 	cq-peek-batch.c file-register.c cq-size.c 8a9973408177-test.c \
 	a0908ae19763-test.c 232c93d07b74-test.c socket-rw.c accept.c \
-	timeout-overflow.c defer.c read-write.c io-cancel.c link-timeout.c
+	timeout-overflow.c defer.c read-write.c io-cancel.c link-timeout.c \
+	link_drain.c
 
 test_objs := $(patsubst %.c,%.ol,$(test_srcs))
 
diff --git a/test/link_drain.c b/test/link_drain.c
new file mode 100644
index 0000000..aafd139
--- /dev/null
+++ b/test/link_drain.c
@@ -0,0 +1,122 @@
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
+char expect[6][5] = {
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
+
+	for (i = 0; i < 6; i++) {
+		if (memcmp(data, expect[i], 5) == 0)
+			break;
+	}
+	if (i == 6)
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



