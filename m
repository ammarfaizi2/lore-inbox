Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVCOGYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVCOGYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVCOGYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:24:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:21972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262277AbVCOGYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:24:47 -0500
Date: Mon, 14 Mar 2005 22:24:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Enrico Bartky" <DOSProfi@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMbus not enabled
Message-Id: <20050314222431.1d64f84c.akpm@osdl.org>
In-Reply-To: <833993817@web.de>
References: <833993817@web.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Enrico Bartky" <DOSProfi@web.de> wrote:
>
> my notebook have a SiS 964 Chipset and "quirked" by "quirk_sis_503", ...
> but there is no SMbus device. If I add a call to the "quirk_sis_96x_smbus"
> function directly from the "quirk_sis_503" function, the smbus is present,
> but I think a call to a quirk from a quirk is not optimal. Is there a better
> solution?

(Please wrap your email lines before column 80)

What version of the kernel are you using?

I assume that you mean that the machine does have SMBus, but that it is not
being recognised by the kernel?

It could be that we don't have the appropriate PCI IDs in there.  Please
run `lspci -vvxx' and send the part which is relevant to the SMBus
interface.

Also, in drivers/pci/quirks.c you can change `#undef DEBUG' to `#define
DEBUG' and it will print useful information.

This patch will help, too:

--- 25/drivers/pci/quirks.c~a	2005-03-14 22:23:08.000000000 -0800
+++ 25-akpm/drivers/pci/quirks.c	2005-03-14 22:23:57.000000000 -0800
@@ -1262,6 +1262,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
 	while (f < end) {
+		pr_debug(PCI: quirks: inspecting %04x:%04x\n",
+			dev->vendor, dev->device);
 		if ((f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
  		    (f->device == dev->device || f->device == (u16) PCI_ANY_ID)) {
 			pr_debug("PCI: Calling quirk %p for %s\n", f->hook, pci_name(dev));
_

