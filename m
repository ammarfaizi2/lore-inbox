Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVIZVvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVIZVvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIZVvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:51:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39308 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932330AbVIZVvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:51:55 -0400
Date: Mon, 26 Sep 2005 22:50:45 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "goggin, edward" <egoggin@emc.com>
Subject: [PATCH] device-mapper: Trigger an event when a table is deleted
Message-ID: <20050926215045.GC5526@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	"goggin, edward" <egoggin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If anything is waiting on a device's table when the device is 
removed, we must first wake it up so it will release its reference.
Otherwise the table's reference count will not drop to zero
and the table will not get removed.

From: "goggin, edward" <egoggin@emc.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14-rc2/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/md/dm-ioctl.c	2005-09-20 04:00:41.000000000 +0100
+++ linux-2.6.14-rc2/drivers/md/dm-ioctl.c	2005-09-26 22:36:37.000000000 +0100
@@ -230,11 +230,20 @@
 
 static void __hash_remove(struct hash_cell *hc)
 {
+	struct dm_table *table;
+
 	/* remove from the dev hash */
 	list_del(&hc->uuid_list);
 	list_del(&hc->name_list);
 	unregister_with_devfs(hc);
 	dm_set_mdptr(hc->md, NULL);
+
+	table = dm_get_table(hc->md);
+	if (table) {
+		dm_table_event(table);
+		dm_table_put(table);
+	}
+
 	dm_put(hc->md);
 	if (hc->new_map)
 		dm_table_put(hc->new_map);
