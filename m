Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbTGIAmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267995AbTGIAmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:42:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268111AbTGIAlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:41:53 -0400
Subject: [PATCH libaio] add timeout to io_queue_run and remove io_queue_wait
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Benjamin LaHaise <bcrl@kvack.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-FV5zZbDqAuV80+lCEtIu"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Jul 2003 17:57:04 -0700
Message-Id: <1057712224.11509.35.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FV5zZbDqAuV80+lCEtIu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a patch to libaio which adds a timeout parameter to
io_queue_run() and removes io_queue_wait().  This makes my
earlier kernel patch to fs/aio.c unnecessary, since I removed
io_queue_wait() which was calling the io_getevents() syscall
with a zero number of events.  This keeps the callback interface
in the library and allows a user process to wait for i/o's to
complete if it wants to.  I also changed io_queue_run() to
batch up to 8 completions at a time, so it is more efficient.
This requires no kernel changes. I also updated the io_queue_run() 
man page and that is in a separate patch.

Thoughts?

Daniel McNeil <daniel@osdl.org


--=-FV5zZbDqAuV80+lCEtIu
Content-Disposition: attachment; filename=patch.libaio.io_queue_run
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch.libaio.io_queue_run; charset=ISO-8859-1

diff -rupN -X /home/daniel_nfs/dontdiff libaio-0.3.93/src/io_queue_run.c li=
baio-0.3.93-io_queue_run_with_timeout/src/io_queue_run.c
--- libaio-0.3.93/src/io_queue_run.c	2002-09-26 09:39:38.000000000 -0700
+++ libaio-0.3.93-io_queue_run_with_timeout/src/io_queue_run.c	2003-07-08 1=
6:38:52.983739711 -0700
@@ -21,19 +21,33 @@
 #include <stdlib.h>
 #include <time.h>
=20
-int io_queue_run(io_context_t ctx)
+#define IO_BATCH_EVENTS	8		/* number of events to batch up */
+
+int io_queue_run(io_context_t ctx, struct timespec *timeout)
 {
-	static struct timespec timeout =3D { 0, 0 };
-	struct io_event event;
-	int ret;
-
-	/* FIXME: batch requests? */
-	while (1 =3D=3D (ret =3D io_getevents(ctx, 0, 1, &event, &timeout))) {
-		io_callback_t cb =3D (io_callback_t)event.data;
-		struct iocb *iocb =3D event.obj;
+	struct io_event events[IO_BATCH_EVENTS];
+	struct io_event *ep;
+	int ret =3D 0;		/* total number of events processed */
+	int n;
+
+	/*
+	 * Process io events and call the callbacks.
+	 * Try to batch the events up to IO_BATCH_EVENTS at a time.
+	 * Loop until we have read all the available events and called the callba=
cks.
+	 */
+	do {
+		int i;
+
+		if ((n =3D io_getevents(ctx, 1, IO_BATCH_EVENTS, &events, timeout)) <=3D=
 0)
+			break;
+		ret +=3D n;
+		for (ep =3D events, i =3D n; i-- > 0; ep++) {
+			io_callback_t cb =3D (io_callback_t)ep->data;
+			struct iocb *iocb =3D ep->obj;
=20
-		cb(ctx, iocb, event.res, event.res2);
-	}
+			cb(ctx, iocb, ep->res, ep->res2);
+		}
+	} while (n =3D=3D IO_BATCH_EVENTS);
=20
-	return ret;
+	return ret ? ret : n;		/* return number of events or error */
 }
diff -rupN -X /home/daniel_nfs/dontdiff libaio-0.3.93/src/libaio.h libaio-0=
.3.93-io_queue_run_with_timeout/src/libaio.h
--- libaio-0.3.93/src/libaio.h	2002-10-08 16:33:42.000000000 -0700
+++ libaio-0.3.93-io_queue_run_with_timeout/src/libaio.h	2003-07-08 16:41:0=
6.471880979 -0700
@@ -123,7 +123,7 @@ extern int io_queue_init(int maxevents,=20
 /*extern int io_queue_grow(io_context_t ctx, int new_maxevents);*/
 extern int io_queue_release(io_context_t ctx);
 /*extern int io_queue_wait(io_context_t ctx, struct timespec *timeout);*/
-extern int io_queue_run(io_context_t ctx);
+extern int io_queue_run(io_context_t ctx, struct timespec *timeout);
=20
 /* Actual syscalls */
 extern int io_setup(int maxevents, io_context_t *ctxp);
Binary files libaio-0.3.93/src/libaio.so.1 and libaio-0.3.93-io_queue_run_w=
ith_timeout/src/libaio.so.1 differ
diff -rupN -X /home/daniel_nfs/dontdiff libaio-0.3.93/src/Makefile libaio-0=
.3.93-io_queue_run_with_timeout/src/Makefile
--- libaio-0.3.93/src/Makefile	2002-09-12 20:30:12.000000000 -0700
+++ libaio-0.3.93-io_queue_run_with_timeout/src/Makefile	2003-07-08 16:47:2=
9.426559122 -0700
@@ -14,7 +14,7 @@ all: $(all_targets)
=20
 # libaio provided functions
 libaio_srcs :=3D io_queue_init.c io_queue_release.c
-libaio_srcs +=3D io_queue_wait.c io_queue_run.c
+libaio_srcs +=3D io_queue_run.c
=20
 # real syscalls
 libaio_srcs +=3D io_getevents.c io_submit.c io_cancel.c

--=-FV5zZbDqAuV80+lCEtIu
Content-Disposition: attachment; filename=patch.libaio.man.io_queue_run
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch.libaio.man.io_queue_run; charset=ISO-8859-1

diff -rupN -X /home/daniel_nfs/dontdiff libaio-0.3.93/man/io_queue_run.3 li=
baio-0.3.93-io_queue_run_with_timeout/man/io_queue_run.3
--- libaio-0.3.93/man/io_queue_run.3	2002-09-26 08:55:18.000000000 -0700
+++ libaio-0.3.93-io_queue_run_with_timeout/man/io_queue_run.3	2003-07-08 1=
7:28:55.441862077 -0700
@@ -9,16 +9,21 @@ io_queue_run \- Handle completed io requ
 .B #include <libaio.h>
 .br
 .sp
-.BI "int io_queue_run(io_context_t  ctx );"
+.BI "int io_queue_run(io_context_t  ctx, struct timespec *timeout);"
 .sp
 .fi
 .SH DESCRIPTION
 .B io_queue_run
-Attempts to read  all the events events from
-the completion queue for the aio_context specified by ctx_id.
+Attempts to read all the events events from
+the completion queue for the aio_context specified by ctx and calls the ca=
llbacks
+setup by io_set_callback().
 .SH "RETURN VALUES"
+Returns the number of events handled.
 May return
-0 if no events are available.
+0 if no events are available and the timeout specified
+by timeout has elapsed, where timeout =3D=3D NULL specifies an infinite
+timeout.  Note that the timeout pointed to by timeout is relative and
+will be updated if not NULL and the operation blocks.
 Will fail with -ENOSYS if not implemented.
 .SH ERRORS
 .TP
@@ -44,7 +49,6 @@ Not implemented
 .BR io_prep_pwrite(3),
 .BR io_queue_init(3),
 .BR io_queue_release(3),
-.BR io_queue_wait(3),
 .BR io_set_callback(3),
 .BR io_submit(3),
 .BR errno(3)

--=-FV5zZbDqAuV80+lCEtIu--

