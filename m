Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWEQAUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWEQAUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEQAU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:20:27 -0400
Received: from mx0.towertech.it ([213.215.222.73]:40171 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932340AbWEQATy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:19:54 -0400
Date: Wed, 17 May 2006 02:11:56 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rtc subsystem, fix capability checks in kernel interface
Message-ID: <20060517021156.34cce7c9@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Remove CAP_SYS_XXX checks from the in kernel interface. Those
 functions are meant to be used in-kernel only.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/rtc/interface.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

--- linux-rtc.orig/drivers/rtc/interface.c	2006-05-17 01:18:19.000000000 +0200
+++ linux-rtc/drivers/rtc/interface.c	2006-05-17 01:41:17.000000000 +0200
@@ -229,6 +229,9 @@ int rtc_irq_set_state(struct class_devic
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(class_dev);
 
+	if (rtc->ops->irq_set_state == NULL)
+		return -ENXIO;
+
 	spin_lock_irqsave(&rtc->irq_task_lock, flags);
 	if (rtc->irq_task != task)
 		err = -ENXIO;
@@ -243,25 +246,12 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_state);
 
 int rtc_irq_set_freq(struct class_device *class_dev, struct rtc_task *task, int freq)
 {
-	int err = 0, tmp = 0;
+	int err = 0;
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(class_dev);
 
-	/* allowed range is 2-8192 */
-	if (freq < 2 || freq > 8192)
-		return -EINVAL;
-/*
-	FIXME: this does not belong here, will move where appropriate
-	at a later stage. It cannot hurt right now, trust me :)
-	if ((freq > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
-		return -EACCES;
-*/
-	/* check if freq is a power of 2 */
-	while (freq > (1 << tmp))
-		tmp++;
-
-	if (freq != (1 << tmp))
-		return -EINVAL;
+	if (rtc->ops->irq_set_freq == NULL)
+		return -ENXIO;
 
 	spin_lock_irqsave(&rtc->irq_task_lock, flags);
 	if (rtc->irq_task != task)
