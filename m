Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUIXRQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUIXRQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268933AbUIXQfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:35:37 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:34179 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S268911AbUIXQRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:17:11 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
Date: Fri, 24 Sep 2004 10:16:46 -0600
User-Agent: KMail/1.7
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "David Brownell" <david-b@pacbell.net>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "David Brownell" <dbrownell@users.sourceforge.net>,
       "Roman Weissgaerber" <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net, "K.R. Foley" <kr@cybsft.com>
References: <414F8CFB.3030901@cybsft.com> <20040924125500.GB9369@elte.hu> <25766.195.245.190.94.1096034422.squirrel@195.245.190.94>
In-Reply-To: <25766.195.245.190.94.1096034422.squirrel@195.245.190.94>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uhEVBMvDJ6U8xrf"
Message-Id: <200409241016.46201.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_uhEVBMvDJ6U8xrf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

My box has:

0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at f5e70000 (32-bit, non-prefetchable)

0000:00:0f.2 Class 0c03: 1166:0220 (rev 05)

The attached patch (which applies on top of Rui's patch for
ALI M5237) fixes the problem for my DL360.  Here's the relevant
output:

ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
ohci_hcd 0000:00:0f.2: irq 10, pci mem 0xf5e70000
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.2: Serverworks OSB4/CSB5 init quirk
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.2

Thanks for chasing this down!

--Boundary-00=_uhEVBMvDJ6U8xrf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ohci_pci-serverworks-quirk-initreset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ohci_pci-serverworks-quirk-initreset.patch"

diff -u -ur 2.6.9-rc2-mm2-orig/drivers/usb/host/ohci-pci.c 2.6.9-rc2-mm2/drivers/usb/host/ohci-pci.c
--- 2.6.9-rc2-mm2-orig/drivers/usb/host/ohci-pci.c	2004-09-24 09:52:43.000000000 -0600
+++ 2.6.9-rc2-mm2/drivers/usb/host/ohci-pci.c	2004-09-24 09:50:44.000000000 -0600
@@ -102,6 +102,13 @@
 			ohci_info (ohci, "ALI M5237 init quirk\n");
 		}
 
+		/* Serverworks OSB4/CSB5 also acts wierd during init */
+		else if (pdev->vendor == PCI_VENDOR_ID_SERVERWORKS
+				&& pdev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4USB) {
+			ohci->flags = OHCI_QUIRK_INITRESET;
+			ohci_info (ohci, "Serverworks OSB4/CSB5 init quirk\n");
+		}
+
 	}
 
 	/* NOTE: there may have already been a first reset, to

--Boundary-00=_uhEVBMvDJ6U8xrf--
