Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbUKUAPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUKUAPH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUKUANj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:13:39 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:43536 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261690AbUKUANM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:13:12 -0500
Date: Sat, 20 Nov 2004 19:13:09 -0500
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH 1/5] selinux: cache not freed if load_policy fails.
Message-ID: <20041121001309.GB979@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If security_load_policy() fails on the first try, the cache is never cleaned
up. When the policy is fixed and a reload is attempted, the old cache will
still exist, causing a BUG() in kmem_cache_create().

This patch adds a destroy operation to clean up the cache on failure.

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

diff -rupX dontdiff linux-2.6.9/security/selinux/ss/avtab.c linux-2.6.9.selinux/security/selinux/ss/avtab.c
--- linux-2.6.9/security/selinux/ss/avtab.c	2004-11-19 14:40:58.000000000 -0500
+++ linux-2.6.9.selinux/security/selinux/ss/avtab.c	2004-11-19 16:14:51.573323560 -0500
@@ -407,3 +407,8 @@ void avtab_cache_init(void)
 					      sizeof(struct avtab_node),
 					      0, SLAB_PANIC, NULL, NULL);
 }
+
+void avtab_cache_destroy(void)
+{
+        kmem_cache_destroy (avtab_node_cachep);
+}
diff -rupX dontdiff linux-2.6.9/security/selinux/ss/avtab.h linux-2.6.9.selinux/security/selinux/ss/avtab.h
--- linux-2.6.9/security/selinux/ss/avtab.h	2004-11-19 14:40:58.000000000 -0500
+++ linux-2.6.9.selinux/security/selinux/ss/avtab.h	2004-11-19 16:16:06.801887080 -0500
@@ -79,6 +79,7 @@ struct avtab_node *avtab_search_node(str
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
 void avtab_cache_init(void);
+void avtab_cache_destroy(void);
 
 #define AVTAB_HASH_BITS 15
 #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
diff -rupX dontdiff linux-2.6.9/security/selinux/ss/services.c linux-2.6.9.selinux/security/selinux/ss/services.c
--- linux-2.6.9/security/selinux/ss/services.c	2004-11-19 14:40:58.000000000 -0500
+++ linux-2.6.9.selinux/security/selinux/ss/services.c	2004-11-19 16:15:05.941139320 -0500
@@ -1037,11 +1037,13 @@ int security_load_policy(void *data, siz
 		avtab_cache_init();
 		if (policydb_read(&policydb, fp)) {
 			LOAD_UNLOCK;
+			avtab_cache_destroy();
 			return -EINVAL;
 		}
 		if (policydb_load_isids(&policydb, &sidtab)) {
 			LOAD_UNLOCK;
 			policydb_destroy(&policydb);
+			avtab_cache_destroy();
 			return -EINVAL;
 		}
 		ss_initialized = 1;
-- 
Jeff Mahoney
SuSE Labs
