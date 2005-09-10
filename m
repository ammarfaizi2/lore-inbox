Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbVIJGAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbVIJGAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 02:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVIJGAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 02:00:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030496AbVIJGAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 02:00:35 -0400
Date: Fri, 9 Sep 2005 22:59:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miguel <frankpoole@terra.es>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: PCI bug in 2.6.13
Message-Id: <20050909225956.42021440.akpm@osdl.org>
In-Reply-To: <20050909180405.3e356c2a.frankpoole@terra.es>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel <frankpoole@terra.es> wrote:
>
> After switching from 2.6.13-rc7 to 2.6.13 I've started to have corrupted
>  data written on my hard disks, there was appearing blocks of 0x00 bytes
>  in between the data. I've tracked when this started to happen in the git
>  patches and I've found that this bug is due to the changes done in the
>  file drivers/pci/setup-res.c of 2.6.13-rc7-git2 patch. Now I run a 2.6.13
>  kernel with that file unmodified and everything is ok.

Ugly.   I assume you're referring to this?

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=50d6685dcbcce801682c9600a81be2a98f90f8a1;hp=5598b4714f77ac2efaf0f545e404b4c9163c4fcf;hb=755528c860b05fcecda1c88a2bdaffcb50760a7f;f=drivers/pci/setup-res.c


Ignore disabled ROM resources at setup

Writing even a disabled value seems to mess up some matrox graphics
cards.  It may be a card-related issue, but we may also be writing
reserved low bits in the result.

This was a fall-out of switching x86 over to the generic PCI resource
allocation code, and needs more debugging.  In particular, the old x86
code defaulted to not doing any resource allocations at all for ROM
resources.

In the meantime, this has been reported to make X happier by Helge
Hafting <helgehaf@aitel.hist.no>.


diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -53,7 +53,9 @@ pci_update_resource(struct pci_dev *dev,
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		new |= res->flags & IORESOURCE_ROM_ENABLE;
+		if (!(res->flags & IORESOURCE_ROM_ENABLE))
+			return;
+		new |= PCI_ROM_ADDRESS_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */


