Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSIEUG5>; Thu, 5 Sep 2002 16:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSIEUG5>; Thu, 5 Sep 2002 16:06:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54998 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318026AbSIEUG4>; Thu, 5 Sep 2002 16:06:56 -0400
Date: Thu, 5 Sep 2002 22:11:27 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Christoph Hellwig <hch@infradead.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <paulkf@microgate.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Fix .text.exit error with static compile of synclinkmp.c
In-Reply-To: <20020905184359.A9907@infradead.org>
Message-ID: <Pine.NEB.4.44.0209052147500.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Christoph Hellwig wrote:

> > The problem is that the __exit function synclinkmp_remove_one is referred
> > to in "static struct pci_driver synclinkmp_pci_driver".
> >
> > The fix is simple:
>
> And wrong.  Please use __devexit_p() instead.


Yes, that sounds like a better idea. What about the following patch?


--- drivers/char/synclinkmp.c.old	2002-09-05 21:29:11.000000000 +0200
+++ drivers/char/synclinkmp.c	2002-09-05 21:33:32.000000000 +0200
@@ -506,8 +506,8 @@
 static char *driver_name = "SyncLink MultiPort driver";
 static char *driver_version = "$Revision: 3.17 $";

-static int __init synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
-static void __exit synclinkmp_remove_one(struct pci_dev *dev);
+static int __devinit synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
+static void __devexit synclinkmp_remove_one(struct pci_dev *dev);

 static struct pci_device_id synclinkmp_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_SCA, PCI_ANY_ID, PCI_ANY_ID, },
@@ -519,7 +519,7 @@
 	name:		"synclinkmp",
 	id_table:	synclinkmp_pci_tbl,
 	probe:		synclinkmp_init_one,
-	remove:		synclinkmp_remove_one,
+	remove:		__devexit_p(synclinkmp_remove_one),
 };


@@ -5595,8 +5595,8 @@
 }


-static int __init synclinkmp_init_one (struct pci_dev *dev,
-				       const struct pci_device_id *ent)
+static int __devinit synclinkmp_init_one (struct pci_dev *dev,
+				          const struct pci_device_id *ent)
 {
 	if (pci_enable_device(dev)) {
 		printk("error enabling pci device %p\n", dev);
@@ -5606,6 +5606,6 @@
 	return 0;
 }

-static void __exit synclinkmp_remove_one (struct pci_dev *dev)
+static void __devexit synclinkmp_remove_one (struct pci_dev *dev)
 {
 }

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


