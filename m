Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUJQPfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUJQPfY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUJQPfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:35:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:42500 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S269113AbUJQPfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:35:01 -0400
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
	<200410162230.14363.dominik.karall@gmx.net>
	<1097958703.2148.27.camel@krustophenia.net>
	<200410162344.41533.dominik.karall@gmx.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 18 Oct 2004 00:32:17 +0900
In-Reply-To: <200410162344.41533.dominik.karall@gmx.net> (Dominik Karall's
 message of "Sat, 16 Oct 2004 23:44:35 +0200")
Message-ID: <87k6tpwebi.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Dominik Karall <dominik.karall@gmx.net> writes:

> i could reproduce it now, but only once. it appeared when i started an avi 
> movie from my fat32 partition. mplayer stopped at buffering 2% and does not 
> play the movie. i tried to start mplayer again and reproduce it, but the bug 
> does not appear again. mplayer only stopped at 2% buffering and does nothing 
> more. it seems like the file couldn't be read clearly now from the fat32 
> partition, as it does not work with xine and others too.
> here is the bug i get now:
>
> ------------[ cut here ]------------
> kernel BUG at fs/fat/cache.c:150!

Probably this BUG_ON() was wrong. Does this bug occur only by the
specific file?

If so, please do "filefrag -v filename" against that file.

Then, can you try the attached patch? This patch removes the BUG_ON(),
and instead adds printk() for debugging. When the bug occured, it prints
the current cache.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fat-debug.patch



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletion(-)

diff -puN fs/fat/cache.c~fat-debug fs/fat/cache.c
--- linux-2.6.9-final-a/fs/fat/cache.c~fat-debug	2004-10-17 23:45:27.000000000 +0900
+++ linux-2.6.9-final-a-hirofumi/fs/fat/cache.c	2004-10-18 00:26:44.000000000 +0900
@@ -134,6 +134,30 @@ static struct fat_cache *fat_cache_merge
 	return NULL;
 }
 
+static void fat_cache_check(struct inode *inode, struct fat_cache_id *new)
+{
+	struct fat_cache *p;
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
+	printk("%s: id %u, contig %d, fclus %d, dclus %d\n", __FUNCTION__,
+	       new->id, new->nr_contig, new->fcluster, new->dcluster);
+	list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
+		printk("contig %d, fclus %d, dclus %d\n",
+		       p->nr_contig, p->fcluster, p->dcluster);
+	}
+}
+
 static void fat_cache_add(struct inode *inode, struct fat_cache_id *new)
 {
 	struct fat_cache *cache, *tmp;
@@ -146,8 +170,8 @@ static void fat_cache_add(struct inode *
 	    new->id != MSDOS_I(inode)->cache_valid_id)
 		goto out;	/* this cache was invalidated */
 
+	fat_cache_check(inode, new);
 	cache = fat_cache_merge(inode, new);
-	BUG_ON(new->id == FAT_CACHE_VALID && cache != NULL);
 	if (cache == NULL) {
 		if (MSDOS_I(inode)->nr_caches < fat_max_cache(inode)) {
 			MSDOS_I(inode)->nr_caches++;
_

--=-=-=--
