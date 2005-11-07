Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVKGVCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVKGVCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVKGVCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:02:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39564 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932288AbVKGVCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:02:42 -0500
Date: Mon, 7 Nov 2005 15:02:39 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dlm: configfs lock
Message-ID: <20051107210239.GA4287@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need to hold the subsys semaphore while accessing the children list.

Signed-off-by: David Teigland <teigland@redhat.com>

----

diff -ur a/drivers/dlm/config.c b/drivers/dlm/config.c
--- a/drivers/dlm/config.c	2005-08-22 14:48:26.450499104 +0800
+++ b/drivers/dlm/config.c	2005-08-22 14:49:36.767809248 +0800
@@ -627,12 +627,14 @@
 static struct comm *get_comm(int nodeid, struct sockaddr_storage *addr)
 {
 	struct config_item *i;
-	struct comm *cm;
+	struct comm *cm = NULL;
 	int found = 0;
 
 	if (!comm_list)
 		return NULL;
 
+	down(&clusters_root.subsys.su_sem);
+
 	list_for_each_entry(i, &comm_list->cg_children, ci_entry) {
 		cm = to_comm(i);
 
@@ -649,6 +651,7 @@
 			break;
 		}
 	}
+	up(&clusters_root.subsys.su_sem);
 
 	if (found)
 		config_item_get(i);
