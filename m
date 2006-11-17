Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755612AbWKQJgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbWKQJgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbWKQJgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:36:22 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:55424 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755612AbWKQJgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:36:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=f7pBglSMdKrj/ij6k9jLeuVyiC/C14nb3oL2UH2pU1nJ/9Y82mczZn280T3wYrQRG+tUOeu31pbYhb6ljBorQzVgImVR5KjsEuhG6dF0SmOjbRcmdybpE/uSz8G5n25Ae0OH3plhfC/Ii+WE3m8l1Pc5/50gTf2irfDK1YbQZ6s=  ;
X-YMail-OSG: qlTOH2kVM1knnb7F_G4xM8RZPgcfWJcHKg1GUbOF_PEAJChfqBqyfUDFvfjwFYJNN7TcSPgT3NZPfnnyuGS8dEp_Ezr7qTf3A5X_ReiB5LNzEINAG4sxAg--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.19-rc6] rtc framework handles periodic irqs
Date: Thu, 16 Nov 2006 23:12:09 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611162312.09415.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC framework has an irq_set_freq() method that should be used to
manage the periodic IRQ frequency, but the current ioctl logic doesn't
know how to do that.  This patch teaches it how.

This means that drivers implementing irq_set_freq() will automatically
support RTC_IRQP_{READ,SET} ioctls; that logic doesn't need duplication
within the driver.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/rtc-dev.c
===================================================================
--- g26.orig/drivers/rtc/rtc-dev.c	2006-11-12 12:24:31.000000000 -0800
+++ g26/drivers/rtc/rtc-dev.c	2006-11-12 15:37:17.000000000 -0800
@@ -214,7 +214,7 @@ static int rtc_dev_ioctl(struct inode *i
 	struct rtc_wkalrm alarm;
 	void __user *uarg = (void __user *) arg;
 
-	/* check that the calles has appropriate permissions
+	/* check that the calling task has appropriate permissions
 	 * for certain ioctls. doing this check here is useful
 	 * to avoid duplicate code in each driver.
 	 */
@@ -299,6 +299,17 @@ static int rtc_dev_ioctl(struct inode *i
 
 		err = rtc_set_time(class_dev, &tm);
 		break;
+
+	case RTC_IRQP_READ:
+		if (ops->irq_set_freq)
+			err = put_user(rtc->irq_freq, (unsigned long *) arg);
+		break;
+
+	case RTC_IRQP_SET:
+		if (ops->irq_set_freq)
+			err = rtc_irq_set_freq(class_dev, rtc->irq_task, arg);
+		break;
+
 #if 0
 	case RTC_EPOCH_SET:
 #ifndef rtc_epoch
