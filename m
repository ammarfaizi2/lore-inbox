Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVAMSdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVAMSdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAMSW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:22:29 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:35507 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261275AbVAMSUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:20:11 -0500
Subject: [PATCH][SELINUX] Fix error handling code for policy load
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1105640024.24406.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 13:13:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.11-rc1-bk1 fixes several bugs in the error
handling code for SELinux policy loading that were introduced by my
earlier patch to eliminate unaligned accesses by that code.  Please
apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/ss/avtab.c    |    4 +++-
 security/selinux/ss/ebitmap.c  |    6 ++++--
 security/selinux/ss/policydb.c |    9 +++++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

Index: linux-2.6/security/selinux/ss/avtab.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/avtab.c,v
retrieving revision 1.22
diff -u -p -r1.22 avtab.c
--- linux-2.6/security/selinux/ss/avtab.c	8 Dec 2004 14:27:45 -0000	1.22
+++ linux-2.6/security/selinux/ss/avtab.c	11 Jan 2005 20:58:27 -0000
@@ -386,8 +386,10 @@ int avtab_read(struct avtab *a, void *fp
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
-		if (avtab_read_item(fp, &avdatum, &avkey))
+		if (avtab_read_item(fp, &avdatum, &avkey)) {
+			rc = -EINVAL;
 			goto bad;
+		}
 		rc = avtab_insert(a, &avkey, &avdatum);
 		if (rc) {
 			if (rc == -ENOMEM)
Index: linux-2.6/security/selinux/ss/ebitmap.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/ebitmap.c,v
retrieving revision 1.15
diff -u -p -r1.15 ebitmap.c
--- linux-2.6/security/selinux/ss/ebitmap.c	8 Dec 2004 14:27:45 -0000	1.15
+++ linux-2.6/security/selinux/ss/ebitmap.c	11 Jan 2005 20:56:40 -0000
@@ -237,7 +237,7 @@ void ebitmap_destroy(struct ebitmap *e)
 
 int ebitmap_read(struct ebitmap *e, void *fp)
 {
-	int rc = -EINVAL;
+	int rc;
 	struct ebitmap_node *n, *l;
 	u32 buf[3], mapsize, count, i;
 	u64 map;
@@ -256,7 +256,7 @@ int ebitmap_read(struct ebitmap *e, void
 		printk(KERN_ERR "security: ebitmap: map size %u does not "
 		       "match my size %Zd (high bit was %d)\n", mapsize,
 		       MAPSIZE, e->highbit);
-		goto out;
+		goto bad;
 	}
 	if (!e->highbit) {
 		e->node = NULL;
@@ -329,6 +329,8 @@ out:
 bad_free:
 	kfree(n);
 bad:
+	if (!rc)
+		rc = -EINVAL;
 	ebitmap_destroy(e);
 	goto out;
 }
Index: linux-2.6/security/selinux/ss/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/policydb.c,v
retrieving revision 1.34
diff -u -p -r1.34 policydb.c
--- linux-2.6/security/selinux/ss/policydb.c	8 Dec 2004 14:27:45 -0000	1.34
+++ linux-2.6/security/selinux/ss/policydb.c	11 Jan 2005 20:51:20 -0000
@@ -832,7 +832,6 @@ static int class_read(struct policydb *p
 	}
 
 	lc = NULL;
-	rc = -EINVAL;
 	for (i = 0; i < ncons; i++) {
 		c = kmalloc(sizeof(*c), GFP_KERNEL);
 		if (!c) {
@@ -875,6 +874,7 @@ static int class_read(struct policydb *p
 			e->attr = le32_to_cpu(buf[1]);
 			e->op = le32_to_cpu(buf[2]);
 
+			rc = -EINVAL;
 			switch (e->expr_type) {
 			case CEXPR_NOT:
 				if (depth < 0)
@@ -915,6 +915,8 @@ static int class_read(struct policydb *p
 	rc = hashtab_insert(h, key, cladatum);
 	if (rc)
 		goto bad;
+
+	rc = 0;
 out:
 	return rc;
 bad:
@@ -1110,7 +1112,6 @@ int policydb_read(struct policydb *p, vo
 	if (rc)
 		goto out;
 
-	rc = -EINVAL;
 	/* Read the magic number and string length. */
 	rc = next_entry(buf, fp, sizeof(u32)* 2);
 	if (rc < 0)
@@ -1503,12 +1504,16 @@ int policydb_read(struct policydb *p, vo
 	rc = mls_read_trusted(p, fp);
 	if (rc)
 		goto bad;
+	
+	rc = 0;
 out:
 	policydb_loaded_version = r_policyvers;
 	return rc;
 bad_newc:
 	ocontext_destroy(newc,OCON_FSUSE);
 bad:
+	if (!rc)
+		rc = -EINVAL;
 	policydb_destroy(p);
 	goto out;
 }

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

