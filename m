Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270469AbUJTXaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbUJTXaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270520AbUJTXaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:30:09 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:62953 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S270469AbUJTXXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:23:35 -0400
Date: Thu, 21 Oct 2004 01:24:24 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041020232424.GH24619@dualathlon.random>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain> <20041019143522.GA8688@logos.cnet> <1098297838.12366.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098297838.12366.4.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 07:43:58PM +0100, Alan Cox wrote:
> On Maw, 2004-10-19 at 15:35, Marcelo Tosatti wrote:
> > > That isnt sufficient. Consider anything else taking a reference to the
> > > page and the refcount going negative. 
> > 
> > You mean not going negative? The problem here as I understand here is 
> > we dont release the count if the PageReserved is set, but we should.
> 
> Drivers like the OSS audio drivers move page between Reserved and 
> unreserved. The count can thus be corrupted.

the PG_reserved goes away after VM_IO, so forbidding pages with
PG_reserved of vmas with VM_IO isn't any different as far as I can tell,
and since PG_reserved is the real offender sure we shouldn't leave a
check in get_user_pages that explicitly do something if the page is
reserved, since if the page is reserved at that point we'd need to
return -EFAULT or BUG_ON.

Adding the VM_IO patch on top of this is sure a good idea.

--- sles/mm/memory.c.~1~	2004-10-19 19:34:10.264335488 +0200
+++ sles/mm/memory.c	2004-10-19 19:58:47.403776160 +0200
@@ -806,7 +806,7 @@ int get_user_pages(struct task_struct *t
 			}
 			if (pages) {
 				pages[i] = get_page_map(map);
-				if (!pages[i]) {
+				if (!pages[i] || PageReserved(pages[i])) {
 					spin_unlock(&mm->page_table_lock);
 					while (i--)
 						page_cache_release(pages[i]);
@@ -814,8 +814,7 @@ int get_user_pages(struct task_struct *t
 					goto out;
 				}
 				flush_dcache_page(pages[i]);
-				if (!PageReserved(pages[i]))
-					page_cache_get(pages[i]);
+				page_cache_get(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;

My version of the fix for 2.4 is this, but this fixes as well an issue
with the zeropage and it's on top of some other fix for COW corruption
in 2.4 not yet fixed in mainline 2.4. Since 2.4 never checked
PageReserved like 2.6 does in get_user_pages, 2.4 as worse can suffer a
memleak.

--- sles/include/linux/mm.h.~1~	2004-10-18 10:20:53.391823696 +0200
+++ sles/include/linux/mm.h	2004-10-18 10:47:10.861011928 +0200
@@ -533,9 +533,8 @@ extern void unpin_pte_page(struct page *
 
 static inline void put_user_page_pte_pin(struct page * page)
 {
-	if (PagePinned(page))
-		/* must run before put_page, put_page may free the page */
-		unpin_pte_page(page);
+	/* must run before put_page, put_page may free the page */
+	unpin_pte_page(page);
 
 	put_page(page);
 }
--- sles/mm/memory.c.~1~	2004-10-18 10:20:54.947587184 +0200
+++ sles/mm/memory.c	2004-10-18 10:47:49.822088944 +0200
@@ -530,7 +530,11 @@ void __wait_on_pte_pinned_page(struct pa
 
 void unpin_pte_page(struct page *page)
 {
-	wait_queue_head_t *waitqueue = page_waitqueue(page);
+	wait_queue_head_t *waitqueue;
+
+	if (!PagePinned(page))
+		return;
+	waitqueue = page_waitqueue(page);
 	if (unlikely(!TestClearPagePinned(page)))
 		BUG();
 	smp_mb__after_clear_bit(); 
@@ -598,17 +602,21 @@ int __get_user_pages(struct task_struct 
 				 */
 				if (!map)
 					goto bad_page;
-				page_cache_get(map);
-				if (pte_pin && unlikely(TestSetPagePinned(map))) {
-					/* fail if this is a duplicate physical page in this kiovec */
-					int i2 = i;
-					while (i2--)
-						if (map == pages[i2]) {
-							put_page(map);
-							goto bad_page;
-						}
-					/* hold a reference on "map" so we can wait on it */
-					goto pte_pin_collision;
+				if (map != ZERO_PAGE(start)) {
+					if (PageReserved(map))
+						goto bad_page;
+					page_cache_get(map);
+					if (pte_pin && unlikely(TestSetPagePinned(map))) {
+						/* fail if this is a duplicate physical page in this kiovec */
+						int i2 = i;
+						while (i2--)
+							if (map == pages[i2]) {
+								put_page(map);
+								goto bad_page;
+							}
+						/* hold a reference on "map" so we can wait on it */
+						goto pte_pin_collision;
+					}
 				}
 				pages[i] = map;
 			}
