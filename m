Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVIAPsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVIAPsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVIAPsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:48:33 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:13256 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030213AbVIAPsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:48:32 -0400
Message-ID: <431722CC.8040204@cosmosbay.com>
Date: Thu, 01 Sep 2005 17:48:28 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] : struct dentry : place d_hash close to d_parent and d_name
 to speedup lookups
References: <20050901035542.1c621af6.akpm@osdl.org> <431721F0.6090402@cosmosbay.com>
In-Reply-To: <431721F0.6090402@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------030207030509060902010006"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 01 Sep 2005 17:48:29 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030207030509060902010006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

dentry cache uses sophisticated RCU technology (and prefetching if available) 
but touches 2 cache lines per dentry during hlist lookup.

This patch moves d_hash in the same cache line than d_parent and d_name fields 
so that :

1) One cache line is needed instead of two.
2) the hlist_for_each_rcu() prefetching has a chance to bring all the needed 
data in advance, not only the part that includes d_hash.next.

I also changed one old comment that was wrong for 64bits.

A further optimisation would be to separate dentry in two parts, one that is 
mostly read, and one writen (d_count/d_lock) to avoid false sharing on 
SMP/NUMA but this would need different field placement depending on 32bits or 
64bits platform.

with the patch this time :)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------030207030509060902010006
Content-Type: text/plain;
 name="dcache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dcache.patch"

--- linux-2.6.13/include/linux/dcache.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-ed/include/linux/dcache.h	2005-09-01 17:22:32.000000000 +0200
@@ -88,8 +88,9 @@
 					 * negative */
 	/*
 	 * The next three fields are touched by __d_lookup.  Place them here
-	 * so they all fit in a 16-byte range, with 16-byte alignment.
+	 * so they all fit in a cache line.
 	 */
+	struct hlist_node d_hash;	/* lookup hash list */	
 	struct dentry *d_parent;	/* parent directory */
 	struct qstr d_name;
 
@@ -103,7 +104,6 @@
 	void *d_fsdata;			/* fs-specific data */
  	struct rcu_head d_rcu;
 	struct dcookie_struct *d_cookie; /* cookie, if any */
-	struct hlist_node d_hash;	/* lookup hash list */	
 	int d_mounted;
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
 };

--------------030207030509060902010006--
