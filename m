Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbULKDAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbULKDAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 22:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbULKDAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 22:00:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261920AbULKDAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 22:00:12 -0500
Date: Fri, 10 Dec 2004 21:24:15 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH] SELinux - fix bug in avc_update_node()
Message-ID: <Xine.LNX.4.44.0412102112170.17677-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a bug in avc_update_node(), reported by Alan Cox.  
This can only happen on a UP kernel (where spin_trylock() always succeeds)  
and when SELinux is running in non-enforcing mode.  Under these
circumstances, the code can cause an avc node to be reclaimed as it is
updating it, leading to an oops.

The patch below fixes this by ensuring that avc node allocation and 
possible reclamation happens before the cache lookup.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>

---

 security/selinux/avc.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff -purN -X dontdiff linux-2.6.10-rc2-mm4.o/security/selinux/avc.c linux-2.6.10-rc2-mm4.w/security/selinux/avc.c
--- linux-2.6.10-rc2-mm4.o/security/selinux/avc.c	2004-12-09 16:25:19.000000000 -0500
+++ linux-2.6.10-rc2-mm4.w/security/selinux/avc.c	2004-12-10 11:26:20.903442608 -0500
@@ -249,6 +249,13 @@ static void avc_node_delete(struct avc_n
 	atomic_dec(&avc_cache.active_nodes);
 }
 
+static void avc_node_kill(struct avc_node *node)
+{
+	kmem_cache_free(avc_node_cachep, node);
+	avc_cache_stats_incr(frees);
+	atomic_dec(&avc_cache.active_nodes);
+}
+
 static void avc_node_replace(struct avc_node *new, struct avc_node *old)
 {
 	list_replace_rcu(&old->list, &new->list);
@@ -722,6 +729,12 @@ static int avc_update_node(u32 event, u3
 	unsigned long flag;
 	struct avc_node *pos, *node, *orig = NULL;
 
+	node = avc_alloc_node();
+	if (!node) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	/* Lock the target slot */
 	hvalue = avc_hash(ssid, tsid, tclass);
 	spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
@@ -737,17 +750,13 @@ static int avc_update_node(u32 event, u3
 
 	if (!orig) {
 		rc = -ENOENT;
-		goto out;
+		avc_node_kill(node);
+		goto out_unlock;
 	}
 
 	/*
 	 * Copy and replace original node.
 	 */
-	node = avc_alloc_node();
-	if (!node) {
-		rc = -ENOMEM;
-		goto out;
-	}
 
 	avc_node_populate(node, ssid, tsid, tclass, &orig->ae);
 
@@ -773,9 +782,9 @@ static int avc_update_node(u32 event, u3
 		break;
 	}
 	avc_node_replace(node, orig);
-out:
+out_unlock:
 	spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);
-
+out:
 	return rc;
 }
 

