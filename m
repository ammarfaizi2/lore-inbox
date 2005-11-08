Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVKHA5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVKHA5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVKHA5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:57:33 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:49323 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964927AbVKHA5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:57:32 -0500
Message-ID: <436FF7F7.1060907@us.ibm.com>
Date: Mon, 07 Nov 2005 16:57:27 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] Cleanup slabinfo_write()
References: <436FF51D.8080509@us.ibm.com>
In-Reply-To: <436FF51D.8080509@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040302030108010406000103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040302030108010406000103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Cleanup slabinfo_write().

mcd@arrakis:~/linux/source/linux-2.6.14+slab_cleanup/patches $ diffstat
slabinfo_write.patch
 slab.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

-Matt

--------------040302030108010406000103
Content-Type: text/x-patch;
 name="slabinfo_write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slabinfo_write.patch"

Some cleanup for slabinfo_write():

* Set 'res' at declaration instead of later in the function.
* Move an if statement that clearly only needs to be evaluated once
     above and outside the loop where it was.
* Move a second if statement into a loop, where it belongs.

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-07 15:59:14.091887752 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-07 16:00:09.005539608 -0800
@@ -3533,7 +3533,7 @@ ssize_t slabinfo_write(struct file *file
 		       size_t count, loff_t *ppos)
 {
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
-	int limit, batchcount, shared, res;
+	int limit, batchcount, shared, res = -EINVAL;
 	struct list_head *p;
 	
 	if (count > MAX_SLABINFO_WRITE)
@@ -3549,27 +3549,22 @@ ssize_t slabinfo_write(struct file *file
 	tmp++;
 	if (sscanf(tmp, " %d %d %d", &limit, &batchcount, &shared) != 3)
 		return -EINVAL;
+	if (limit < 1 || batchcount < 1 || batchcount > limit || shared < 0)
+		return 0;
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
-	res = -EINVAL;
 	list_for_each(p,&cache_chain) {
 		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
+		if (strcmp(cachep->name, kbuf))
+			continue;
 
-		if (!strcmp(cachep->name, kbuf)) {
-			if (limit < 1 || batchcount < 1 ||
-			    batchcount > limit || shared < 0) {
-				res = 0;
-			} else {
-				res = do_tune_cpucache(cachep, limit,
-							batchcount, shared);
-			}
-			break;
-		}
+		res = do_tune_cpucache(cachep, limit, batchcount, shared);
+		if (res >= 0)
+			res = count;	
+		break;
 	}
 	up(&cache_chain_sem);
-	if (res >= 0)
-		res = count;
 	return res;
 }
 #endif /* CONFIG_PROC_FS */

--------------040302030108010406000103--
