Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266027AbUFVVIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUFVVIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUFVVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:08:17 -0400
Received: from mail.dif.dk ([193.138.115.101]:29643 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266040AbUFVVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:04:39 -0400
Date: Tue, 22 Jun 2004 23:03:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Mark Lord <mlord@pobox.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] check_region removal - trm290.c
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F96@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch to remove check_region from drivers/ide/pci/trm190.c

As far as I can see this should not make the driver any less safe than it
currently is, but as Guennadi Liakhovetski has pointed out to me
previously, it doesn't look quite safe that the driver tries to access
ports before request_region gets called from ide_hwif_request_regions()
Unfortunately I'm not quite sure how to rework the driver properly to
make sure it's safe (suggestions welcome).

Anyway, this gets us one step closer to being able to get rid of
check_region() completely, and I don't see how it can do any harm. If the
drivers port access is currently broken, then it's no less broken with
this patch and we gain the bennefit of one less warning and one less
check_region user.
Comments on how to fix this up better are welcome as well as comments on
whether or not it's sufficient and safe to just get rid of check_region
without any further changes.
Patch below is against 2.6.7


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/ide/pci/trm290.c	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.7/drivers/ide/pci/trm290.c	2004-06-22 22:53:10.000000000 +0200
@@ -3,6 +3,10 @@
  *
  *  Copyright (c) 1997-1998  Mark Lord
  *  May be copied or modified under the terms of the GNU General Public License
+ *
+ *  June 22, 2004 - get rid of check_region
+ *                  Jesper Juhl <juhl-lkml@dif.dk>
+ *
  */

 /*
@@ -372,16 +376,6 @@ void __devinit init_hwif_trm290(ide_hwif
 		if (old != compat && old_mask == 0xff) {
 			/* leave lower 10 bits untouched */
 			compat += (next_offset += 0x400);
-#  if 1
-			if (check_region(compat + 2, 1))
-				printk(KERN_ERR "%s: check_region failure at 0x%04x\n",
-					hwif->name, (compat + 2));
-			/*
-			 * The region check is not needed; however.........
-			 * Since this is the checked in ide-probe.c,
-			 * this is only an assignment.
-			 */
-#  endif
 			hwif->io_ports[IDE_CONTROL_OFFSET] = compat + 2;
 			hwif->OUTW(compat|1, hwif->config_data);
 			new = hwif->INW(hwif->config_data);


--
Jesper Juhl <juhl-lkml@dif.dk>

