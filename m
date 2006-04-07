Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWDGNwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWDGNwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWDGNwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:52:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:49843 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964793AbWDGNwp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:52:45 -0400
Date: Fri, 7 Apr 2006 19:27:14 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Patch to fix cdrom being confused on using kdump
Message-ID: <20060407135714.GA25569@in.ibm.com>
Reply-To: rachita@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

As we had discussed earlier, I had seen the cdrom drive appearing
confused on using kdump on certain x86_64 systems. During the booting 
up of the second kernel, the following message would keep flooding
the console, and the booting would not proceed any further.

hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)

In this patch, whenever we are hitting a confused state in the interrupt
handler with the DRQ set, we clear the DSC bit of the status register and 
return 'ide_stopped' from the interrupt handler. 

Please provide your comments and feedback.

Thanks
Rachita


Signed-off-by: Rachita Kothiyal <rachita@in.ibm.com>
---

 drivers/ide/ide-cd.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN drivers/ide/ide-cd.c~cdrom-confused-clrinterrupt drivers/ide/ide-cd.c
--- linux-2.6.16-mm2/drivers/ide/ide-cd.c~cdrom-confused-clrinterrupt	2006-03-29 11:23:18.000000000 +0530
+++ linux-2.6.16-mm2-rachita/drivers/ide/ide-cd.c	2006-04-07 19:05:48.962710872 +0530
@@ -1450,6 +1450,11 @@ static ide_startstop_t cdrom_pc_intr (id
 			rq->sense_len += thislen;
 	} else {
 confused:
+		if (( stat & DRQ_STAT) == DRQ_STAT) {
+			/* DRQ is set. Interrupt not welcome now. Ignore */
+			HWIF(drive)->OUTB((stat & 0xEF), IDE_STATUS_REG);
+			return ide_stopped;
+		}
 		printk (KERN_ERR "%s: cdrom_pc_intr: The drive "
 			"appears confused (ireason = 0x%02x)\n",
 			drive->name, ireason);
_
