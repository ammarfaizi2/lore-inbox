Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270284AbUJTBzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270284AbUJTBzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbUJTAyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:54:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:1460 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266611AbUJTAT2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:28 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315061975@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:26 -0700
Message-Id: <1098231506495@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2072, 2004/10/19 15:21:15-07:00, nacc@us.ibm.com

[PATCH] I2C: replace schedule_timeout() with msleep_interruptible() in i2c-ibm_iic.c

Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected. Remove the unnecessary
set_current_state() following the if, as schedule_timeout() [and thus,
mlseep_interruptible()] is guaranteed to return in TASK_RUNNING.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ibm_iic.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-19 16:53:58 -07:00
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-19 16:53:58 -07:00
@@ -416,10 +416,8 @@
     		init_waitqueue_entry(&wait, current);
 		
 		add_wait_queue(&dev->wq, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
 		if (in_8(&iic->sts) & STS_PT)
-			schedule_timeout(dev->adap.timeout * HZ);
-		set_current_state(TASK_RUNNING);
+			msleep_interruptible(dev->adap.timeout * 1000);
 		remove_wait_queue(&dev->wq, &wait);
 		
 		if (unlikely(signal_pending(current))){

