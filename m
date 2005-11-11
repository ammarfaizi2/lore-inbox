Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVKKAGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVKKAGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVKKAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:06:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60849 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932259AbVKKAGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:06:33 -0500
Message-ID: <4373E086.7090906@us.ibm.com>
Date: Thu, 10 Nov 2005 16:06:30 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] Cleanup slabinfo_write()
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080700050701040702050806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080700050701040702050806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Shuffle a little code around in slabinfo_write(), both for efficiency and
readability.

-Matt

--------------080700050701040702050806
Content-Type: text/x-patch;
 name="slabinfo_write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slabinfo_write.patch"

Some cleanup for slabinfo_write():

* Move an if statement that clearly only needs to be evaluated once
     above and outside the loop where it belongs.
* Move a second if statement into a loop, where it belongs.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:48:49.384347400 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:49:19.028840752 -0800
@@ -3574,27 +3574,23 @@ ssize_t slabinfo_write(struct file *file
 	tmp++;
 	if (sscanf(tmp, " %d %d %d", &limit, &batchcount, &shared) != 3)
 		return -EINVAL;
+	if (limit < 1 || batchcount < 1 || batchcount > limit || shared < 0)
+		return 0;
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
 	res = -EINVAL;
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
-						       batchcount, shared);
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

--------------080700050701040702050806--
