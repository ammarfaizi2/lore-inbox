Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWFNOJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWFNOJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWFNOJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:09:45 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:42050 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964955AbWFNOJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:09:43 -0400
Date: Wed, 14 Jun 2006 16:01:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 10/24] s390: modular 3270 driver.
Message-ID: <20060614140142.GK9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] modular 3270 driver.

The initial i/o to a 3270 device is done using the static module variables
raw3270_init_data and raw3270_init_request. If the 3270 device driver is
built as a module and gets loaded above 2GB, the initial i/o will fail
because these variables will get addresses > 2GB. To make it work the
two variables are moved to struct raw3270 and the data structure is
allocated with GFP_DMA.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/raw3270.c |   65 ++++++++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 32 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2006-06-14 14:29:44.000000000 +0200
@@ -50,6 +50,9 @@ struct raw3270 {
 	unsigned char *ascebc;		/* ascii -> ebcdic table */
 	struct class_device *clttydev;	/* 3270-class tty device ptr */
 	struct class_device *cltubdev;	/* 3270-class tub device ptr */
+
+	struct raw3270_request init_request;
+	unsigned char init_data[256];
 };
 
 /* raw3270->flags */
@@ -484,8 +487,6 @@ struct raw3270_ua {	/* Query Reply struc
 	} __attribute__ ((packed)) aua;
 } __attribute__ ((packed));
 
-static unsigned char raw3270_init_data[256];
-static struct raw3270_request raw3270_init_request;
 static struct diag210 raw3270_init_diag210;
 static DECLARE_MUTEX(raw3270_init_sem);
 
@@ -644,17 +645,17 @@ __raw3270_size_device(struct raw3270 *rp
 	 * required (3270 device switched to 'stand-by') and command
 	 * rejects (old devices that can't do 'read partition').
 	 */
-	memset(&raw3270_init_request, 0, sizeof(raw3270_init_request));
-	memset(raw3270_init_data, 0, sizeof(raw3270_init_data));
-	/* Store 'read partition' data stream to raw3270_init_data */
-	memcpy(raw3270_init_data, wbuf, sizeof(wbuf));
-	INIT_LIST_HEAD(&raw3270_init_request.list);
-	raw3270_init_request.ccw.cmd_code = TC_WRITESF;
-	raw3270_init_request.ccw.flags = CCW_FLAG_SLI;
-	raw3270_init_request.ccw.count = sizeof(wbuf);
-	raw3270_init_request.ccw.cda = (__u32) __pa(raw3270_init_data);
+	memset(&rp->init_request, 0, sizeof(rp->init_request));
+	memset(&rp->init_data, 0, 256);
+	/* Store 'read partition' data stream to init_data */
+	memcpy(&rp->init_data, wbuf, sizeof(wbuf));
+	INIT_LIST_HEAD(&rp->init_request.list);
+	rp->init_request.ccw.cmd_code = TC_WRITESF;
+	rp->init_request.ccw.flags = CCW_FLAG_SLI;
+	rp->init_request.ccw.count = sizeof(wbuf);
+	rp->init_request.ccw.cda = (__u32) __pa(&rp->init_data);
 
-	rc = raw3270_start_init(rp, &raw3270_init_view, &raw3270_init_request);
+	rc = raw3270_start_init(rp, &raw3270_init_view, &rp->init_request);
 	if (rc)
 		/* Check error cases: -ERESTARTSYS, -EIO and -EOPNOTSUPP */
 		return rc;
@@ -679,18 +680,18 @@ __raw3270_size_device(struct raw3270 *rp
 	 * The device accepted the 'read partition' command. Now
 	 * set up a read ccw and issue it.
 	 */
-	raw3270_init_request.ccw.cmd_code = TC_READMOD;
-	raw3270_init_request.ccw.flags = CCW_FLAG_SLI;
-	raw3270_init_request.ccw.count = sizeof(raw3270_init_data);
-	raw3270_init_request.ccw.cda = (__u32) __pa(raw3270_init_data);
-	rc = raw3270_start_init(rp, &raw3270_init_view, &raw3270_init_request);
+	rp->init_request.ccw.cmd_code = TC_READMOD;
+	rp->init_request.ccw.flags = CCW_FLAG_SLI;
+	rp->init_request.ccw.count = sizeof(rp->init_data);
+	rp->init_request.ccw.cda = (__u32) __pa(rp->init_data);
+	rc = raw3270_start_init(rp, &raw3270_init_view, &rp->init_request);
 	if (rc)
 		return rc;
 	/* Got a Query Reply */
-	count = sizeof(raw3270_init_data) - raw3270_init_request.rescnt;
-	uap = (struct raw3270_ua *) (raw3270_init_data + 1);
+	count = sizeof(rp->init_data) - rp->init_request.rescnt;
+	uap = (struct raw3270_ua *) (rp->init_data + 1);
 	/* Paranoia check. */
-	if (raw3270_init_data[0] != 0x88 || uap->uab.qcode != 0x81)
+	if (rp->init_data[0] != 0x88 || uap->uab.qcode != 0x81)
 		return -EOPNOTSUPP;
 	/* Copy rows/columns of default Usable Area */
 	rp->rows = uap->uab.h;
@@ -749,18 +750,18 @@ raw3270_reset_device(struct raw3270 *rp)
 	int rc;
 
 	down(&raw3270_init_sem);
-	memset(&raw3270_init_request, 0, sizeof(raw3270_init_request));
-	memset(raw3270_init_data, 0, sizeof(raw3270_init_data));
-	/* Store reset data stream to raw3270_init_data/raw3270_init_request */
-	raw3270_init_data[0] = TW_KR;
-	INIT_LIST_HEAD(&raw3270_init_request.list);
-	raw3270_init_request.ccw.cmd_code = TC_EWRITEA;
-	raw3270_init_request.ccw.flags = CCW_FLAG_SLI;
-	raw3270_init_request.ccw.count = 1;
-	raw3270_init_request.ccw.cda = (__u32) __pa(raw3270_init_data);
+	memset(&rp->init_request, 0, sizeof(rp->init_request));
+	memset(&rp->init_data, 0, sizeof(rp->init_data));
+	/* Store reset data stream to init_data/init_request */
+	rp->init_data[0] = TW_KR;
+	INIT_LIST_HEAD(&rp->init_request.list);
+	rp->init_request.ccw.cmd_code = TC_EWRITEA;
+	rp->init_request.ccw.flags = CCW_FLAG_SLI;
+	rp->init_request.ccw.count = 1;
+	rp->init_request.ccw.cda = (__u32) __pa(rp->init_data);
 	rp->view = &raw3270_init_view;
 	raw3270_init_view.dev = rp;
-	rc = raw3270_start_init(rp, &raw3270_init_view, &raw3270_init_request);
+	rc = raw3270_start_init(rp, &raw3270_init_view, &rp->init_request);
 	raw3270_init_view.dev = 0;
 	rp->view = 0;
 	up(&raw3270_init_sem);
@@ -854,7 +855,7 @@ raw3270_setup_console(struct ccw_device 
 	char *ascebc;
 	int rc;
 
-	rp = (struct raw3270 *) alloc_bootmem(sizeof(struct raw3270));
+	rp = (struct raw3270 *) alloc_bootmem_low(sizeof(struct raw3270));
 	ascebc = (char *) alloc_bootmem(256);
 	rc = raw3270_setup_device(cdev, rp, ascebc);
 	if (rc)
@@ -895,7 +896,7 @@ raw3270_create_device(struct ccw_device 
 	char *ascebc;
 	int rc;
 
-	rp = kmalloc(sizeof(struct raw3270), GFP_KERNEL);
+	rp = kmalloc(sizeof(struct raw3270), GFP_KERNEL | GFP_DMA);
 	if (!rp)
 		return ERR_PTR(-ENOMEM);
 	ascebc = kmalloc(256, GFP_KERNEL);
