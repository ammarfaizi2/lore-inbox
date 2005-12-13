Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVLMI25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVLMI25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVLMIZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:12164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932563AbVLMIZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:03 -0500
Date: Tue, 13 Dec 2005 00:22:06 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       bunk@stusta.de, mark_salyzyn@adaptec.com
Subject: [patch 01/26] drivers/scsi/dpt_i2o.c: fix a user-after-free
Message-ID: <20051213082206.GB5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dpt_i2o-fix-a-null-pointer-deref.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Adrian Bunk <bunk@stusta.de>

The Coverity checker spotted this obvious use-after-free

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Mark Salyzyn <mark_salyzyn@adaptec.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/scsi/dpt_i2o.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.14.3.orig/drivers/scsi/dpt_i2o.c
+++ linux-2.6.14.3/drivers/scsi/dpt_i2o.c
@@ -816,7 +816,7 @@ static int adpt_hba_reset(adpt_hba* pHba
 static void adpt_i2o_sys_shutdown(void)
 {
 	adpt_hba *pHba, *pNext;
-	struct adpt_i2o_post_wait_data *p1, *p2;
+	struct adpt_i2o_post_wait_data *p1, *old;
 
 	 printk(KERN_INFO"Shutting down Adaptec I2O controllers.\n");
 	 printk(KERN_INFO"   This could take a few minutes if there are many devices attached\n");
@@ -830,13 +830,14 @@ static void adpt_i2o_sys_shutdown(void)
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

--
