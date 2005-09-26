Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVIZV5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVIZV5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVIZV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:57:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51856 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932332AbVIZV5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:57:33 -0400
Date: Mon, 26 Sep 2005 22:57:27 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: Fix queue_if_no_path initialisation
Message-ID: <20050926215727.GD5526@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a multipath device, if the queue_if_no_path parameter
is specified it gets ignored.

While the queue_if_no_path variable is correctly set to 1, 
the saved_queue_if_no_path gets set to 0.  When the device is 
subsequently made live (resumed), the saved value (0) always 
overwrites the live value (1) so the option *always* gets turned off.

The fix adds a parameter to the queue_if_no_path() function to indicate
whether the previous value should be preserved or not - if not, as
when the device is being set up, the saved value is set to the new value (1).

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14-rc2/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/md/dm-mpath.c	2005-09-20 04:00:41.000000000 +0100
+++ linux-2.6.14-rc2/drivers/md/dm-mpath.c	2005-09-26 22:43:00.000000000 +0100
@@ -329,13 +329,17 @@
 /*
  * If we run out of usable paths, should we queue I/O or error it?
  */
-static int queue_if_no_path(struct multipath *m, unsigned queue_if_no_path)
+static int queue_if_no_path(struct multipath *m, unsigned queue_if_no_path,
+			    unsigned save_old_value)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&m->lock, flags);
 
-	m->saved_queue_if_no_path = m->queue_if_no_path;
+	if (save_old_value)
+		m->saved_queue_if_no_path = m->queue_if_no_path;
+	else
+		m->saved_queue_if_no_path = queue_if_no_path;
 	m->queue_if_no_path = queue_if_no_path;
 	if (!m->queue_if_no_path && m->queue_size)
 		queue_work(kmultipathd, &m->process_queued_ios);
@@ -677,7 +681,7 @@
 		return 0;
 
 	if (!strnicmp(shift(as), MESG_STR("queue_if_no_path")))
-		return queue_if_no_path(m, 1);
+		return queue_if_no_path(m, 1, 0);
 	else {
 		ti->error = "Unrecognised multipath feature request";
 		return -EINVAL;
@@ -1077,7 +1081,7 @@
 {
 	struct multipath *m = (struct multipath *) ti->private;
 
-	queue_if_no_path(m, 0);
+	queue_if_no_path(m, 0, 1);
 }
 
 /*
@@ -1222,9 +1226,9 @@
 
 	if (argc == 1) {
 		if (!strnicmp(argv[0], MESG_STR("queue_if_no_path")))
-			return queue_if_no_path(m, 1);
+			return queue_if_no_path(m, 1, 0);
 		else if (!strnicmp(argv[0], MESG_STR("fail_if_no_path")))
-			return queue_if_no_path(m, 0);
+			return queue_if_no_path(m, 0, 0);
 	}
 
 	if (argc != 2)
