Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVCBOnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVCBOnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVCBOmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:42:38 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:16262 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262322AbVCBOlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:41:08 -0500
Subject: Re: [2.6.11-rc5-mm1 patch] reiser4 cleanup (PG_arch_1)
From: Vladimir Saveliev <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <20050302011448.37f1e951.akpm@osdl.org>
References: <20050301012741.1d791cd2.akpm@osdl.org>
	 <20050301234324.GJ4845@stusta.de> <yq0is4afml7.fsf@jaguar.mkp.net>
	 <20050302011448.37f1e951.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-Plc7lRnv8+SGWUuc4Jzx"
Message-Id: <1109774424.3503.444.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 02 Mar 2005 17:40:25 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Plc7lRnv8+SGWUuc4Jzx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Wed, 2005-03-02 at 12:14, Andrew Morton wrote:
> Jes Sorensen <jes@wildopensource.com> wrote:
> >
> > >>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:
> > 
> > Adrian> The current reiser4 help texts have two disadvantages: 1. they
> > Adrian> are more marketing speech than technical speech with some
> > Adrian> debatable statements 2. they are too long
> > 
> > Excellent patch, that help description has been totally inappropriate
> > since it was first introduced. I'm sure it will do fine on namesys'
> > website, but not in the kernel.
> > 
> > Adrian> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > Signed-off-by: Jes Sorensen <jes@wildopensource.com>
> > 
> > Speaking of inappropriate components in reiser4:
> > 
> > [jes@tomahawk linux-2.6.11-rc5-mm1]$ grep PG_arch fs/reiser4/*.c
> > fs/reiser4/page_cache.c:               page_flag_name(page, PG_arch_1),
> > fs/reiser4/txnmgr.c:                    assert("vs-1448", test_and_clear_bit(PG_arch_1, &node->pg->flags));
> > fs/reiser4/txnmgr.c:            ON_DEBUG(set_bit(PG_arch_1, &(copy->pg)->flags));
> > 
> > Someone was obviously smoking something illegal, what part of 'arch'
> > did she/he not understand? I assume we can request this is fixed by
> > the patch owner asap.
> > 
> 
> Could the reiserfs team please comment?
> 

Yes, that was old debugging code. It is to be removed. The patch for
that is attached.

Please also apply another attached small bug fix.



> If it's just debug then probably it would be better to add a new flag.
> 
> If these pages are never mmapped then it'll just happen to work, I guess. 
> But a filesystem really shouldn't be dinking with PG_arch_1.
> 
> 

--=-Plc7lRnv8+SGWUuc4Jzx
Content-Disposition: attachment; filename=reiser4-cleanup.patch
Content-Type: text/plain; name=reiser4-cleanup.patch; charset=koi8-r
Content-Transfer-Encoding: 7bit


This cleanups old debugging code


 fs/reiser4/page_cache.c |    6 ++++--
 fs/reiser4/txnmgr.c     |    6 +-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff -puN fs/reiser4/txnmgr.c~reiser4-cleanup fs/reiser4/txnmgr.c
--- linux-2.6.11-rc4-mm1/fs/reiser4/txnmgr.c~reiser4-cleanup	2005-03-02 17:23:47.000000000 +0300
+++ linux-2.6.11-rc4-mm1-vs/fs/reiser4/txnmgr.c	2005-03-02 17:24:27.000000000 +0300
@@ -1507,11 +1507,8 @@ invalidate_list(capture_list_head * head
 		atom = node->atom;
 		LOCK_ATOM(atom);
 		LOCK_JNODE(node);
-		if (JF_ISSET(node, JNODE_CC) && node->pg) {
-			/* corresponding page_cache_get is in swap_jnode_pages */
-			assert("vs-1448", test_and_clear_bit(PG_arch_1, &node->pg->flags));
+		if (JF_ISSET(node, JNODE_CC) && node->pg)
 			page_cache_release(node->pg);
-		}
 		uncapture_block(node);
 		UNLOCK_ATOM(atom);
 		JF_CLR(node, JNODE_SCANNED);
@@ -3578,7 +3575,6 @@ swap_jnode_pages(jnode *node, jnode *cop
 		assert("vs-1416", radix_tree_lookup(&mapping->page_tree, index) == NULL);
 		check_me("vs-1418", radix_tree_insert(&mapping->page_tree, index, copy->pg) == 0);
 		___add_to_page_cache(copy->pg, mapping, index);
-		ON_DEBUG(set_bit(PG_arch_1, &(copy->pg)->flags));
 
 		/* corresponding page_cache_release is in invalidate_list */
 		page_cache_get(copy->pg);
diff -puN fs/reiser4/page_cache.c~reiser4-cleanup fs/reiser4/page_cache.c
--- linux-2.6.11-rc4-mm1/fs/reiser4/page_cache.c~reiser4-cleanup	2005-03-02 17:23:47.000000000 +0300
+++ linux-2.6.11-rc4-mm1-vs/fs/reiser4/page_cache.c	2005-03-02 17:25:36.000000000 +0300
@@ -743,18 +743,20 @@ print_page(const char *prefix, struct pa
 	}
 	printk("%s: page index: %lu mapping: %p count: %i private: %lx\n",
 	       prefix, page->index, page->mapping, page_count(page), page->private);
-	printk("\tflags: %s%s%s%s %s%s%s %s%s%s%s %s%s%s\n",
+	printk("\tflags: %s%s%s%s %s%s%s %s%s%s %s%s%s\n",
 	       page_flag_name(page, PG_locked),
 	       page_flag_name(page, PG_error),
 	       page_flag_name(page, PG_referenced),
 	       page_flag_name(page, PG_uptodate),
+
 	       page_flag_name(page, PG_dirty),
 	       page_flag_name(page, PG_lru),
 	       page_flag_name(page, PG_slab),
+
 	       page_flag_name(page, PG_highmem),
 	       page_flag_name(page, PG_checked),
-	       page_flag_name(page, PG_arch_1),
 	       page_flag_name(page, PG_reserved),
+
 	       page_flag_name(page, PG_private), page_flag_name(page, PG_writeback), page_flag_name(page, PG_nosave));
 	if (jprivate(page) != NULL) {
 		print_jnode("\tpage jnode", jprivate(page));

_

--=-Plc7lRnv8+SGWUuc4Jzx
Content-Disposition: attachment; filename=reiser4-add-missing-spin_unlock.patch
Content-Type: text/plain; name=reiser4-add-missing-spin_unlock.patch; charset=koi8-r
Content-Transfer-Encoding: 7bit


This patch adds missing spin_unlock to error handling path


 fs/reiser4/plugin/item/extent_file_ops.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN fs/reiser4/plugin/item/extent_file_ops.c~reiser4-add-missing-spin_unlock fs/reiser4/plugin/item/extent_file_ops.c
--- linux-2.6.11-rc4-mm1/fs/reiser4/plugin/item/extent_file_ops.c~reiser4-add-missing-spin_unlock	2005-03-02 17:29:46.000000000 +0300
+++ linux-2.6.11-rc4-mm1-vs/fs/reiser4/plugin/item/extent_file_ops.c	2005-03-02 17:32:05.000000000 +0300
@@ -799,8 +799,10 @@ extent_write_flow(struct inode *inode, f
 		   to dirty list */
 		LOCK_JNODE(j);
 		result = try_capture(j, ZNODE_WRITE_LOCK, 0, 1/* can_coc */);
-		if (result)
+		if (result) {
+			UNLOCK_JNODE(j);
 			goto exit2;
+		}
 		jnode_make_dirty_locked(j);
 		UNLOCK_JNODE(j);
 

_

--=-Plc7lRnv8+SGWUuc4Jzx--

