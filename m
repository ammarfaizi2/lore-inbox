Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUIXLg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUIXLg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268693AbUIXLg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:36:26 -0400
Received: from zero.aec.at ([193.170.194.10]:22791 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268690AbUIXLgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:36:25 -0400
To: Suresh Siddha <suresh.b.siddha@intel.com>
cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for
 E7520/E7320/E7525
References: <2HSdY-7dr-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 24 Sep 2004 13:36:16 +0200
In-Reply-To: <2HSdY-7dr-3@gated-at.bofh.it> (Suresh Siddha's message of
 "Fri, 24 Sep 2004 09:00:19 +0200")
Message-ID: <m3mzzf99vz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh Siddha <suresh.b.siddha@intel.com> writes:

> Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
> with x86 mach-default

And breaks compilation with MSI on. Here's a hackish workaround
that will probably fail with >64 CPUs.
Proper fix would be to fix MSI to deal with cpumasks properly

-Andi

diff -u linux/drivers/pci/msi.c-o linux/drivers/pci/msi.c
--- linux/drivers/pci/msi.c-o	2004-09-24 13:03:44.000000000 +0200
+++ linux/drivers/pci/msi.c	2004-09-24 13:34:18.000000000 +0200
@@ -282,7 +282,8 @@
 	msi_address->lo_address.u.dest_mode = MSI_DEST_MODE;
 	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
 	msi_address->lo_address.u.dest_id = dest_id;
-	msi_address->lo_address.value |= (MSI_TARGET_CPU << MSI_TARGET_CPU_SHIFT);
+	/* FIXME: broken for >64 CPUs */
+	msi_address->lo_address.value |= (*cpus_addr(MSI_TARGET_CPU) << MSI_TARGET_CPU_SHIFT);
 }
 
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
diff -u linux/include/asm-x86_64/smp.h-o linux/include/asm-x86_64/smp.h

