Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVBVOoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVBVOoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVBVOoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:44:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:936 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262324AbVBVOoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:44:15 -0500
Date: Tue, 22 Feb 2005 14:44:02 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Tim Burgess <tim.burgess@anu.edu.au>
Subject: [PATCH] device-mapper: dm-raid1 deadlock fix
Message-ID: <20050222144402.GI10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Tim Burgess <tim.burgess@anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a dm-raid1 deadlock: nested spinlocks with _irq.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Tim Burgess <tim.burgess@anu.edu.au>
--- diff/drivers/md/dm-raid1.c	2005-02-22 14:35:14.000000000 +0000
+++ source/drivers/md/dm-raid1.c	2005-02-22 14:35:01.000000000 +0000
@@ -253,9 +253,9 @@
 	else {
 		__rh_insert(rh, nreg);
 		if (nreg->state == RH_CLEAN) {
-			spin_lock_irq(&rh->region_lock);
+			spin_lock(&rh->region_lock);
 			list_add(&nreg->list, &rh->clean_regions);
-			spin_unlock_irq(&rh->region_lock);
+			spin_unlock(&rh->region_lock);
 		}
 		reg = nreg;
 	}
