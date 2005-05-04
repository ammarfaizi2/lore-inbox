Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVEDHOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVEDHOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVEDHOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:14:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:61929 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262065AbVEDHLo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:11:44 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: allow multiple aoe devices to have the same mac
In-Reply-To: <1115190696161@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:11:36 -0700
Message-Id: <11151906962505@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: allow multiple aoe devices to have the same mac

allow multiple aoe devices to have the same mac

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -u b/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c

---
commit 93d489fc56f819d8805d80ae83cbafc5e5719804
tree 946adcae0abe20dc6d9d58682ea2d6980efd1a4c
parent 67d9f84786cc4fd42cb40c9474c248eadaff15c6
author Ed L Cashin <ecashin@coraid.com> 1114784662 -0400
committer Greg KH <gregkh@suse.de> 1115188494 -0700

Index: drivers/block/aoe/aoedev.c
===================================================================
--- f1ef2e8c1d1f1b21969704666f20ac1dbec42197/drivers/block/aoe/aoedev.c  (mode:100644 sha1:ec16c64dd114c37b30f2f97bb5e8f895c0a6e9bb)
+++ 946adcae0abe20dc6d9d58682ea2d6980efd1a4c/drivers/block/aoe/aoedev.c  (mode:100644 sha1:6e231c5a119958dd3549e5d825f4706f9d04f9ec)
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

