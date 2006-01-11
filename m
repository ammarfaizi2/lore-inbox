Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWAKCHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWAKCHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWAKCHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:07:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:46814 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161152AbWAKCHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:07:46 -0500
Message-ID: <43C46867.4050005@tw.ibm.com>
Date: Wed, 11 Jan 2006 10:07:35 +0800
From: Albert Lee <albertcc@tw.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Treubig <jtreubig@hotmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Douglas Gilbert <dougg@torque.net>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: Error handling in LibATA
References: <BAY101-F102837A76FADACF6F37DBBDF250@phx.gbl>
In-Reply-To: <BAY101-F102837A76FADACF6F37DBBDF250@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Treubig wrote:
> I've been working on a problem with Promise 20269 PATA adapter under
> LibATA that if the drive has a write error or time-out, the application
> that is accessing the drive using SG should see some sort of error.  My
> first problem was my system hung.  After patching the IDE-IO.C, with a
> recognized patch, I have been able to keep my system from hanging.  Now
> the only problem is the application gets no notification that the drive
> has been rendered inaccessible.  (Test case is to run a system with my
> app going, and then pull the power from the drive.  System log shows the
> errors, but nothing gets back to the app).  The app does get
> notifications if I perform the same type of test on a drive attached to
> the motherboard secondary IDE adapter, so we know the app is correctly
> implemented.

As Alan commented, not sure you are using IDE or libata?
Could you send the boot dmesg?

> 
> I've traced the errors down to the fact that the errors are caught in
> libata-core.c (ata_qc_timeout).  I'd like to put a call in libata-core.c
> that would cause an error to be reflected back to the application.  Can
> you suggest the function or method that would do this?
> 

If you are using libata, maybe the following patch can help.
It checks more bits of drv_stat, so status like 0x00 are returned as error.

Albert

========

--- linux/drivers/scsi/libata-core.c	2006-01-11 09:47:25.000000000 +0800
+++ errmask/drivers/scsi/libata-core.c	2006-01-11 09:51:09.000000000 +0800
@@ -3418,8 +3418,14 @@ static void ata_qc_timeout(struct ata_qu
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
+		/* If drv_stat looks ok (0x50 normally), we treat this
+		 * as lost interrupt and complete the qc as normal.
+		 * If drv_stat looks bad (0x00, 0xff, etc), err_mask is set.
+		 */
+		if (!ata_ok(drv_stat))
+			qc->err_mask |= __ac_err_mask(drv_stat);
+
 		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(drv_stat);
 		ata_qc_complete(qc);
 		break;
 	}




