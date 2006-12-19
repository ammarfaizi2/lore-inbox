Return-Path: <linux-kernel-owner+w=401wt.eu-S1754793AbWLSHDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbWLSHDN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbWLSHDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:03:13 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:21547 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754793AbWLSHDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:03:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=o5RQIBlhKRDxQfgRwQ2Biqu+KBNI6gI5YHEAOqrd3ORNZuZxY60XQaLjgof3UxiS4UxQsJduG3/bs8iqXyhzCjzVtt5PtrpdvXOS2qalPjbp5rDTtCiWs2saGDW9nC/boShGh/8sceRFM6HlLM0gZ+XgbCyEn8tTtX2cB1bos/s=  ;
X-YMail-OSG: xbhJK5kVM1mvi4hIGOqdKbk3nrXFwALXUmTcHl8o2Y.9C6S3GRtjCw22r6MqhDWSo.YqHSRanCIolPKJ4qsmNc6P5WGceM9UnY9xp9qt3ramIj.wpCueNuO7PoIcvraFp0lkFe9jD1cvFts-
Message-ID: <45878E8A.6000506@yahoo.com.au>
Date: Tue, 19 Dec 2006 18:02:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Chris Rankin <cj.rankin@ntlworld.com>
Subject: Re: -mm merge plans for 2.6.20
References: <20061204204024.2401148d.akpm@osdl.org> <20061205160250.GB9076@kernelslacker.org> <20061212174909.GD2140@redhat.com> <458776A5.3060007@yahoo.com.au> <20061219064454.GG31146@redhat.com>
In-Reply-To: <20061219064454.GG31146@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------030805050103090907020108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030805050103090907020108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Jones wrote:
> On Tue, Dec 19, 2006 at 04:20:37PM +1100, Nick Piggin wrote:
>  > Dave Jones wrote:
>  > 
>  > > Eeek! page_mapcount(page) went negative! (-2)
>  > 
>  > Hmm, probably happened once before, too.
> 
> You're right. Going back further in the log, I noticed
> that it had happened again exactly at the time that cron restarted vpnc.
> The first time, the flags were different..
> 
>  Dec  4 00:01:03 firewall kernel: Eeek! page_mapcount(page) went negative! (-1)
>  Dec  4 00:01:03 firewall kernel:   page->flags = 400
>  Dec  4 00:01:03 firewall kernel:   page->count = 1
>  Dec  4 00:01:03 firewall kernel:   page->mapping = 00000000

Still reserved, with a NULL mapping. I'd say it could be the same page.

> 
>  > >   page->flags = 404
>  > 
>  > What's that? PG_referenced|PG_reserved? So I'd say it is likely
>  > that some driver has got its refcounting wrong.
> 
> At the time that it bit me, here's what was loaded..
> 
> tun ipt_MASQUERADE iptable_nat ip_nat ipt_LOG xt_limit ipv6
> ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
> iptable_filter ip_tables x_tables video sbs i2c_ec button battery asus_acpi ac
> parport_pc lp parport pcspkr ide_cd i2c_viapro i2c_core cdrom 3c59x via_rhine
> via_ircc mii irda crc_ccitt serio_raw dm_snapshot dm_zero dm_mirror dm_mod ext3
> jbd ehci_hcd ohci_hcd uhci_hcd
> 
> The scary ones (i2c, irda) weren't in use at all, and had never been opened afaik,
> so the potential for those to be corrupting memory is slim, but not out of the
> question. (Why the hell asus_acpi is loaded is a mystery, this isn't an Asus,
> or a laptop. Probably dumb initscripts).

OK that could be useful if I do some grepping and see which ones are
setting PG_reserved.

>  > And I see we've got another report for 2.6.19.1 from Chris, which
>  > is equally vague.
> 
> I'll be moving that box to 2.6.19.x at some point real soon, so I'll holler
> if I see it again on a later kernel.
> 
>  > IMO the pattern is much too consistent to be able to attribute
>  > them all to hardware problems. And considering it takes so long
>  > for these things to appear, can we get something like the attached
>  > patch upstream at least until we manage to stamp them out?
> 
> Sounds like a good idea to me.
> 
> ACKed-by: Dave Jones <davej@redhat.com>

Thanks.

> 
>  > Any other debugging info we can add?
> 
> Would it be useful to print the pfn of the page ?
> In cases like mine, where it bit twice before it killed the box, it
> might be interesting to see if its always the same page.  Not sure
> what that would prove/disprove though.

Might help. I guess the site where it is allocated from might be
another one, although I'm hoping that if we know what ->nopage is
being used then we'll be able to track it. OTOH it may be using
remap_pfn_range from fops->mmap, rather than nopage... I wonder
how we could get at that info? vma->vm_file->f_op->mmap?

-- 
SUSE Labs, Novell Inc.

--------------030805050103090907020108
Content-Type: text/plain;
 name="mm-rmap-debug-more.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-rmap-debug-more.patch"

Index: linux-2.6/include/linux/rmap.h
===================================================================
--- linux-2.6.orig/include/linux/rmap.h	2006-12-04 19:56:17.000000000 +1100
+++ linux-2.6/include/linux/rmap.h	2006-12-19 16:14:30.000000000 +1100
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
Index: linux-2.6/mm/filemap_xip.c
===================================================================
--- linux-2.6.orig/mm/filemap_xip.c	2006-12-04 19:07:10.000000000 +1100
+++ linux-2.6/mm/filemap_xip.c	2006-12-19 16:14:30.000000000 +1100
@@ -189,7 +189,7 @@ __xip_unmap (struct address_space * mapp
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap_unlock(pte, ptl);
Index: linux-2.6/mm/fremap.c
===================================================================
--- linux-2.6.orig/mm/fremap.c	2006-12-04 19:56:20.000000000 +1100
+++ linux-2.6/mm/fremap.c	2006-12-19 16:14:30.000000000 +1100
@@ -33,7 +33,7 @@ static int zap_pte(struct mm_struct *mm,
 		if (page) {
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			page_cache_release(page);
 		}
 	} else {
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-12-04 19:56:21.000000000 +1100
+++ linux-2.6/mm/memory.c	2006-12-19 16:14:30.000000000 +1100
@@ -681,7 +681,7 @@ static unsigned long zap_pte_range(struc
 					mark_page_accessed(page);
 				file_rss--;
 			}
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1576,7 +1576,7 @@ gotten:
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
 		if (old_page) {
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma);
 			if (!PageAnon(old_page)) {
 				dec_mm_counter(mm, file_rss);
 				inc_mm_counter(mm, anon_rss);
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c	2006-12-04 19:56:21.000000000 +1100
+++ linux-2.6/mm/rmap.c	2006-12-19 18:02:18.000000000 +1100
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 #include <linux/module.h>
+#include <linux/kallsyms.h>
 
 #include <asm/tlbflush.h>
 
@@ -567,14 +568,20 @@ void page_add_file_rmap(struct page *pag
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page, struct vm_area_struct *vma)
 {
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 		if (unlikely(page_mapcount(page) < 0)) {
 			printk (KERN_EMERG "Eeek! page_mapcount(page) went negative! (%d)\n", page_mapcount(page));
+			printk (KERN_EMERG "  page pfn = %lx\n", page_to_pfn(page));
 			printk (KERN_EMERG "  page->flags = %lx\n", page->flags);
 			printk (KERN_EMERG "  page->count = %x\n", page_count(page));
 			printk (KERN_EMERG "  page->mapping = %p\n", page->mapping);
+			print_symbol (KERN_EMERG "  vma->vm_ops = %s\n", (unsigned long)vma->vm_ops);
+			if (vma->vm_ops)
+				print_symbol (KERN_EMERG "  vma->vm_ops->nopage = %s\n", (unsigned long)vma->vm_ops->nopage);
+			if (vma->vm_file && vma->vm_file->f_op)
+				print_symbol (KERN_EMERG "  vma->vm_file->f_op->mmap = %s\n", (unsigned long)vma->vm_file->f_op->mmap);
 			BUG();
 		}
 
@@ -679,7 +686,7 @@ static int try_to_unmap_one(struct page 
 		dec_mm_counter(mm, file_rss);
 
 
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma);
 	page_cache_release(page);
 
 out_unmap:
@@ -769,7 +776,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;

--------------030805050103090907020108--
Send instant messages to your online friends http://au.messenger.yahoo.com 
