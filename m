Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVCYUAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVCYUAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVCYUAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:00:40 -0500
Received: from grerelbul01.net.external.hp.com ([155.208.255.36]:15295 "EHLO
	grerelbul01.net.external.hp.com") by vger.kernel.org with ESMTP
	id S261771AbVCYUAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:00:06 -0500
Date: Fri, 25 Mar 2005 20:59:22 +0100
From: Bruno Cornec <Bruno.Cornec@hp.com>
To: James Bottomley <jejb@steeleye.com>, linux-megaraid-devel@dell.com,
       linux-scsi@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Bruno Cornec <Bruno.Cornec@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, tvignaud@mandrakesoft.com
Subject: Re: megaraid driver (proposed patch)
Message-ID: <20050325195922.GG8591@morley.grenoble.hp.com>
References: <20050325182252.GA4268@morley.grenoble.hp.com> <1111775992.5692.25.camel@mulgrave> <20050325184718.GA15215@infradead.org> <1111777477.5692.29.camel@mulgrave> <20050325190732.GA15497@infradead.org> <1111778657.5692.40.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111778657.5692.40.camel@mulgrave>
X-Humor: Linux is to Windows what early music is to military music
X-Operating-System: Linux morley.grenoble.hp.com 2.6.8.1-24mdk
X-Current-Uptime: 18:53:12 up 21 days,  4:37,  1 user,  load average: 0.51, 0.33, 0.27
X-HP-HOWTO-URL: http://www.HyPer-Linux.org/HP-HOWTO/current
X-URL: http://eurolinux.grenoble.hp.com/
X-eurolinux: ftp://eurolinux.grenoble.hp.com/pub/linux
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After a first attempt of discussion on lkml, I'd like to get your
feedback on the following points.

I've noticed that since recent kernel versions, it's not possible
anymore to use simultaneously new and old megaraid driver.

It seems to have been introduced by that changeset:
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/scsi/megaraid/Kconfig.megar
aid@1.1??nav=index.html|src/.|src/drivers|src/drivers/scsi|src/drivers/scsi/mega
raid|hist/drivers/scsi/megaraid/Kconfig.megaraid

It particularly makes life of people developing kernel for distro
difficult as it forces them to drop support for legacy hardware which is
working just fine with 2.6, or to patch their own kernel build.
As well it prevents simultaneous usage of new and old cards in the same
system.

As notes by James Bottomley and Christoph Hellwig the best thing to do
is probably to remove support for cards in the old driver that are still
supported by the new driver.

I'd like to propose a patch but looking at the code I have the following
question: the card id 101E:1960 seems to be supported by the new driver
as per the header of megaraid_mbox.c but in reality I was unable to boot
my system which uses that precise card with the new driver.

Are they mistakes in the header file ? Should they be removed from the
new driver (if they don't work) or from the old if they work ?

My current status is the following (just for discussion)

diff -Nru drivers/scsi/megaraid/Kconfig.megaraid
drivers.new/scsi/megaraid/Kconfig.megaraid
--- drivers/scsi/megaraid/Kconfig.megaraid      Fri Mar 25 20:34:06 2005
+++ drivers.new/scsi/megaraid/Kconfig.megaraid  Fri Mar 25 20:53:37 2005
@@ -64,15 +64,12 @@
        To compile this driver as a module, choose M here: the
        module will be called megaraid_mbox
 
-if MEGARAID_NEWGEN=n
 config MEGARAID_LEGACY
        tristate "LSI Logic Legacy MegaRAID Driver"
        depends on PCI && SCSI
        help
        This driver supports the LSI MegaRAID 418, 428, 438, 466, 762,
490
-       and 467 SCSI host adapters. This driver also support the all
        U320
-       RAID controllers
+       and 467 SCSI host adapters.
 
        To compile this driver as a module, choose M here: the
        module will be called megaraid
-endif
diff -Nru drivers/scsi/megaraid.c drivers.new/scsi/megaraid.c
--- drivers/scsi/megaraid.c     Fri Mar 25 20:28:29 2005
+++ drivers.new/scsi/megaraid.c Fri Mar 25 20:57:25 2005
@@ -5033,12 +5033,6 @@
 }
 
 static struct pci_device_id megaraid_pci_tbl[] = {
-       {PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DISCOVERY,
-               PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-       {PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_PERC4_DI,
-               PCI_ANY_ID, PCI_ANY_ID, 0, 0, BOARD_64BIT},
-       {PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_PERC4_QC_VERDE,
-               PCI_ANY_ID, PCI_ANY_ID, 0, 0, BOARD_64BIT},
        {PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
        {PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID2,
diff -Nru drivers/scsi/megaraid.h drivers.new/scsi/megaraid.h
--- drivers/scsi/megaraid.h     Fri Mar 25 20:28:25 2005
+++ drivers.new/scsi/megaraid.h Fri Mar 25 20:57:03 2005
@@ -73,10 +73,6 @@
 #define PCI_DEVICE_ID_AMI_MEGARAID3    0x1960
 #endif
 
-#define PCI_DEVICE_ID_DISCOVERY                0x000E
-#define PCI_DEVICE_ID_PERC4_DI         0x000F
-#define PCI_DEVICE_ID_PERC4_QC_VERDE   0x0407
-
 /* Sub-System Vendor IDs */
 #define        AMI_SUBSYS_VID                  0x101E
 #define DELL_SUBSYS_VID                        0x1028

-- 
Linux Solution Consultant   /   Open Source Evangelist   \    HP C&I EMEA ISG
HP/Intel Solution Center http://hpintelco.net Hewlett-Packard Grenoble/France
Des infos sur Linux?  http://www.HyPer-Linux.org      http://www.hp.com/linux
La musique ancienne?  http://www.musique-ancienne.org http://www.medieval.org
