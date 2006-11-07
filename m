Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754252AbWKGSa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbWKGSa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbWKGSa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:30:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754252AbWKGSaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:30:55 -0500
Date: Tue, 7 Nov 2006 18:30:46 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 2.6.19 2/5] dm: suspend: fix error path
Message-ID: <20061107183046.GD6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already suspended, just return the error and skip the
code that would incorrectly wipe md->suspended_bdev.

(This isn't currently a problem because existing code avoids
calling this function if the device is already suspended.)

Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc4/drivers/md/dm.c
===================================================================
--- linux-2.6.19-rc4.orig/drivers/md/dm.c	2006-11-07 17:06:27.000000000 +0000
+++ linux-2.6.19-rc4/drivers/md/dm.c	2006-11-07 17:07:57.000000000 +0000
@@ -1285,7 +1285,7 @@ int dm_suspend(struct mapped_device *md,
 	down(&md->suspend_lock);
 
 	if (dm_suspended(md))
-		goto out;
+		goto out_unlock;
 
 	map = dm_get_table(md);
 
@@ -1361,6 +1361,8 @@ out:
 	}
 
 	dm_table_put(map);
+
+out_unlock:
 	up(&md->suspend_lock);
 	return r;
 }
