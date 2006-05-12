Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWELXod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWELXod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWELXod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:33 -0400
Received: from mx.pathscale.com ([64.160.42.68]:32681 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932185AbWELXoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:32 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 53] ipath - fix spinlock recursion bug
X-Mercurial-Node: 9b9f24aab3505e192ed1021ac0636dcd1d620395
Message-Id: <9b9f24aab3505e192ed1.1147477366@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:46 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The local loopback path for RC can lock the rkey table lock without
blocking interrupts.  The receive interrupt path can then call
ipath_rkey_ok() and deadlock.  Since the lock only protects a 64 bit read,
the lock isn't needed.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 89f7c69a68bf -r 9b9f24aab350 drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Fri May 12 15:55:27 2006 -0700
@@ -136,9 +136,7 @@ int ipath_lkey_ok(struct ipath_lkey_tabl
 		ret = 1;
 		goto bail;
 	}
-	spin_lock(&rkt->lock);
 	mr = rkt->table[(sge->lkey >> (32 - ib_ipath_lkey_table_size))];
-	spin_unlock(&rkt->lock);
 	if (unlikely(mr == NULL || mr->lkey != sge->lkey)) {
 		ret = 0;
 		goto bail;
@@ -184,8 +182,6 @@ bail:
  * @acc: access flags
  *
  * Return 1 if successful, otherwise 0.
- *
- * The QP r_rq.lock should be held.
  */
 int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
 		  u32 len, u64 vaddr, u32 rkey, int acc)
@@ -196,9 +192,7 @@ int ipath_rkey_ok(struct ipath_ibdev *de
 	size_t off;
 	int ret;
 
-	spin_lock(&rkt->lock);
 	mr = rkt->table[(rkey >> (32 - ib_ipath_lkey_table_size))];
-	spin_unlock(&rkt->lock);
 	if (unlikely(mr == NULL || mr->lkey != rkey)) {
 		ret = 0;
 		goto bail;
