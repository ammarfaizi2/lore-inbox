Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbUKQTSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUKQTSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUKQTRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:17:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:41902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262460AbUKQTOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:14:01 -0500
Date: Wed, 17 Nov 2004 11:13:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: 76306.1226@compuserve.com, ak@suse.de, andrea@novell.com,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
Message-Id: <20041117111336.608409ef.akpm@osdl.org>
In-Reply-To: <20041117120819.GG4620@wotan.suse.de>
References: <200411162259_MC3-1-8ED8-6C32@compuserve.com>
	<20041117120819.GG4620@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Tue, Nov 16, 2004 at 10:54:09PM -0500, Chuck Ebbert wrote:
> > On Wed, 17 Nov 2004 at 02:00:20 +0100, Andi Kleen wrote:
> > 
> > > On Mon, Nov 15, 2004 at 11:15:51PM -0500, Chuck Ebbert wrote:
> > > > Andrea posted this one-liner a while ago as part of a larger patch.  He said
> > > > it fixed return of the wrong policy in some conditions.  Was this a valid fix?
> > >
> > > Yes it was.
> > 
> >   At least it wasn't dropped -- it's in -mm as part of
> > fix-for-mpol-mm-corruption-on-tmpfs, though it's unrelated to tmpfs.
> > (That patch contains three separate changes...)
> > 
> >   Should just this part, which changes '<' to '<=', be pushed upstream?
> 
> Yes. I'm sure Andrea will take care of that himself. 
> 

That fix is contained within fix-for-mpol-mm-corruption-on-tmpfs.patch
anyway, isn't it?  And that patch is slated for merging once I work out
whether Hugh and Andrea have sorted things out?


From: Andrea Arcangeli <andrea@novell.com>

With the inline symlink shmem_inode_info structure is overwritten with data
until vfs_inode, and that caused the ->policy to be a corrupted pointer
during unlink.  It wasn't immediatly easy to see what was going on due the
random mm corruption that generated a weird oops, it looked more like a
race condition on freed memory at first.

There's simply no need to set a policy for inodes, since the idx is always
zero.  All we have to do is to initialize the data structure (the semaphore
may need to run during the page allocation for the non-inline symlink) but
we don't need to allocate the rb nodes.  This way we don't need to call
mpol_free during the destroy_inode (not doable at all if the policy rbtree
is corrupt by the inline symlink ;).

An equivalent version of this patch based on a 2.6.5 tree with additional
numa features on top of this (i.e.  interleaved by default, and that's
prompted me to add a comment in the LNK init path), works fine in a numa
simulation on my laptop (untested on the bare hardware).

The patch includes another unrelated bugfix I did while checking
mempolicy.c code that would return the wrong policy in some case and some
unrelated optimizations again in mempolicy.c (like to avoid rebalancing the
tree while destroying it and by breaking loops early and not checking for
invariant conditions in the replace operation).  You want to review the
rebalance optimization I did in shared_policy_replace, that's tricky code.

Signed-off-by: Andrea Arcangeli <andrea@novell.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/mempolicy.c |   18 ++++++++----------
 25-akpm/mm/shmem.c     |   12 ++++++++++--
 2 files changed, 18 insertions(+), 12 deletions(-)

diff -puN mm/mempolicy.c~fix-for-mpol-mm-corruption-on-tmpfs mm/mempolicy.c
--- 25/mm/mempolicy.c~fix-for-mpol-mm-corruption-on-tmpfs	2004-11-15 20:01:14.174522104 -0800
+++ 25-akpm/mm/mempolicy.c	2004-11-15 20:01:14.179521344 -0800
@@ -1078,13 +1078,13 @@ sp_lookup(struct shared_policy *sp, unsi
 
 	while (n) {
 		struct sp_node *p = rb_entry(n, struct sp_node, nd);
-		if (start >= p->end) {
+
+		if (start >= p->end)
 			n = n->rb_right;
-		} else if (end < p->start) {
+		else if (end <= p->start)
 			n = n->rb_left;
-		} else {
+		else
 			break;
-		}
 	}
 	if (!n)
 		return NULL;
@@ -1197,12 +1197,10 @@ restart:
 						return -ENOMEM;
 					goto restart;
 				}
-				n->end = end;
+				n->end = start;
 				sp_insert(sp, new2);
-				new2 = NULL;
-			}
-			/* Old crossing beginning, but not end (easy) */
-			if (n->start < start && n->end > start)
+				break;
+			} else
 				n->end = start;
 		}
 		if (!next)
@@ -1256,11 +1254,11 @@ void mpol_free_shared_policy(struct shar
 	while (next) {
 		n = rb_entry(next, struct sp_node, nd);
 		next = rb_next(&n->nd);
-		rb_erase(&n->nd, &p->root);
 		mpol_free(n->policy);
 		kmem_cache_free(sn_cache, n);
 	}
 	spin_unlock(&p->lock);
+	p->root = RB_ROOT;
 }
 
 struct page *
diff -puN mm/shmem.c~fix-for-mpol-mm-corruption-on-tmpfs mm/shmem.c
--- 25/mm/shmem.c~fix-for-mpol-mm-corruption-on-tmpfs	2004-11-15 20:01:14.175521952 -0800
+++ 25-akpm/mm/shmem.c	2004-11-15 20:01:14.181521040 -0800
@@ -1283,7 +1283,6 @@ shmem_get_inode(struct super_block *sb, 
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
- 		mpol_shared_policy_init(&info->policy);
 		INIT_LIST_HEAD(&info->swaplist);
 
 		switch (mode & S_IFMT) {
@@ -1294,6 +1293,7 @@ shmem_get_inode(struct super_block *sb, 
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
+			mpol_shared_policy_init(&info->policy);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -1303,6 +1303,11 @@ shmem_get_inode(struct super_block *sb, 
 			inode->i_fop = &simple_dir_operations;
 			break;
 		case S_IFLNK:
+			/*
+			 * Must not load anything in the rbtree,
+			 * mpol_free_shared_policy will not be called.
+			 */
+			mpol_shared_policy_init(&info->policy);
 			break;
 		}
 	} else if (sbinfo) {
@@ -2021,7 +2026,10 @@ static struct inode *shmem_alloc_inode(s
 
 static void shmem_destroy_inode(struct inode *inode)
 {
-	mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	if ((inode->i_mode & S_IFMT) == S_IFREG) {
+		/* only struct inode is valid if it's an inline symlink */
+		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	}
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
_

