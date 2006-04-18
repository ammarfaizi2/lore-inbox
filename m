Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWDRJGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWDRJGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWDRJGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:06:51 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:63948 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750904AbWDRJGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:06:51 -0400
Date: Tue, 18 Apr 2006 18:08:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060418180810.e947564c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604180126221.4627@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
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
	<20060418123256.41eb56af.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604172353570.4352@schroedinger.engr.sgi.com>
	<20060418170517.b46736d8.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604180126221.4627@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006 01:27:40 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Tue, 18 Apr 2006, KAMEZAWA Hiroyuki wrote:
> 
> > On Mon, 17 Apr 2006 23:58:41 -0700 (PDT)
> > Christoph Lameter <clameter@sgi.com> wrote:
> > 
> > > Hmmm... Good ideas. I think it could be much simpler like the following 
> > > patch.
> > > 
> > > However, the problem here is how to know that we really took the anon_vma 
> > > lock and what to do about a page being unmmapped while migrating. This 
> > > could cause the anon_vma not to be unlocked.
> > > 
> > lock dependency here is page_lock(page) -> page's anon_vma->lock.
> > So, I guess  anon_vma->lock cannot be unlocked by other threads 
> > if we have page_lock(page).
> 
> No the problem is to know if the lock was really taken. SWAP_AGAIN could 
> mean that page_lock_anon_vma failed.
> 
Ah, I see. and understood what you did in http://lkml.org/lkml/2006/4/18/19

That will be happen when the migration takes the anon_vma->lock in
try_to_unmap().

> Also the page may be freed while it is being processes. In that case 
> remove_migration_ptes may not find the mapping and may not unlock the 
> anon_vma.
> 
My patch in http://lkml.org/lkml/2006/4/17/180

This is a look when above patch is applied.
==
/*
 * Common logic to directly migrate a single page suitable for
 * pages that do not use PagePrivate.
 *
 * Pages are locked upon entry and exit.
 */
int migrate_page(struct page *newpage, struct page *page)
{
        int rc;
        struct anon_vma *anon_vma;
        BUG_ON(PageWriteback(page));    /* Writeback must be complete */
        if (PageAnon(page)) {
                anon_vma = page_lock_anon_vma(page);
        }
        rc = migrate_page_remove_references(newpage, page,
                        page_mapping(page) ? 2 : 1);

        if (rc) {
                remove_migration_ptes(anon_vma, page, page);
                goto unlock_out;
        }
        migrate_page_copy(newpage, page);
        remove_migration_ptes(anon_vma, page, newpage);
unlock_out:
        if (anon_vma)
                spin_unlock(&anon_vma->lock);
        return rc;
}
==

lock around anon_vma->lock does not depend on the result of 
try_to_unmap() and remove_migration_ptes(). 

But I agree : 'taking anon_vma->lock before try_to_unmap() is ugly and complicated
and will make things insane.'

Will this attached one make things clearer ?

This anon_vma->lock is just an optimization (for now) but complicated.
I think restart discusstion against -mm3? will be better.
-Kame
==
Index: Christoph-NewMigrationV2/mm/rmap.c
===================================================================
--- Christoph-NewMigrationV2.orig/mm/rmap.c
+++ Christoph-NewMigrationV2/mm/rmap.c
@@ -711,29 +711,44 @@ static void try_to_unmap_cluster(unsigne
 	pte_unmap_unlock(pte - 1, ptl);
 }
 
-static int try_to_unmap_anon(struct page *page, int migration)
+static int __try_to_unmap_anon(struct anon_vma *anon_vma,
+	struct page *page, int migration)
 {
-	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
 	int ret = SWAP_AGAIN;
 
-	if (migration) { /* anon_vma->lock is held under migration */
-		unsigned long mapping;
-		mapping = (unsigned long)page->mapping - PAGE_MAPPING_ANON;
-		anon_vma = (struct anon_vma *)mapping;
-	} else {
-		anon_vma = page_lock_anon_vma(page);
-	}
-	if (!anon_vma)
-		return ret;
-
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
 		ret = try_to_unmap_one(page, vma, migration);
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			break;
 	}
-	if (!migration)
-		spin_unlock(&anon_vma->lock);
+	return ret;
+}
+
+static int try_to_unmap_anon(struct page *page)
+{
+        struct anon_vma *anon_vma;
+        struct vm_area_struct *vma;
+        int ret = SWAP_AGAIN;
+
+	anon_vma = page_lock_anon_vma(page);
+	if (!anon_vma)
+		return ret;
+	ret = __try_to_unmap_anon(anon_vma, page, 0);
+	spin_unlock(&anon_vma->lock);
+	return ret;
+}
+
+static int try_to_unmap_anon_migrate(struct page *page)
+{
+	struct anon_vma *anon_vma;
+	unsigned long mapping;
+	int ret = SWAP_AGAIN;
+	if (PageAnon(page))
+		return ret;
+	mapping = page->mapping;
+	anon_vma = (struct anon_vma *)(mapping - PAGE_MAPPING_ANON);
+	ret = __try_to_unmap_anon_migrate(anon_vma, page, 1);
 	return ret;
 }
 
@@ -851,9 +866,12 @@ int try_to_unmap(struct page *page, int 
 
 	BUG_ON(!PageLocked(page));
 
-	if (PageAnon(page))
-		ret = try_to_unmap_anon(page, migration);
-	else
+	if (PageAnon(page)) {
+		if (migration)
+			ret = try_to_unmap_anon_migrate(page);
+		else
+			ret = try_to_unmap_anon(page);
+	} else
 		ret = try_to_unmap_file(page, migration);
 
 	if (!page_mapped(page))

