Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVJTUX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVJTUX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVJTUX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 16:23:58 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:37778 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932523AbVJTUX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 16:23:57 -0400
Subject: [patch 1/1] selinux: Fix NULL deref in policydb_destroy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Oct 2005 16:20:23 -0400
Message-Id: <1129839623.2375.515.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible NULL dereference in policydb_destroy, where
p->type_attr_map can be NULL if policydb_destroy is called to clean up a
partially loaded policy upon an error during policy load.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 security/selinux/ss/policydb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/security/selinux/ss/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/policydb.c,v
retrieving revision 1.44
diff -u -p -r1.44 policydb.c
--- linux-2.6/security/selinux/ss/policydb.c	29 Aug 2005 14:13:22 -0000	1.44
+++ linux-2.6/security/selinux/ss/policydb.c	20 Oct 2005 19:11:06 -0000
@@ -650,8 +650,10 @@ void policydb_destroy(struct policydb *p
 	}
 	if (lrt) kfree(lrt);
 
-	for (i = 0; i < p->p_types.nprim; i++)
-		ebitmap_destroy(&p->type_attr_map[i]);
+	if (p->type_attr_map) {
+		for (i = 0; i < p->p_types.nprim; i++)
+			ebitmap_destroy(&p->type_attr_map[i]);
+	}
 	kfree(p->type_attr_map);
 
 	return;

-- 
Stephen Smalley
National Security Agency

