Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVKTXAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVKTXAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVKTXAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:00:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932112AbVKTXAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:00:51 -0500
Date: Mon, 21 Nov 2005 00:00:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: markus.lidel@shadowconnect.com, James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: [2.6 patch] drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference
Message-ID: <20051120230050.GB16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obvious NULL pointer dereference.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/dpt_i2o.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/scsi/dpt_i2o.c.old	2005-11-20 22:13:37.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/dpt_i2o.c	2005-11-20 22:16:57.000000000 +0100
@@ -816,7 +816,7 @@
 static void adpt_i2o_sys_shutdown(void)
 {
 	adpt_hba *pHba, *pNext;
-	struct adpt_i2o_post_wait_data *p1, *p2;
+	struct adpt_i2o_post_wait_data *p1, *old;
 
 	 printk(KERN_INFO"Shutting down Adaptec I2O controllers.\n");
 	 printk(KERN_INFO"   This could take a few minutes if there are many devices attached\n");
@@ -830,13 +830,14 @@
 	}
 
 	/* Remove any timedout entries from the wait queue.  */
-	p2 = NULL;
 //	spin_lock_irqsave(&adpt_post_wait_lock, flags);
 	/* Nothing should be outstanding at this point so just
 	 * free them 
 	 */
-	for(p1 = adpt_post_wait_queue; p1; p2 = p1, p1 = p2->next) {
-		kfree(p1);
+	for(p1 = adpt_post_wait_queue; p1;) {
+		old = p1;
+		p1 = p1->next;
+		kfree(old);
 	}
 //	spin_unlock_irqrestore(&adpt_post_wait_lock, flags);
 	adpt_post_wait_queue = NULL;

