Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVG0TM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVG0TM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVG0TKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:10:07 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:43196 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262426AbVG0S2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:28:12 -0400
Date: Wed, 27 Jul 2005 13:28:32 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 14/15] lsm stacking v0.3: fix security_{del,unlink}_value race
Message-ID: <20050727182832.GO22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The security_unlink_value() hook can race with security_del_value().  This
is because security_del_value() is optimized to assume that it is naturally
serialized by only being called from security_<object>_free().

At the moment we want modules to only call security_unlink_value() while
they are being unloaded, so we try to avoid a spinlock at any other time.
If this is unreasonable, we can simply protect security_del_value() with
the spinlock at all times.  Or, we can try to find another solution.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 security.c |   18 ++++++++++++++++--
 stacker.c  |    2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6.13-rc3/security/security.c
===================================================================
--- linux-2.6.13-rc3.orig/security/security.c	2005-07-25 14:50:34.000000000 -0500
+++ linux-2.6.13-rc3/security/security.c	2005-07-25 15:30:35.000000000 -0500
@@ -125,22 +125,36 @@ void security_disown_value(struct hlist_
 	spin_unlock(&stacker_value_spinlock);
 }
 
+int lsm_unloading;
+
 /* No locking needed: only called during object_destroy */
 fastcall struct security_list *
 security_del_value(struct hlist_head *head, int security_id)
 {
 	struct security_list *e;
 	struct hlist_node *tmp;
+	char d = 0;
+
+	if (lsm_unloading) {
+		d = 1;
+		spin_lock(&stacker_value_spinlock);
+	}
 
 	for (tmp = head->first; tmp; tmp = tmp->next) {
 		e = hlist_entry(tmp, struct security_list, list);
 		if (e->security_id == security_id) {
 			hlist_del(&e->list);
-			return e;
+			goto out;
 		}
 	}
 
-	return NULL;
+	e = NULL;
+
+out:
+	if (d)
+		spin_unlock(&stacker_value_spinlock);
+
+	return e;
 }
 
 EXPORT_SYMBOL_GPL(security_get_value);
Index: linux-2.6.13-rc3/security/stacker.c
===================================================================
--- linux-2.6.13-rc3.orig/security/stacker.c	2005-07-25 14:55:27.000000000 -0500
+++ linux-2.6.13-rc3/security/stacker.c	2005-07-25 15:31:17.000000000 -0500
@@ -1267,6 +1267,7 @@ find_lsm_with_namelen(const char *name, 
 	return ret;
 }
 
+extern int lsm_unloading;  /* from security/security.c */
 /*
  * XXX TODO I need an all_modules list again to use here
  */
@@ -1286,6 +1287,7 @@ static int stacker_unregister (const cha
 	}
 	list_del_rcu(&m->all_lsms);
 	call_rcu(&m->m_rcu, stacker_del_module);
+	lsm_unloading = 1;
 
 out:
 	spin_unlock(&stacker_lock);
