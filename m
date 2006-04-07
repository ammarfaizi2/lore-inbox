Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWDGStH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWDGStH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWDGSsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:50 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:1168
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964869AbWDGSsg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 3/7] sidtab - hashtable to store SIDs
Date: Fri, 7 Apr 2006 21:39:49 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
In-Reply-To: <200604072124.24000.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604072139.49935.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sidtab.c from SELinux, adapted to use the context structure 
specific to fireflier.

This patch is not meant to modify sidtab.c from SELinux!
It is meant to copy sidtab.c from SELinux, make the required changes, and put 
it into the fireflier_lsm directory.

How can I prevent this code duplication? I'd prefer not to duplicate files 
like this.

---
 sidtab.c |   42 ++++++++++++++++++++----------------------
 sidtab.h |   34 ++++++++++++++++------------------
 2 files changed, 36 insertions(+), 40 deletions(-)

--- /home/edwin/kernel/linux-2.6.16/security/selinux/ss/sidtab.c	2006-02-10 
09:22:48.000000000 +0200
+++ fireflier_lsm/sidtab.c	2006-04-07 15:06:00.000000000 +0300
@@ -1,16 +1,19 @@
 /*
  * Implementation of the SID table type.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Heavily based on selinux/ss/sidtab.c
+ * Original author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ *
+ * Modified for fireflier by: Török Edwin <edwin@gurde.com>
  */
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
-#include "flask.h"
-#include "security.h"
 #include "sidtab.h"
+#include "constants.h"
 
 #define SIDTAB_HASH(sid) \
 (sid & SIDTAB_HASH_MASK)
@@ -29,13 +32,13 @@ int sidtab_init(struct sidtab *s)
 	for (i = 0; i < SIDTAB_SIZE; i++)
 		s->htable[i] = NULL;
 	s->nel = 0;
-	s->next_sid = 1;
+	s->next_sid = FIREFLIER_SECINITSID_KERNEL+1;
 	s->shutdown = 0;
 	INIT_SIDTAB_LOCK(s);
 	return 0;
 }
 
-int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
+int sidtab_insert(struct sidtab *s, u32 sid, const struct context *context)
 {
 	int hvalue, rc = 0;
 	struct sidtab_node *prev, *cur, *newnode;
@@ -64,12 +67,7 @@ int sidtab_insert(struct sidtab *s, u32 
 		goto out;
 	}
 	newnode->sid = sid;
-	if (context_cpy(&newnode->context, context)) {
-		kfree(newnode);
-		rc = -ENOMEM;
-		goto out;
-	}
-
+	context_cpy(&newnode->context,context);
 	if (prev) {
 		newnode->next = prev->next;
 		wmb();
@@ -83,10 +81,10 @@ int sidtab_insert(struct sidtab *s, u32 
 	s->nel++;
 	if (sid >= s->next_sid)
 		s->next_sid = sid + 1;
 	return rc;
 }
 
-struct context *sidtab_search(struct sidtab *s, u32 sid)
+const struct context *sidtab_search(struct sidtab *s, u32 sid)
 {
 	int hvalue;
 	struct sidtab_node *cur;
@@ -102,7 +100,7 @@ struct context *sidtab_search(struct sid
 
 	if (cur == NULL || sid != cur->sid) {
 		/* Remap invalid SIDs to the unlabeled SID. */
-		sid = SECINITSID_UNLABELED;
+		sid = FIREFLIER_SID_UNLABELED;
 		hvalue = SIDTAB_HASH(sid);
 		cur = s->htable[hvalue];
 		while (cur != NULL && sid > cur->sid)
@@ -111,6 +109,6 @@ struct context *sidtab_search(struct sid
 			return NULL;
 	}
 
-	return &cur->context;
+	return cur->context;
 }
 

 void sidtab_map_remove_on_error(struct sidtab *s,
 				int (*apply) (u32 sid,
-					      struct context *context,
+					      const struct context *context,
 					      void *args),
 				void *args)
 {
@@ -155,7 +129,7 @@ void sidtab_map_remove_on_error(struct s
 		last = NULL;
 		cur = s->htable[i];
 		while (cur != NULL) {
-			ret = apply(cur->sid, &cur->context, args);
+			ret = apply(cur->sid, cur->context, args);
 			if (ret) {
 				if (last) {
 					last->next = cur->next;
@@ -165,7 +139,7 @@ void sidtab_map_remove_on_error(struct s
 
 				temp = cur;
 				cur = cur->next;
-				context_destroy(&temp->context);
+				kfree(temp->context);
 				kfree(temp);
 				s->nel--;
 			} else {
@@ -179,7 +153,7 @@ void sidtab_map_remove_on_error(struct s
 }
 
 static inline u32 sidtab_search_context(struct sidtab *s,
-						  struct context *context)
+					const struct context *context)
 {
 	int i;
 	struct sidtab_node *cur;
@@ -187,7 +161,7 @@ static inline u32 sidtab_search_context(
 	for (i = 0; i < SIDTAB_SIZE; i++) {
 		cur = s->htable[i];
 		while (cur != NULL) {
-			if (context_cmp(&cur->context, context))
+			if (context_cmp(cur->context, context))
 				return cur->sid;
 			cur = cur->next;
 		}
@@ -196,14 +170,14 @@ static inline u32 sidtab_search_context(
 }
 
 int sidtab_context_to_sid(struct sidtab *s,
-			  struct context *context,
+			  const struct context *context,
 			  u32 *out_sid)
 {
 	u32 sid;
 	int ret = 0;
 	unsigned long flags;
 
-	*out_sid = SECSID_NULL;
+	*out_sid = FIREFLIER_SID_UNLABELED;
 
 	sid = sidtab_search_context(s, context);
 	if (!sid) {
@@ -221,7 +195,7 @@ int sidtab_context_to_sid(struct sidtab 
 		ret = sidtab_insert(s, sid, context);
 		if (ret)
 			s->next_sid--;
 		SIDTAB_UNLOCK(s, flags);
 	}
 
@@ -272,7 +246,7 @@ void sidtab_destroy(struct sidtab *s)
 		while (cur != NULL) {
 			temp = cur;
 			cur = cur->next;
-			context_destroy(&temp->context);
+			kfree(temp->context);
 			kfree(temp);
 		}
 		s->htable[i] = NULL;
@@ -283,18 +257,6 @@ void sidtab_destroy(struct sidtab *s)
 	s->next_sid = 1;
 }
 
--- /home/edwin/kernel/linux-2.6.16/security/selinux/ss/sidtab.h	2006-02-10 
09:22:48.000000000 +0200
+++ fireflier_lsm/sidtab.h	2006-03-29 23:23:57.000000000 +0300
@@ -1,20 +1,24 @@
 /*
  * A security identifier table (sidtab) is a hash table
- * of security context structures indexed by SID value.
+ * of (executable) file structures indexed by SID value.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Heavily based on selinux/ss/sidtab.h
+ * Original author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ *
+ * Modified for fireflier by: Török Edwin <edwin@gurde.com>
  */
-#ifndef _SS_SIDTAB_H_
-#define _SS_SIDTAB_H_
+#ifndef _FF_SIDTAB_H_
+#define _FF_SIDTAB_H_
 
 #include "context.h"
-
-struct sidtab_node {
-	u32 sid;		/* security identifier */
-	struct context context;	/* security context structure */
+struct sidtab_node
+{
+	u32 sid;
+	struct context* context;
 	struct sidtab_node *next;
 };
 
+
 #define SIDTAB_HASH_BITS 7
 #define SIDTAB_HASH_BUCKETS (1 << SIDTAB_HASH_BITS)
 #define SIDTAB_HASH_MASK (SIDTAB_HASH_BUCKETS-1)
@@ -30,28 +34,22 @@ struct sidtab {
 };
 
 int sidtab_init(struct sidtab *s);
-int sidtab_insert(struct sidtab *s, u32 sid, struct context *context);
-struct context *sidtab_search(struct sidtab *s, u32 sid);
+int sidtab_insert(struct sidtab *s, u32 sid,const struct context* context);
+const struct context* sidtab_search(struct sidtab *s, u32 sid);
 
-int sidtab_map(struct sidtab *s,
-	       int (*apply) (u32 sid,
-			     struct context *context,
-			     void *args),
-	       void *args);
 
 void sidtab_map_remove_on_error(struct sidtab *s,
 				int (*apply) (u32 sid,
-					      struct context *context,
+					      const struct context *context,
 					      void *args),
 				void *args);
 
 int sidtab_context_to_sid(struct sidtab *s,
-			  struct context *context,
+			  const struct context *context,
 			  u32 *sid);
 
 void sidtab_hash_eval(struct sidtab *h, char *tag);
 void sidtab_destroy(struct sidtab *s);
-void sidtab_set(struct sidtab *dst, struct sidtab *src);
 void sidtab_shutdown(struct sidtab *s);
 
 #endif	/* _SS_SIDTAB_H_ */
