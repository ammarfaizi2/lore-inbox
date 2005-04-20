Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVDTRSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVDTRSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVDTRS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:18:29 -0400
Received: from ns1.coraid.com ([65.14.39.133]:17064 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261735AbVDTRQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:16:08 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
References: <874qe1pejv.fsf@coraid.com>
Subject: [PATCH 2.6.12-rc2] aoe [4/6]: allow multiple aoe devices to have
 the same mac
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 20 Apr 2005 13:06:00 -0400
Message-ID: <87is2hnzt3.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


allow multiple aoe devices to have the same mac

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -u b/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
--- b/drivers/block/aoe/aoedev.c	2005-04-20 11:42:18.000000000 -0400
+++ b/drivers/block/aoe/aoedev.c	2005-04-20 11:42:22.000000000 -0400
@@ -109,25 +109,22 @@
 	spin_lock_irqsave(&devlist_lock, flags);
 
 	for (d=devlist; d; d=d->next)
-		if (d->sysminor == sysminor
-		|| memcmp(d->addr, addr, sizeof d->addr) == 0)
+		if (d->sysminor == sysminor)
 			break;
 
 	if (d == NULL && (d = aoedev_newdev(bufcnt)) == NULL) {
 		spin_unlock_irqrestore(&devlist_lock, flags);
 		printk(KERN_INFO "aoe: aoedev_set: aoedev_newdev failure.\n");
 		return NULL;
-	}
+	} /* if newdev, (d->flags & DEVFL_UP) == 0 for below */
 
 	spin_unlock_irqrestore(&devlist_lock, flags);
 	spin_lock_irqsave(&d->lock, flags);
 
 	d->ifp = ifp;
-
-	if (d->sysminor != sysminor
-	|| (d->flags & DEVFL_UP) == 0) {
+	memcpy(d->addr, addr, sizeof d->addr);
+	if ((d->flags & DEVFL_UP) == 0) {
 		aoedev_downdev(d); /* flushes outstanding frames */
-		memcpy(d->addr, addr, sizeof d->addr);
 		d->sysminor = sysminor;
 		d->aoemajor = AOEMAJOR(sysminor);
 		d->aoeminor = AOEMINOR(sysminor);


-- 
  Ed L. Cashin <ecashin@coraid.com>

