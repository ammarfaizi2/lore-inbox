Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUDLOT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDLOT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:19:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10675 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262911AbUDLOSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:18:44 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 3/9
Date: Mon, 12 Apr 2004 09:18:33 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120918.33386.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle interrupts within suspend.

--- diff/drivers/md/dm.c	2004-04-09 09:41:53.000000000 -0500
+++ source/drivers/md/dm.c	2004-04-09 09:42:02.000000000 -0500
@@ -925,7 +925,7 @@
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (!atomic_read(&md->pending))
+		if (!atomic_read(&md->pending) || signal_pending(current))
 			break;
 
 		io_schedule();
@@ -934,6 +934,14 @@
 
 	down_write(&md->lock);
 	remove_wait_queue(&md->wait, &wait);
+
+	/* were we interrupted ? */
+	if (atomic_read(&md->pending)) {
+		clear_bit(DMF_BLOCK_IO, &md->flags);
+		up_write(&md->lock);
+		return -EINTR;
+	}
+
 	set_bit(DMF_SUSPENDED, &md->flags);
 
 	map = dm_get_table(md);
