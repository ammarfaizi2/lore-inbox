Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129681AbRBNNZF>; Wed, 14 Feb 2001 08:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNNY4>; Wed, 14 Feb 2001 08:24:56 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:53705 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129681AbRBNNYW>; Wed, 14 Feb 2001 08:24:22 -0500
Message-ID: <3A8A8937.A77BA18D@uow.edu.au>
Date: Thu, 15 Feb 2001 00:33:43 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org, David Hinds <dhinds@sonic.net>
Subject: Re: [PATCH] network driver updates
In-Reply-To: <Pine.LNX.3.96.1010214020707.28011E-100000@mandrakesoft.mandrakesoft.com> <3A8A7159.AF0E6180@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> I found 2 bugs in several network drivers:
> 
> * dev->mem_start: NULL means "not command line configuration" 0xffffffff
> means "default".
> several drivers only check for NULL, not for 0xffffffff.

I think that's worth another "ewww...", don't you?

> * something is wrong in the vortex initialization: I don't have such a
> card, but the driver didn't return an error message on insmod. I'm not
> sure if my fix is correct.

That was intentional - dhinds suggested that if the hardware
isn't present the driver should float about in memory anyway.
That is the current behaviour of 3c575_cb.c  I forget the
rationale for this.  Perhaps David can remind me?

There are a fair few pending 3c59x updates wrt Linus'
tree - small stuff.  Most are in the zerocopy patch,
and there's a delta on top of that here.


Jeff Garzik wrote:
> 
> 
> IMHO vortex should be trying to initialize EISA regardless of the
> results of the PCI probe... Andrew?

I guess so.  Testing is hard - EISA vorticies are hen's teeth.  I've
heard from only two people who have such hardware in a year.

I've made the below change.  Pending enlightenment from
DavidH and some testing from my sole EISA Vortex person,
I'll flush this stuff out to DavidM.  Thanks.



--- drivers/net/3c59x.c	2001/02/14 11:51:43	1.41
+++ drivers/net/3c59x.c	2001/02/14 13:23:49
@@ -866,8 +866,7 @@
 		}
 
 		rc = vortex_probe1(NULL, ioaddr, inw(ioaddr + 0xC88) >> 12,
-				   EISA_TBL_OFFSET,
-				   vortex_cards_found);
+				   EISA_TBL_OFFSET, vortex_cards_found);
 		if (rc == 0)
 			vortex_cards_found++;
 		else
@@ -1005,7 +1004,7 @@
 		pdev->driver_data = dev;
 
 	/* The lower four bits are the media type. */
-	if (dev->mem_start) {
+	if (dev->mem_start && dev->mem_start != ~0UL) {
 		/*
 		 * AKPM: ewww..  The 'options' param is passed in as the third arg to the
 		 * LILO 'ether=' argument for non-modular use
@@ -2794,18 +2793,17 @@
 
 static int __init vortex_init (void)
 {
-	int rc;
-	
-	rc = pci_module_init(&vortex_driver);
-	if (rc < 0) {
-		rc = vortex_eisa_init();
-		if (rc > 0)
-			vortex_have_eisa = 1;
-	} else {
+	int pci_rc, eisa_rc;
+
+	pci_rc = pci_module_init(&vortex_driver);
+	eisa_rc = vortex_eisa_init();
+
+	if (pci_rc == 0)
 		vortex_have_pci = 1;
-	}
+	if (eisa_rc > 0)
+		vortex_have_eisa = 1;
 
-	return rc;
+	return (vortex_have_pci + vortex_have_eisa) ? 0 : -ENODEV;
 }
