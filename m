Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWIGXld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWIGXld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWIGXlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:41:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:31637 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751741AbWIGXlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:41:31 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 8 Sep 2006 01:40:29 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 1/2] ieee1394: sbp2: don't prefer MODE SENSE 10
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.9abbd263c892fb65@s5r6.in-berlin.de>
Message-ID: <tkrat.99b311c66a739310@s5r6.in-berlin.de>
References: <tkrat.9abbd263c892fb65@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the old days, sbp2 used to coerce all MODE SENSE commands into the
10 bytes version.  When all command set conversions were removed from
sbp2 several months ago, sdev->use_10_for_ms = 1 was added.  Meaning,
higher SCSI layers preferred the 10 bytes version but would try the 6
bytes version if the former failed.

Recently, a problem with the 10 bytes version was discovered.  An Initio
INIC-1530 firmware accepted the 10 bytes version but replied with bogus
data, showing the HDD incorrectly as write-protected.  Since RBC
actually mandates MODE SENSE (6), I checked which version was sent by
Windows XP and Mac OS X 10.3 to an SBP-2 target hosted by Linux --- it
was the 6 bytes version.  (Exception: OS X sent the 10 bytes version to
an MMC target.  RBC and SBC got MODE SENSE (6).)

Therefore, drop the use_10_for_ms flag from sbp2.  Now the upper layers
will try MODE SENSE (6) before MODE SENSE (10) on all SBP-2 devices.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Long story, short patch.  This supercedes patch "ieee1394: sbp2:
workaround for write protect bit of Initio firmware".

Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-09-06 23:51:42.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-09-07 00:35:09.000000000 +0200
@@ -2529,7 +2529,6 @@ static int sbp2scsi_slave_configure(stru
 
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
 	sdev->use_10_for_rw = 1;
-	sdev->use_10_for_ms = 1;
 
 	if (sdev->type == TYPE_DISK &&
 	    scsi_id->workarounds & SBP2_WORKAROUND_MODE_SENSE_8)


