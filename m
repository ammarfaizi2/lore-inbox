Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWEYTOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWEYTOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWEYTOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:14:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61834 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030354AbWEYTOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:14:06 -0400
Date: Thu, 25 May 2006 20:13:57 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/10] dm: move idr_pre_get
Message-ID: <20060525191357.GV4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

idr_pre_get() can sleep while allocating memory.

The next patch will change _minor_lock into a spinlock, so this 
patch moves idr_pre_get() outside the lock in preparation.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm.c	2006-05-23 18:16:42.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm.c	2006-05-23 18:16:44.000000000 +0100
@@ -766,6 +766,10 @@ static int specific_minor(struct mapped_
 	if (minor >= (1 << MINORBITS))
 		return -EINVAL;
 
+	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
 	mutex_lock(&_minor_lock);
 
 	if (idr_find(&_minor_idr, minor)) {
@@ -773,16 +777,9 @@ static int specific_minor(struct mapped_
 		goto out;
 	}
 
-	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
-
 	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m);
-	if (r) {
+	if (r)
 		goto out;
-	}
 
 	if (m != minor) {
 		idr_remove(&_minor_idr, m);
@@ -800,13 +797,11 @@ static int next_free_minor(struct mapped
 	int r;
 	unsigned int m;
 
-	mutex_lock(&_minor_lock);
-
 	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
+	if (!r)
+		return -ENOMEM;
+
+	mutex_lock(&_minor_lock);
 
 	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {
