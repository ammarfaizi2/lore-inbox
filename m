Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUJRDv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUJRDv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 23:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269372AbUJRDv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 23:51:59 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:24079 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S269370AbUJRDvw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 23:51:52 -0400
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<200410162344.41533.dominik.karall@gmx.net>
	<87k6tpwebi.fsf@devron.myhome.or.jp>
	<200410171946.33472.dominik.karall@gmx.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 18 Oct 2004 12:50:26 +0900
In-Reply-To: <200410171946.33472.dominik.karall@gmx.net> (Dominik Karall's
 message of "Sun, 17 Oct 2004 19:46:31 +0200")
Message-ID: <87ekjw65x9.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Dominik Karall <dominik.karall@gmx.net> writes:

> yes, the bug only occurs on a specific file.
> as the bug is present in -mm1 (without vp) too, i applied your patch to that 
> one. here is the output:
>
> fat_cache_check: id 0, contig 6415, fclus 38231, dclus 1010103
> contig 6416, fclus 38231, dclus 1010103
> contig 0, fclus 32, dclus 603964
> contig 1, fclus 30, dclus 603960
> contig 7, fclus 22, dclus 603950
> contig 4, fclus 17, dclus 603943
> contig 1, fclus 15, dclus 603940
> contig 6, fclus 8, dclus 603931
> contig 0, fclus 7, dclus 603929

Thanks. Seems good. There is no inconsistency in cache.

> and the movie starts to play in mplayer without problems. tell me if
> you need more debugging!

Can you please try the patch again? This patch should tell who added
the cache.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fat-debug.patch



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletion(-)

diff -puN fs/fat/cache.c~fat-debug fs/fat/cache.c
--- linux-2.6.9-final-a/fs/fat/cache.c~fat-debug	2004-10-17 23:45:27.000000000 +0900
+++ linux-2.6.9-final-a-hirofumi/fs/fat/cache.c	2004-10-18 09:38:31.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 #include <linux/buffer_head.h>
+#include <linux/sched.h>
 
 /* this must be > 0. */
 #define FAT_MAX_CACHE	8
@@ -20,6 +21,10 @@ struct fat_cache {
 	int nr_contig;	/* number of contiguous clusters */
 	int fcluster;	/* cluster number in the file. */
 	int dcluster;	/* cluster number on disk. */
+	char comm[16];
+	pid_t pid;
+	unsigned int id;
+	unsigned long long tsc;
 };
 
 struct fat_cache_id {
@@ -134,6 +139,36 @@ static struct fat_cache *fat_cache_merge
 	return NULL;
 }
 
+static void fat_cache_check(struct inode *inode, struct fat_cache_id *new)
+{
+	struct fat_cache *p;
+	unsigned long long tsc;
+
+	if (new->id == FAT_CACHE_VALID) {
+		list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
+			/* Find the same part as "new" in cluster-chain. */
+			if (p->fcluster == new->fcluster) {
+				BUG_ON(p->dcluster != new->dcluster);
+				goto dump_cache;
+			}
+		}
+	}
+	return;
+
+dump_cache:
+	rdtscll(tsc);
+	printk("%s: tsc %llu, comm %s, pid %d, id %u, "
+	       "contig %d, fclus %d, dclus %d\n",
+	       __FUNCTION__, tsc, current->comm, current->pid, new->id,
+	       new->nr_contig, new->fcluster, new->dcluster);
+	list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
+		printk("tsc %llu, comm %s, pid %d, id %u, "
+		       "contig %d, fclus %d, dclus %d\n",
+		       p->tsc, p->comm, p->pid, p->id,
+		       p->nr_contig, p->fcluster, p->dcluster);
+	}
+}
+
 static void fat_cache_add(struct inode *inode, struct fat_cache_id *new)
 {
 	struct fat_cache *cache, *tmp;
@@ -146,8 +181,8 @@ static void fat_cache_add(struct inode *
 	    new->id != MSDOS_I(inode)->cache_valid_id)
 		goto out;	/* this cache was invalidated */
 
+	fat_cache_check(inode, new);
 	cache = fat_cache_merge(inode, new);
-	BUG_ON(new->id == FAT_CACHE_VALID && cache != NULL);
 	if (cache == NULL) {
 		if (MSDOS_I(inode)->nr_caches < fat_max_cache(inode)) {
 			MSDOS_I(inode)->nr_caches++;
@@ -171,6 +206,10 @@ static void fat_cache_add(struct inode *
 		cache->nr_contig = new->nr_contig;
 	}
 out_update_lru:
+	strcpy(cache->comm, current->comm);
+	cache->pid = current->pid;
+	cache->id = new->id;
+	rdtscll(cache->tsc);
 	fat_cache_update_lru(inode, cache);
 out:
 	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
_

--=-=-=--
