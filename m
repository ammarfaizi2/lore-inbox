Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbUKTS2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUKTS2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUKTS2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:28:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:59274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263141AbUKTS2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:28:50 -0500
Date: Sat, 20 Nov 2004 10:28:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Len Brown <len.brown@intel.com>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <20041120124001.GA2829@stusta.de>
Message-ID: <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe>
 <20041120124001.GA2829@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Nov 2004, Adrian Bunk wrote:
> 
> With your patch, the boot failure goes away.
> This was with a kernel without Linus' patch applied.

It boots for me too, but it all seems pretty accidental.

In particular, the code will disable irq12 (mouse interrupt), so the mouse
has no chance of working. Having tested it, it so happens that if I boot
with a mouse actually conntected, the BIOS will not use irq12 for PCI
devices, so that will hide the problem since ACPI won't try to disable it
when it doesn't see it.

But if I had more PCI devices, or another legacy device that doesn't have
the same kind of "test if something is connected" logic, it really looks
like it would break again. (It's entirely possible that Windows has the
exact same issue, of course, at which point it's fairly safe to say that 
manufacturers will have tested this and just not done it, but I don't feel 
all that safe making that assumption).

So I think the simpler fix is just this one-liner: we should not disable
preexisting links, because non-PCI devices may depend on the same routing
information, and thus the comments about "being activated on use" is not
actually true.

		Linus

===== drivers/acpi/pci_link.c 1.34 vs edited =====
--- 1.34/drivers/acpi/pci_link.c	2004-11-01 23:40:09 -08:00
+++ edited/drivers/acpi/pci_link.c	2004-11-20 09:43:56 -08:00
@@ -685,9 +685,6 @@
 	acpi_link.count++;
 
 end:
-	/* disable all links -- to be activated on use */
-	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
-
 	if (result)
 		kfree(link);
 
