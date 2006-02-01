Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWBAI7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWBAI7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 03:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWBAI7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 03:59:18 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:42429 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751101AbWBAI7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 03:59:18 -0500
To: Alan Cox <alan@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jeremy Higdon <jeremy@sgi.com>
Subject: [patch] SGIIOC4 limit request size
From: Jes Sorensen <jes@sgi.com>
Date: 01 Feb 2006 03:59:16 -0500
Message-ID: <yq0vevzpi8r.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one takes care of a problem with the SGI IOC4 driver where it
hits DMA problems if the request grows too large.

Cheers,
Jes

Avoid requests larger than the number of SG table entries, to avoid
DMA timeouts.

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 drivers/ide/pci/sgiioc4.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (C) 2003, 2006 Silicon Graphics, Inc.  All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -613,6 +613,12 @@
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->INB = &sgiioc4_INB;
+
+	/*
+	 * Limit the request size to avoid DMA timeouts when
+	 * requesting  more entries than goes in the sg table.
+	 */
+	hwif->rqsize = 127;
 }
 
 static int __devinit
