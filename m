Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWEWSdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWEWSdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWEWSdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:35 -0400
Received: from mx.pathscale.com ([64.160.42.68]:2487 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751207AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 10] ipath - fix spinlock recursion bug
X-Mercurial-Node: bc968dacc8608566f4d2eaa96c513179d37c01ff
Message-Id: <bc968dacc8608566f4d2.1148409149@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:29 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The local loopback path for RC can lock the rkey table lock without
blocking interrupts.  The receive interrupt path can then call
ipath_rkey_ok() and deadlock.  Remove the redundant lock.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r abcc41d46f4c -r bc968dacc860 drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Tue May 23 11:29:11 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Tue May 23 11:29:15 2006 -0700
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
