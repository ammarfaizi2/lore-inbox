Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVHPV4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVHPV4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVHPV4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:56:04 -0400
Received: from magic.adaptec.com ([216.52.22.17]:13245 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750980AbVHPV4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:56:03 -0400
Message-ID: <430260E6.4090108@adaptec.com>
Date: Tue, 16 Aug 2005 17:55:50 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
CC: Jim Houston <jim.houston@ccur.com>
Subject: [PATCH 2.4.12.5 1/2] lib: allow idr to be used in irq context
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 21:53:34.0996 (UTC) FILETIME=[F34DBD40:01C5A2AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch allows idr to be used in irq context.

idr_pre_get() is necessary to be called before
idr_get_new() is called.  No locking is necessary when
calling idr_pre_get().

But idr_get_new(), idr_find() and idr_remove()
must be serialized with respect to each other.

All of the aforementioned, may end up in alloc_layer()
or free_layer() which grabs the idp lock using spin_lock.

If idr_get_new() or idr_remove() is used in IRQ context,
then we may get a lockup when idr_pre_get was called
in process context and an IRQ interrupted while it held
the idp lock.

This patch changes the spin_lock to spin_lock_irqsave,
and spin_unlock to spin_unlock_irqrestore, to allow
idr_get_new(), idr_find() and idr_remove() to be
called from IRQ context, while idr_pre_get() to be
called in process context.

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

--- linux-2.6.12.5/lib/idr.c.old	2005-08-16 17:20:08.000000000 -0400
+++ linux-2.6.12.5/lib/idr.c	2005-08-16 17:22:16.000000000 -0400
@@ -37,27 +37,29 @@
 static struct idr_layer *alloc_layer(struct idr *idp)
 {
 	struct idr_layer *p;
+	unsigned long flags;
 
-	spin_lock(&idp->lock);
+	spin_lock_irqsave(&idp->lock, flags);
 	if ((p = idp->id_free)) {
 		idp->id_free = p->ary[0];
 		idp->id_free_cnt--;
 		p->ary[0] = NULL;
 	}
-	spin_unlock(&idp->lock);
+	spin_unlock_irqrestore(&idp->lock, flags);
 	return(p);
 }
 
 static void free_layer(struct idr *idp, struct idr_layer *p)
 {
+	unsigned long flags;
 	/*
 	 * Depends on the return element being zeroed.
 	 */
-	spin_lock(&idp->lock);
+	spin_lock_irqsave(&idp->lock, flags);
 	p->ary[0] = idp->id_free;
 	idp->id_free = p;
 	idp->id_free_cnt++;
-	spin_unlock(&idp->lock);
+	spin_unlock_irqrestore(&idp->lock, flags);
 }
 
 /**
