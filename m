Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUITDVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUITDVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 23:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUITDVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 23:21:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265887AbUITDVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 23:21:33 -0400
Date: Sun, 19 Sep 2004 20:21:26 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, zaitcev@redhat.com
Subject: Re: [BUG] ub.c badness in current bk
Message-Id: <20040919202126.1073925b@lembas.zaitcev.lan>
In-Reply-To: <1095473325.3574.4.camel@gaston>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
	<20040917002935.77620d1d@lembas.zaitcev.lan>
	<1095414394.13531.77.camel@gaston>
	<20040917090448.32ff763c@lembas.zaitcev.lan>
	<1095469463.3574.2.camel@gaston>
	<1095473325.3574.4.camel@gaston>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 12:08:46 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> And the real one without fuckup in media_change(), sorry, I sent
> the wrong patch.

> +	 * Here's our equivalent of spinup. We probably need to better check
> +	 * the sense codes from TUR ?

This really bothers me. The key 6 is asking for a clearing and possibly
a spin-up (my ZIP 100 returns 6 until it's spun up), that's right. But
it won't start without START_STOP command, on pure TURs. So it's a delusion
to accept this as a spin-up. I do plan for a decent spin-up code, but
it's a little difficult within the ub's phylosophy (possibly it was a bad
design to rely on a state machine too much).

How about this deal. I'll add a clearly marked workaround like the
appended patch, and then ask you to try again when a proper spin-up gets
implemented?

Note that the patch is against -mm where the REQUEST SENSE is set correctly.
I strongly suggest you to use ub from -mm. Linus' tree is behind.

Also, I might have screwed something along the way, so if it fails, please
send me dmesg and the contents of /sys/..../diag.

Greetings,
-- Pete

diff -urp -X dontdiff linux-2.6.9-rc2-mm1/drivers/block/ub.c linux-2.6.9-rc2-mm1-ub/drivers/block/ub.c
--- linux-2.6.9-rc2-mm1/drivers/block/ub.c	2004-09-17 23:04:27.000000000 -0700
+++ linux-2.6.9-rc2-mm1-ub/drivers/block/ub.c	2004-09-19 20:11:07.655890215 -0700
@@ -25,6 +25,7 @@
  *  -- prune comments, they are too volumnous
  *  -- Exterminate P3 printks
  *  -- Resove XXX's
+ *  -- Redo "benh's retries", perhaps have spin-up code to handle them. V:D=?
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -157,7 +158,8 @@ struct ub_scsi_cmd {
 	struct ub_scsi_cmd *next;
 
 	int error;			/* Return code - valid upon done */
-	int act_len;			/* Return size */
+	unsigned int act_len;		/* Return size */
+	unsigned char key, asc, ascq;	/* May be valid if error==-EIO */
 
 	int stat_count;			/* Retries getting status. */
 
@@ -1141,16 +1146,8 @@ static void ub_scsi_urb_compl(struct ub_
 		(*cmd->done)(sc, cmd);
 
 	} else if (cmd->state == UB_CMDST_SENSE) {
-		/* 
-		 * We do not look at sense, because even if there was no sense,
-		 * we get into UB_CMDST_SENSE from a STALL or CSW FAIL only.
-		 * We request sense because we want to clear CHECK CONDITION
-		 * on devices with delusions of SCSI, and not because we
-		 * are curious in any way about the sense itself.
-		 */
-		/* if ((cmd->top_sense[2] & 0x0F) == NO_SENSE) { foo } */
-
 		ub_state_done(sc, cmd, -EIO);
+
 	} else {
 		printk(KERN_WARNING "%s: "
 		    "wrong command state %d on device %u\n",
@@ -1309,6 +1306,10 @@ static void ub_top_sense_done(struct ub_
 	 */
 	ub_cmdtr_sense(sc, scmd, sense);
 
+	/*
+	 * Find the command which triggered the unit attention or a check,
+	 * save the sense into it, and advance its state machine.
+	 */
 	if ((cmd = ub_cmdq_peek(sc)) == NULL) {
 		printk(KERN_WARNING "%s: sense done while idle\n", sc->name);
 		return;
@@ -1326,6 +1327,10 @@ static void ub_top_sense_done(struct ub_
 		return;
 	}
 
+	cmd->key = sense[2] & 0x0F;
+	cmd->asc = sense[12];
+	cmd->ascq = sense[13];
+
 	ub_scsi_urb_compl(sc, cmd);
 }
 
@@ -1621,6 +1638,9 @@ static int ub_sync_tur(struct ub_dev *sc
 
 	rc = cmd->error;
 
+	if (rc == -EIO && cmd->key != 0)	/* Retries for benh's key */
+		rc = cmd->key;
+
 err_submit:
 	kfree(cmd);
 err_alloc:
@@ -1836,6 +1856,7 @@ static int ub_probe(struct usb_interface
 	request_queue_t *q;
 	struct gendisk *disk;
 	int rc;
+	int i;
 
 	rc = -ENOMEM;
 	if ((sc = kmalloc(sizeof(struct ub_dev), GFP_KERNEL)) == NULL)
@@ -1902,7 +1923,11 @@ static int ub_probe(struct usb_interface
 	 * has to succeed, so we clear checks with an additional one here.
 	 * In any case it's not our business how revaliadation is implemented.
 	 */
-	ub_sync_tur(sc);
+	for (i = 0; i < 3; i++) {	/* Retries for benh's key */
+		if ((rc = ub_sync_tur(sc)) <= 0) break;
+		if (rc != 0x6) break;
+		msleep(10);
+	}
 
 	sc->removable = 1;		/* XXX Query this from the device */
 
