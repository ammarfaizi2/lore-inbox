Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVGaFx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVGaFx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVGaFx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:53:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9705 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263175AbVGaFv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:51:56 -0400
Date: Sat, 30 Jul 2005 22:51:52 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: 2.6.13 ub 3/3: death to ub_bd_rq_fn_1
Message-Id: <20050730225152.53a68751.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When Al Viro saw the ub.c, he observed that it was a proof positive of
Linus not reading patches anymore: names like fo_ob_ar_ba_2 used to
cause serious fireworks. In my defence, any good scheme can be pushed
to the realm of absurd if pushed far enough.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>

--- linux-2.6.13-rc4-4seg/drivers/block/ub.c	2005-07-30 22:19:55.000000000 -0700
+++ linux-2.6.13-rc4-lem/drivers/block/ub.c	2005-07-29 22:42:00.000000000 -0700
@@ -407,7 +407,7 @@ struct ub_dev {
 /*
  */
 static void ub_cleanup(struct ub_dev *sc);
-static int ub_bd_rq_fn_1(struct ub_lun *lun, struct request *rq);
+static int ub_request_fn_1(struct ub_lun *lun, struct request *rq);
 static int ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_scsi_cmd *cmd, struct request *rq);
 static void ub_scsi_build_block(struct ub_lun *lun,
@@ -767,20 +768,20 @@ static struct ub_scsi_cmd *ub_cmdq_pop(s
  * The request function is our main entry point
  */
 
-static void ub_bd_rq_fn(request_queue_t *q)
+static void ub_request_fn(request_queue_t *q)
 {
 	struct ub_lun *lun = q->queuedata;
 	struct request *rq;
 
 	while ((rq = elv_next_request(q)) != NULL) {
-		if (ub_bd_rq_fn_1(lun, rq) != 0) {
+		if (ub_request_fn_1(lun, rq) != 0) {
 			blk_stop_queue(q);
 			break;
 		}
 	}
 }
 
-static int ub_bd_rq_fn_1(struct ub_lun *lun, struct request *rq)
+static int ub_request_fn_1(struct ub_lun *lun, struct request *rq)
 {
 	struct ub_dev *sc = lun->udev;
 	struct ub_scsi_cmd *cmd;
@@ -2356,7 +2357,7 @@ static int ub_probe_lun(struct ub_dev *s
 	disk->driverfs_dev = &sc->intf->dev;	/* XXX Many to one ok? */
 
 	rc = -ENOMEM;
-	if ((q = blk_init_queue(ub_bd_rq_fn, &sc->lock)) == NULL)
+	if ((q = blk_init_queue(ub_request_fn, &sc->lock)) == NULL)
 		goto err_blkqinit;
 
 	disk->queue = q;
