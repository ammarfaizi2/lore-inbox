Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbTISXG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTISXG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:06:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:29585 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261810AbTISXFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:05:06 -0400
Date: Fri, 19 Sep 2003 16:04:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, sds@epoch.ncsc.mil
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030919160459.K27079@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
> START -->
> 1334:		newgenfs = kmalloc(sizeof(*newgenfs), GFP_KERNEL);
> 1335:		if (!newgenfs) {
> 1336:			rc = -ENOMEM;
> 1337:			goto bad;
> 1338:		}
> 1339:		memset(newgenfs, 0, sizeof(*newgenfs));
>         ... DELETED 5 lines ...
You missed one ;-)

1344		buf = next_entry(fp, len);
1345		if (!buf)
1346			goto bad;


> GOTO -->
> 1350:			goto bad;

Yes, this is a bug.

> 1357:				printk(KERN_ERR "security:  dup genfs "
> 1358:				       "fstype %s\n", newgenfs->fstype);
> GOTO -->
> 1359:				goto bad;

Yes, this is a bug.  I'm not sure if CHECKER caught that it leaks two
allocations here.  Both newgenfs and newgenfs->fstype.

> [FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
> START -->
> 1374:			newc = kmalloc(sizeof(*newc), GFP_KERNEL);
> 1375:			if (!newc) {
> 1376:				rc = -ENOMEM;
> 1377:				goto bad;
> 1378:			}
> 1379:			memset(newc, 0, sizeof(*newc));

You missed some more.  Not sure if this is meant to be comprensive or not...

1380			buf = next_entry(fp, sizeof(u32));
1381			if (!buf)
1382				goto bad;
*HERE*
1383			len = le32_to_cpu(buf[0]);
1384			buf = next_entry(fp, len);
1385			if (!buf)
1386				goto bad;
*HERE*
1387			 newc->u.name = kmalloc(len + 1,GFP_KERNEL);
1388			 if (!newc->u.name) {
1389				 rc = -ENOMEM;
1390				 goto bad;
*HERE*

>         ... DELETED 14 lines ...
> 1394:			buf = next_entry(fp, sizeof(u32));
> 1395:			if (!buf)
> 1396:				goto bad;

Again, not sure if you meant to capture both leakages here: newc and
newc->u.name.

> 1397:			newc->v.sclass = le32_to_cpu(buf[0]);
> 1398:			if (context_read_and_validate(&newc->context[0], p, fp))
> GOTO -->
> 1399:				goto bad;

And both here.

> 1400:			for (l = NULL, c = newgenfs->head; c;
> 1401:			     l = c, c = c->next) {
> 1402:				if (!strcmp(newc->u.name, c->u.name) &&
> 1403:				    (!c->v.sclass || !newc->v.sclass ||
> 1404:				     newc->v.sclass == c->v.sclass)) {
> 1405:					printk(KERN_ERR "security:  dup genfs "
> 1406:					       "entry (%s,%s)\n",
> 1407:					       newgenfs->fstype, c->u.name);
> GOTO -->
> 1408:					goto bad;

And both here.

Patch below fixes the leaks in a brute force method.  Stephen, look ok?
I could see rearranging the code to ensure things are stored in the policydb
earlier so they are all caught by policydb_destroy().

> [FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
> START -->
>  759:		c = kmalloc(sizeof(*c), GFP_KERNEL);
>  760:		if (!c) {
>  761:			rc = -ENOMEM;
>  762:			goto bad;
>  763:		}
>  764:		memset(c, 0, sizeof(*c));

You missed this one:
765		 buf = next_entry(fp, sizeof(u32)*2);
766		 if (!buf)
767			 goto bad;
And this one:
774			 if (!e) {
775				 rc = -ENOMEM;
776				 goto bad;
And this one:
780			 if (!buf) {
781				 kfree(e);
782				 goto bad;
And this one:
790				 if (depth < 0) {
791					 kfree(e);
792					 goto bad;
etc...

>         ... DELETED 64 lines ...
>  829:				c->expr = e;
>  830:			}
>  831:			le = e;
>  832:		}
>  833:		if (depth != 0)
> GOTO -->

Yes, this is a bug.  Stephen, the patch below fixes this, and adds a
constraint_destroy() function to help cleanup when the constaint_node
isn't yet attached to the class_datum but there may already be some
constraint_expr's on the constraint_node.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


===== security/selinux/ss/policydb.c 1.3 vs edited =====
--- 1.3/security/selinux/ss/policydb.c	Sun Aug 31 16:14:19 2003
+++ edited/security/selinux/ss/policydb.c	Fri Sep 19 15:59:02 2003
@@ -321,17 +321,11 @@
 	return 0;
 }
 
-static int class_destroy(void *key, void *datum, void *p)
+static void constraint_destroy(struct constraint_node *constraint)
 {
-	struct class_datum *cladatum;
-	struct constraint_node *constraint, *ctemp;
+	struct constraint_node *ctemp;
 	struct constraint_expr *e, *etmp;
 
-	kfree(key);
-	cladatum = datum;
-	hashtab_map(cladatum->permissions.table, perm_destroy, 0);
-	hashtab_destroy(cladatum->permissions.table);
-	constraint = cladatum->constraints;
 	while (constraint) {
 		e = constraint->expr;
 		while (e) {
@@ -344,6 +338,19 @@
 		constraint = constraint->next;
 		kfree(ctemp);
 	}
+}
+
+static int class_destroy(void *key, void *datum, void *p)
+{
+	struct class_datum *cladatum;
+	struct constraint_node *constraint;
+
+	kfree(key);
+	cladatum = datum;
+	hashtab_map(cladatum->permissions.table, perm_destroy, 0);
+	hashtab_destroy(cladatum->permissions.table);
+	constraint = cladatum->constraints;
+	constraint_destroy(constraint);
 	kfree(cladatum->comkey);
 	kfree(datum);
 	return 0;
@@ -763,8 +770,10 @@
 		}
 		memset(c, 0, sizeof(*c));
 		buf = next_entry(fp, sizeof(u32)*2);
-		if (!buf)
+		if (!buf) {
+			kfree(c);
 			goto bad;
+		}
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
 		le = NULL;
@@ -773,11 +782,13 @@
 			e = kmalloc(sizeof(*e), GFP_KERNEL);
 			if (!e) {
 				rc = -ENOMEM;
+				constraint_destroy(c);
 				goto bad;
 			}
 			memset(e, 0, sizeof(*e));
 			buf = next_entry(fp, sizeof(u32)*3);
 			if (!buf) {
+				constraint_destroy(c);
 				kfree(e);
 				goto bad;
 			}
@@ -788,6 +799,7 @@
 			switch (e->expr_type) {
 			case CEXPR_NOT:
 				if (depth < 0) {
+					constraint_destroy(c);
 					kfree(e);
 					goto bad;
 				}
@@ -795,6 +807,7 @@
 			case CEXPR_AND:
 			case CEXPR_OR:
 				if (depth < 1) {
+					constraint_destroy(c);
 					kfree(e);
 					goto bad;
 				}
@@ -802,6 +815,7 @@
 				break;
 			case CEXPR_ATTR:
 				if (depth == (CEXPR_MAXDEPTH-1)) {
+					constraint_destroy(c);
 					kfree(e);
 					goto bad;
 				}
@@ -809,16 +823,19 @@
 				break;
 			case CEXPR_NAMES:
 				if (depth == (CEXPR_MAXDEPTH-1)) {
+					constraint_destroy(c);
 					kfree(e);
 					goto bad;
 				}
 				depth++;
 				if (ebitmap_read(&e->names, fp)) {
+					constraint_destroy(c);
 					kfree(e);
 					goto bad;
 				}
 				break;
 			default:
+				constraint_destroy(c);
 				kfree(e);
 				goto bad;
 				break;
@@ -830,8 +847,10 @@
 			}
 			le = e;
 		}
-		if (depth != 0)
+		if (depth != 0) {
+			constraint_destroy(c);
 			goto bad;
+		}
 		if (lc) {
 			lc->next = c;
 		} else {
@@ -1338,15 +1357,20 @@
 		}
 		memset(newgenfs, 0, sizeof(*newgenfs));
 		buf = next_entry(fp, sizeof(u32));
-		if (!buf)
+		if (!buf) {
+			kfree(newgenfs);
 			goto bad;
+		}
 		len = le32_to_cpu(buf[0]);
 		buf = next_entry(fp, len);
-		if (!buf)
+		if (!buf) {
+			kfree(newgenfs);
 			goto bad;
+		}
 		newgenfs->fstype = kmalloc(len + 1,GFP_KERNEL);
 		if (!newgenfs->fstype) {
 			rc = -ENOMEM;
+			kfree(newgenfs);
 			goto bad;
 		}
 		memcpy(newgenfs->fstype, buf, len);
@@ -1356,6 +1380,8 @@
 			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
 				printk(KERN_ERR "security:  dup genfs "
 				       "fstype %s\n", newgenfs->fstype);
+				kfree(newgenfs->fstype);
+				kfree(newgenfs);
 				goto bad;
 			}
 			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
@@ -1378,25 +1404,36 @@
 			}
 			memset(newc, 0, sizeof(*newc));
 			buf = next_entry(fp, sizeof(u32));
-			if (!buf)
+			if (!buf) {
+				kfree(newc);
 				goto bad;
+			}
 			len = le32_to_cpu(buf[0]);
 			buf = next_entry(fp, len);
-			if (!buf)
+			if (!buf) {
+				kfree(newc);
 				goto bad;
+			}
 			newc->u.name = kmalloc(len + 1,GFP_KERNEL);
 			if (!newc->u.name) {
 				rc = -ENOMEM;
+				kfree(newc);
 				goto bad;
 			}
 			memcpy(newc->u.name, buf, len);
 			newc->u.name[len] = 0;
 			buf = next_entry(fp, sizeof(u32));
-			if (!buf)
+			if (!buf) {
+				kfree(newc->u.name);
+				kfree(newc);
 				goto bad;
+			}
 			newc->v.sclass = le32_to_cpu(buf[0]);
-			if (context_read_and_validate(&newc->context[0], p, fp))
+			if (context_read_and_validate(&newc->context[0], p, fp)){ 
+				kfree(newc->u.name);
+				kfree(newc);
 				goto bad;
+			}
 			for (l = NULL, c = newgenfs->head; c;
 			     l = c, c = c->next) {
 				if (!strcmp(newc->u.name, c->u.name) &&
@@ -1405,6 +1442,8 @@
 					printk(KERN_ERR "security:  dup genfs "
 					       "entry (%s,%s)\n",
 					       newgenfs->fstype, c->u.name);
+					kfree(newc->u.name);
+					kfree(newc);
 					goto bad;
 				}
 				len = strlen(newc->u.name);
