Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFSWze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 18:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTFSWze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 18:55:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261808AbTFSWzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 18:55:31 -0400
Subject: [PATCH 2.7.72-mm1] aio wait on io_queue_wait()
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-9g2bZOmfAMT+Rz/trEzl"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Jun 2003 16:09:49 -0700
Message-Id: <1056064189.17372.48.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9g2bZOmfAMT+Rz/trEzl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been testing AIO on 2.5.72-mm1.  While running tests using the
io_submit(), io_queue_run() and io_queue_wait() interfaces, I
noticed that io_queue_wait() was never waiting.  It was always
returning immediately.  The library implements 
io_queue_wait(ctx, timeout) as io_getevents(ctx, 0, 0, NULL, timeout);

io_getevents() was always returning immediately since this is asking
for zero events.  Here's a patch that allows io_getevents() to wait
for the timeout in this case.  I changed aio_read_evt() to return
if there are any events, but not the events themselves and changed
read_events() to wait when there are no events.

I've tested this on my 2-proc.

Thoughts?

Daniel McNeil <daniel@osdl.org>



--=-9g2bZOmfAMT+Rz/trEzl
Content-Disposition: attachment; filename=patch.2.5.72-mm1.aio
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch.2.5.72-mm1.aio; charset=ISO-8859-1

diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72-mm1/fs/aio.c linux-2.5=
.72-mm1.aio/fs/aio.c
--- linux-2.5.72-mm1/fs/aio.c	2003-06-19 15:35:38.763726959 -0700
+++ linux-2.5.72-mm1.aio/fs/aio.c	2003-06-19 15:29:50.448560742 -0700
@@ -956,6 +956,9 @@ int aio_complete(struct kiocb *iocb, lon
  *	events fetched (0 or 1 ;-)
  *	FIXME: make this use cmpxchg.
  *	TODO: make the ringbuffer user mmap()able (requires FIXME).
+ *
+ *	If ent is NULL, then only check if an event is on the ring.
+ *	This is to handle io_queue_wait().
  */
 static int aio_read_evt(struct kioctx *ioctx, struct io_event *ent)
 {
@@ -972,6 +975,15 @@ static int aio_read_evt(struct kioctx *i
 	if (ring->head =3D=3D ring->tail)
 		goto out;
=20
+	/*
+	 * If ent =3D=3D NULL we are just checking,
+	 * so return now saying there is an event.
+	 */
+	if (ent =3D=3D NULL) {
+		ret =3D 1;
+		goto out;
+	}
+
 	spin_lock(&info->ring_lock);
=20
 	head =3D ring->head % info->nr;
@@ -1080,7 +1092,10 @@ static int read_events(struct kioctx *ct
 		i ++;
 	}
=20
-	if (min_nr <=3D i)
+	/*
+	 * To handle io_queue_wait(), do not return if nr and min_nr are zero.
+	 */
+	if (nr && min_nr && min_nr <=3D i)
 		return i;
 	if (ret)
 		return ret;
@@ -1097,6 +1112,28 @@ static int read_events(struct kioctx *ct
 		set_timeout(start_jiffies, &to, &ts);
 	}
=20
+	/*
+	 * Handle io_queue_wait() by waiting for any completed events,
+	 * but not getting them off the ring.
+	 */
+	if (nr =3D=3D 0) {
+		add_wait_queue_exclusive(&ctx->wait, &wait);
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+		ret =3D aio_read_evt(ctx, 0);
+		/*
+		 * If there are no events and i/o active, wait.
+		 */
+		if (!ret && !to.timed_out && ctx->reqs_active) {
+			schedule();
+		}
+		set_task_state(tsk, TASK_RUNNING);
+		remove_wait_queue(&ctx->wait, &wait);
+		if (timeout)
+			clear_timeout(&to);
+		return 0;
+	}
+
+
 	while (likely(i < nr)) {
 		add_wait_queue_exclusive(&ctx->wait, &wait);
 		do {

--=-9g2bZOmfAMT+Rz/trEzl--

