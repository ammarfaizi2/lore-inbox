Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUKWSGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUKWSGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbUKWSEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:04:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40629 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261429AbUKWSCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:02:49 -0500
Date: Tue, 23 Nov 2004 10:02:47 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: ub: oops with preempt ("Sahara Workshop")
Message-ID: <20041123100247.2ea47e2d@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I admit that the code should be locked properly instead, but the global plan
is to drop all P3 tagged printks anyway. So let it be guarded for the moment.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>

--- linux-2.6.10-rc2-bk8-ub/drivers/block/ub.c	2004-11-16 17:03:02.000000000 -0800
+++ linux-2.6.10-rc1-ub/drivers/block/ub.c	2004-11-07 19:01:03.000000000 -0800
@@ -1535,8 +1535,11 @@
 
 	ub_revalidate(sc);
 	/* This is pretty much a long term P3 */
-	printk(KERN_INFO "%s: device %u capacity nsec %ld bsize %u\n",
-	    sc->name, sc->dev->devnum, sc->capacity.nsec, sc->capacity.bsize);
+	if (!atomic_read(&sc->poison)) {		/* Cover sc->dev */
+		printk(KERN_INFO "%s: device %u capacity nsec %ld bsize %u\n",
+		    sc->name, sc->dev->devnum,
+		    sc->capacity.nsec, sc->capacity.bsize);
+	}
 
 	/* XXX Support sector size switching like in sr.c */
 	blk_queue_hardsect_size(disk->queue, sc->capacity.bsize);
