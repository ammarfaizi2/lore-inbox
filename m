Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVH2R5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVH2R5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVH2R5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:57:50 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:13516 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751251AbVH2R5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:57:30 -0400
Date: Mon, 29 Aug 2005 19:57:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 10/10] s390: disconnected 3270 console.
Message-ID: <20050829175725.GJ6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 10/10] s390: disconnected 3270 console.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix reboot with a disconnected 3270 console.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/raw3270.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2005-08-29 19:18:13.000000000 +0200
@@ -632,12 +632,9 @@ __raw3270_size_device(struct raw3270 *rp
 	raw3270_init_request.ccw.cda = (__u32) __pa(raw3270_init_data);
 
 	rc = raw3270_start_init(rp, &raw3270_init_view, &raw3270_init_request);
-	if (rc) {
+	if (rc)
 		/* Check error cases: -ERESTARTSYS, -EIO and -EOPNOTSUPP */
-		if (rc == -EOPNOTSUPP && MACHINE_IS_VM)
-			return __raw3270_size_device_vm(rp);
 		return rc;
-	}
 
 	/* Wait for attention interrupt. */
 #ifdef CONFIG_TN3270_CONSOLE
@@ -695,7 +692,10 @@ raw3270_size_device(struct raw3270 *rp)
 	down(&raw3270_init_sem);
 	rp->view = &raw3270_init_view;
 	raw3270_init_view.dev = rp;
-	rc = __raw3270_size_device(rp);
+	if (MACHINE_IS_VM)
+		rc = __raw3270_size_device_vm(rp);
+	else
+		rc = __raw3270_size_device(rp);
 	raw3270_init_view.dev = 0;
 	rp->view = 0;
 	up(&raw3270_init_sem);
@@ -710,6 +710,12 @@ raw3270_size_device(struct raw3270 *rp)
 			rp->model = 4;
 		if (rp->rows == 27 && rp->cols == 132)
 			rp->model = 5;
+	} else {
+		/* Couldn't detect size. Use default model 2. */
+		rp->model = 2;
+		rp->rows = 24;
+		rp->cols = 80;
+		return 0;
 	}
 	return rc;
 }
