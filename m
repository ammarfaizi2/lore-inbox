Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUF3T5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUF3T5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUF3T5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:57:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48320 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261857AbUF3T5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:57:07 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2/4: DM: kcopyd.c: make client_add() return void
Date: Wed, 30 Jun 2004 14:57:55 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406301452.16886.kevcorry@us.ibm.com>
In-Reply-To: <200406301452.16886.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301457.55233.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kcopyd.c: client_add() can return void instead of an int, which will eliminate
an unnecessary error path in kcopyd_client_create().

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/kcopyd.c	2004-06-30 08:48:15.384847256 -0500
+++ source/drivers/md/kcopyd.c	2004-06-30 08:48:19.528217368 -0500
@@ -573,12 +573,11 @@
 static DECLARE_MUTEX(_client_lock);
 static LIST_HEAD(_clients);
 
-static int client_add(struct kcopyd_client *kc)
+static void client_add(struct kcopyd_client *kc)
 {
 	down(&_client_lock);
 	list_add(&kc->list, &_clients);
 	up(&_client_lock);
-	return 0;
 }
 
 static void client_del(struct kcopyd_client *kc)
@@ -668,15 +667,7 @@
 		return r;
 	}
 
-	r = client_add(kc);
-	if (r) {
-		dm_io_put(nr_pages);
-		client_free_pages(kc);
-		kfree(kc);
-		kcopyd_exit();
-		return r;
-	}
-
+	client_add(kc);
 	*result = kc;
 	return 0;
 }
