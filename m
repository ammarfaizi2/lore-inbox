Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbULAUnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbULAUnU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 15:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbULAUnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 15:43:20 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:18067 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261442AbULAUnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 15:43:13 -0500
Subject: Re: phase change messages cusing slowdown with sym53c8xx_2 driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041201203226.GI5752@parcelfarce.linux.theplanet.co.uk>
References: <20041130030212.GB22916@austin.ibm.com>
	<20041201165654.GA32687@rx8.austin.ibm.com>
	<1101921398.1930.24.camel@mulgrave> 
	<20041201203226.GI5752@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Dec 2004 15:43:02 -0500
Message-Id: <1101933788.1930.226.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 15:32, Matthew Wilcox wrote:
> On Wed, Dec 01, 2004 at 12:16:33PM -0500, James Bottomley wrote:
> > does this look like the "drive won't respond properly to PPR if the bus
> > is SE" problem again?
> 
> Thomas Babut who tested that fix reported it didn't solve his problem ;-(
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=109968716312783&w=2
> http://marc.theaimsgroup.com/?l=linux-scsi&m=109969829411685&w=2
> 
> I'm out of ideas for fixing that one.  Would you consider Richard
> Waltham's patch?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109967237930243&w=2

Actually, yes, or the attached variant of it.  Does this solve the
problem?

There's no reason why we should assume a SCSI_3 or greater device
automatically supports ppr (especially if it's inquiry bit is
advertising that it doesn't...)

James

===== drivers/scsi/scsi_scan.c 1.134 vs edited =====
--- 1.134/drivers/scsi/scsi_scan.c	2004-10-24 07:09:48 -04:00
+++ edited/drivers/scsi/scsi_scan.c	2004-12-01 15:41:03 -05:00
@@ -554,10 +554,8 @@
 	sdev->removable = (0x80 & inq_result[1]) >> 7;
 	sdev->lockable = sdev->removable;
 	sdev->soft_reset = (inq_result[7] & 1) && ((inq_result[3] & 7) == 2);
+	sdev->ppr = (sdev->inquiry_len > 56 && (inq_result[56] & 0x04) == 0x04);
 
-	if (sdev->scsi_level >= SCSI_3 || (sdev->inquiry_len > 56 &&
-		inq_result[56] & 0x04))
-		sdev->ppr = 1;
 	if (inq_result[7] & 0x60)
 		sdev->wdtr = 1;
 	if (inq_result[7] & 0x10)

