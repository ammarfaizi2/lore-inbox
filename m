Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUHQSrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUHQSrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268390AbUHQSrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:47:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268396AbUHQSqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:46:17 -0400
Date: Tue, 17 Aug 2004 14:46:07 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reduce SELinux kernel memory use on 64-bit systems
Message-ID: <Xine.LNX.4.44.0408171431580.10343-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below reduces kernel memory used by SELinux policy rules by
about 37% on 64-bit systems.  This is because the size of struct
avtab_node is 40 bytes on 64-bit, and defaults to a size-64 slab.

Creating a slab cache specifically for these structs saves considerable
amounts of kernel memory on 64-bit systems with large rulesets.  'Strict' 
policy has over 300k rules, while 'targeted' policy has around 3k rules.

Here's the slabtop output with 64 and 40 byte sized slabs to show the 
memory savings, for strict policy:

303475 303447  99%    0.06K   4975       61     19900K avtab_node 
303456 303447  99%    0.04K   3161       96     12644K avtab_node

Also, there are 57% more objects per slab.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

 security/selinux/ss/avtab.c    |   12 ++++++++++--
 security/selinux/ss/avtab.h    |    2 ++
 security/selinux/ss/services.c |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)


diff -urN -X dontdiff linux-2.6.8-rc3.o/security/selinux/ss/avtab.c linux-2.6.8-rc3.w/security/selinux/ss/avtab.c
--- linux-2.6.8-rc3.o/security/selinux/ss/avtab.c	2004-06-16 01:19:43.000000000 -0400
+++ linux-2.6.8-rc3.w/security/selinux/ss/avtab.c	2004-08-17 00:39:26.000000000 -0400
@@ -28,12 +28,14 @@
  (keyp->source_type << 9)) & \
  AVTAB_HASH_MASK)
 
+static kmem_cache_t *avtab_node_cachep;
+
 static struct avtab_node*
 avtab_insert_node(struct avtab *h, int hvalue, struct avtab_node * prev, struct avtab_node * cur,
 		  struct avtab_key *key, struct avtab_datum *datum)
 {
 	struct avtab_node * newnode;
-	newnode = (struct avtab_node *) kmalloc(sizeof(struct avtab_node),GFP_KERNEL);
+	newnode = kmem_cache_alloc(avtab_node_cachep, SLAB_KERNEL);
 	if (newnode == NULL)
 		return NULL;
 	memset(newnode, 0, sizeof(struct avtab_node));
@@ -226,7 +228,7 @@
 		while (cur != NULL) {
 			temp = cur;
 			cur = cur->next;
-			kfree(temp);
+			kmem_cache_free(avtab_node_cachep, temp);
 		}
 		h->htable[i] = NULL;
 	}
@@ -399,3 +401,9 @@
 	goto out;
 }
 
+void avtab_cache_init(void)
+{
+	avtab_node_cachep = kmem_cache_create("avtab_node",
+					      sizeof(struct avtab_node),
+					      0, SLAB_PANIC, NULL, NULL);
+}
diff -urN -X dontdiff linux-2.6.8-rc3.o/security/selinux/ss/avtab.h linux-2.6.8-rc3.w/security/selinux/ss/avtab.h
--- linux-2.6.8-rc3.o/security/selinux/ss/avtab.h	2004-06-16 01:19:13.000000000 -0400
+++ linux-2.6.8-rc3.w/security/selinux/ss/avtab.h	2004-08-17 00:18:06.000000000 -0400
@@ -78,6 +78,8 @@
 
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
+void avtab_cache_init(void);
+
 #define AVTAB_HASH_BITS 15
 #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
 #define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
diff -urN -X dontdiff linux-2.6.8-rc3.o/security/selinux/ss/services.c linux-2.6.8-rc3.w/security/selinux/ss/services.c
--- linux-2.6.8-rc3.o/security/selinux/ss/services.c	2004-08-06 16:12:05.000000000 -0400
+++ linux-2.6.8-rc3.w/security/selinux/ss/services.c	2004-08-17 00:18:06.000000000 -0400
@@ -1034,6 +1034,7 @@
 	LOAD_LOCK;
 
 	if (!ss_initialized) {
+		avtab_cache_init();
 		if (policydb_read(&policydb, fp)) {
 			LOAD_UNLOCK;
 			return -EINVAL;


