Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUIXOBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUIXOBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUIXOBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:01:49 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:23975 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268753AbUIXOBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:01:45 -0400
Message-ID: <25766.195.245.190.94.1096034422.squirrel@195.245.190.94>
In-Reply-To: <20040924125500.GB9369@elte.hu>
References: <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
    <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
    <20040923122838.GA9252@elte.hu>
    <24137.195.245.190.93.1095946528.squirrel@195.245.190.93>
    <20040923134000.GA15455@elte.hu>
    <35929.195.245.190.93.1095956611.squirrel@195.245.190.93>
    <48836.195.245.190.94.1095962870.squirrel@195.245.190.94>
    <1076.195.245.190.93.1096029825.squirrel@195.245.190.93>
    <20040924125500.GB9369@elte.hu>
Date: Fri, 24 Sep 2004 15:00:22 +0100 (WEST)
Subject: Re: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "David Brownell" <david-b@pacbell.net>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "David Brownell" <dbrownell@users.sourceforge.net>,
       "Roman Weissgaerber" <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net, "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040924150022_79840"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 24 Sep 2004 14:01:43.0007 (UTC) FILETIME=[05608EF0:01C4A23F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20040924150022_79840
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> Then, in a silent suggestion from David Brownell, I hacked ohci_hcd.c,
>> forcing the OHCI_QUIRK_INITRESET flag behaviour, build a new kernel and
>> modules and voila', all USB is back to functionality.
>
>
> it would be cleaner to make this dependent on your chipset/vendor-id -
> look how OHCI_QUIRK_INITRESET gets activated for e.g. SiS
> (PCI_VENDOR_ID_SI) and OPTi (PCI_VENDOR_ID_OPTI). What is your box's
> pdev->vendor and pdev->device? (lspci -v) (If it's indeed a quirk that
> is needed, not some other fix.)
>

Here it is:

(lspci -n)

00:02.0 Class 0c03: 10b9:5237 (rev 03)

(lspci -v)

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2


So I made it strictly specific to this hardware vendor PCI_VENDOR_ID_AL
(0x10b9) and device PCI_DEVICE_ID_AL_M5237 (0x5237).

The attached patch applies now to ohci_pci.c and it just works for me (tm:)

Thanks for the suggestion Ingo.

I feel better now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20040924150022_79840
Content-Type: text/plain; name="ohci_pci-ali-m5237-quirk-initreset.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="ohci_pci-ali-m5237-quirk-initreset.patch"

diff -duPNr linux.1/drivers/usb/host/ohci-pci.c linux.2/drivers/usb/host/ohci-pci.c
--- linux.1/drivers/usb/host/ohci-pci.c	2004-09-24 14:15:37.146541120 +0100
+++ linux.2/drivers/usb/host/ohci-pci.c	2004-09-24 14:26:20.147790072 +0100
@@ -95,6 +95,13 @@
 			ohci_info(ohci, "SiS init quirk\n");
 		}
 	
+		/* ALI M5237 also acts wierd during init */
+		else if (pdev->vendor == PCI_VENDOR_ID_AL
+				&& pdev->device == PCI_DEVICE_ID_AL_M5237) {
+			ohci->flags = OHCI_QUIRK_INITRESET;
+			ohci_info (ohci, "ALI M5237 init quirk\n");
+		}
+
 	}
 
 	/* NOTE: there may have already been a first reset, to
------=_20040924150022_79840--


