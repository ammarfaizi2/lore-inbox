Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWFZN1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWFZN1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWFZN1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:27:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38592 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932166AbWFZN1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:27:01 -0400
Subject: PATCH: Old IDE, fix SATA detection for cabling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 14:42:59 +0100
Message-Id: <1151329380.27147.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on the proposed patches flying around but also checks that
the device in question is new enough to have word 93 rather thanb
blindly assuming word 93 == 0 means SATA (see ATA-5, ATA-7)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/ide-iops.c linux-2.6.17/drivers/ide/ide-iops.c
--- linux.vanilla-2.6.17/drivers/ide/ide-iops.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/ide-iops.c	2006-06-26 14:04:52.101408544 +0100
@@ -597,6 +597,10 @@
 {
 	if(HWIF(drive)->udma_four == 0)
 		return 0;
+		
+	/* Check for SATA but only if we are ATA5 or higher */
+	if (drive->id->hw_config == 0 && (drive->id->major_rev_num & 0x7FE0))
+		return 1;
 	if (!(drive->id->hw_config & 0x6000))
 		return 0;
 #ifndef CONFIG_IDEDMA_IVB

