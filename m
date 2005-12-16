Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVLPECf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVLPECf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVLPECe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:02:34 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:29388 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751107AbVLPECd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:02:33 -0500
Subject: Re: Fw: crash on x86_64 - mm related?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20051215190930.GA20156@tau.solarneutrino.net>
References: <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
	 <20051206160815.GC11560@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com>
	 <20051206204336.GA12248@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com>
	 <20051212165443.GD17295@tau.solarneutrino.net>
	 <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
	 <1134409531.9994.13.camel@mulgrave>
	 <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
	 <1134411882.9994.18.camel@mulgrave>
	 <20051215190930.GA20156@tau.solarneutrino.net>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 20:01:43 -0800
Message-Id: <1134705703.3906.1.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 14:09 -0500, Ryan Richter wrote:
> On Mon, Dec 12, 2005 at 12:24:42PM -0600, James Bottomley wrote:
> > I'll find a fix for the real problem, but this patch isn't the cause.
> 
> Is the patch set you posted yesterday supposed to fix this?  If so, is
> it available in patch form anywhere?

No, I've been too busin integrating other people's patches to work on
ones of my own.  Try this.

James

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -400,6 +400,35 @@ static struct scsi_target *scsi_alloc_ta
 	return found_target;
 }
 
+struct work_queue_wrapper {
+	struct work_struct	work;
+	struct scsi_target	*starget;
+};
+
+static void scsi_target_reap_work(void *data) {
+	struct work_queue_wrapper *wqw = (struct work_queue_wrapper *)data;
+	struct scsi_target *starget = wqw->starget;
+	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	unsigned long flags;
+
+	kfree(wqw);
+
+	spin_lock_irqsave(shost->host_lock, flags);
+
+	if (--starget->reap_ref == 0 && list_empty(&starget->devices)) {
+		list_del_init(&starget->siblings);
+		spin_unlock_irqrestore(shost->host_lock, flags);
+		device_del(&starget->dev);
+		transport_unregister_device(&starget->dev);
+		put_device(&starget->dev);
+		return;
+
+	}
+	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	return;
+}
+
 /**
  * scsi_target_reap - check to see if target is in use and destroy if not
  *
@@ -411,19 +440,18 @@ static struct scsi_target *scsi_alloc_ta
  */
 void scsi_target_reap(struct scsi_target *starget)
 {
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	unsigned long flags;
-	spin_lock_irqsave(shost->host_lock, flags);
+	struct work_queue_wrapper *wqw = 
+		kzalloc(sizeof(struct work_queue_wrapper), GFP_ATOMIC);
 
-	if (--starget->reap_ref == 0 && list_empty(&starget->devices)) {
-		list_del_init(&starget->siblings);
-		spin_unlock_irqrestore(shost->host_lock, flags);
-		device_del(&starget->dev);
-		transport_unregister_device(&starget->dev);
-		put_device(&starget->dev);
+	if (!wqw) {
+		starget_printk(KERN_ERR, starget,
+			       "Failed to allocate memory in scsi_reap_target()\n");
 		return;
 	}
-	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	INIT_WORK(&wqw->work, scsi_target_reap_work, wqw);
+	wqw->starget = starget;
+	schedule_work(&wqw->work);
 }
 
 /**


