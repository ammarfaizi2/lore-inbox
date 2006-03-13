Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWCMFqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWCMFqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 00:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWCMFqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 00:46:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:19411 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751475AbWCMFqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 00:46:47 -0500
From: Neil Brown <neilb@suse.de>
To: Jan Blunck <jblunck@suse.de>
Date: Mon, 13 Mar 2006 16:45:32 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17429.1788.586399.181869@cse.unsw.edu.au>
Cc: Kirill Korotaev <dev@openvz.org>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
In-Reply-To: message from Jan Blunck on Monday March 13
References: <20060309165833.GK4243@hasse.suse.de>
	<441060D2.6090800@openvz.org>
	<17425.2594.967505.22336@cse.unsw.edu.au>
	<441138B7.9060809@sw.ru>
	<20060310105950.GL4243@hasse.suse.de>
	<17425.26668.678359.918399@cse.unsw.edu.au>
	<20060310123153.GN4243@hasse.suse.de>
	<17428.39221.861124.797480@cse.unsw.edu.au>
	<20060312230331.GO4243@hasse.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 13, jblunck@suse.de wrote:
> On Mon, Mar 13, Neil Brown wrote:
> 
> > No you don't.
> 
> Err, you are right. But this brings a new idea to my mind: why don't we use
> s_umount to prevent umounting while we prune one dentry? Something like:
> 
>   if (down_read_trylock()) {
>     if (s_root)
>       prune_one_dentry()
>     up_read()
>   }
>   // else just skip it
> 
> So maybe our prunes counter isn't the only way to go. Comments?

Hmmm.... yes, I think that could work.  Patch below against
2.6.16-rc6-mm1.

I cannot see down_read_trylock being slower than dcache_lock, so I
suspect this shouldn't impact performance.

Does this meet with everyone's approval?

NeilBrown




Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c |   40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2006-03-13 16:19:29.000000000 +1100
+++ ./fs/dcache.c	2006-03-13 16:43:59.000000000 +1100
@@ -383,6 +383,8 @@ static inline void prune_one_dentry(stru
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
+ * @sb: if given, ignore dentries for other superblocks
+ *         which are being unmounted.
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -393,7 +395,7 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count)
+static void prune_dcache(int count, struct super_block *sb)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
@@ -420,15 +422,27 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
-			dentry->d_flags &= ~DCACHE_REFERENCED;
- 			list_add(&dentry->d_lru, &dentry_unused);
- 			dentry_stat.nr_unused++;
- 			spin_unlock(&dentry->d_lock);
-			continue;
+		if (!(dentry->d_flags & DCACHE_REFERENCED) &&
+		    (!sb || dentry->d_sb == sb)) {
+			if (sb) {
+				prune_one_dentry(dentry);
+				continue;
+			}
+			/* Need to avoid race with generic_shutdown_super */
+			if (down_read_trylock(&dentry->d_sb->s_umount) &&
+			    dentry->d_sb->s_root != NULL) {
+				prune_one_dentry(dentry);
+				up_read(&dentry->d_sb->s_umount);
+				continue;
+			}
 		}
-		prune_one_dentry(dentry);
+		/* The dentry was recently referenced, or the filesystem
+		 * is being unmounted, so don't free it. */
+
+		dentry->d_flags &= ~DCACHE_REFERENCED;
+		list_add(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
+		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -639,9 +653,10 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_dcache(found, parent->d_sb);
 }
 
+#if 0
 /**
  * shrink_dcache_anon - further prune the cache
  * @head: head of d_hash list of dentries to prune
@@ -677,9 +692,10 @@ void shrink_dcache_anon(struct hlist_hea
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found);
+		prune_dcache(found, NULL);
 	} while(found);
 }
+#endif
 
 /*
  * Scan `nr' dentries and return the number which remain.
@@ -698,7 +714,7 @@ static int shrink_dcache_memory(int nr, 
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
 			return -1;
-		prune_dcache(nr);
+		prune_dcache(nr, NULL);
 	}
 	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }
