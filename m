Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTILP0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTILP0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:26:38 -0400
Received: from vlugnet.org ([217.160.107.28]:38568 "EHLO vlugnet.org")
	by vger.kernel.org with ESMTP id S261507AbTILP0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:26:36 -0400
From: Ronny Buchmann <ronny-lkml@vlugnet.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Date: Fri, 12 Sep 2003 17:26:01 +0200
User-Agent: KMail/1.5.3
References: <200309091406.56334.ronny-lkml@vlugnet.org> <200309121624.41989.ronny-lkml@vlugnet.org> <200309121642.19966.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200309121642.19966.bzolnier@elka.pw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marko Kreen <marko@l-t.ee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309121726.01792.ronny-lkml@vlugnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 12 September 2003 16:42 schrieben Sie:
> On Friday 12 of September 2003 16:24, Ronny Buchmann wrote:
> > Am Freitag 12 September 2003 14:58 schrieb Bartlomiej Zolnierkiewicz:
> > > On Friday 12 of September 2003 12:48, Alan Cox wrote:
> > > > On Gwe, 2003-09-12 at 10:41, Ronny Buchmann wrote:
> > > > > -	d->channels = 1;
> > > > > +	d->channels = 2;
> > > >
> > > > Need to work out which 372N and others are dual channel but yes
> > >
> > > No, "d->channels = 1" is only executed for orginal HPT366 which has
> > > separate PCI configurations for first and second channel.  For HPT372N
> > > you have correct value in hpt366.h - ".channels = 2".
Some of the HPT372N (including mine) have the same device id as the HPT366 (0004),
they differ only in revision (rev 6 is 372N).

(this logic is already used in other functions)

--- linux-2.4.22-ac1/drivers/ide/pci/hpt366.c.orig	2003-09-11 21:29:06.000000000 +0200
+++ linux-2.4.22-ac1/drivers/ide/pci/hpt366.c	2003-09-12 17:13:31.000000000 +0200
@@ -1343,7 +1343,7 @@
 	u8 pin1 = 0, pin2 = 0;
 	unsigned int class_rev;
 	static char *chipset_names[] = {"HPT366", "HPT366",  "HPT368",
-				 "HPT370", "HPT370A", "HPT372"};
+				 "HPT370", "HPT370A", "HPT372", "HPT372N"};
 
 	if (PCI_FUNC(dev->devfn) & 1)
 		return;
@@ -1351,16 +1351,11 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-	/* New ident 372N reports revision 1. We could do the 
-	   io port based type identification instead perhaps (DID, RID) */
-	   
-	if(d->device == PCI_DEVICE_ID_TTI_HPT372N)
-		class_rev = 5;
-		
-	if(class_rev < 6)
+	if(class_rev <= 6)
 		d->name = chipset_names[class_rev];
 
 	switch(class_rev) {
+		case 6:
 		case 5:
 		case 4:
 		case 3: ide_setup_pci_device(dev, d);

Since the 372N with the new id (0009) is set up with init_setup_37x(), "class_rev = 5" is never executed.

So the second part of the previous patch is wrong.

-- 
ronny


