Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUJ1JY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUJ1JY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUJ1JY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:24:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:24844 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262848AbUJ1JYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:24:13 -0400
To: Nigel Kukard <nkukard@lbsd.net>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net>
	<200410281055.47263.vda@port.imtp.ilyichevsk.odessa.ua>
	<4180A9A4.4000503@lbsd.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 28 Oct 2004 18:23:31 +0900
In-Reply-To: <4180A9A4.4000503@lbsd.net> (Nigel Kukard's message of "Thu, 28
 Oct 2004 08:11:16 +0000")
Message-ID: <873bzzw60c.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard <nkukard@lbsd.net> writes:

> OOPS is 100% reproducable. I boot into X, and run    eog
> /mnt/camera/dcim/100cresi    and BANG.

This is known problem. Can you please try the following patch?
Then, please send debugging output.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



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
