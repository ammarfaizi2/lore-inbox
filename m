Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTIWNQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 09:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTIWNQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 09:16:55 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:42998 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263345AbTIWNQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 09:16:46 -0400
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: David Yu Chen <dychen@stanford.edu>, lkml <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20030919160459.K27079@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
	 <20030919160459.K27079@osdlab.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1064322949.3851.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Sep 2003 09:15:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-19 at 19:04, Chris Wright wrote:
> Yes, this is a bug.  Stephen, the patch below fixes this, and adds a
> constraint_destroy() function to help cleanup when the constaint_node
> isn't yet attached to the class_datum but there may already be some
> constraint_expr's on the constraint_node.

Hi Chris,

Sorry for the duplicated effort, but I had already written up a patch
prior to the hurricane, but didn't get it sent out.  I believe that the
patch below fixes the legitimate leaks in the SELinux code.  In some
cases, it rearranges the code (moving the allocation later to reduce the
need for further cleanup or linking the object into a containing
structure earlier so that the policydb_destroy will handle it upon any
subsequent errors).

 security/selinux/ss/mls.c      |   13 ++++
 security/selinux/ss/policydb.c |  112 ++++++++++++++++++++---------------------
 2 files changed, 68 insertions(+), 57 deletions(-)

Index: linux-2.6/security/selinux/ss/mls.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/mls.c,v
retrieving revision 1.16
diff -u -r1.16 mls.c
--- linux-2.6/security/selinux/ss/mls.c	17 Jul 2003 11:33:35 -0000	1.16
+++ linux-2.6/security/selinux/ss/mls.c	16 Sep 2003 19:45:35 -0000
@@ -548,8 +548,10 @@
 		memset(r, 0, sizeof(*r));
 
 		rc = mls_read_range_helper(&r->range, fp);
-		if (rc)
+		if (rc) {
+			kfree(r);
 			goto out;
+		}
 
 		if (l)
 			l->next = r;
@@ -581,10 +583,17 @@
 		goto out;
 	rc = ebitmap_read(&p->trustedwriters, fp);
 	if (rc)
-		goto out;
+		goto bad;
 	rc = ebitmap_read(&p->trustedobjects, fp);
+	if (rc)
+		goto bad2;
 out:
 	return rc;
+bad2:
+	ebitmap_destroy(&p->trustedwriters);
+bad:
+	ebitmap_destroy(&p->trustedreaders);
+	goto out;
 }
 
 int sens_index(void *key, void *datum, void *datap)
Index: linux-2.6/security/selinux/ss/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/policydb.c,v
retrieving revision 1.24
diff -u -r1.24 policydb.c
--- linux-2.6/security/selinux/ss/policydb.c	26 Aug 2003 13:13:50 -0000	1.24
+++ linux-2.6/security/selinux/ss/policydb.c	16 Sep 2003 19:57:10 -0000
@@ -390,6 +390,16 @@
 	mls_destroy_f
 };
 
+void ocontext_destroy(struct ocontext *c, int i)
+{
+	context_destroy(&c->context[0]);
+	context_destroy(&c->context[1]);
+	if (i == OCON_ISID || i == OCON_FS ||
+	    i == OCON_NETIF || i == OCON_FSUSE)
+		kfree(c->u.name);
+	kfree(c);
+}
+
 /*
  * Free any memory allocated by a policy database structure.
  */
@@ -423,12 +433,7 @@
 		while (c) {
 			ctmp = c;
 			c = c->next;
-			context_destroy(&ctmp->context[0]);
-			context_destroy(&ctmp->context[1]);
-			if (i == OCON_ISID || i == OCON_FS ||
-			    i == OCON_NETIF || i == OCON_FSUSE)
-				kfree(ctmp->u.name);
-			kfree(ctmp);
+			ocontext_destroy(ctmp,i);
 		}
 	}
 
@@ -439,9 +444,7 @@
 		while (c) {
 			ctmp = c;
 			c = c->next;
-			context_destroy(&ctmp->context[0]);
-			kfree(ctmp->u.name);
-			kfree(ctmp);
+			ocontext_destroy(ctmp,OCON_FSUSE);
 		}
 		gtmp = g;
 		g = g->next;
@@ -762,6 +765,13 @@
 			goto bad;
 		}
 		memset(c, 0, sizeof(*c));
+
+		if (lc) {
+			lc->next = c;
+		} else {
+			cladatum->constraints = c;
+		}
+
 		buf = next_entry(fp, sizeof(u32)*2);
 		if (!buf)
 			goto bad;
@@ -776,67 +786,50 @@
 				goto bad;
 			}
 			memset(e, 0, sizeof(*e));
+
+			if (le) {
+				le->next = e;
+			} else {
+				c->expr = e;
+			}
+
 			buf = next_entry(fp, sizeof(u32)*3);
-			if (!buf) {
-				kfree(e);
+			if (!buf)
 				goto bad;
-			}
 			e->expr_type = le32_to_cpu(buf[0]);
 			e->attr = le32_to_cpu(buf[1]);
 			e->op = le32_to_cpu(buf[2]);
 
 			switch (e->expr_type) {
 			case CEXPR_NOT:
-				if (depth < 0) {
-					kfree(e);
+				if (depth < 0)
 					goto bad;
-				}
 				break;
 			case CEXPR_AND:
 			case CEXPR_OR:
-				if (depth < 1) {
-					kfree(e);
+				if (depth < 1)
 					goto bad;
-				}
 				depth--;
 				break;
 			case CEXPR_ATTR:
-				if (depth == (CEXPR_MAXDEPTH-1)) {
-					kfree(e);
+				if (depth == (CEXPR_MAXDEPTH-1))
 					goto bad;
-				}
 				depth++;
 				break;
 			case CEXPR_NAMES:
-				if (depth == (CEXPR_MAXDEPTH-1)) {
-					kfree(e);
+				if (depth == (CEXPR_MAXDEPTH-1))
 					goto bad;
-				}
 				depth++;
-				if (ebitmap_read(&e->names, fp)) {
-					kfree(e);
+				if (ebitmap_read(&e->names, fp))
 					goto bad;
-				}
 				break;
 			default:
-				kfree(e);
 				goto bad;
-				break;
-			}
-			if (le) {
-				le->next = e;
-			} else {
-				c->expr = e;
 			}
 			le = e;
 		}
 		if (depth != 0)
 			goto bad;
-		if (lc) {
-			lc->next = c;
-		} else {
-			cladatum->constraints = c;
-		}
 		lc = c;
 	}
 
@@ -1331,12 +1324,6 @@
 	genfs_p = NULL;
 	rc = -EINVAL;
 	for (i = 0; i < nel; i++) {
-		newgenfs = kmalloc(sizeof(*newgenfs), GFP_KERNEL);
-		if (!newgenfs) {
-			rc = -ENOMEM;
-			goto bad;
-		}
-		memset(newgenfs, 0, sizeof(*newgenfs));
 		buf = next_entry(fp, sizeof(u32));
 		if (!buf)
 			goto bad;
@@ -1344,9 +1331,17 @@
 		buf = next_entry(fp, len);
 		if (!buf)
 			goto bad;
+		newgenfs = kmalloc(sizeof(*newgenfs), GFP_KERNEL);
+		if (!newgenfs) {
+			rc = -ENOMEM;
+			goto bad;
+		}
+		memset(newgenfs, 0, sizeof(*newgenfs));
+
 		newgenfs->fstype = kmalloc(len + 1,GFP_KERNEL);
 		if (!newgenfs->fstype) {
 			rc = -ENOMEM;
+			kfree(newgenfs);
 			goto bad;
 		}
 		memcpy(newgenfs->fstype, buf, len);
@@ -1356,6 +1351,8 @@
 			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
 				printk(KERN_ERR "security:  dup genfs "
 				       "fstype %s\n", newgenfs->fstype);
+				kfree(newgenfs->fstype);
+				kfree(newgenfs);
 				goto bad;
 			}
 			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
@@ -1371,12 +1368,6 @@
 			goto bad;
 		nel2 = le32_to_cpu(buf[0]);
 		for (j = 0; j < nel2; j++) {
-			newc = kmalloc(sizeof(*newc), GFP_KERNEL);
-			if (!newc) {
-				rc = -ENOMEM;
-				goto bad;
-			}
-			memset(newc, 0, sizeof(*newc));
 			buf = next_entry(fp, sizeof(u32));
 			if (!buf)
 				goto bad;
@@ -1384,19 +1375,27 @@
 			buf = next_entry(fp, len);
 			if (!buf)
 				goto bad;
+
+			newc = kmalloc(sizeof(*newc), GFP_KERNEL);
+			if (!newc) {
+				rc = -ENOMEM;
+				goto bad;
+			}
+			memset(newc, 0, sizeof(*newc));
+
 			newc->u.name = kmalloc(len + 1,GFP_KERNEL);
 			if (!newc->u.name) {
 				rc = -ENOMEM;
-				goto bad;
+				goto bad_newc;
 			}
 			memcpy(newc->u.name, buf, len);
 			newc->u.name[len] = 0;
 			buf = next_entry(fp, sizeof(u32));
 			if (!buf)
-				goto bad;
+				goto bad_newc;
 			newc->v.sclass = le32_to_cpu(buf[0]);
 			if (context_read_and_validate(&newc->context[0], p, fp))
-				goto bad;
+				goto bad_newc;
 			for (l = NULL, c = newgenfs->head; c;
 			     l = c, c = c->next) {
 				if (!strcmp(newc->u.name, c->u.name) &&
@@ -1405,13 +1404,14 @@
 					printk(KERN_ERR "security:  dup genfs "
 					       "entry (%s,%s)\n",
 					       newgenfs->fstype, c->u.name);
-					goto bad;
+					goto bad_newc;
 				}
 				len = strlen(newc->u.name);
 				len2 = strlen(c->u.name);
 				if (len > len2)
 					break;
 			}
+
 			newc->next = c;
 			if (l)
 				l->next = newc;
@@ -1425,6 +1425,8 @@
 		goto bad;
 out:
 	return rc;
+bad_newc:
+	ocontext_destroy(newc,OCON_FSUSE);
 bad:
 	policydb_destroy(p);
 	goto out;


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

