Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVEaHJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVEaHJO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVEaHJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:09:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:57774 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261279AbVEaHJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:09:09 -0400
Subject: [PATCH] Don't "lose" devices on suspend on failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 31 May 2005 17:08:49 +1000
Message-Id: <1117523329.5826.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I think we need this patch or we might "lose" devices to the dpm_irq_off
list if a failure occurs during the suspend process.

Patrick, Greg, your opinion ?

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/base/power/suspend.c
===================================================================
--- linux-work.orig/drivers/base/power/suspend.c	2005-05-31 16:29:22.000000000 +1000
+++ linux-work/drivers/base/power/suspend.c	2005-05-31 16:57:29.000000000 +1000
@@ -113,8 +113,19 @@
 		put_device(dev);
 	}
 	up(&dpm_list_sem);
-	if (error)
+	if (error) {
+		/* we failed... before resuming, bring back devices from
+		 * dpm_off_irq list back to main dpm_off list, we do want
+		 * to call resume() on them, in case they partially suspended
+		 * despite returning -EAGAIN
+		 */
+		while (!list_empty(&dpm_off_irq)) {
+			struct list_head * entry = dpm_off_irq.next;
+			list_del(entry);
+			list_add(entry, &dpm_off);
+		}
 		dpm_resume();
+	}
 	up(&dpm_sem);
 	return error;
 }


