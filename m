Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKRO6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKRO6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVKRO6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:58:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46231 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750762AbVKRO6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:58:40 -0500
Date: Fri, 18 Nov 2005 14:58:37 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>
Subject: [PATCH] device-mapper: add dm_find_md
Message-ID: <20051118145837.GM11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	David Teigland <teigland@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract dm_find_md() from dm_get_mdptr() to allow use elsewhere.

From: David Teigland <teigland@redhat.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm.c	2005-11-18 14:40:40.000000000 +0000
+++ linux-2.6.14/drivers/md/dm.c	2005-11-18 14:40:48.000000000 +0000
@@ -913,10 +913,9 @@ int dm_create_with_minor(unsigned int mi
 	return create_aux(minor, 1, result);
 }
 
-void *dm_get_mdptr(dev_t dev)
+static struct mapped_device *dm_find_md(dev_t dev)
 {
 	struct mapped_device *md;
-	void *mdptr = NULL;
 	unsigned minor = MINOR(dev);
 
 	if (MAJOR(dev) != _major || minor >= (1 << MINORBITS))
@@ -925,12 +924,22 @@ void *dm_get_mdptr(dev_t dev)
 	down(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
-
-	if (md && (dm_disk(md)->first_minor == minor))
-		mdptr = md->interface_ptr;
+	if (!md || (dm_disk(md)->first_minor != minor))
+		md = NULL;
 
 	up(&_minor_lock);
 
+	return md;
+}
+
+void *dm_get_mdptr(dev_t dev)
+{
+	struct mapped_device *md;
+	void *mdptr = NULL;
+
+	md = dm_find_md(dev);
+	if (md)
+		mdptr = md->interface_ptr;
 	return mdptr;
 }
 
