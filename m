Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268657AbUIQJsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268657AbUIQJsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUIQJsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:48:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:10666 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268657AbUIQJrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:47:49 -0400
Subject: Re: [BUG] ub.c badness in current bk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040917002935.77620d1d@lembas.zaitcev.lan>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
	 <20040917002935.77620d1d@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1095414394.13531.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Sep 2004 19:46:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's a modified patch that fixes the problem for me. As you
noticed, it seems the changed flag need to be one-shot, but your
code that "made" changed didn't follow that logic. Note that in
it's current form, the "new" function is equivalent to getting rid
of the "changed" flag completely and just returning the result of
ub_sync_tur(). I'll let you do that though if you think it's
correct.

Ben.

===== drivers/block/ub.c 1.5 vs edited =====
--- 1.5/drivers/block/ub.c	2004-08-24 10:02:30 +10:00
+++ edited/drivers/block/ub.c	2004-09-17 19:44:04 +10:00
@@ -1217,9 +1217,18 @@
 		goto error;
 	}
 
+	/*
+	 * ``If the allocation length is eighteen or greater, and a device
+	 * server returns less than eithteen bytes of data, the application
+	 * client should assume that the bytes not transferred would have been
+	 * zeroes had the device server returned those bytes.''
+	 */
+
 	memset(&sc->top_sense, 0, UB_SENSE_SIZE);
+
 	scmd = &sc->top_rqs_cmd;
 	scmd->cdb[0] = REQUEST_SENSE;
+	scmd->cdb[4] = UB_SENSE_SIZE;
 	scmd->cdb_len = 6;
 	scmd->dir = UB_DIR_READ;
 	scmd->state = UB_CMDST_INIT;
@@ -1352,7 +1361,6 @@
  */
 static void ub_revalidate(struct ub_dev *sc)
 {
-
 	sc->readonly = 0;	/* XXX Query this from the device */
 
 	/*
@@ -1509,6 +1517,7 @@
 static int ub_bd_media_changed(struct gendisk *disk)
 {
 	struct ub_dev *sc = disk->private_data;
+	int ret;
 
 	if (!sc->removable)
 		return 0;
@@ -1525,12 +1534,13 @@
 	if (ub_sync_tur(sc) != 0) {
 		sc->changed = 1;
 		/* P3 */ printk("%s: made changed\n", sc->name);
-		return 1;
 	}
 
 	/* The sd.c clears this before returning (one-shot flag). Why? */
-	/* P3 */ printk("%s: %s changed\n", sc->name,
-	    sc->changed? "is": "was not");
+	ret = sc->changed;
+	/* P3 */ printk("%s: %s changed\n", sc->name, ret ? "is": "was not");
+	
+	sc->changed = 0;
 	return sc->changed;
 }
 


