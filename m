Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTELWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTELWA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:00:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39500 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262830AbTELWAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:00:08 -0400
Date: Mon, 12 May 2003 15:08:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, michel@daenzer.net, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
Message-Id: <20030512150831.5bf2e14c.akpm@digeo.com>
In-Reply-To: <20030512225728.A17182@infradead.org>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
	<16064.453.497373.127754@napali.hpl.hp.com>
	<1052774487.10750.294.camel@thor>
	<16064.5964.342357.501507@napali.hpl.hp.com>
	<20030512225728.A17182@infradead.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2003 22:12:45.0788 (UTC) FILETIME=[9D9B69C0:01C318D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 12, 2003 at 02:51:08PM -0700, David Mosberger wrote:
> > Is there someone else on this list who would be able to look into
> > backporting vmap()/vunmap() to 2.4?  I don't use 2.4 with any
> > regularity anymore, but I suppose if nobody else is interested, I
> > could look into it.
> 
> I did that for the XFS tree ages ago, it's also in the -ac and -aa (the latter
> still has the old three-arg version) now. I will submit it to Marcelo as soon
> as 2.4.21 is out (so with the current 2.4 merge rate it'll be in in about 6 month..)
> 

That 2.5 vmap rework introduced a subtle race-bug-goes-oops in
vmalloc()/vfree().  The below patch from Bill fixes it up.




From: William Lee Irwin III <wli@holomorphy.com>

The new vmalloc() semantics from 2.5.32 had a race window.  As things stand,
the presence of a vm_area in the vmlist protects from allocators other than
the owner examining the ptes in that area.  This puts an ordering constraint
on unmapping, so that allocators are required to unmap areas before removing
them from the list or otherwise dropping the lock.

Currently, unmap_vm_area() is done outside the lock and after the area is
removed, which as we've seen from Felix von Leitner's test is oopsable.

The following patch folds calls to unmap_vm_area() into remove_vm_area() to
reinstate what are essentially the 2.4.x semantics of vfree().  This renders
a number of unmap_vm_area() calls unnecessary (and in fact oopsable since
they wipe ptes from later allocations).  It's an open question as to whether
this is sufficiently performant, but it is the minimally invasive approach. 
The more performant alternative is to provide the right API hooks to wipe the
vmalloc() area clean before removing them from the list, using the ownership
of the area to eliminate holding the vmlist_lock for the duration of the
unmapping.  If it proves to be necessary wli is on standby to implement it.


 25-akpm/arch/i386/mm/ioremap.c       |    1 -
 25-akpm/arch/sparc64/kernel/module.c |    2 ++
 25-akpm/arch/x86_64/kernel/module.c  |    2 +-
 25-akpm/arch/x86_64/mm/ioremap.c     |    1 -
 25-akpm/mm/vmalloc.c                 |    3 +--
 5 files changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/i386/mm/ioremap.c~vmalloc-race-fix arch/i386/mm/ioremap.c
--- 25/arch/i386/mm/ioremap.c~vmalloc-race-fix	Mon May 12 14:17:19 2003
+++ 25-akpm/arch/i386/mm/ioremap.c	Mon May 12 14:17:19 2003
@@ -222,7 +222,6 @@ void iounmap(void *addr)
 		return;
 	} 
 
-	unmap_vm_area(p);
 	if (p->flags && p->phys_addr < virt_to_phys(high_memory)) { 
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
diff -puN arch/sparc64/kernel/module.c~vmalloc-race-fix arch/sparc64/kernel/module.c
--- 25/arch/sparc64/kernel/module.c~vmalloc-race-fix	Mon May 12 14:17:19 2003
+++ 25-akpm/arch/sparc64/kernel/module.c	Mon May 12 14:17:19 2003
@@ -138,7 +138,9 @@ void *module_alloc(unsigned long size)
 /* Free memory returned from module_core_alloc/module_init_alloc */
 void module_free(struct module *mod, void *module_region)
 {
+	write_lock(&vmlist_lock);
 	module_unmap(module_region);
+	write_unlock(&vmlist_lock);
 	/* FIXME: If module_region == mod->init_region, trim exception
            table entries. */
 }
diff -puN arch/x86_64/kernel/module.c~vmalloc-race-fix arch/x86_64/kernel/module.c
--- 25/arch/x86_64/kernel/module.c~vmalloc-race-fix	Mon May 12 14:17:19 2003
+++ 25-akpm/arch/x86_64/kernel/module.c	Mon May 12 14:17:19 2003
@@ -48,7 +48,6 @@ void module_free(struct module *mod, voi
 	for (prevp = &mod_vmlist ; (map = *prevp) ; prevp = &map->next) {
 		if ((unsigned long)map->addr == addr) {
 			*prevp = map->next;
-			write_unlock(&vmlist_lock); 
 			goto found;
 		}
 	}
@@ -57,6 +56,7 @@ void module_free(struct module *mod, voi
 	return;
  found:
 	unmap_vm_area(map);
+	write_unlock(&vmlist_lock); 
 	if (map->pages) {
 		for (i = 0; i < map->nr_pages; i++)
 			if (map->pages[i])
diff -puN arch/x86_64/mm/ioremap.c~vmalloc-race-fix arch/x86_64/mm/ioremap.c
--- 25/arch/x86_64/mm/ioremap.c~vmalloc-race-fix	Mon May 12 14:17:19 2003
+++ 25-akpm/arch/x86_64/mm/ioremap.c	Mon May 12 14:17:19 2003
@@ -222,7 +222,6 @@ void iounmap(void *addr)
 		return;
 	} 
 
-	unmap_vm_area(p);
 	if (p->flags && p->phys_addr < virt_to_phys(high_memory)) { 
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
diff -puN mm/vmalloc.c~vmalloc-race-fix mm/vmalloc.c
--- 25/mm/vmalloc.c~vmalloc-race-fix	Mon May 12 14:17:19 2003
+++ 25-akpm/mm/vmalloc.c	Mon May 12 14:17:19 2003
@@ -260,6 +260,7 @@ struct vm_struct *remove_vm_area(void *a
 	return NULL;
 
 found:
+	unmap_vm_area(tmp);
 	*p = tmp->next;
 	write_unlock(&vmlist_lock);
 	return tmp;
@@ -283,8 +284,6 @@ void __vunmap(void *addr, int deallocate
 				addr);
 		return;
 	}
-
-	unmap_vm_area(area);
 	
 	if (deallocate_pages) {
 		int i;

_

