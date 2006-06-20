Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWFTRiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFTRiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWFTRiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:38:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750708AbWFTRhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:37:48 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/6] Keys: Allocate key serial numbers randomly [try #3]
Date: Tue, 20 Jun 2006 18:37:44 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Message-Id: <20060620173744.5034.50837.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael LeMay <mdlemay@epoch.ncsc.mil>

The attached patch causes key_alloc_serial() to generate key serial numbers
randomly rather than in linear sequence.

Using an linear sequence permits a covert communication channel to be
established, in which one process can communicate with another by creating or
not creating new keys within a certain timeframe.  The second process can
probe for the expected next key serial number and judge its existence by the
error returned.

This is a problem as the serial number namespace is globally shared between
all tasks, regardless of their context.

For more information on this topic, this old TCSEC guide is recommended:

	http://www.radium.ncsc.mil/tpep/library/rainbow/NCSC-TG-030.html

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@namei.org>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 security/keys/key.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index a9b6ca7..10fea8c 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -15,11 +15,11 @@ #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/workqueue.h>
+#include <linux/random.h>
 #include <linux/err.h>
 #include "internal.h"
 
 static kmem_cache_t	*key_jar;
-static key_serial_t	key_serial_next = 3;
 struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
 DEFINE_SPINLOCK(key_serial_lock);
 
@@ -169,22 +169,23 @@ static void __init __key_insert_serial(s
 /*****************************************************************************/
 /*
  * assign a key the next unique serial number
- * - we work through all the serial numbers between 2 and 2^31-1 in turn and
- *   then wrap
+ * - these are assigned randomly to avoid security issues through covert
+ *   channel problems
  */
 static inline void key_alloc_serial(struct key *key)
 {
 	struct rb_node *parent, **p;
 	struct key *xkey;
 
-	spin_lock(&key_serial_lock);
-
-	/* propose a likely serial number and look for a hole for it in the
+	/* propose a random serial number and look for a hole for it in the
 	 * serial number tree */
-	key->serial = key_serial_next;
-	if (key->serial < 3)
-		key->serial = 3;
-	key_serial_next = key->serial + 1;
+	do {
+		get_random_bytes(&key->serial, sizeof(key->serial));
+
+		key->serial >>= 1; /* negative numbers are not permitted */
+	} while (key->serial < 3);
+
+	spin_lock(&key_serial_lock);
 
 	parent = NULL;
 	p = &key_serial_tree.rb_node;
@@ -204,12 +205,11 @@ static inline void key_alloc_serial(stru
 
 	/* we found a key with the proposed serial number - walk the tree from
 	 * that point looking for the next unused serial number */
- serial_exists:
+serial_exists:
 	for (;;) {
-		key->serial = key_serial_next;
+		key->serial++;
 		if (key->serial < 2)
 			key->serial = 2;
-		key_serial_next = key->serial + 1;
 
 		if (!parent->rb_parent)
 			p = &key_serial_tree.rb_node;
@@ -228,7 +228,7 @@ static inline void key_alloc_serial(stru
 	}
 
 	/* we've found a suitable hole - arrange for this key to occupy it */
- insert_here:
+insert_here:
 	rb_link_node(&key->serial_node, parent, p);
 	rb_insert_color(&key->serial_node, &key_serial_tree);
 

