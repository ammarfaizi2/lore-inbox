Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVCIB7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVCIB7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVCIB5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:57:06 -0500
Received: from fmr22.intel.com ([143.183.121.14]:47581 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262308AbVCIBxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:53:46 -0500
Message-Id: <200503090153.j291rbg16445@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Jens Axboe'" <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Tue, 8 Mar 2005 17:53:36 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkSNzKYDObGXK9SD6A7gSOX+GhIwAAa6Tg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, last one in the series: user level test programs that stress
the kernel I/O stack.  Pretty dull stuff.

- Ken



diff -Nur zero/aio_null.c blknull_test/aio_null.c
--- zero/aio_null.c	1969-12-31 16:00:00.000000000 -0800
+++ blknull_test/aio_null.c	2005-03-08 00:46:17.000000000 -0800
@@ -0,0 +1,76 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <linux/ioctl.h>
+#include <libaio.h>
+
+#define MAXAIO		1024
+
+char	buf[4096] __attribute__((aligned(4096)));
+
+io_context_t	io_ctx;
+struct iocb	iocbpool[MAXAIO];
+struct io_event	ioevent[MAXAIO];
+
+void aio_setup(int n)
+{
+	int res = io_queue_init(n, &io_ctx);
+	if (res != 0) {
+		printf("io_queue_setup(%d) returned %d (%s)\n",
+			n, res, strerror(-res));
+		exit(0);
+	}
+}
+
+main(int argc, char* argv[])
+{
+	int	fd, i, status, batch;
+	struct iocb* iocbbatch[MAXAIO];
+	int	devidx;
+	off_t	offset;
+	unsigned long start, end;
+
+	batch = argc < 2 ? 100: atoi(argv[1]);
+	if (batch >= MAXAIO)
+		batch = MAXAIO;
+
+	aio_setup(MAXAIO);
+	fd = open("/dev/raw/raw1", O_RDONLY);
+
+	if (fd == -1) {
+		perror("error opening\n");
+		exit (0);
+	}
+	for (i=0; i<batch; i++) {
+		iocbbatch[i] = iocbpool+i;
+		io_prep_pread(iocbbatch[i], fd, buf, 4096, 0);
+	}
+
+	while (1) {
+		struct timespec	ts={30,0};
+		int bufidx;
+		int reap;
+
+		status = io_submit(io_ctx, i, iocbbatch);
+		if (status != i) {
+			printf("bad io_submit: %d [%s]\n", status,
+				strerror(-status));
+		}
+
+		// reap at least batch count back
+		reap = io_getevents(io_ctx, batch, MAXAIO, ioevent, &ts);
+		if (reap < batch) {
+			printf("io_getevents returned=%d [%s]\n", reap,
+				strerror(-reap));
+		}
+
+		// check the return result of each event
+		for (i=0; i<reap; i++)
+			if (ioevent[i].res != 4096)
+				printf("error in read: %lx\n", ioevent[i].res);
+	} /* while (1) */
+}
diff -Nur zero/pread_null.c blknull_test/pread_null.c
--- zero/pread_null.c	1969-12-31 16:00:00.000000000 -0800
+++ blknull_test/pread_null.c	2005-03-08 00:44:20.000000000 -0800
@@ -0,0 +1,27 @@
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <malloc.h>
+
+main(int argc, char* argv[])
+{
+	int fd;
+	char *addr;
+
+	fd = open("/dev/raw/raw1", O_RDONLY);
+	if (fd == -1) {
+		perror("error opening\n");
+		exit(0);
+	}
+
+	addr = memalign(4096, 4096);
+	if (addr == 0) {
+		printf("no memory\n");
+		exit(0);
+	}
+
+	while (1) {
+		pread(fd, addr, 4096, 0);
+	}
+
+}
diff -Nur zero/makefile blknull_test/makefile
--- zero/makefile	1969-12-31 16:00:00.000000000 -0800
+++ blknull_test/makefile	2005-03-08 17:10:39.000000000 -0800
@@ -0,0 +1,10 @@
+all:	pread_null aio_null
+
+pread_null: pread_null.c
+	gcc -O3 -o $@ pread_null.c
+
+aio_null: aio_null.c
+	gcc -O3 -o $@ aio_null.c -laio
+
+clean:
+	rm -f pread_null aio_null



