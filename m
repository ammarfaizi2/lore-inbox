Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269097AbUIRCJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269097AbUIRCJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 22:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269103AbUIRCJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 22:09:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:31664 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269097AbUIRCJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 22:09:09 -0400
Subject: Re: [BUG] ub.c badness in current bk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1095469463.3574.2.camel@gaston>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
	 <20040917002935.77620d1d@lembas.zaitcev.lan>
	 <1095414394.13531.77.camel@gaston>
	 <20040917090448.32ff763c@lembas.zaitcev.lan>
	 <1095469463.3574.2.camel@gaston>
Content-Type: text/plain
Message-Id: <1095473325.3574.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 18 Sep 2004 12:08:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-18 at 11:04, Benjamin Herrenschmidt wrote:
> Ok, here's a patch that works for me and makes more sense ;)
>
> .../...

And the real one without fuckup in media_change(), sorry, I sent
the wrong patch.


===== drivers/block/ub.c 1.5 vs edited =====
--- 1.5/drivers/block/ub.c	2004-08-24 10:02:30 +10:00
+++ edited/drivers/block/ub.c	2004-09-18 12:04:47 +10:00
@@ -1217,9 +1217,16 @@
 		goto error;
 	}
 
+	/*
+	 * ``If the allocation length is eighteen or greater, and a device
+	 * server returns less than eithteen bytes of data, the application
+	 * client should assume that the bytes not transferred would have been
+	 * zeroes had the device server returned those bytes.''
+	 */
 	memset(&sc->top_sense, 0, UB_SENSE_SIZE);
 	scmd = &sc->top_rqs_cmd;
 	scmd->cdb[0] = REQUEST_SENSE;
+	scmd->cdb[4] = UB_SENSE_SIZE;
 	scmd->cdb_len = 6;
 	scmd->dir = UB_DIR_READ;
 	scmd->state = UB_CMDST_INIT;
@@ -1352,6 +1359,7 @@
  */
 static void ub_revalidate(struct ub_dev *sc)
 {
+	int retries;
 
 	sc->readonly = 0;	/* XXX Query this from the device */
 
@@ -1364,8 +1372,21 @@
 	sc->capacity.bsize = 512;
 	sc->capacity.bshift = 0;
 
-	if (ub_sync_tur(sc) != 0)
-		return;			/* Not ready */
+	/*
+	 * Here's our equivalent of spinup. We probably need to better check
+	 * the sense codes from TUR ? Anyway, some flash devices tend to want
+	 * us to wait a little bit before beeing ready. We may want to do something
+	 * closer to what sd.c does here. --BenH
+	 */
+	retries = 0;
+	for (;;) {
+		if (ub_sync_tur(sc) == 0)
+			break;
+		if (++retries > 3)
+			return;
+		msleep(10); /* ahem ... */
+	}
+
 	sc->changed = 0;
 
 	if (ub_sync_read_cap(sc, &sc->capacity) != 0) {
@@ -1509,6 +1530,7 @@
 static int ub_bd_media_changed(struct gendisk *disk)
 {
 	struct ub_dev *sc = disk->private_data;
+	int ret;
 
 	if (!sc->removable)
 		return 0;
@@ -1531,7 +1553,9 @@
 	/* The sd.c clears this before returning (one-shot flag). Why? */
 	/* P3 */ printk("%s: %s changed\n", sc->name,
 	    sc->changed? "is": "was not");
-	return sc->changed;
+	ret = sc->changed;
+	sc->changed = 0;
+	return ret;
 }
 
 static struct block_device_operations ub_bd_fops = {


