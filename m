Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSBERPj>; Tue, 5 Feb 2002 12:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289661AbSBERP3>; Tue, 5 Feb 2002 12:15:29 -0500
Received: from iere.net.avaya.com ([198.152.12.101]:23721 "EHLO
	iere.net.avaya.com") by vger.kernel.org with ESMTP
	id <S289659AbSBERPQ>; Tue, 5 Feb 2002 12:15:16 -0500
Message-ID: <029b01c1ae68$5df20b20$12320987@dr.avaya.com>
From: "Roger Massey" <rmassey@avaya.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17 panic on boot - patch for ide-pci
Date: Tue, 5 Feb 2002 10:13:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-OriginalArrivalTime: 05 Feb 2002 17:15:46.0765 (UTC) FILETIME=[C03587D0:01C1AE68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kr7a-raid (hpt372 raid) motherboard.i The 2.4.17 kernel
(plus the 2.4.xx variants on the redhat 7.2 and mandrake 8.1)
panic during boot.

I have found the problem is in ide-pci.c (and a similar one in
hpt366.c) and diff -u follows below.

The code of interest begins at line 835 (2.4.17 base):
The hpt372 returns a class_rev of  5  which is not expected
by the switch statement.

        pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
        class_rev &= 0xff;

        strcpy(d->name, chipset_names[class_rev]);

        switch(class_rev) {
                case 4:
                case 3: printk("%s: IDE controller on PCI bus %02x dev
%02x\n",d->name, dev->bus->number, dev->devfn);
                        ide_setup_pci_device(dev, d);
                        return;
                default:        break;
        }

The patch makes this code more defensive by using the highest known
class_rev if one is returned which is higher.

Also, for class_rev == 4, the strcpy copies a 7 byte string over
a 6 byte one ("HPT370A" over "HPT366") so I added a strncpy
to make this more defensive as well.

Roger Massey

////////////////////////////////////////////////////////////////////////////
////////////////////////////
--- drivers/ide/ide-pci.c Mon Feb  4 19:44:02 2002
+++ drivers/ide/ide-pci.orig.c Mon Feb  4 19:37:50 2002
@@ -836,11 +836,7 @@
  pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
  class_rev &= 0xff;

- if(class_rev >= (sizeof(chipset_names)/sizeof(char *))) {
-  class_rev = (sizeof(chipset_names)/sizeof(char *)) - 1;
- }
-
- strncpy(d->name, chipset_names[class_rev], strlen(d->name));
+ strcpy(d->name, chipset_names[class_rev]);

  switch(class_rev) {
   case 4:
--- drivers/ide/hpt366.c Mon Feb  4 19:32:45 2002
+++ drivers/ide/hpt366.orig.c Mon Feb  4 19:33:30 2002
@@ -214,9 +214,6 @@
  pci_read_config_dword(bmide_dev, PCI_CLASS_REVISION, &class_rev);
  class_rev &= 0xff;

- if(class_rev >= (sizeof(chipset_names)/sizeof(char *)))
-  class_rev = (sizeof(chipset_names)/sizeof(char *)) -1;
-
         /*
          * at that point bibma+0x2 et bibma+0xa are byte registers
          * to investigate:



