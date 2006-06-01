Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWFASal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWFASal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWFASal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:30:41 -0400
Received: from rtr.ca ([64.26.128.89]:58558 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750769AbWFASal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:30:41 -0400
Message-ID: <447F3250.5070101@rtr.ca>
Date: Thu, 01 Jun 2006 14:30:40 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: State of resume for AHCI?
References: <447F23C2.8030802@goop.org>
In-Reply-To: <447F23C2.8030802@goop.org>
Content-Type: multipart/mixed;
 boundary="------------030800020008080802040106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800020008080802040106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The one-line "resume fix" (attached) *might* be all that you need.
This is in current Linus 2.6.17-rc*-git*

Cheers

--------------030800020008080802040106
Content-Type: text/x-patch;
 name="resume_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resume_fix.patch"

Return-Path: <linux-ide-owner@vger.kernel.org>
X-Original-To: liml@rtr.ca
Delivered-To: liml@rtr.ca
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail.rtr.ca (Postfix) with ESMTP id 2DCD7830162
	for <liml@rtr.ca>; Sun, 28 May 2006 11:28:07 -0400 (EDT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWE1P2E (ORCPT <rfc822;liml@rtr.ca>);
	Sun, 28 May 2006 11:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWE1P2D
	(ORCPT <rfc822;linux-ide-outgoing>); Sun, 28 May 2006 11:28:03 -0400
Received: from rtr.ca ([64.26.128.89]:19922 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750768AbWE1P2C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 May 2006 11:28:02 -0400
Received: from silvy.localnet (silvy.localnet [10.0.0.14])
	by mail.rtr.ca (Postfix) with ESMTP id D0C538300A1;
	Sun, 28 May 2006 11:28:00 -0400 (EDT)
From: Mark Lord <liml@rtr.ca>
Organization: Real-Time Remedies Inc.
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] 2.6.17-rc5: the latest consensus libata resume fix
Date:	Sun, 28 May 2006 11:28:00 -0400
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
	"zhao, forrest" <forrest.zhao@intel.com>,
	Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
References: <200605272245.30108.axboe@suse.de> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F681.8050607@garzik.org>
In-Reply-To: <4478F681.8050607@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605281128.00532.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-ide@vger.kernel.org

Okay, just to sum things up.

The patch below is the current "release candidate" for
improving the libata/ata_piix resume functionality in 2.6.17-rc*.

It forces libata to wait for up to 2 seconds for BUSY|DRQ to clear
on resume before continuing.  This is only for 2.6.17 at present.

We are waiting on Jens to test and report back for this specific version.

Signed-off-by:  Mark Lord <liml@rtr.ca>
---
--- linux-2.6.17-rc5/drivers/scsi/libata-core.c
+++ linux/drivers/scsi/libata-core.c
@@ -4296,6 +4296,7 @@ static int ata_start_drive(struct ata_po
  */
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------030800020008080802040106--
