Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWFQUsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWFQUsD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 16:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWFQUsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 16:48:03 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6098 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750869AbWFQUsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 16:48:01 -0400
Date: Sat, 17 Jun 2006 22:47:53 +0200 (MEST)
Message-Id: <200606172047.k5HKlrUU002902@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, marcelo@kvack.org
Subject: [PATCH 2.4.33-rc1] repair __ide_dma_no_op breakage
Cc: willy@w.ods.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 15:14:19 -0300, Marcelo Tosatti wrote:
>Summary of changes from v2.4.33-pre3 to v2.4.33-rc1
...
>Willy TARREAU:
...
>      ide: trying to enable DMA may cause an oops

This patch to ide-dma.c defines a function 'int __ide_dma_no_op(void)'
and stores its address in function pointer fields with type
'int (*)(ide_drive_t*)'. Thus callers will call __ide_dma_no_op() with
more parameters than it expects.

This is invalid C and it will break horribly in some valid calling
conventions (in particular, when parameters are passed on the stack
and the callee not the caller pops them).

Furtunately the fix is simple: just define __ide_dma_no_op() with
the correct prototype (taking an unused ide_drive_t* parameter),
and drop the now redundant casts from the assignments. Also make
__ide_dma_no_op() 'static' as it is local to ide-dma.c.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

diff -rupN linux-2.4.33-rc1/drivers/ide/ide-dma.c linux-2.4.33-rc1.ide-dma-no-op-fix/drivers/ide/ide-dma.c
--- linux-2.4.33-rc1/drivers/ide/ide-dma.c	2006-06-17 17:58:36.000000000 +0200
+++ linux-2.4.33-rc1.ide-dma-no-op-fix/drivers/ide/ide-dma.c	2006-06-17 18:12:31.000000000 +0200
@@ -572,7 +572,7 @@ static int dma_timer_expiry (ide_drive_t
  *	This empty function prevents non-DMA controllers from causing an oops.
  */
 
-int __ide_dma_no_op (void)
+static int __ide_dma_no_op (ide_drive_t *ignored)
 {
 	return 0;
 }
@@ -1235,11 +1235,11 @@ EXPORT_SYMBOL_GPL(ide_setup_dma);
 void ide_setup_no_dma (ide_hwif_t *hwif)
 {
 	if (!hwif->ide_dma_off_quietly)
-		hwif->ide_dma_off_quietly = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+		hwif->ide_dma_off_quietly = &__ide_dma_no_op;
 	if (!hwif->ide_dma_host_off)
-		hwif->ide_dma_host_off = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+		hwif->ide_dma_host_off = &__ide_dma_no_op;
 	if (!hwif->ide_dma_host_on)
-		hwif->ide_dma_host_on = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+		hwif->ide_dma_host_on = &__ide_dma_no_op;
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_no_dma);
