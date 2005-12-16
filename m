Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVLPTJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVLPTJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVLPTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:09:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:63638 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932342AbVLPTJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:09:43 -0500
Date: Fri, 16 Dec 2005 11:08:55 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de
Subject: [patch 3/4] PCI: Fix dumb bug in mmconfig fix
Message-ID: <20051216190855.GD4594@kroah.com>
References: <20051216185442.633779000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-dumb-bug-in-mmconfig-fix.patch"
In-Reply-To: <20051216190828.GA4594@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>

Use correct address when referencing mmconfig aperture while checking
for broken MCFG.  This was a typo when porting the code from 64bit to
32bit.  It caused oopses at boot on some ThinkPads.

Should definitely go into 2.6.15.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/pci/mmconfig.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/arch/i386/pci/mmconfig.c
+++ gregkh-2.6/arch/i386/pci/mmconfig.c
@@ -155,7 +155,7 @@ static __init void unreachable_devices(v
 		addr = get_base_addr(0, 0, PCI_DEVFN(i, 0));
 		if (addr != 0)
 			pci_exp_set_dev_base(addr, 0, PCI_DEVFN(i, 0));
-		if (addr == 0 || readl((u32 __iomem *)addr) != val1)
+		if (addr == 0 || readl((u32 __iomem *)mmcfg_virt_addr) != val1)
 			set_bit(i, fallback_slots);
 		spin_unlock_irqrestore(&pci_config_lock, flags);
 	}

--
