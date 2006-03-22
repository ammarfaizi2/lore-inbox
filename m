Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWCVP0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWCVP0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWCVP0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:26:53 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:22964 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751322AbWCVP0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:26:51 -0500
Date: Wed, 22 Mar 2006 16:27:17 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, snakebyte@gmx.de, linux-kernel@vger.kernel.org
Subject: [patch 24/24] s390: kzalloc() conversion in drivers/s390.
Message-ID: <20060322152717.GX5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

[patch 24/24] s390: kzalloc() conversion in drivers/s390.

Convert all kmalloc + memset sequences in drivers/s390 to kzalloc usage.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c      |   12 ++++--------
 drivers/s390/block/dcssblk.c   |    3 +--
 drivers/s390/char/fs3270.c     |    3 +--
 drivers/s390/char/keyboard.c   |   12 ++++--------
 drivers/s390/char/monreader.c  |    6 ++----
 drivers/s390/char/raw3270.c    |    3 +--
 drivers/s390/char/tape_class.c |    3 +--
 drivers/s390/char/tape_core.c  |   16 +++++-----------
 drivers/s390/char/tty3270.c    |    9 +++------
 drivers/s390/char/vmlogrdr.c   |    3 +--
 drivers/s390/cio/ccwgroup.c    |    3 +--
 drivers/s390/cio/chsc.c        |    3 +--
 drivers/s390/cio/css.c         |    3 +--
 drivers/s390/cio/device.c      |    6 ++----
 drivers/s390/cio/device_ops.c  |    9 +++------
 drivers/s390/cio/qdio.c        |   20 +++++++-------------
 drivers/s390/crypto/z90main.c  |   10 +++-------
 drivers/s390/net/claw.c        |    3 +--
 drivers/s390/net/fsm.c         |   10 +++-------
 drivers/s390/net/iucv.c        |   11 ++++-------
 drivers/s390/net/lcs.c         |   11 ++++-------
 drivers/s390/net/netiucv.c     |    7 ++-----
 drivers/s390/net/qeth_eddp.c   |   13 ++++---------
 drivers/s390/net/qeth_main.c   |   20 ++++++--------------
 drivers/s390/net/qeth_sys.c    |    3 +--
 drivers/s390/s390_rdev.c       |    3 +--
 26 files changed, 67 insertions(+), 138 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-03-22 14:36:30.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-03-22 14:36:43.000000000 +0100
@@ -71,10 +71,9 @@ dasd_alloc_device(void)
 {
 	struct dasd_device *device;
 
-	device = kmalloc(sizeof (struct dasd_device), GFP_ATOMIC);
+	device = kzalloc(sizeof (struct dasd_device), GFP_ATOMIC);
 	if (device == NULL)
 		return ERR_PTR(-ENOMEM);
-	memset(device, 0, sizeof (struct dasd_device));
 	/* open_count = 0 means device online but not in use */
 	atomic_set(&device->open_count, -1);
 
@@ -547,29 +546,26 @@ dasd_kmalloc_request(char *magic, int cp
 	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE)
 		BUG();
 
-	cqr = kmalloc(sizeof(struct dasd_ccw_req), GFP_ATOMIC);
+	cqr = kzalloc(sizeof(struct dasd_ccw_req), GFP_ATOMIC);
 	if (cqr == NULL)
 		return ERR_PTR(-ENOMEM);
-	memset(cqr, 0, sizeof(struct dasd_ccw_req));
 	cqr->cpaddr = NULL;
 	if (cplength > 0) {
-		cqr->cpaddr = kmalloc(cplength*sizeof(struct ccw1),
+		cqr->cpaddr = kcalloc(cplength, sizeof(struct ccw1),
 				      GFP_ATOMIC | GFP_DMA);
 		if (cqr->cpaddr == NULL) {
 			kfree(cqr);
 			return ERR_PTR(-ENOMEM);
 		}
-		memset(cqr->cpaddr, 0, cplength*sizeof(struct ccw1));
 	}
 	cqr->data = NULL;
 	if (datasize > 0) {
-		cqr->data = kmalloc(datasize, GFP_ATOMIC | GFP_DMA);
+		cqr->data = kzalloc(datasize, GFP_ATOMIC | GFP_DMA);
 		if (cqr->data == NULL) {
 			kfree(cqr->cpaddr);
 			kfree(cqr);
 			return ERR_PTR(-ENOMEM);
 		}
-		memset(cqr->data, 0, datasize);
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
diff -urpN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-patched/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dcssblk.c	2006-03-22 14:36:43.000000000 +0100
@@ -388,12 +388,11 @@ dcssblk_add_store(struct device *dev, st
 	/*
 	 * get a struct dcssblk_dev_info
 	 */
-	dev_info = kmalloc(sizeof(struct dcssblk_dev_info), GFP_KERNEL);
+	dev_info = kzalloc(sizeof(struct dcssblk_dev_info), GFP_KERNEL);
 	if (dev_info == NULL) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(dev_info, 0, sizeof(struct dcssblk_dev_info));
 
 	strcpy(dev_info->segment_name, local_buf);
 	strlcpy(dev_info->dev.bus_id, local_buf, BUS_ID_SIZE);
diff -urpN linux-2.6/drivers/s390/char/fs3270.c linux-2.6-patched/drivers/s390/char/fs3270.c
--- linux-2.6/drivers/s390/char/fs3270.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/fs3270.c	2006-03-22 14:36:43.000000000 +0100
@@ -368,10 +368,9 @@ fs3270_alloc_view(void)
 {
 	struct fs3270 *fp;
 
-	fp = (struct fs3270 *) kmalloc(sizeof(struct fs3270),GFP_KERNEL);
+	fp = kzalloc(sizeof(struct fs3270),GFP_KERNEL);
 	if (!fp)
 		return ERR_PTR(-ENOMEM);
-	memset(fp, 0, sizeof(struct fs3270));
 	fp->init = raw3270_request_alloc(0);
 	if (IS_ERR(fp->init)) {
 		kfree(fp);
diff -urpN linux-2.6/drivers/s390/char/keyboard.c linux-2.6-patched/drivers/s390/char/keyboard.c
--- linux-2.6/drivers/s390/char/keyboard.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/keyboard.c	2006-03-22 14:36:43.000000000 +0100
@@ -50,14 +50,12 @@ kbd_alloc(void) {
 	struct kbd_data *kbd;
 	int i, len;
 
-	kbd = kmalloc(sizeof(struct kbd_data), GFP_KERNEL);
+	kbd = kzalloc(sizeof(struct kbd_data), GFP_KERNEL);
 	if (!kbd)
 		goto out;
-	memset(kbd, 0, sizeof(struct kbd_data));
-	kbd->key_maps = kmalloc(sizeof(key_maps), GFP_KERNEL);
+	kbd->key_maps = kzalloc(sizeof(key_maps), GFP_KERNEL);
 	if (!key_maps)
 		goto out_kbd;
-	memset(kbd->key_maps, 0, sizeof(key_maps));
 	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
 		if (key_maps[i]) {
 			kbd->key_maps[i] =
@@ -68,10 +66,9 @@ kbd_alloc(void) {
 			       sizeof(u_short)*NR_KEYS);
 		}
 	}
-	kbd->func_table = kmalloc(sizeof(func_table), GFP_KERNEL);
+	kbd->func_table = kzalloc(sizeof(func_table), GFP_KERNEL);
 	if (!kbd->func_table)
 		goto out_maps;
-	memset(kbd->func_table, 0, sizeof(func_table));
 	for (i = 0; i < ARRAY_SIZE(func_table); i++) {
 		if (func_table[i]) {
 			len = strlen(func_table[i]) + 1;
@@ -82,10 +79,9 @@ kbd_alloc(void) {
 		}
 	}
 	kbd->fn_handler =
-		kmalloc(sizeof(fn_handler_fn *) * NR_FN_HANDLER, GFP_KERNEL);
+		kzalloc(sizeof(fn_handler_fn *) * NR_FN_HANDLER, GFP_KERNEL);
 	if (!kbd->fn_handler)
 		goto out_func;
-	memset(kbd->fn_handler, 0, sizeof(fn_handler_fn *) * NR_FN_HANDLER);
 	kbd->accent_table =
 		kmalloc(sizeof(struct kbdiacr)*MAX_DIACR, GFP_KERNEL);
 	if (!kbd->accent_table)
diff -urpN linux-2.6/drivers/s390/char/monreader.c linux-2.6-patched/drivers/s390/char/monreader.c
--- linux-2.6/drivers/s390/char/monreader.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/monreader.c	2006-03-22 14:36:43.000000000 +0100
@@ -257,14 +257,13 @@ mon_alloc_mem(void)
 	int i,j;
 	struct mon_private *monpriv;
 
-	monpriv = kmalloc(sizeof(struct mon_private), GFP_KERNEL);
+	monpriv = kzalloc(sizeof(struct mon_private), GFP_KERNEL);
 	if (!monpriv) {
 		P_ERROR("no memory for monpriv\n");
 		return NULL;
 	}
-	memset(monpriv, 0, sizeof(struct mon_private));
 	for (i = 0; i < MON_MSGLIM; i++) {
-		monpriv->msg_array[i] = kmalloc(sizeof(struct mon_msg),
+		monpriv->msg_array[i] = kzalloc(sizeof(struct mon_msg),
 						    GFP_KERNEL);
 		if (!monpriv->msg_array[i]) {
 			P_ERROR("open, no memory for msg_array\n");
@@ -272,7 +271,6 @@ mon_alloc_mem(void)
 				kfree(monpriv->msg_array[j]);
 			return NULL;
 		}
-		memset(monpriv->msg_array[i], 0, sizeof(struct mon_msg));
 	}
 	return monpriv;
 }
diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2006-03-22 14:36:43.000000000 +0100
@@ -115,10 +115,9 @@ raw3270_request_alloc(size_t size)
 	struct raw3270_request *rq;
 
 	/* Allocate request structure */
-	rq = kmalloc(sizeof(struct raw3270_request), GFP_KERNEL | GFP_DMA);
+	rq = kzalloc(sizeof(struct raw3270_request), GFP_KERNEL | GFP_DMA);
 	if (!rq)
 		return ERR_PTR(-ENOMEM);
-	memset(rq, 0, sizeof(struct raw3270_request));
 
 	/* alloc output buffer. */
 	if (size > 0) {
diff -urpN linux-2.6/drivers/s390/char/tape_class.c linux-2.6-patched/drivers/s390/char/tape_class.c
--- linux-2.6/drivers/s390/char/tape_class.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_class.c	2006-03-22 14:36:43.000000000 +0100
@@ -44,11 +44,10 @@ struct tape_class_device *register_tape_
 	int		rc;
 	char *		s;
 
-	tcd = kmalloc(sizeof(struct tape_class_device), GFP_KERNEL);
+	tcd = kzalloc(sizeof(struct tape_class_device), GFP_KERNEL);
 	if (!tcd)
 		return ERR_PTR(-ENOMEM);
 
-	memset(tcd, 0, sizeof(struct tape_class_device));
 	strncpy(tcd->device_name, device_name, TAPECLASS_NAME_LEN);
 	for (s = strchr(tcd->device_name, '/'); s; s = strchr(s, '/'))
 		*s = '!';
diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-03-22 14:36:36.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-03-22 14:36:43.000000000 +0100
@@ -453,16 +453,14 @@ tape_alloc_device(void)
 {
 	struct tape_device *device;
 
-	device = (struct tape_device *)
-		kmalloc(sizeof(struct tape_device), GFP_KERNEL);
+	device = kzalloc(sizeof(struct tape_device), GFP_KERNEL);
 	if (device == NULL) {
 		DBF_EXCEPTION(2, "ti:no mem\n");
 		PRINT_INFO ("can't allocate memory for "
 			    "tape info structure\n");
 		return ERR_PTR(-ENOMEM);
 	}
-	memset(device, 0, sizeof(struct tape_device));
-	device->modeset_byte = (char *) kmalloc(1, GFP_KERNEL | GFP_DMA);
+	device->modeset_byte = kmalloc(1, GFP_KERNEL | GFP_DMA);
 	if (device->modeset_byte == NULL) {
 		DBF_EXCEPTION(2, "ti:no mem\n");
 		PRINT_INFO("can't allocate memory for modeset byte\n");
@@ -659,34 +657,30 @@ tape_alloc_request(int cplength, int dat
 
 	DBF_LH(6, "tape_alloc_request(%d, %d)\n", cplength, datasize);
 
-	request = (struct tape_request *) kmalloc(sizeof(struct tape_request),
-						  GFP_KERNEL);
+	request = kzalloc(sizeof(struct tape_request), GFP_KERNEL);
 	if (request == NULL) {
 		DBF_EXCEPTION(1, "cqra nomem\n");
 		return ERR_PTR(-ENOMEM);
 	}
-	memset(request, 0, sizeof(struct tape_request));
 	/* allocate channel program */
 	if (cplength > 0) {
-		request->cpaddr = kmalloc(cplength*sizeof(struct ccw1),
+		request->cpaddr = kcalloc(cplength, sizeof(struct ccw1),
 					  GFP_ATOMIC | GFP_DMA);
 		if (request->cpaddr == NULL) {
 			DBF_EXCEPTION(1, "cqra nomem\n");
 			kfree(request);
 			return ERR_PTR(-ENOMEM);
 		}
-		memset(request->cpaddr, 0, cplength*sizeof(struct ccw1));
 	}
 	/* alloc small kernel buffer */
 	if (datasize > 0) {
-		request->cpdata = kmalloc(datasize, GFP_KERNEL | GFP_DMA);
+		request->cpdata = kzalloc(datasize, GFP_KERNEL | GFP_DMA);
 		if (request->cpdata == NULL) {
 			DBF_EXCEPTION(1, "cqra nomem\n");
 			kfree(request->cpaddr);
 			kfree(request);
 			return ERR_PTR(-ENOMEM);
 		}
-		memset(request->cpdata, 0, datasize);
 	}
 	DBF_LH(6, "New request %p(%p/%p)\n", request, request->cpaddr,
 		request->cpdata);
diff -urpN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-patched/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tty3270.c	2006-03-22 14:36:43.000000000 +0100
@@ -691,10 +691,9 @@ tty3270_alloc_view(void)
 	struct tty3270 *tp;
 	int pages;
 
-	tp = kmalloc(sizeof(struct tty3270),GFP_KERNEL);
+	tp = kzalloc(sizeof(struct tty3270), GFP_KERNEL);
 	if (!tp)
 		goto out_err;
-	memset(tp, 0, sizeof(struct tty3270));
 	tp->freemem_pages =
 		kmalloc(sizeof(void *) * TTY3270_STRING_PAGES, GFP_KERNEL);
 	if (!tp->freemem_pages)
@@ -767,16 +766,14 @@ tty3270_alloc_screen(struct tty3270 *tp)
 	int lines;
 
 	size = sizeof(struct tty3270_line) * (tp->view.rows - 2);
-	tp->screen = kmalloc(size, GFP_KERNEL);
+	tp->screen = kzalloc(size, GFP_KERNEL);
 	if (!tp->screen)
 		goto out_err;
-	memset(tp->screen, 0, size);
 	for (lines = 0; lines < tp->view.rows - 2; lines++) {
 		size = sizeof(struct tty3270_cell) * tp->view.cols;
-		tp->screen[lines].cells = kmalloc(size, GFP_KERNEL);
+		tp->screen[lines].cells = kzalloc(size, GFP_KERNEL);
 		if (!tp->screen[lines].cells)
 			goto out_screen;
-		memset(tp->screen[lines].cells, 0, size);
 	}
 	return 0;
 out_screen:
diff -urpN linux-2.6/drivers/s390/char/vmlogrdr.c linux-2.6-patched/drivers/s390/char/vmlogrdr.c
--- linux-2.6/drivers/s390/char/vmlogrdr.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/vmlogrdr.c	2006-03-22 14:36:43.000000000 +0100
@@ -759,9 +759,8 @@ vmlogrdr_register_device(struct vmlogrdr
 	struct device *dev;
 	int ret;
 
-	dev = kmalloc(sizeof(struct device), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (dev) {
-		memset(dev, 0, sizeof(struct device));
 		snprintf(dev->bus_id, BUS_ID_SIZE, "%s",
 			 priv->internal_name);
 		dev->bus = &iucv_bus;
diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2006-03-22 14:36:43.000000000 +0100
@@ -157,11 +157,10 @@ ccwgroup_create(struct device *root,
 	if (argc > 256) /* disallow dumb users */
 		return -EINVAL;
 
-	gdev = kmalloc(sizeof(*gdev) + argc*sizeof(gdev->cdev[0]), GFP_KERNEL);
+	gdev = kzalloc(sizeof(*gdev) + argc*sizeof(gdev->cdev[0]), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 
-	memset(gdev, 0, sizeof(*gdev) + argc*sizeof(gdev->cdev[0]));
 	atomic_set(&gdev->onoff, 0);
 
 	del_drvdata = 0;
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-03-22 14:36:12.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-03-22 14:36:43.000000000 +0100
@@ -1413,10 +1413,9 @@ new_channel_path(int chpid)
 	struct channel_path *chp;
 	int ret;
 
-	chp = kmalloc(sizeof(struct channel_path), GFP_KERNEL);
+	chp = kzalloc(sizeof(struct channel_path), GFP_KERNEL);
 	if (!chp)
 		return -ENOMEM;
-	memset(chp, 0, sizeof(struct channel_path));
 
 	/* fill in status, etc. */
 	chp->id = chpid;
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-03-22 14:36:12.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-03-22 14:36:43.000000000 +0100
@@ -630,10 +630,9 @@ css_enqueue_subchannel_slow(struct subch
 	struct slow_subchannel *new_slow_sch;
 	unsigned long flags;
 
-	new_slow_sch = kmalloc(sizeof(struct slow_subchannel), GFP_ATOMIC);
+	new_slow_sch = kzalloc(sizeof(struct slow_subchannel), GFP_ATOMIC);
 	if (!new_slow_sch)
 		return -ENOMEM;
-	memset(new_slow_sch, 0, sizeof(struct slow_subchannel));
 	new_slow_sch->schid = schid;
 	spin_lock_irqsave(&slow_subchannel_lock, flags);
 	list_add_tail(&new_slow_sch->slow_list, &slow_subchannels_head);
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-03-22 14:36:43.000000000 +0100
@@ -826,17 +826,15 @@ io_subchannel_probe (struct subchannel *
 			get_device(&cdev->dev);
 		return 0;
 	}
-	cdev  = kmalloc (sizeof(*cdev), GFP_KERNEL);
+	cdev = kzalloc (sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return -ENOMEM;
-	memset(cdev, 0, sizeof(struct ccw_device));
-	cdev->private = kmalloc(sizeof(struct ccw_device_private), 
+	cdev->private = kzalloc(sizeof(struct ccw_device_private),
 				GFP_KERNEL | GFP_DMA);
 	if (!cdev->private) {
 		kfree(cdev);
 		return -ENOMEM;
 	}
-	memset(cdev->private, 0, sizeof(struct ccw_device_private));
 	atomic_set(&cdev->private->onoff, 0);
 	cdev->dev = (struct device) {
 		.parent = &sch->dev,
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-03-22 14:36:43.000000000 +0100
@@ -359,10 +359,9 @@ read_dev_chars (struct ccw_device *cdev,
 	CIO_TRACE_EVENT (4, "rddevch");
 	CIO_TRACE_EVENT (4, sch->dev.bus_id);
 
-	rdc_ccw = kmalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	rdc_ccw = kzalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
 	if (!rdc_ccw)
 		return -ENOMEM;
-	memset(rdc_ccw, 0, sizeof(struct ccw1));
 	rdc_ccw->cmd_code = CCW_CMD_RDC;
 	rdc_ccw->count = length;
 	rdc_ccw->flags = CCW_FLAG_SLI;
@@ -426,16 +425,14 @@ read_conf_data_lpm (struct ccw_device *c
 	if (!ciw || ciw->cmd == 0)
 		return -EOPNOTSUPP;
 
-	rcd_ccw = kmalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	rcd_ccw = kzalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
 	if (!rcd_ccw)
 		return -ENOMEM;
-	memset(rcd_ccw, 0, sizeof(struct ccw1));
-	rcd_buf = kmalloc(ciw->count, GFP_KERNEL | GFP_DMA);
+	rcd_buf = kzalloc(ciw->count, GFP_KERNEL | GFP_DMA);
  	if (!rcd_buf) {
 		kfree(rcd_ccw);
 		return -ENOMEM;
 	}
- 	memset (rcd_buf, 0, ciw->count);
 	rcd_ccw->cmd_code = ciw->cmd;
 	rcd_ccw->cda = (__u32) __pa (rcd_buf);
 	rcd_ccw->count = ciw->count;
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-03-22 14:36:43.000000000 +0100
@@ -1686,16 +1686,14 @@ qdio_alloc_qs(struct qdio_irq *irq_ptr,
 	int result=-ENOMEM;
 
 	for (i=0;i<no_input_qs;i++) {
-		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL);
+		q = kzalloc(sizeof(struct qdio_q), GFP_KERNEL);
 
 		if (!q) {
 			QDIO_PRINT_ERR("kmalloc of q failed!\n");
 			goto out;
 		}
 
-		memset(q,0,sizeof(struct qdio_q));
-
-		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
+		q->slib = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!q->slib) {
 			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
 			goto out;
@@ -1705,14 +1703,12 @@ qdio_alloc_qs(struct qdio_irq *irq_ptr,
 	}
 
 	for (i=0;i<no_output_qs;i++) {
-		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL);
+		q = kzalloc(sizeof(struct qdio_q), GFP_KERNEL);
 
 		if (!q) {
 			goto out;
 		}
 
-		memset(q,0,sizeof(struct qdio_q));
-
 		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
 		if (!q->slib) {
 			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
@@ -2984,7 +2980,7 @@ qdio_allocate(struct qdio_initialize *in
 	qdio_allocate_do_dbf(init_data);
 
 	/* create irq */
-	irq_ptr=kmalloc(sizeof(struct qdio_irq), GFP_KERNEL | GFP_DMA);
+	irq_ptr = kzalloc(sizeof(struct qdio_irq), GFP_KERNEL | GFP_DMA);
 
 	QDIO_DBF_TEXT0(0,setup,"irq_ptr:");
 	QDIO_DBF_HEX0(0,setup,&irq_ptr,sizeof(void*));
@@ -2994,8 +2990,6 @@ qdio_allocate(struct qdio_initialize *in
 		return -ENOMEM;
 	}
 
-	memset(irq_ptr,0,sizeof(struct qdio_irq));
-
 	init_MUTEX(&irq_ptr->setting_up_sema);
 
 	/* QDR must be in DMA area since CCW data address is only 32 bit */
@@ -3686,10 +3680,10 @@ qdio_get_qdio_memory(void)
 
 	for (i=1;i<INDICATORS_PER_CACHELINE;i++)
 		indicator_used[i]=0;
-	indicators=(__u32*)kmalloc(sizeof(__u32)*(INDICATORS_PER_CACHELINE),
+	indicators = kzalloc(sizeof(__u32)*(INDICATORS_PER_CACHELINE),
 				   GFP_KERNEL);
-       	if (!indicators) return -ENOMEM;
-	memset(indicators,0,sizeof(__u32)*(INDICATORS_PER_CACHELINE));
+       	if (!indicators)
+		return -ENOMEM;
 	return 0;
 }
 
diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2006-03-22 14:36:41.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2006-03-22 14:36:43.000000000 +0100
@@ -707,13 +707,12 @@ z90crypt_open(struct inode *inode, struc
 	if (quiesce_z90crypt)
 		return -EQUIESCE;
 
-	private_data_p = kmalloc(sizeof(struct priv_data), GFP_KERNEL);
+	private_data_p = kzalloc(sizeof(struct priv_data), GFP_KERNEL);
 	if (!private_data_p) {
 		PRINTK("Memory allocate failed\n");
 		return -ENOMEM;
 	}
 
-	memset((void *)private_data_p, 0, sizeof(struct priv_data));
 	private_data_p->status = STAT_OPEN;
 	private_data_p->opener_pid = PID();
 	filp->private_data = private_data_p;
@@ -2737,13 +2736,11 @@ create_z90crypt(int *cdx_p)
 	z90crypt.max_count = Z90CRYPT_NUM_DEVS;
 	z90crypt.cdx = *cdx_p;
 
-	hdware_blk_p = (struct hdware_block *)
-		kmalloc(sizeof(struct hdware_block), GFP_ATOMIC);
+	hdware_blk_p = kzalloc(sizeof(struct hdware_block), GFP_ATOMIC);
 	if (!hdware_blk_p) {
 		PDEBUG("kmalloc for hardware block failed\n");
 		return ENOMEM;
 	}
-	memset(hdware_blk_p, 0x00, sizeof(struct hdware_block));
 	z90crypt.hdware_info = hdware_blk_p;
 
 	return 0;
@@ -2978,12 +2975,11 @@ create_crypto_device(int index)
 		total_size = sizeof(struct device) +
 			     z90crypt.q_depth_array[index] * sizeof(int);
 
-		dev_ptr = (struct device *) kmalloc(total_size, GFP_ATOMIC);
+		dev_ptr = kzalloc(total_size, GFP_ATOMIC);
 		if (!dev_ptr) {
 			PRINTK("kmalloc device %d failed\n", index);
 			return ENOMEM;
 		}
-		memset(dev_ptr, 0, total_size);
 		dev_ptr->dev_resp_p = kmalloc(MAX_RESPONSE_SIZE, GFP_ATOMIC);
 		if (!dev_ptr->dev_resp_p) {
 			kfree(dev_ptr);
diff -urpN linux-2.6/drivers/s390/net/claw.c linux-2.6-patched/drivers/s390/net/claw.c
--- linux-2.6/drivers/s390/net/claw.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/claw.c	2006-03-22 14:36:43.000000000 +0100
@@ -310,7 +310,7 @@ claw_probe(struct ccwgroup_device *cgdev
         printk(KERN_INFO "claw: variable cgdev =\n");
         dumpit((char *)cgdev, sizeof(struct ccwgroup_device));
 #endif
-	privptr = kmalloc(sizeof(struct claw_privbk), GFP_KERNEL);
+	privptr = kzalloc(sizeof(struct claw_privbk), GFP_KERNEL);
 	if (privptr == NULL) {
 		probe_error(cgdev);
 		put_device(&cgdev->dev);
@@ -319,7 +319,6 @@ claw_probe(struct ccwgroup_device *cgdev
 		CLAW_DBF_TEXT_(2,setup,"probex%d",-ENOMEM);
 		return -ENOMEM;
 	}
-	memset(privptr,0x00,sizeof(struct claw_privbk));
 	privptr->p_mtc_envelope= kmalloc( MAX_ENVELOPE_SIZE, GFP_KERNEL);
 	privptr->p_env = kmalloc(sizeof(struct claw_env), GFP_KERNEL);
         if ((privptr->p_mtc_envelope==NULL) || (privptr->p_env==NULL)) {
diff -urpN linux-2.6/drivers/s390/net/fsm.c linux-2.6-patched/drivers/s390/net/fsm.c
--- linux-2.6/drivers/s390/net/fsm.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/fsm.c	2006-03-22 14:36:43.000000000 +0100
@@ -21,38 +21,34 @@ init_fsm(char *name, const char **state_
 	fsm_function_t *m;
 	fsm *f;
 
-	this = (fsm_instance *)kmalloc(sizeof(fsm_instance), order);
+	this = kzalloc(sizeof(fsm_instance), order);
 	if (this == NULL) {
 		printk(KERN_WARNING
 			"fsm(%s): init_fsm: Couldn't alloc instance\n", name);
 		return NULL;
 	}
-	memset(this, 0, sizeof(fsm_instance));
 	strlcpy(this->name, name, sizeof(this->name));
 
-	f = (fsm *)kmalloc(sizeof(fsm), order);
+	f = kzalloc(sizeof(fsm), order);
 	if (f == NULL) {
 		printk(KERN_WARNING
 			"fsm(%s): init_fsm: Couldn't alloc fsm\n", name);
 		kfree_fsm(this);
 		return NULL;
 	}
-	memset(f, 0, sizeof(fsm));
 	f->nr_events = nr_events;
 	f->nr_states = nr_states;
 	f->event_names = event_names;
 	f->state_names = state_names;
 	this->f = f;
 
-	m = (fsm_function_t *)kmalloc(
-			sizeof(fsm_function_t) * nr_states * nr_events, order);
+	m = kcalloc(nr_states*nr_events, sizeof(fsm_function_t), order);
 	if (m == NULL) {
 		printk(KERN_WARNING
 			"fsm(%s): init_fsm: Couldn't alloc jumptable\n", name);
 		kfree_fsm(this);
 		return NULL;
 	}
-	memset(m, 0, sizeof(fsm_function_t) * f->nr_states * f->nr_events);
 	f->jumpmatrix = m;
 
 	for (i = 0; i < tmpl_len; i++) {
diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2006-03-22 14:36:43.000000000 +0100
@@ -386,7 +386,7 @@ iucv_init(void)
 	}
 
 	/* Note: GFP_DMA used used to get memory below 2G */
-	iucv_external_int_buffer = kmalloc(sizeof(iucv_GeneralInterrupt),
+	iucv_external_int_buffer = kzalloc(sizeof(iucv_GeneralInterrupt),
 					   GFP_KERNEL|GFP_DMA);
 	if (!iucv_external_int_buffer) {
 		printk(KERN_WARNING
@@ -396,10 +396,9 @@ iucv_init(void)
 		bus_unregister(&iucv_bus);
 		return -ENOMEM;
 	}
-	memset(iucv_external_int_buffer, 0, sizeof(iucv_GeneralInterrupt));
 
 	/* Initialize parameter pool */
-	iucv_param_pool = kmalloc(sizeof(iucv_param) * PARAM_POOL_SIZE,
+	iucv_param_pool = kzalloc(sizeof(iucv_param) * PARAM_POOL_SIZE,
 				  GFP_KERNEL|GFP_DMA);
 	if (!iucv_param_pool) {
 		printk(KERN_WARNING "%s: Could not allocate param pool\n",
@@ -410,7 +409,6 @@ iucv_init(void)
 		bus_unregister(&iucv_bus);
 		return -ENOMEM;
 	}
-	memset(iucv_param_pool, 0, sizeof(iucv_param) * PARAM_POOL_SIZE);
 
 	/* Initialize irq queue */
 	INIT_LIST_HEAD(&iucv_irq_queue);
@@ -793,15 +791,14 @@ iucv_register_program (__u8 pgmname[16],
 		}
 
 		max_connections = iucv_query_maxconn();
-		iucv_pathid_table = kmalloc(max_connections * sizeof(handler *),
-				       GFP_ATOMIC);
+		iucv_pathid_table = kcalloc(max_connections, sizeof(handler *),
+					GFP_ATOMIC);
 		if (iucv_pathid_table == NULL) {
 			printk(KERN_WARNING "%s: iucv_pathid_table storage "
 			       "allocation failed\n", __FUNCTION__);
 			kfree(new_handler);
 			return NULL;
 		}
-		memset (iucv_pathid_table, 0, max_connections * sizeof(handler *));
 	}
 	memset(new_handler, 0, sizeof (handler));
 	memcpy(new_handler->id.user_data, pgmname,
diff -urpN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2006-03-22 14:36:43.000000000 +0100
@@ -115,11 +115,10 @@ lcs_alloc_channel(struct lcs_channel *ch
 	LCS_DBF_TEXT(2, setup, "ichalloc");
 	for (cnt = 0; cnt < LCS_NUM_BUFFS; cnt++) {
 		/* alloc memory fo iobuffer */
-		channel->iob[cnt].data = (void *)
-			kmalloc(LCS_IOBUFFERSIZE, GFP_DMA | GFP_KERNEL);
+		channel->iob[cnt].data =
+			kzalloc(LCS_IOBUFFERSIZE, GFP_DMA | GFP_KERNEL);
 		if (channel->iob[cnt].data == NULL)
 			break;
-		memset(channel->iob[cnt].data, 0, LCS_IOBUFFERSIZE);
 		channel->iob[cnt].state = BUF_STATE_EMPTY;
 	}
 	if (cnt < LCS_NUM_BUFFS) {
@@ -182,10 +181,9 @@ lcs_alloc_card(void)
 
 	LCS_DBF_TEXT(2, setup, "alloclcs");
 
-	card = kmalloc(sizeof(struct lcs_card), GFP_KERNEL | GFP_DMA);
+	card = kzalloc(sizeof(struct lcs_card), GFP_KERNEL | GFP_DMA);
 	if (card == NULL)
 		return NULL;
-	memset(card, 0, sizeof(struct lcs_card));
 	card->lan_type = LCS_FRAME_TYPE_AUTO;
 	card->pkt_seq = 0;
 	card->lancmd_timeout = LCS_LANCMD_TIMEOUT_DEFAULT;
@@ -793,10 +791,9 @@ lcs_alloc_reply(struct lcs_cmd *cmd)
 
 	LCS_DBF_TEXT(4, trace, "getreply");
 
-	reply = kmalloc(sizeof(struct lcs_reply), GFP_ATOMIC);
+	reply = kzalloc(sizeof(struct lcs_reply), GFP_ATOMIC);
 	if (!reply)
 		return NULL;
-	memset(reply,0,sizeof(struct lcs_reply));
 	atomic_set(&reply->refcnt,1);
 	reply->sequence_no = cmd->sequence_no;
 	reply->received = 0;
diff -urpN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-patched/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/netiucv.c	2006-03-22 14:36:43.000000000 +0100
@@ -1728,14 +1728,13 @@ static int
 netiucv_register_device(struct net_device *ndev)
 {
 	struct netiucv_priv *priv = ndev->priv;
-	struct device *dev = kmalloc(sizeof(struct device), GFP_KERNEL);
+	struct device *dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	int ret;
 
 
 	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	if (dev) {
-		memset(dev, 0, sizeof(struct device));
 		snprintf(dev->bus_id, BUS_ID_SIZE, "net%s", ndev->name);
 		dev->bus = &iucv_bus;
 		dev->parent = iucv_root;
@@ -1784,11 +1783,9 @@ netiucv_new_connection(struct net_device
 {
 	struct iucv_connection **clist = &iucv_connections;
 	struct iucv_connection *conn =
-		(struct iucv_connection *)
-		kmalloc(sizeof(struct iucv_connection), GFP_KERNEL);
+		kzalloc(sizeof(struct iucv_connection), GFP_KERNEL);
 
 	if (conn) {
-		memset(conn, 0, sizeof(struct iucv_connection));
 		skb_queue_head_init(&conn->collect_queue);
 		skb_queue_head_init(&conn->commit_queue);
 		conn->max_buffsize = NETIUCV_BUFSIZE_DEFAULT;
diff -urpN linux-2.6/drivers/s390/net/qeth_eddp.c linux-2.6-patched/drivers/s390/net/qeth_eddp.c
--- linux-2.6/drivers/s390/net/qeth_eddp.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_eddp.c	2006-03-22 14:36:43.000000000 +0100
@@ -389,9 +389,8 @@ qeth_eddp_create_eddp_data(struct qeth_h
 	struct qeth_eddp_data *eddp;
 
 	QETH_DBF_TEXT(trace, 5, "eddpcrda");
-	eddp = kmalloc(sizeof(struct qeth_eddp_data), GFP_ATOMIC);
+	eddp = kzalloc(sizeof(struct qeth_eddp_data), GFP_ATOMIC);
 	if (eddp){
-		memset(eddp, 0, sizeof(struct qeth_eddp_data));
 		eddp->nhl = nhl;
 		eddp->thl = thl;
 		memcpy(&eddp->qh, qh, sizeof(struct qeth_hdr));
@@ -542,12 +541,11 @@ qeth_eddp_create_context_generic(struct 
 
 	QETH_DBF_TEXT(trace, 5, "creddpcg");
 	/* create the context and allocate pages */
-	ctx = kmalloc(sizeof(struct qeth_eddp_context), GFP_ATOMIC);
+	ctx = kzalloc(sizeof(struct qeth_eddp_context), GFP_ATOMIC);
 	if (ctx == NULL){
 		QETH_DBF_TEXT(trace, 2, "ceddpcn1");
 		return NULL;
 	}
-	memset(ctx, 0, sizeof(struct qeth_eddp_context));
 	ctx->type = QETH_LARGE_SEND_EDDP;
 	qeth_eddp_calc_num_pages(ctx, skb, hdr_len);
 	if (ctx->elements_per_skb > QETH_MAX_BUFFER_ELEMENTS(card)){
@@ -555,13 +553,12 @@ qeth_eddp_create_context_generic(struct 
 		kfree(ctx);
 		return NULL;
 	}
-	ctx->pages = kmalloc(ctx->num_pages * sizeof(u8 *), GFP_ATOMIC);
+	ctx->pages = kcalloc(ctx->num_pages, sizeof(u8 *), GFP_ATOMIC);
 	if (ctx->pages == NULL){
 		QETH_DBF_TEXT(trace, 2, "ceddpcn2");
 		kfree(ctx);
 		return NULL;
 	}
-	memset(ctx->pages, 0, ctx->num_pages * sizeof(u8 *));
 	for (i = 0; i < ctx->num_pages; ++i){
 		addr = (u8 *)__get_free_page(GFP_ATOMIC);
 		if (addr == NULL){
@@ -573,15 +570,13 @@ qeth_eddp_create_context_generic(struct 
 		memset(addr, 0, PAGE_SIZE);
 		ctx->pages[i] = addr;
 	}
-	ctx->elements = kmalloc(ctx->num_elements *
+	ctx->elements = kcalloc(ctx->num_elements,
 				sizeof(struct qeth_eddp_element), GFP_ATOMIC);
 	if (ctx->elements == NULL){
 		QETH_DBF_TEXT(trace, 2, "ceddpcn4");
 		qeth_eddp_free_context(ctx);
 		return NULL;
 	}
-	memset(ctx->elements, 0,
-	       ctx->num_elements * sizeof(struct qeth_eddp_element));
 	/* reset num_elements; will be incremented again in fill_buffer to
 	 * reflect number of actually used elements */
 	ctx->num_elements = 0;
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2006-03-22 14:36:43.000000000 +0100
@@ -297,12 +297,10 @@ qeth_alloc_card(void)
 	struct qeth_card *card;
 
 	QETH_DBF_TEXT(setup, 2, "alloccrd");
-	card = (struct qeth_card *) kmalloc(sizeof(struct qeth_card),
-					    GFP_DMA|GFP_KERNEL);
+	card = kzalloc(sizeof(struct qeth_card), GFP_DMA|GFP_KERNEL);
 	if (!card)
 		return NULL;
 	QETH_DBF_HEX(setup, 2, &card, sizeof(void *));
-	memset(card, 0, sizeof(struct qeth_card));
 	if (qeth_setup_channel(&card->read)) {
 		kfree(card);
 		return NULL;
@@ -1632,9 +1630,8 @@ qeth_alloc_reply(struct qeth_card *card)
 {
 	struct qeth_reply *reply;
 
-	reply = kmalloc(sizeof(struct qeth_reply), GFP_ATOMIC);
+	reply = kzalloc(sizeof(struct qeth_reply), GFP_ATOMIC);
 	if (reply){
-		memset(reply, 0, sizeof(struct qeth_reply));
 		atomic_set(&reply->refcnt, 1);
 		reply->card = card;
 	};
@@ -3348,13 +3345,11 @@ qeth_qdio_establish(struct qeth_card *ca
 
 	QETH_DBF_TEXT(setup, 2, "qdioest");
 
-	qib_param_field = kmalloc(QDIO_MAX_BUFFERS_PER_Q * sizeof(char),
+	qib_param_field = kzalloc(QDIO_MAX_BUFFERS_PER_Q * sizeof(char),
 			      GFP_KERNEL);
  	if (!qib_param_field)
 		return -ENOMEM;
 
- 	memset(qib_param_field, 0, QDIO_MAX_BUFFERS_PER_Q * sizeof(char));
-
 	qeth_create_qib_param_field(card, qib_param_field);
 	qeth_create_qib_param_field_blkt(card, qib_param_field);
 
@@ -4844,9 +4839,8 @@ qeth_arp_query(struct qeth_card *card, c
 	/* get size of userspace buffer and mask_bits -> 6 bytes */
 	if (copy_from_user(&qinfo, udata, 6))
 		return -EFAULT;
-	if (!(qinfo.udata = kmalloc(qinfo.udata_len, GFP_KERNEL)))
+	if (!(qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL)))
 		return -ENOMEM;
-	memset(qinfo.udata, 0, qinfo.udata_len);
 	qinfo.udata_offset = QETH_QARP_ENTRIES_OFFSET;
 	iob = qeth_get_setassparms_cmd(card, IPA_ARP_PROCESSING,
 				       IPA_CMD_ASS_ARP_QUERY_INFO,
@@ -4994,11 +4988,10 @@ qeth_snmp_command(struct qeth_card *card
 		return -EFAULT;
 	}
 	qinfo.udata_len = ureq->hdr.data_len;
-	if (!(qinfo.udata = kmalloc(qinfo.udata_len, GFP_KERNEL))){
+	if (!(qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL))){
 		kfree(ureq);
 		return -ENOMEM;
 	}
-	memset(qinfo.udata, 0, qinfo.udata_len);
 	qinfo.udata_offset = sizeof(struct qeth_snmp_ureq_hdr);
 
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL,
@@ -5604,12 +5597,11 @@ qeth_get_addr_buffer(enum qeth_prot_vers
 {
 	struct qeth_ipaddr *addr;
 
-	addr = kmalloc(sizeof(struct qeth_ipaddr), GFP_ATOMIC);
+	addr = kzalloc(sizeof(struct qeth_ipaddr), GFP_ATOMIC);
 	if (addr == NULL) {
 		PRINT_WARN("Not enough memory to add address\n");
 		return NULL;
 	}
-	memset(addr,0,sizeof(struct qeth_ipaddr));
 	addr->type = QETH_IP_TYPE_NORMAL;
 	addr->proto = prot;
 	return addr;
diff -urpN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2006-03-22 14:36:43.000000000 +0100
@@ -1145,11 +1145,10 @@ qeth_dev_ipato_add_store(const char *buf
 	if ((rc = qeth_parse_ipatoe(buf, proto, addr, &mask_bits)))
 		return rc;
 
-	if (!(ipatoe = kmalloc(sizeof(struct qeth_ipato_entry), GFP_KERNEL))){
+	if (!(ipatoe = kzalloc(sizeof(struct qeth_ipato_entry), GFP_KERNEL))){
 		PRINT_WARN("No memory to allocate ipato entry\n");
 		return -ENOMEM;
 	}
-	memset(ipatoe, 0, sizeof(struct qeth_ipato_entry));
 	ipatoe->proto = proto;
 	memcpy(ipatoe->addr, addr, (proto == QETH_PROT_IPV4)? 4:16);
 	ipatoe->mask_bits = mask_bits;
diff -urpN linux-2.6/drivers/s390/s390_rdev.c linux-2.6-patched/drivers/s390/s390_rdev.c
--- linux-2.6/drivers/s390/s390_rdev.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390_rdev.c	2006-03-22 14:36:43.000000000 +0100
@@ -27,10 +27,9 @@ s390_root_dev_register(const char *name)
 
 	if (!strlen(name))
 		return ERR_PTR(-EINVAL);
-	dev = kmalloc(sizeof(struct device), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
-	memset(dev, 0, sizeof(struct device));
 	strncpy(dev->bus_id, name, min(strlen(name), (size_t)BUS_ID_SIZE));
 	dev->release = s390_root_dev_release;
 	ret = device_register(dev);
