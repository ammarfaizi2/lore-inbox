Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVAUR5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVAUR5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVAUR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:57:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51358 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262429AbVAUR5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:57:33 -0500
Date: Fri, 21 Jan 2005 17:57:20 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: device-mapper: fix mirror log type module ref count
Message-ID: <20050121175720.GF10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix module reference counting for mirror log type.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-log.c	2005-01-12 15:21:22.000000000 +0000
+++ source/drivers/md/dm-log.c	2005-01-12 18:55:17.000000000 +0000
@@ -17,9 +17,6 @@
 
 int dm_register_dirty_log_type(struct dirty_log_type *type)
 {
-	if (!try_module_get(type->module))
-		return -EINVAL;
-
 	spin_lock(&_lock);
 	type->use_count = 0;
 	list_add(&type->list, &_log_types);
@@ -34,10 +31,8 @@
 
 	if (type->use_count)
 		DMWARN("Attempt to unregister a log type that is still in use");
-	else {
+	else
 		list_del(&type->list);
-		module_put(type->module);
-	}
 
 	spin_unlock(&_lock);
 
@@ -51,6 +46,10 @@
 	spin_lock(&_lock);
 	list_for_each_entry (type, &_log_types, list)
 		if (!strcmp(type_name, type->name)) {
+			if (!type->use_count && !try_module_get(type->module)){
+				spin_unlock(&_lock);
+				return NULL;
+			}
 			type->use_count++;
 			spin_unlock(&_lock);
 			return type;
@@ -63,7 +62,8 @@
 static void put_type(struct dirty_log_type *type)
 {
 	spin_lock(&_lock);
-	type->use_count--;
+	if (!--type->use_count)
+		module_put(type->module);
 	spin_unlock(&_lock);
 }
 
