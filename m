Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVBTDjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVBTDjB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 22:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVBTDjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 22:39:00 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34236 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261503AbVBTDi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 22:38:58 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
	 <1108863372.8413.158.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 19 Feb 2005 22:38:51 -0500
Message-Id: <1108870731.8413.163.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 18:10 -0800, Linus Torvalds wrote:

> I _think_ it's the code in arch/i386/pci/fixup.c that does this. See the
> 
> 	static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)
> 
> thing, and try to disable it. Maybe that rule is wrong, and triggers much 
> too often?
> 

Linus,

Thank you very much! That was it.  The following patch made everything
look good.

--- arch/i386/pci/fixup.c.orig	2005-02-19 22:22:29.622416639 -0500
+++ arch/i386/pci/fixup.c	2005-02-19 22:20:39.562713691 -0500
@@ -208,7 +208,9 @@
 static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)
 {
 	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
-	    (dev->device & 0xff00) == 0x2400)
+	    (dev->device & 0xff00) == 0x2400 &&
+	    /* the 2448 bridge is not transparent */
+	    dev->device != 0x2448)
 		dev->transparent = 1;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_fixup_transparent_bridge);



PCMCIA cards now show up. Although I still have yet to get one of mine
working, but that's because of the card and not the bridge. Now I need
to start downloading drivers for my card. But at least the kernel now
sees them!

Thanks again,

-- Steve


