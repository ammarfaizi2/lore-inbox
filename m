Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVI0On0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVI0On0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVI0OnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:43:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964804AbVI0OnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:43:25 -0400
Date: Tue, 27 Sep 2005 07:42:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stian Jordet <liste@jordet.nu>
cc: Olaf Hering <olh@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
In-Reply-To: <1127831274.433956ea35992@webmail.jordet.nu>
Message-ID: <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org>
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
 <1127831274.433956ea35992@webmail.jordet.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Stian Jordet wrote:
> 
> He wanted me to test 2.6.12-rc2-mm3, which actually disabled irq9 as
> well at boottime. After some debugging, he made this patch, which made
> irq 9 work as normal again for me. Please don't back this patch out,
> without at least re-looking at my system.

Well, looking at your messages, I bet that the appended patch works for 
you, since your irq's are all in the legacy range.

It is also conceptually closer to what the code _used_ to be (it used to
say "if we have an IO-APIC, don't do this", now it says "if this irq is
bound to an IO-APIC, don't do this")

Whether this will matter to Olaf, I don't know, but the old code was 
definitely just writing random bits for the IO-APIC case afaik.

		Linus

---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -546,7 +546,10 @@ static void quirk_via_irq(struct pci_dev
 {
 	u8 irq, new_irq;
 
-	new_irq = dev->irq & 0xf;
+	new_irq = dev->irq;
+	if (!new_irq || new_irq >= 15)
+		return;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
 		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
