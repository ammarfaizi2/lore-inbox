Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUFRSew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUFRSew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUFRSew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:34:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45546 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266680AbUFRScS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:32:18 -0400
Date: Fri, 18 Jun 2004 11:32:12 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Patch for USB 2.4.26 - jumpshot's capacity
Message-Id: <20040618113212.0016be5a@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another victim of SCSI standards which make devices return
the address of the last sector instead of the number of sectors.
Just about every other driver which emulates SCSI fails to report
capacity right. I blame Shurgart & Associates for this.

Made from a 2.6 patch by Alan Stern.

-- Pete

diff -urp -X dontdiff linux-2.4.27-pre6/drivers/usb/storage/jumpshot.c linux-2.4.27-pre5-usbx/drivers/usb/storage/jumpshot.c
--- linux-2.4.27-pre6/drivers/usb/storage/jumpshot.c	2003-06-13 07:51:37.000000000 -0700
+++ linux-2.4.27-pre5-usbx/drivers/usb/storage/jumpshot.c	2004-06-17 22:21:12.000000000 -0700
@@ -710,15 +710,8 @@ int jumpshot_transport(Scsi_Cmnd * srb, 
 
 		// build the reply
 		//
-		ptr[0] = (info->sectors >> 24) & 0xFF;
-		ptr[1] = (info->sectors >> 16) & 0xFF;
-		ptr[2] = (info->sectors >> 8) & 0xFF;
-		ptr[3] = (info->sectors) & 0xFF;
-
-		ptr[4] = (info->ssize >> 24) & 0xFF;
-		ptr[5] = (info->ssize >> 16) & 0xFF;
-		ptr[6] = (info->ssize >> 8) & 0xFF;
-		ptr[7] = (info->ssize) & 0xFF;
+		((u32 *) ptr)[0] = cpu_to_be32(info->sectors - 1);
+		((u32 *) ptr)[1] = cpu_to_be32(info->ssize);
 
 		return USB_STOR_TRANSPORT_GOOD;
 	}
