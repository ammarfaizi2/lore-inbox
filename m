Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVGGQW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVGGQW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVGGQWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:22:24 -0400
Received: from graphe.net ([209.204.138.32]:44206 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261360AbVGGQWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:22:00 -0400
Date: Thu, 7 Jul 2005 09:21:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <20050706133052.GF21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507070912140.27066@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> Without this patch a dual Xeon EM64T machine would oops on boot
> because the hwif pointer here was NULL. I also added a check for
> pci_dev because it's doubtful that all IDE devices have pci_devs.

Here is IMHO the right way to fix this. Test for the hwif != NULL and
test for pci_dev != NULL before determining the node number of the pci 
bus that the device is connected to. Maybe we need a hwif_to_node for ide 
drivers that is also able to determine the locality of other hardware?

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.git/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.git.orig/drivers/ide/ide-probe.c	2005-06-23 11:38:02.000000000 -0700
+++ linux-2.6.git/drivers/ide/ide-probe.c	2005-07-07 09:15:04.000000000 -0700
@@ -979,7 +979,8 @@
 	 */
 
 	q = blk_init_queue_node(do_ide_request, &ide_lock,
-				pcibus_to_node(drive->hwif->pci_dev->bus));
+				(drive->hwif && drive->hwif->pci_dev) ?
+				pcibus_to_node(drive->hwif->pci_dev->bus): -1);
 	if (!q)
 		return 1;
 
@@ -1097,7 +1098,8 @@
 		spin_unlock_irq(&ide_lock);
 	} else {
 		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
-			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
+			(hwif->drives[0].hwif && hwif->drives[0].hwif->pci_dev) ?
+			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus) : -1);
 		if (!hwgroup)
 	       		goto out_up;
 
