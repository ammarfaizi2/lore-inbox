Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVCVGFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVCVGFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVCVGDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:03:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:20443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262491AbVCVGBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:01:25 -0500
Date: Mon, 21 Mar 2005 22:01:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mika Kukkonen <mikukkon@gmail.com>
Cc: ambx1@neo.rr.com, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile warning in drivers/pnp/resource.c with
 !CONFIG_PCI
Message-Id: <20050321220100.1fe68929.akpm@osdl.org>
In-Reply-To: <4301cff605032110402f521ce8@mail.gmail.com>
References: <4301cff605032110402f521ce8@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Kukkonen <mikukkon@gmail.com> wrote:
>
> 
>  With !CONFIG_PCI I get following warning:
> 
>    CC      drivers/pnp/resource.o
>  drivers/pnp/resource.c:24: warning: `pnp_skip_pci_scan' defined but not used
> 
>  Two ways to fix this, first one would be to simply #ifdef the
>  variable. But the variable
>  in question is not (according to cscope) actually used outside this
>  one other place (and reason why it became a warning now is that Adrian
>  made it static), and so the code inside CONFIG_PCI is actually relying
>  on the fact that the variable is implicitly initialized to 0.
>  So the patch just deletes the variable.

Well Adam might actually have meant to set pnp_skip_pci_scan with a __setup
thingy.

Your patch was wildly wordwrapped.

We have a cute macro for that pci_dev walk.

I queued this up:


--- 25/drivers/pnp/resource.c~fix-compile-warning-in-drivers-pnp-resourcec-with-config_pci	2005-03-21 21:57:11.000000000 -0800
+++ 25-akpm/drivers/pnp/resource.c	2005-03-21 21:58:49.000000000 -0800
@@ -21,7 +21,6 @@
 #include <linux/pnp.h>
 #include "base.h"
 
-static int pnp_skip_pci_scan;				/* skip PCI resource scanning */
 static int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
 static int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
 static int pnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
@@ -385,9 +384,9 @@ int pnp_check_irq(struct pnp_dev * dev, 
 
 #ifdef CONFIG_PCI
 	/* check if the resource is being used by a pci device */
-	if (!pnp_skip_pci_scan) {
-		struct pci_dev * pci = NULL;
-		while ((pci = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci)) != NULL) {
+	{
+		struct pci_dev *pci = NULL;
+		for_each_pci_dev(pci) {
 			if (pci->irq == *irq)
 				return 0;
 		}
_

