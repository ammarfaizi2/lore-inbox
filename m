Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWDRDbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWDRDbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 23:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWDRDbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 23:31:47 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50320 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751394AbWDRDbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 23:31:46 -0400
Date: Tue, 18 Apr 2006 12:32:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060418123256.41eb56af.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604172011490.3624@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
	<20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
	<20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
	<20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
	<20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604170958100.29732@schroedinger.engr.sgi.com>
	<20060418090439.3e2f0df4.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604171724070.2752@schroedinger.engr.sgi.com>
	<20060418094212.3ece222f.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604171856290.2986@schroedinger.engr.sgi.com>
	<20060418120016.14419e02.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604172011490.3624@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006 20:16:11 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Tue, 18 Apr 2006, KAMEZAWA Hiroyuki wrote:
> 
> > I think following patch will help. but this increases complexity...
> 
> Hmm... So the idea is to lock the anon vma before removing the ptes and 
> keep it until we are finished migrating. I like it! That would also reduce 
> the locking overhead.
> 
> >  /*
> > + * When mmap->sem is not held, we have to guarantee anon_vma is not freed.
> > + */
> > +static void migrate_lock_anon_vma(struct page *page)
> > +{
> > +	unsigned long mapping;
> > +	struct anon_vma *anon_vma;
> > +	struct vm_area_struct *vma;
> > +
> > +	if (PageAnon(page))
> > +		page_lock_anon_vma(page);
> > +	/* remove migration ptes will unlock */
> > +}
> 
> We need a whole function for two statements?
> 
Ah, ok, inlining is better.


> >  	 */
> >  	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
> > -	spin_lock(&anon_vma->lock);
> 
> Maybe we better pass the anon_vma as a parameter?
> 
Agreed, it will improve total look. 

> > +++ Christoph-NewMigrationV2/mm/rmap.c
> > @@ -160,7 +160,7 @@ void anon_vma_unlink(struct vm_area_stru
> >  	empty = list_empty(&anon_vma->head);
> >  	spin_unlock(&anon_vma->lock);
> >  
> > -	if (empty)
> > +	if (empty && !anon_vma->async_refernece)
> >  		anon_vma_free(anon_vma);
> >  }
> 
> async_reference? What is this for? This does not exist in Linus' 
> tree.
please ignore ;), this is trash of my old tree. sorry.

Here is updated one.
-Kame

hold anon_vma->lock under migration.

While migration, page_mapcount(page) goes down to 0 and page->mapping is valid.
This breaks assumptions around page_mapcount() and page->mapping.
(See rmap.c, page_remove_rmap())
If mmap->sem is held while migration, there is no problem. But if mmap->sem is
not held, this is a race.

This patch locks anon_vma under migration.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: Christoph-NewMigrationV2/mm/migrate.c
===================================================================
--- Christoph-NewMigrationV2.orig/mm/migrate.c
+++ Christoph-NewMigrationV2/mm/migrate.c
@@ -184,28 +184,18 @@ out:
  * Must hold mmap_sem lock on at least one of the vmas containing
  * the page so that the anon_vma cannot vanish.
  */
-static void remove_migration_ptes(struct page *old, struct page *new)
+static void remove_migration_ptes(struct anon_vma *anon_vma,
+			struct page *old, struct page *new)
 {
-	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
 	unsigned long mapping;
 
-	mapping = (unsigned long)new->mapping;
-
-	if (!mapping || (mapping & PAGE_MAPPING_ANON) == 0)
+	if (!anon_vma)
 		return;
 
-	/*
-	 * We hold the mmap_sem lock. So no need to call page_lock_anon_vma.
-	 */
-	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
-	spin_lock(&anon_vma->lock);
-
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node)
 		remove_migration_pte(vma, page_address_in_vma(new, vma),
 					old, new);
-
-	spin_unlock(&anon_vma->lock);
 }
 
 /*
@@ -368,20 +358,24 @@ EXPORT_SYMBOL(migrate_page_copy);
 int migrate_page(struct page *newpage, struct page *page)
 {
 	int rc;
-
+	struct anon_vma *anon_vma;
 	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
-
+	if (PageAnon(page)) {
+		anon_vma = page_lock_anon_vma(page);
+	}
 	rc = migrate_page_remove_references(newpage, page,
 			page_mapping(page) ? 2 : 1);
 
 	if (rc) {
-		remove_migration_ptes(page, page);
-		return rc;
+		remove_migration_ptes(anon_vma, page, page);
+		goto unlock_out;
 	}
-
 	migrate_page_copy(newpage, page);
-	remove_migration_ptes(page, newpage);
-	return 0;
+	remove_migration_ptes(anon_vma, page, newpage);
+unlock_out:
+	if (anon_vma)
+		spin_unlock(&anon_vma->lock);
+	return rc;
 }
 EXPORT_SYMBOL(migrate_page);
 
Index: Christoph-NewMigrationV2/mm/rmap.c
===================================================================
--- Christoph-NewMigrationV2.orig/mm/rmap.c
+++ Christoph-NewMigrationV2/mm/rmap.c
@@ -717,7 +717,13 @@ static int try_to_unmap_anon(struct page
 	struct vm_area_struct *vma;
 	int ret = SWAP_AGAIN;
 
-	anon_vma = page_lock_anon_vma(page);
+	if (migration) { /* anon_vma->lock is held under migration */
+		unsigned long mapping;
+		mapping = (unsigned long)page->mapping - PAGE_MAPPING_ANON;
+		anon_vma = (struct anon_vma *)mapping;
+	} else {
+		anon_vma = page_lock_anon_vma(page);
+	}
 	if (!anon_vma)
 		return ret;
 
@@ -726,7 +732,8 @@ static int try_to_unmap_anon(struct page
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			break;
 	}
-	spin_unlock(&anon_vma->lock);
+	if (!migration)
+		spin_unlock(&anon_vma->lock);
 	return ret;
 }
 


