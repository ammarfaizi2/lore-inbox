Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUKIFy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUKIFy6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbUKIFxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:53:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:4767 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261386AbUKIFZC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:02 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778541107@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:14 -0800
Message-Id: <10999778542218@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.2, 2004/10/22 12:52:13-07:00, ebs@ebshome.net

[PATCH] I2C: fix recently introduced race in IBM PPC4xx I2C driver

On Tue, Oct 19, 2004 at 10:21:08PM -0700, Eugene Surovegin wrote:
[snip]
> It looks like this change added race I tried to avoid here.
>
> This code is modeled after __wait_event_interruptible_timeout, where
> "prepare_to_wait" is done _before_ checking completion status. This
> change breaks this, e.g. if IRQ happens right after we check iic->sts,
> but before calling msleep_interruptible(). In this case we'll sleep
> much more than required (seconds instead of microseconds)
>
> Greg, if my analysis is correct, please rollback this change.
>
> Nishanth, I'd be nice if you CC'ed me with this patch, my e-mail is at
> the top of that source file.

Oh, well. I should have used wait_event_interruptible_timeout when I
ported this driver to 2.6.

This patch fixes recently introduced race and also cleans ups some
2.4-ism.


Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ibm_iic.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	2004-11-08 18:56:20 -08:00
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	2004-11-08 18:56:20 -08:00
@@ -412,18 +412,12 @@
 	
 	if (dev->irq >= 0){
 		/* Interrupt mode */
-		wait_queue_t wait;
-    		init_waitqueue_entry(&wait, current);
-		
-		add_wait_queue(&dev->wq, &wait);
-		if (in_8(&iic->sts) & STS_PT)
-			msleep_interruptible(dev->adap.timeout * 1000);
-		remove_wait_queue(&dev->wq, &wait);
-		
-		if (unlikely(signal_pending(current))){
+		ret = wait_event_interruptible_timeout(dev->wq, 
+			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout * HZ);
+
+		if (unlikely(ret < 0))
 			DBG("%d: wait interrupted\n", dev->idx);
-			ret = -ERESTARTSYS;
-		} else if (unlikely(in_8(&iic->sts) & STS_PT)){
+		else if (unlikely(in_8(&iic->sts) & STS_PT)){
 			DBG("%d: wait timeout\n", dev->idx);
 			ret = -ETIMEDOUT;
 		}

