Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUI0Bpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUI0Bpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 21:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUI0Bpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 21:45:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265477AbUI0Bpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 21:45:42 -0400
Date: Sun, 26 Sep 2004 18:43:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc2-mm2 pcmcia oops
Message-Id: <20040926184327.79e05988.akpm@osdl.org>
In-Reply-To: <20040926221614.GB1466@mail.muni.cz>
References: <20040926221614.GB1466@mail.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@fi.muni.cz> wrote:
>
> Unable to handle kernel paging request at virtual address 0000ffff
>   printing eip:
>  c0402097
>  *pde = 00000000
>  Oops: 0002 [#1]
>  PREEMPT 
>  Modules linked in: yenta_socket pcmcia_core i830 ehci_hcd uhci_hcd rtc
>  CPU:    0
>  EIP:    0060:[<c0402097>]    Tainted:  P   VLI
>  EFLAGS: 00010246   (2.6.9-rc2-mm2) 
>  EIP is at quirk_usb_early_handoff+0x0/0x3e
>  eax: 0000ffff   ebx: c035d954   ecx: c6866000   edx: 00020000
>  esi: c6866000   edi: c035da4c   ebp: ceede380   esp: c7f4bed8
>  ds: 007b   es: 007b   ss: 0068
>  Process pccardd (pid: 3386, threadinfo=c7f4a000 task=c5ea2d70)
>  Stack: c01d2076 c6866000 c6866000 ceede380 00000000 c01d20ba c6866000 c035d81c 
>         c035da4c c01d01ce 00000000 c6866000 00000000 00000000 c01d0214 ceede380 
>         00000000 c686642c ceede380 ceede394 c7f4a000 cfbdd0de ceede380 00000000 
>  Call Trace:
>   [<c01d2076>] pci_do_fixups+0x49/0x4b

Well quirk_usb_early_handoff() should be __devinit, not __init.

There are a few other things in there which look hotpluggy, and are marked
__init.  The whole thing needs a review.


diff -puN drivers/pci/quirks.c~pci-quirk-section-fixes drivers/pci/quirks.c
--- 25/drivers/pci/quirks.c~pci-quirk-section-fixes	2004-09-26 18:41:35.933120712 -0700
+++ 25-akpm/drivers/pci/quirks.c	2004-09-26 18:42:05.859571200 -0700
@@ -869,7 +869,7 @@ static int __init usb_handoff_early(char
 }
 __setup("usb-handoff", usb_handoff_early);
 
-static void __init quirk_usb_handoff_uhci(struct pci_dev *pdev)
+static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {
 	unsigned long base = 0;
 	int wait_time, delta;
@@ -922,7 +922,7 @@ static void __init quirk_usb_handoff_uhc
 		
 }
 
-static void __init quirk_usb_handoff_ohci(struct pci_dev *pdev)
+static void __devinit quirk_usb_handoff_ohci(struct pci_dev *pdev)
 {
 	void __iomem *base;
 	int wait_time;
@@ -952,7 +952,7 @@ static void __init quirk_usb_handoff_ohc
 	iounmap(base);
 }
 
-static void __init quirk_usb_disable_ehci(struct pci_dev *pdev)
+static void __devinit quirk_usb_disable_ehci(struct pci_dev *pdev)
 {
 	int wait_time, delta;
 	void __iomem *base, *op_reg_base;
@@ -1042,7 +1042,7 @@ static void __init quirk_usb_disable_ehc
 
 
 
-static void __init quirk_usb_early_handoff(struct pci_dev *pdev)
+static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
 {
 	if (!usb_early_handoff)
 		return;
_

