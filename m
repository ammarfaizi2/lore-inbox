Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268322AbUHQQLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbUHQQLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUHQQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:11:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21705 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268319AbUHQQLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:11:34 -0400
Date: Tue, 17 Aug 2004 12:10:36 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PATCH: Make the SCAN_HWIF/UNREGISTER_HWIF stuff private
Message-ID: <20040817161036.GA22966@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Until we can kill these off here is a simple change that removes the
pci_dev check and just stops users unloading interfaces not created by
SCAN_HWIF. That cleans up all the unloading of hotplug device corner
cases and stops users breaking things by killing live non generic devices.

Not sure what your current code looks like but a variant of the theory should
apply to any version of the code independantly.

--- include/linux/ide.h~	2004-08-17 17:07:53.907433024 +0100
+++ include/linux/ide.h	2004-08-17 17:07:53.907433024 +0100
@@ -982,6 +982,7 @@
 	unsigned	present    : 1;	/* this interface exists logically (ie users) */
 	unsigned	configured : 1;	/* this hwif exists and is set up (may not be "present") */
 	unsigned	hold       : 1; /* this interface is always present */
+	unsigned	user_dev   : 1; /* user ioctl created device */
 	unsigned	serialized : 1;	/* serialized all channel operation */
 	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
 	unsigned	reset      : 1;	/* reset after probe */
--- drivers/ide/ide.c~	2004-08-17 17:07:15.589258272 +0100
+++ drivers/ide/ide.c	2004-08-17 17:07:15.589258272 +0100
@@ -1796,6 +1796,7 @@
 		case HDIO_SCAN_HWIF:
 		{
 			hw_regs_t hw;
+			ide_hwif_t *hwif;
 			int args[3];
 			if (!capable(CAP_SYS_RAWIO)) return -EACCES;
 			if (copy_from_user(args, p, 3 * sizeof(int)))
@@ -1804,15 +1805,16 @@
 			ide_init_hwif_ports(&hw, (unsigned long) args[0],
 					    (unsigned long) args[1], NULL);
 			hw.irq = args[2];
-			if (ide_register_hw(&hw, NULL) == -1)
+			if (ide_register_hw(&hw, &hwif) == -1)
 				return -EIO;
+			hwif->user_dev = 1;
 			return 0;
 		}
 	        case HDIO_UNREGISTER_HWIF:
 			if (!capable(CAP_SYS_RAWIO)) return -EACCES;
 			if(arg > MAX_HWIFS || arg < 0)
 				return -EINVAL;
-			if(ide_hwifs[arg].pci_dev)
+			if(!ide_hwifs[arg].user_dev)
 				return -EINVAL;
 			return ide_unregister_hwif(&ide_hwifs[arg]);
 		case HDIO_SET_NICE:
