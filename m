Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWF3WCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWF3WCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWF3WCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:02:39 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:58077 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751257AbWF3WCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:02:39 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Alessio Sangalli <alesan@manoweb.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
Date: Sat, 1 Jul 2006 00:03:30 +0200
User-Agent: KMail/1.7.2
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 1377;
	Body=7 Fuz1=7 Fuz2=7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. We don't actually have any quirks at all for the 82440MX, and that's 
> almost certainly _not_ because it doesn't do something strange (all Intel 
> host bridges have magic IO ranges), but simply because we haven't hit it 
> yet.
> 
> And I can't find the docs for the PCI config space for that dang thing.
> 
> I bet that there's some magic SMBus IO-range that the 440MX decodes using 
> a special magic config setting.
> 
> Has anybody found the config space docs for the 82440MX? 

nope. but from the docs available i would _guess_ this thing is really
similar to the 82443BX/82371AB combination. at least the SMBus base address
register is hidden at the very same place (32bit at 0x90 in function 3 of the
"south" brigde)...so the attached little patch might be enough to fix things...

Alessio, could you try that one on top of a kernel that shows the problem?

rgds
-daniel

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4364d79..1d26a64 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -401,6 +401,8 @@ static void __devinit quirk_piix4_acpi(s
 	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi );
+
 
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
