Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKROyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKROyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKROyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:54:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750747AbVKROyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:54:39 -0500
Date: Fri, 18 Nov 2005 14:54:33 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stefan Bader <Stefan.Bader@de.ibm.com>
Subject: [PATCH] device-mapper dm-mpath: endio spinlock fix
Message-ID: <20051118145433.GJ11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Stefan Bader <Stefan.Bader@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_end_io() can be called without interrupts blocked.

From: Stefan Bader <Stefan.Bader@de.ibm.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-mpath.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/md/dm-mpath.c	2005-11-17 22:22:28.000000000 +0000
@@ -1000,6 +1000,7 @@ static int do_end_io(struct multipath *m
 {
 	struct hw_handler *hwh = &m->hw_handler;
 	unsigned err_flags = MP_FAIL_PATH;	/* Default behavior */
+	unsigned long flags;
 
 	if (!error)
 		return 0;	/* I/O complete */
@@ -1010,17 +1011,17 @@ static int do_end_io(struct multipath *m
 	if (error == -EOPNOTSUPP)
 		return error;
 
-	spin_lock(&m->lock);
+	spin_lock_irqsave(&m->lock, flags);
 	if (!m->nr_valid_paths) {
 		if (!m->queue_if_no_path) {
-			spin_unlock(&m->lock);
+			spin_unlock_irqrestore(&m->lock, flags);
 			return -EIO;
 		} else {
-			spin_unlock(&m->lock);
+			spin_unlock_irqrestore(&m->lock, flags);
 			goto requeue;
 		}
 	}
-	spin_unlock(&m->lock);
+	spin_unlock_irqrestore(&m->lock, flags);
 
 	if (hwh->type && hwh->type->error)
 		err_flags = hwh->type->error(hwh, bio);
@@ -1040,12 +1041,12 @@ static int do_end_io(struct multipath *m
 	dm_bio_restore(&mpio->details, bio);
 
 	/* queue for the daemon to resubmit or fail */
-	spin_lock(&m->lock);
+	spin_lock_irqsave(&m->lock, flags);
 	bio_list_add(&m->queued_ios, bio);
 	m->queue_size++;
 	if (!m->queue_io)
 		queue_work(kmultipathd, &m->process_queued_ios);
-	spin_unlock(&m->lock);
+	spin_unlock_irqrestore(&m->lock, flags);
 
 	return 1;	/* io not complete */
 }
