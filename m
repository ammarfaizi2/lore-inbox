Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262494AbRENU5c>; Mon, 14 May 2001 16:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbRENU5M>; Mon, 14 May 2001 16:57:12 -0400
Received: from gso56-168-043.triad.rr.com ([66.56.168.43]:65158 "EHLO
	hlclabs.dynip.com") by vger.kernel.org with ESMTP
	id <S262491AbRENU5J>; Mon, 14 May 2001 16:57:09 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mike Harmon <mikeharmon@usa.net>
Organization: Harmon Liles Computer Labs
To: torvalds@transmeta.com
Subject: [PATCH] Future Domain SCSI controller fix for 2.4.x
Date: Mon, 14 May 2001 17:07:32 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, faith@cs.unc.edu, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01051417073200.06553@hlclabs.dynip.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, the driver for this card seems to have missed out on one of the changes 
to the SCSI layer between 2.2 and 2.4.  Specifically, scsi_set_pci_device 
now wants an entire SCSI host object, instead of just the pci_dev part.   
Without the patch, we get a null kernel pointer dereference when the driver 
is initialized.  With the single-line update, the driver works again.  I've 
also included a patch to change an udelay loop into the equivalent mdelay 
call for code readability purposes.  These are both against 2.4.4; please 
apply.

-- 
Email:  mikeharmon@usa.net


--- linux-2.4.4/drivers/scsi/fdomain.old	Mon May 14 16:33:11 2001
+++ linux-2.4.4/drivers/scsi/fdomain.c	Fri May  4 11:07:41 2001
 
 inline static void fdomain_make_bus_idle( void )
@@ -971,7 +969,7 @@
    	return 0;
    shpnt->irq = interrupt_level;
    shpnt->io_port = port_base;
-   scsi_set_pci_device(shpnt->pci_dev, pdev);
+   scsi_set_pci_device(shpnt, pdev);
    shpnt->n_io_port = 0x10;
    print_banner( shpnt );

 
--- linux-2.4.4/drivers/scsi/fdomain.old	Mon May 14 16:33:11 2001
+++ linux-2.4.4/drivers/scsi/fdomain.c	Fri May  4 11:07:41 2001
@@ -587,9 +587,7 @@
 
 static void do_pause( unsigned amount )	/* Pause for amount*10 
milliseconds */
 {
-   do {
-	udelay(10*1000);
-   } while (--amount);
+   mdelay(10*amount);
 }

ê2¯@2
