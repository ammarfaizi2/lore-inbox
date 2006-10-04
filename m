Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030829AbWJDL5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030829AbWJDL5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030831AbWJDL5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:57:20 -0400
Received: from havoc.gtf.org ([69.61.125.42]:37001 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030829AbWJDL5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:57:19 -0400
Date: Wed, 4 Oct 2006 07:57:18 -0400
From: Jeff Garzik <jeff@garzik.org>
To: dwmw2@infradead.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/jffs2: kill warning RE debug-only variables
Message-ID: <20061004115718.GA22386@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc emits the following warning on a 'allmodconfig' build:

fs/jffs2/xattr.c: In function ‘unrefer_xattr_datum’:
fs/jffs2/xattr.c:402: warning: unused variable ‘version’
fs/jffs2/xattr.c:402: warning: unused variable ‘xid’

Given that these variables are only used in the debug printk, and they
merely remove a deref, we can easily kill the warning by adding the
derefs to the debug printk.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 fs/jffs2/xattr.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 4da09ce..4bb3f18 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -399,8 +399,6 @@ static void unrefer_xattr_datum(struct j
 {
 	/* must be called under down_write(xattr_sem) */
 	if (atomic_dec_and_lock(&xd->refcnt, &c->erase_completion_lock)) {
-		uint32_t xid = xd->xid, version = xd->version;
-
 		unload_xattr_datum(c, xd);
 		xd->flags |= JFFS2_XFLAGS_DEAD;
 		if (xd->node == (void *)xd) {
@@ -411,7 +409,8 @@ static void unrefer_xattr_datum(struct j
 		}
 		spin_unlock(&c->erase_completion_lock);
 
-		dbg_xattr("xdatum(xid=%u, version=%u) was removed.\n", xid, version);
+		dbg_xattr("xdatum(xid=%u, version=%u) was removed.\n",
+			  xd->xid, xd->version);
 	}
 }
 
