Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWGYOHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWGYOHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWGYOHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:07:22 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:165 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932148AbWGYOHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:07:21 -0400
Subject: [patch 1/1] selinux: fix memory leak
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@trustedcs.com>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Jul 2006 10:09:26 -0400
Message-Id: <1153836566.7104.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrel Goeddel <dgoeddel@TrustedCS.com>

This patch fixes a memory leak when a policydb structure
is destroyed.  Please apply for 2.6.18.

Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 security/selinux/ss/policydb.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.18-rc2-git2/security/selinux/ss/policydb.c linux-2.6.18-rc2-git2-x/security/selinux/ss/policydb.c
--- linux-2.6.18-rc2-git2/security/selinux/ss/policydb.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-rc2-git2-x/security/selinux/ss/policydb.c	2006-07-24 11:31:54.000000000 -0400
@@ -644,10 +644,18 @@ void policydb_destroy(struct policydb *p
 	kfree(lra);
 
 	for (rt = p->range_tr; rt; rt = rt -> next) {
-		kfree(lrt);
+		if (lrt) {
+			ebitmap_destroy(&lrt->range.level[0].cat);
+			ebitmap_destroy(&lrt->range.level[1].cat);
+			kfree(lrt);
+		}
 		lrt = rt;
 	}
-	kfree(lrt);
+	if (lrt) {
+		ebitmap_destroy(&lrt->range.level[0].cat);
+		ebitmap_destroy(&lrt->range.level[1].cat);
+		kfree(lrt);
+	}
 
 	if (p->type_attr_map) {
 		for (i = 0; i < p->p_types.nprim; i++)

-- 
Stephen Smalley
National Security Agency

