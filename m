Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWALTtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWALTtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWALTtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:49:20 -0500
Received: from bay101-f34.bay101.hotmail.com ([64.4.56.44]:46732 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1161218AbWALTtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:49:19 -0500
Message-ID: <BAY101-F347AF31FA4399257978B64DF270@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
In-Reply-To: <BAY101-F3655E91B89B01BBCEB0B7DDF240@phx.gbl>
From: "John Treubig" <jtreubig@hotmail.com>
To: albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, alan@lxorguk.ukuu.org.uk, dougg@torque.net,
       dwm@maxeymade.com
Subject: Re: Error handling in LibATA
Date: Thu, 12 Jan 2006 13:49:18 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 12 Jan 2006 19:49:18.0881 (UTC) FILETIME=[46A9A110:01C617B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert,

I began to try your patch and noticed that the code was different than my 
copy of 2.6.15 rc5, so I downloaded 2.6.15 (release) and still see that the 
base copy of libata-core.c is different.  A good indicator was that 
ata_qc_complete() requires 2 parameters in the code from 2.6.15.  Can you 
tell me where I can find the copy your working off and if I have to have any 
other files to support it?

Best wishes,
John Treubig
VT Miltope


From: "John Treubig" <jtreubig@hotmail.com>
To: albertcc@tw.ibm.com
CC: linux-ide@vger.kernel.org, 
linux-kernel@vger.kernel.org,linux-scsi@vger.kernel.org, 
alan@lxorguk.ukuu.org.uk,dougg@torque.net, dwm@maxeymade.com
Subject: Re: Error handling in LibATA
Date: Wed, 11 Jan 2006 09:30:02 -0600

Thanks all for your recommendations.  I'm in the process of installing your 
patch.  Per your requests I've attached copies of lspci, dmesg and two 
excerpts from the messages file.  The messages from libata.msg are from a 
drive attached to the Promise adapter and ide.msg are from a drive attached 
to the motherboard secondary IDE.  In both cases power was removed during 
testing.

My system is built with 2.6.15 rc5 and I will let you know my results.

Thanks again,
John


From: Albert Lee <albertcc@tw.ibm.com>
To: John Treubig <jtreubig@hotmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,        
linux-scsi@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,        
Douglas Gilbert <dougg@torque.net>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: Error handling in LibATA
Date: Wed, 11 Jan 2006 10:07:35 +0800

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
  		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 
0x%x\n",
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



<< dmesg.lst >>


<< pci.lst >>


<< ide.msg >>


<< libata.msg >>


