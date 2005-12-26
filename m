Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVLZP6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVLZP6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVLZP6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 10:58:34 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:43922 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750833AbVLZP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 10:58:33 -0500
Subject: [PATCH 1/1] Fix Fibre Channel boot oops
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 09:58:49 -0600
Message-Id: <1135612729.3762.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oops is characteristic of the underlying device being removed from
visibility before the class device, and sure enough we do device_del()
before transport_unregister() in the scsi_target_reap() routines.  I've
no idea why this is suddenly showing up, since the code has been in
there since that function was first invented.  However, I've confirmed
this fixes Andrew Vasquez's boot oops.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

P.S. I told you if you waited a while I'd get another bug ...

James

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -418,8 +418,9 @@ static void scsi_target_reap_work(void *
 	if (--starget->reap_ref == 0 && list_empty(&starget->devices)) {
 		list_del_init(&starget->siblings);
 		spin_unlock_irqrestore(shost->host_lock, flags);
+		transport_remove_device(&starget->dev);
 		device_del(&starget->dev);
-		transport_unregister_device(&starget->dev);
+		transport_destroy_device(&starget->dev);
 		put_device(&starget->dev);
 		return;
 



