Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270144AbUJTGgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270144AbUJTGgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270163AbUJTGcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 02:32:11 -0400
Received: from gate.ebshome.net ([64.81.67.12]:9703 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S268069AbUJTG0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 02:26:39 -0400
Date: Tue, 19 Oct 2004 23:26:33 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH] fix recently introduced race in IBM PPC4xx I2C driver
Message-ID: <20041020062633.GA16580@gate.ebshome.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com, Nishanth Aravamudan <nacc@us.ibm.com>
References: <10982315061975@kroah.com> <1098231506495@kroah.com> <20041020052108.GA14871@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020052108.GA14871@gate.ebshome.net>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Please, apply.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

===== drivers/i2c/busses/i2c-ibm_iic.c 1.12 vs edited =====
--- 1.12/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-14 11:30:08 -07:00
+++ edited/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-19 23:18:16 -07:00
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

