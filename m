Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVCPMan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVCPMan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVCPMan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:30:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:52674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262557AbVCPMab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:30:31 -0500
Date: Wed, 16 Mar 2005 04:30:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: noahm@csail.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-Id: <20050316043005.3e2a0ef5.akpm@osdl.org>
In-Reply-To: <20050316003134.GY7699@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> This below is an untested attempt at bringing dquot a bit more in line
>  with the API, to make the whole thing a bit more consistent,

Like this?  (Noah, don't bother testing this one)



Fix some bugs spotted by Andrea Arcangeli <andrea@suse.de>

- When we added /proc/sys/vm/vfs_cache_pressure we forgot to allow it to
  tune the dquot and mbcache slabs as well.

- Reduce lock contention in shrink_dqcache_memory().

- Use dqstats.free_dquots in shrink_dqcache_memory(): this is the count of
  reclaimable objects.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/dquot.c   |   12 +++++-------
 25-akpm/fs/mbcache.c |    2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff -puN fs/dquot.c~slab-shrinkers-use-vfs_cache_pressure fs/dquot.c
--- 25/fs/dquot.c~slab-shrinkers-use-vfs_cache_pressure	2005-03-16 04:22:01.000000000 -0800
+++ 25-akpm/fs/dquot.c	2005-03-16 04:27:09.000000000 -0800
@@ -505,14 +505,12 @@ static void prune_dqcache(int count)
 
 static int shrink_dqcache_memory(int nr, unsigned int gfp_mask)
 {
-	int ret;
-
-	spin_lock(&dq_list_lock);
-	if (nr)
+	if (nr) {
+		spin_lock(&dq_list_lock);
 		prune_dqcache(nr);
-	ret = dqstats.allocated_dquots;
-	spin_unlock(&dq_list_lock);
-	return ret;
+		spin_unlock(&dq_list_lock);
+	}
+	return (dqstats.free_dquots / 100) * sysctl_vfs_cache_pressure;
 }
 
 /*
diff -puN fs/mbcache.c~slab-shrinkers-use-vfs_cache_pressure fs/mbcache.c
--- 25/fs/mbcache.c~slab-shrinkers-use-vfs_cache_pressure	2005-03-16 04:22:01.000000000 -0800
+++ 25-akpm/fs/mbcache.c	2005-03-16 04:24:43.000000000 -0800
@@ -225,7 +225,7 @@ mb_cache_shrink_fn(int nr_to_scan, unsig
 						   e_lru_list), gfp_mask);
 	}
 out:
-	return count;
+	return (count / 100) * sysctl_vfs_cache_pressure;
 }
 
 
_

