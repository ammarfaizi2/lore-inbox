Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVKRPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVKRPAr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVKRPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:00:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51608 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750764AbVKRPAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:00:46 -0500
Date: Fri, 18 Nov 2005 15:00:34 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "goggin, edward" <egoggin@emc.com>
Subject: [PATCH] device-mapper ioctl: event on rename
Message-ID: <20051118150034.GO11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	"goggin, edward" <egoggin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After changing the name of a mapped device, trigger a dm event.
(For userspace multipath tools.)

From: "goggin, edward" <egoggin@emc.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14-rc2/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/md/dm-ioctl.c	2005-11-09 22:37:16.000000000 +0000
+++ linux-2.6.14-rc2/drivers/md/dm-ioctl.c	2005-11-10 23:05:33.000000000 +0000
@@ -270,6 +270,7 @@ static int dm_hash_rename(const char *ol
 {
 	char *new_name, *old_name;
 	struct hash_cell *hc;
+	struct dm_table *table;
 
 	/*
 	 * duplicate new.
@@ -317,6 +318,15 @@ static int dm_hash_rename(const char *ol
 	/* rename the device node in devfs */
 	register_with_devfs(hc);
 
+	/*
+	 * Wake up any dm event waiters.
+	 */
+	table = dm_get_table(hc->md);
+	if (table) {
+		dm_table_event(table);
+		dm_table_put(table);
+	}
+
 	up_write(&_hash_lock);
 	kfree(old_name);
 	return 0;
