Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUIRBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUIRBEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 21:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269081AbUIRBEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 21:04:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:12208 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269080AbUIRBEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 21:04:37 -0400
Subject: Re: [BUG] ub.c badness in current bk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040917090448.32ff763c@lembas.zaitcev.lan>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
	 <20040917002935.77620d1d@lembas.zaitcev.lan>
	 <1095414394.13531.77.camel@gaston>
	 <20040917090448.32ff763c@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1095469463.3574.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 18 Sep 2004 11:04:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's a patch that works for me and makes more sense ;)

What happens is that ub_sync_tur() fails a few times when the device
is inserted. So we end up returning changed = 1 from within the call
to check_disk_change() done by do_open() from the partition code itself,
causing a re-entrance in there... 

I think add_disk() is very fragile here, but I'll let others like viro
(or you :) to fix that.

Anyway, the fix is to better mimmic sd_spinup_disk() within our own
revalidate. I think we _should_ actually request sense & analyze it
properly, eventually sending spinup commands etc... but in the meantime,
a simple retry works well enough for me. Here's the patch:

===== drivers/block/ub.c 1.5 vs edited =====
--- 1.5/drivers/block/ub.c	2004-08-24 10:02:30 +10:00
+++ edited/drivers/block/ub.c	2004-09-18 10:55:49 +10:00
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
@@ -1531,6 +1552,7 @@
 	/* The sd.c clears this before returning (one-shot flag). Why? */
 	/* P3 */ printk("%s: %s changed\n", sc->name,
 	    sc->changed? "is": "was not");
+	sc->changed = 0;
 	return sc->changed;
 }
 
 

