Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUKLLNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUKLLNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 06:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbUKLLNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 06:13:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36224
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262503AbUKLLNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 06:13:39 -0500
Date: Fri, 12 Nov 2004 12:13:38 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, bcasavan@sgi.com
Subject: fix for mpol mm corruption on tmpfs
Message-ID: <20041112111338.GB10142@x30.random>
References: <20041111112922.GA15948@logos.cnet> <20041111154238.GD18365@x30.random> <20041111123850.GA16349@logos.cnet> <20041111165050.GA5822@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111165050.GA5822@x30.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Thu, Nov 11, 2004 at 05:50:51PM +0100, Andrea Arcangeli wrote:
> [..] I've a bad kernel
> crash to debug with random mem corruption [..]

With the inline symlink shmem_inode_info structure is overwritten with
data until vfs_inode, and that caused the ->policy to be a corrupted
pointer during unlink.  It wasn't immediatly easy to see what was going
on due the random mm corruption that generated a weird oops, it looked
more like a race condition on freed memory at first.

There's simply no need to set a policy for inodes, since the idx is
always zero. All we have to do is to initialize the data structure (the
semaphore may need to run during the page allocation for the non-inline
symlink) but we don't need to allocate the rb nodes. This way we don't
need to call mpol_free during the destroy_inode (not doable at all if
the policy rbtree is corrupt by the inline symlink ;).

An equivalent version of this patch based on a 2.6.5 tree with
additional numa features on top of this (i.e. interleaved by default,
and that's prompted me to add a comment in the LNK init path), works
fine in a numa simulation on my laptop (untested on the bare hardware).

The patch includes another unrelated bugfix I did while checking
mempolicy.c code that would return the wrong policy in some case and
some unrelated optimizations again in mempolicy.c (like to avoid
rebalancing the tree while destroying it and by breaking loops early and
not checking for invariant conditions in the replace operation). You
want to review the rebalance optimization I did in
shared_policy_replace, that's tricky code.

Signed-off-by: Andrea Arcangeli <andrea@novell.com>

Index: mm/mempolicy.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/mempolicy.c,v
retrieving revision 1.19
diff -u -p -r1.19 mempolicy.c
--- mm/mempolicy.c	28 Oct 2004 15:16:58 -0000	1.19
+++ mm/mempolicy.c	12 Nov 2004 11:04:11 -0000
@@ -902,7 +902,7 @@ sp_lookup(struct shared_policy *sp, unsi
 		struct sp_node *p = rb_entry(n, struct sp_node, nd);
 		if (start >= p->end) {
 			n = n->rb_right;
-		} else if (end < p->start) {
+		} else if (end <= p->start) {
 			n = n->rb_left;
 		} else {
 			break;
@@ -1015,12 +1015,10 @@ restart:
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
@@ -1073,11 +1071,11 @@ void mpol_free_shared_policy(struct shar
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
 
 /* assumes fs == KERNEL_DS */
Index: mm/shmem.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/shmem.c,v
retrieving revision 1.160
diff -u -p -r1.160 shmem.c
--- mm/shmem.c	28 Oct 2004 15:18:00 -0000	1.160
+++ mm/shmem.c	12 Nov 2004 11:01:13 -0000
@@ -1292,7 +1292,6 @@ shmem_get_inode(struct super_block *sb, 
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
- 		mpol_shared_policy_init(&info->policy);
 		INIT_LIST_HEAD(&info->swaplist);
 
 		switch (mode & S_IFMT) {
@@ -1303,6 +1302,7 @@ shmem_get_inode(struct super_block *sb, 
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
+			mpol_shared_policy_init(&info->policy);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -1312,6 +1312,11 @@ shmem_get_inode(struct super_block *sb, 
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
 	}
@@ -2024,7 +2029,9 @@ static struct inode *shmem_alloc_inode(s
 
 static void shmem_destroy_inode(struct inode *inode)
 {
-	mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	if ((inode->i_mode & S_IFMT) == S_IFREG) {
+		/* only struct inode is valid if it's an inline symlink */
+		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
