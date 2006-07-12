Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWGLUpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWGLUpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWGLUpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:45:18 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:15894 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751046AbWGLUpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:45:17 -0400
To: akpm@osdl.org
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Zach Brown" <zach.brown@oracle.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu>
Subject: [PATCH] Convert idr's internal locking to _irqsave variant
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Jul 2006 13:45:12 -0700
Message-ID: <adaveq2v9gn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jul 2006 20:45:14.0154 (UTC) FILETIME=[135468A0:01C6A5F4]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the code in lib/idr.c uses a bare spin_lock(&idp->lock) to
do internal locking.  This is a nasty trap for code that might call
idr functions from different contexts; for example, it seems perfectly
reasonable to call idr_get_new() from process context and idr_remove()
from interrupt context -- but with the current locking this would lead
to a potential deadlock.

The simplest fix for this is to just convert the idr locking to use
spin_lock_irqsave().

In particular, this fixes a very complicated locking issue detected by
lockdep, involving the ib_ipoib driver's priv->lock and dev->_xmit_lock,
which get involved with the ib_sa module's query_idr.lock.

Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Zach Brown <zach.brown@oracle.com>,
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

diff --git a/lib/idr.c b/lib/idr.c
index 4d09681..16d2143 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -38,14 +38,15 @@ static kmem_cache_t *idr_layer_cache;
 static struct idr_layer *alloc_layer(struct idr *idp)
 {
 	struct idr_layer *p;
+	unsigned long flags;
 
-	spin_lock(&idp->lock);
+	spin_lock_irqsave(&idp->lock, flags);
 	if ((p = idp->id_free)) {
 		idp->id_free = p->ary[0];
 		idp->id_free_cnt--;
 		p->ary[0] = NULL;
 	}
-	spin_unlock(&idp->lock);
+	spin_unlock_irqrestore(&idp->lock, flags);
 	return(p);
 }
 
@@ -59,12 +60,14 @@ static void __free_layer(struct idr *idp
 
 static void free_layer(struct idr *idp, struct idr_layer *p)
 {
+	unsigned long flags;
+
 	/*
 	 * Depends on the return element being zeroed.
 	 */
-	spin_lock(&idp->lock);
+	spin_lock_irqsave(&idp->lock, flags);
 	__free_layer(idp, p);
-	spin_unlock(&idp->lock);
+	spin_unlock_irqrestore(&idp->lock, flags);
 }
 
 /**
@@ -168,6 +171,7 @@ static int idr_get_new_above_int(struct 
 {
 	struct idr_layer *p, *new;
 	int layers, v, id;
+	unsigned long flags;
 
 	id = starting_id;
 build_up:
@@ -191,14 +195,14 @@ build_up:
 			 * The allocation failed.  If we built part of
 			 * the structure tear it down.
 			 */
-			spin_lock(&idp->lock);
+			spin_lock_irqsave(&idp->lock, flags);
 			for (new = p; p && p != idp->top; new = p) {
 				p = p->ary[0];
 				new->ary[0] = NULL;
 				new->bitmap = new->count = 0;
 				__free_layer(idp, new);
 			}
-			spin_unlock(&idp->lock);
+			spin_unlock_irqrestore(&idp->lock, flags);
 			return -1;
 		}
 		new->ary[0] = p;
