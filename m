Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVCUSka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVCUSka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVCUSka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:40:30 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:57171 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261461AbVCUSkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:40:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=l+gfOh+ET7F/gZAwq3SiEaHhY0qa8EmHtaEkwdkzTLuwjRkaS3upBW2MZzIb0RFLi4HUYDRr1jKuTV6VxPiGOh+0omp0N+jjrliinxmfc2L0ZAbF3EmSpX/bmhYLqNX2rvSSVfS6smfAY5g2/dGBko/Wrghl+W8zllFo24nC9AI=
Message-ID: <4301cff605032110402f521ce8@mail.gmail.com>
Date: Mon, 21 Mar 2005 20:40:19 +0200
From: Mika Kukkonen <mikukkon@gmail.com>
Reply-To: Mika Kukkonen <mikukkon@gmail.com>
To: ambx1@neo.rr.com, perex@suse.cz
Subject: [PATCH] Fix compile warning in drivers/pnp/resource.c with !CONFIG_PCI
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With !CONFIG_PCI I get following warning:

  CC      drivers/pnp/resource.o
drivers/pnp/resource.c:24: warning: `pnp_skip_pci_scan' defined but not used

Two ways to fix this, first one would be to simply #ifdef the
variable. But the variable
in question is not (according to cscope) actually used outside this
one other place (and reason why it became a warning now is that Adrian
made it static), and so the code inside CONFIG_PCI is actually relying
on the fact that the variable is implicitly initialized to 0.
So the patch just deletes the variable.

--MiKu

Signed-off-by: Mika Kukkonen (mikukkon@gmail.com)

--- 1.25/drivers/pnp/resource.c 2005-03-14 01:29:58 +02:00
+++ edited/resource.c   2005-03-21 19:41:54 +02:00
@@ -21,7 +21,6 @@
 #include <linux/pnp.h>
 #include "base.h"

-static int pnp_skip_pci_scan;                          /* skip PCI
resource scanning */
 static int pnp_reserve_irq[16] = { [0 ... 15] = -1 };  /* reserve
(don't use) some IRQ */
 static int pnp_reserve_dma[8] = { [0 ... 7] = -1 };    /* reserve
(don't use) some DMA */
 static int pnp_reserve_io[16] = { [0 ... 15] = -1 };   /* reserve
(don't use) some I/O region */
@@ -385,7 +384,7 @@

 #ifdef CONFIG_PCI
        /* check if the resource is being used by a pci device */
-       if (!pnp_skip_pci_scan) {
+       {
                struct pci_dev * pci = NULL;
                while ((pci = pci_find_device(PCI_ANY_ID, PCI_ANY_ID,
pci)) != NULL) {
                        if (pci->irq == *irq)
