Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRKBCmO>; Thu, 1 Nov 2001 21:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280518AbRKBCmE>; Thu, 1 Nov 2001 21:42:04 -0500
Received: from cogito.cam.org ([198.168.100.2]:4868 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S280365AbRKBClq>;
	Thu, 1 Nov 2001 21:41:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Date: Thu, 1 Nov 2001 21:37:11 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102023711.EC03D93E4D@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

shrink_caches can end up lying.  shrink_dcache_memory and friends do not tell 
shrink_caches how many pages they free so nr_pages can be bogus...  Is it worth 
fixing?  The simpliest, harmlessly racey and not too pretty, code follows.  It 
would also not be hard to change the shrink_ calls to return the number of pages 
shrunk, but this would hit more code...

Comments?

Ed Tomlinson

--- linux/mm/vmscan.c.orig	Wed Oct 31 14:11:33 2001
+++ linux/mm/vmscan.c	Wed Oct 31 14:51:58 2001
@@ -552,6 +552,7 @@
 static int shrink_caches(zone_t * classzone, int priority, unsigned int gfp_mask, int nr_pages)
 {
 	int chunk_size = nr_pages;
+	int nr_shrunk;
 	unsigned long ratio;
 
 	nr_pages -= kmem_cache_reap(gfp_mask);
@@ -567,11 +568,21 @@
 	if (nr_pages <= 0)
 		return 0;
 
+	nr_shrunk = nr_free_pages;
+
 	shrink_dcache_memory(priority, gfp_mask);
 	shrink_icache_memory(priority, gfp_mask);
 #ifdef CONFIG_QUOTA
 	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif
+
+	/* racey - calculate how many pages we got from shrinks */
+	nr_shrunk = nr_free_pages - nr_shrunk; 
+	if (nr_shrunk > 0) {
+		nr_pages -= nr_shrunk;
+		if (nr_pages <= 0)
+			return 0;
+	}
 
 	return nr_pages;
 }
