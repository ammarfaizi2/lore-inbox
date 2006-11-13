Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755278AbWKMRDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbWKMRDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbWKMRDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:03:43 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:2717 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1755278AbWKMRDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:03:42 -0500
Date: Mon, 13 Nov 2006 12:03:40 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chad Sellers <csellers@tresys.com>
Subject: [PATCH 3/4] SELinux: ensure keys constant in hashtab_search
In-Reply-To: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
Message-ID: <XMMS.LNX.4.64.0611131203161.6437@d.namei>
References: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chad Sellers <csellers@tresys.com>

Makes the key argument passed into hashtab_search and all the functions
it calls constant. These functions include hash table function pointers
hash_value and keycmp. The only implementations of these currently
are symhash and symcmp, which do not modify the key. The key parameter
should never be changed by any of these, so it should be const. This
is necessary to allow calling these functions with keys found in kernel
object class and permission definitions.

Signed-off-by: Chad Sellers <csellers@tresys.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/ss/hashtab.c |    6 +++---
 security/selinux/ss/hashtab.h |   10 +++++-----
 security/selinux/ss/symtab.c  |    8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 24e5ec9..77b530c 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -8,8 +8,8 @@ #include <linux/slab.h>
 #include <linux/errno.h>
 #include "hashtab.h"
 
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
-                               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
+struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
+                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
                                u32 size)
 {
 	struct hashtab *p;
@@ -71,7 +71,7 @@ int hashtab_insert(struct hashtab *h, vo
 	return 0;
 }
 
-void *hashtab_search(struct hashtab *h, void *key)
+void *hashtab_search(struct hashtab *h, const void *key)
 {
 	u32 hvalue;
 	struct hashtab_node *cur;
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 4cc8581..7e2ff3e 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -22,9 +22,9 @@ struct hashtab {
 	struct hashtab_node **htable;	/* hash table */
 	u32 size;			/* number of slots in hash table */
 	u32 nel;			/* number of elements in hash table */
-	u32 (*hash_value)(struct hashtab *h, void *key);
+	u32 (*hash_value)(struct hashtab *h, const void *key);
 					/* hash function */
-	int (*keycmp)(struct hashtab *h, void *key1, void *key2);
+	int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
 					/* key comparison function */
 };
 
@@ -39,8 +39,8 @@ struct hashtab_info {
  * Returns NULL if insufficent space is available or
  * the new hash table otherwise.
  */
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
-                               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
+struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
+                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
                                u32 size);
 
 /*
@@ -59,7 +59,7 @@ int hashtab_insert(struct hashtab *h, vo
  * Returns NULL if no entry has the specified key or
  * the datum of the entry otherwise.
  */
-void *hashtab_search(struct hashtab *h, void *k);
+void *hashtab_search(struct hashtab *h, const void *k);
 
 /*
  * Destroys the specified hash table.
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 24a10d3..837658a 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -9,9 +9,9 @@ #include <linux/string.h>
 #include <linux/errno.h>
 #include "symtab.h"
 
-static unsigned int symhash(struct hashtab *h, void *key)
+static unsigned int symhash(struct hashtab *h, const void *key)
 {
-	char *p, *keyp;
+	const char *p, *keyp;
 	unsigned int size;
 	unsigned int val;
 
@@ -23,9 +23,9 @@ static unsigned int symhash(struct hasht
 	return val & (h->size - 1);
 }
 
-static int symcmp(struct hashtab *h, void *key1, void *key2)
+static int symcmp(struct hashtab *h, const void *key1, const void *key2)
 {
-	char *keyp1, *keyp2;
+	const char *keyp1, *keyp2;
 
 	keyp1 = key1;
 	keyp2 = key2;
-- 
1.4.2.1

