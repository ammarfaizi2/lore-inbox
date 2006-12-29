Return-Path: <linux-kernel-owner+w=401wt.eu-S1755018AbWL2Bj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbWL2Bj2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 20:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755019AbWL2Bj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 20:39:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49670 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755013AbWL2Bj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 20:39:27 -0500
Date: Thu, 28 Dec 2006 17:38:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: akpm@osdl.org, guichaz@yahoo.fr, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, mh+linux-kernel@zugschlus.de,
       nickpiggin@yahoo.com.au, andrei.popa@i-neo.ro,
       linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, hugh@veritas.com,
       fw@deneb.enyo.de, tbm@cyrius.com, arjan@infradead.org,
       kenneth.w.chen@intel.com
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <20061228.145038.71089607.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0612281730550.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281325290.4473@woody.osdl.org> <20061228.145038.71089607.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1565940707-1167356318=:4473"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1565940707-1167356318=:4473
Content-Type: TEXT/PLAIN; charset=US-ASCII


Btw, 
 much cleaned-up page tracing patch here, in case anybody cares (and 
"test.c" attached, although I don't think it changed since last time). 

The test.c output is a bit hard to read at times, since it will give 
offsets in bytes as hex (ie "00a77664" means page frame 00000a77, and byte 
664h within that page), while the kernel output is obvioiusly the page 
indexes (but the page fault _addresses_ can contain information about the 
exact byte in a page, so you can match them up when some kernel event is 
related to a page fault).

So both forms are necessary/logical, but it means that to match things up, 
you often need to ignore the last three hex digits of the address that 
"test.c" outputs.

This one also adds traces for the tags and the writeback activity, but 
since I'm going out for birthday dinner, I won't have time to try to 
actually analyse the trace I have.. Which is why I'm sending it out, in 
the hope that somebody else is working on this corruption issue and is 
interested..

		Linus

----
diff --git a/fs/buffer.c b/fs/buffer.c
index 263f88e..f5e132a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -722,6 +722,7 @@ int __set_page_dirty_buffers(struct page *page)
 			set_buffer_dirty(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
+		PAGE_TRACE(page, "dirtied buffers");
 	}
 	spin_unlock(&mapping->private_lock);
 
@@ -734,6 +735,7 @@ int __set_page_dirty_buffers(struct page *page)
 			__inc_zone_page_state(page, NR_FILE_DIRTY);
 			task_io_account_write(PAGE_CACHE_SIZE);
 		}
+		PAGE_TRACE(page, "setting TAG_DIRTY");
 		radix_tree_tag_set(&mapping->page_tree,
 				page_index(page), PAGECACHE_TAG_DIRTY);
 	}
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 350878a..0cf3dce 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -91,6 +91,14 @@
 #define PG_nosave_free		18	/* Used for system suspend/resume */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
+#define SetPageInteresting(page) set_bit(PG_arch_1, &(page)->flags)
+#define PageInteresting(page)	test_bit(PG_arch_1, &(page)->flags)
+
+#define PAGE_TRACE(page, msg, arg...) do {	 				\
+	if (PageInteresting(page))	 					\
+		printk(KERN_DEBUG "PG %08lx: %s:%d " msg "\n", 			\
+			(page)->index, __FILE__, __LINE__ ,##arg );		\
+} while (0)
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -183,32 +191,38 @@ static inline void SetPageUptodate(struct page *page)
 #define PageWriteback(page)	test_bit(PG_writeback, &(page)->flags)
 #define SetPageWriteback(page)						\
 	do {								\
-		if (!test_and_set_bit(PG_writeback,			\
-				&(page)->flags))			\
+		if (!test_and_set_bit(PG_writeback, &(page)->flags)) {	\
+			PAGE_TRACE(page, "set writeback");		\
 			inc_zone_page_state(page, NR_WRITEBACK);	\
+		}							\
 	} while (0)
 #define TestSetPageWriteback(page)					\
 	({								\
 		int ret;						\
 		ret = test_and_set_bit(PG_writeback,			\
 					&(page)->flags);		\
-		if (!ret)						\
+		if (!ret) {						\
+			PAGE_TRACE(page, "set writeback");		\
 			inc_zone_page_state(page, NR_WRITEBACK);	\
+		}							\
 		ret;							\
 	})
 #define ClearPageWriteback(page)					\
 	do {								\
-		if (test_and_clear_bit(PG_writeback,			\
-				&(page)->flags))			\
+		if (test_and_clear_bit(PG_writeback, &(page)->flags)) {	\
+			PAGE_TRACE(page, "end writeback");		\
 			dec_zone_page_state(page, NR_WRITEBACK);	\
+		}							\
 	} while (0)
 #define TestClearPageWriteback(page)					\
 	({								\
 		int ret;						\
 		ret = test_and_clear_bit(PG_writeback,			\
 				&(page)->flags);			\
-		if (ret)						\
+		if (ret) {						\
+			PAGE_TRACE(page, "end writeback");		\
 			dec_zone_page_state(page, NR_WRITEBACK);	\
+		}							\
 		ret;							\
 	})
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5c26818..7735b83 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -79,7 +79,7 @@ config DEBUG_KERNEL
 
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
-	range 12 21
+	range 12 24
 	default 17 if S390 || LOCKDEP
 	default 16 if X86_NUMAQ || IA64
 	default 15 if SMP
diff --git a/mm/filemap.c b/mm/filemap.c
index 8332c77..4df7d35 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -116,6 +116,7 @@ void __remove_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 
+	PAGE_TRACE(page, "Removing page cache");
 	radix_tree_delete(&mapping->page_tree, page->index);
 	page->mapping = NULL;
 	mapping->nrpages--;
@@ -421,6 +422,23 @@ int filemap_write_and_wait_range(struct address_space *mapping,
 	return err;
 }
 
+static noinline int is_interesting(struct address_space *mapping)
+{
+	struct inode *inode = mapping->host;
+	struct dentry *dentry;
+	int retval = 0;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(dentry, &inode->i_dentry, d_alias) {
+		if (strcmp(dentry->d_name.name, "mapfile"))
+			continue;
+		retval = 1;
+		break;
+	}
+	spin_unlock(&dcache_lock);
+	return retval;
+}
+
 /**
  * add_to_page_cache - add newly allocated pagecache pages
  * @page:	page to add
@@ -439,6 +457,9 @@ int add_to_page_cache(struct page *page, struct address_space *mapping,
 {
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
+	if (is_interesting(mapping))
+		SetPageInteresting(page);
+
 	if (error == 0) {
 		write_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
diff --git a/mm/memory.c b/mm/memory.c
index 563792f..20af32f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -667,6 +667,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
+			PAGE_TRACE(page, "unmapped at %08lx", addr);
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
 						addr) != page->index)
@@ -1605,6 +1606,7 @@ gotten:
 		 */
 		ptep_clear_flush(vma, address, page_table);
 		set_pte_at(mm, address, page_table, entry);
+		PAGE_TRACE(new_page, "write fault at %08lx", address);
 		update_mmu_cache(vma, address, entry);
 		lru_cache_add_active(new_page);
 		page_add_new_anon_rmap(new_page, vma, address);
@@ -2249,6 +2251,7 @@ retry:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		PAGE_TRACE(new_page, "mapping at %08lx (%s)", address, write_access ? "write" : "read");
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b3a198c..15f3aaf 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -773,6 +773,7 @@ int __set_page_dirty_nobuffers(struct page *page)
 				__inc_zone_page_state(page, NR_FILE_DIRTY);
 				task_io_account_write(PAGE_CACHE_SIZE);
 			}
+			PAGE_TRACE(page, "setting TAG_DIRTY");
 			radix_tree_tag_set(&mapping->page_tree,
 				page_index(page), PAGECACHE_TAG_DIRTY);
 		}
@@ -813,6 +814,7 @@ int fastcall set_page_dirty(struct page *page)
 		if (!spd)
 			spd = __set_page_dirty_buffers;
 #endif
+		PAGE_TRACE(page, "setting dirty");
 		return (*spd)(page);
 	}
 	if (!PageDirty(page)) {
@@ -867,6 +869,7 @@ int clear_page_dirty_for_io(struct page *page)
 
 	if (TestClearPageDirty(page)) {
 		if (mapping_cap_account_dirty(mapping)) {
+			PAGE_TRACE(page, "clean_for_io");
 			page_mkclean(page);
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
@@ -886,10 +889,12 @@ int test_clear_page_writeback(struct page *page)
 
 		write_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestClearPageWriteback(page);
-		if (ret)
+		if (ret) {
+			PAGE_TRACE(page, "clearing TAG_WRITEBACK");
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
+		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestClearPageWriteback(page);
@@ -907,14 +912,18 @@ int test_set_page_writeback(struct page *page)
 
 		write_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestSetPageWriteback(page);
-		if (!ret)
+		if (!ret) {
+			PAGE_TRACE(page, "setting TAG_WRITEBACK");
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-		if (!PageDirty(page))
+		}
+		if (!PageDirty(page)) {
+			PAGE_TRACE(page, "clearing TAG_DIRTY");
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
+		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestSetPageWriteback(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 57306fa..e6b4676 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -448,6 +448,7 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
 	if (pte_dirty(*pte) || pte_write(*pte)) {
 		pte_t entry;
 
+		PAGE_TRACE(page, "cleaning PTE %08lx", address);
 		flush_cache_page(vma, address, pte_pfn(*pte));
 		entry = ptep_clear_flush(vma, address, pte);
 		entry = pte_wrprotect(entry);
@@ -637,6 +638,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		goto out_unmap;
 	}
 
+	PAGE_TRACE(page, "unmapping from %08lx", address);
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
@@ -767,6 +769,7 @@ static void try_to_unmap_cluster(unsigned long cursor,
 		if (ptep_clear_flush_young(vma, address, pte))
 			continue;
 
+		PAGE_TRACE(page, "unmapping from %08lx", address);
 		/* Nuke the page table entry. */
 		flush_cache_page(vma, address, pte_pfn(*pte));
 		pteval = ptep_clear_flush(vma, address, pte);
---1463790079-1565940707-1167356318=:4473
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=test.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0612281738380.4473@woody.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=test.c

I2luY2x1ZGUgPHN5cy9tbWFuLmg+DQojaW5jbHVkZSA8c3lzL2ZjbnRsLmg+
DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQoj
aW5jbHVkZSA8c3RyaW5nLmg+DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNs
dWRlIDx0aW1lLmg+DQoNCiNkZWZpbmUgVEFSR0VUU0laRSAoMjIgPDwgMjAp
DQojZGVmaW5lIENIVU5LU0laRSAoMTQ2MCkNCiNkZWZpbmUgTlJDSFVOS1Mg
KFRBUkdFVFNJWkUgLyBDSFVOS1NJWkUpDQojZGVmaW5lIFNJWkUgKE5SQ0hV
TktTICogQ0hVTktTSVpFKQ0KDQpzdGF0aWMgdm9pZCBmaWxsbWVtKHZvaWQg
KnN0YXJ0LCBpbnQgbnIpDQp7DQoJbWVtc2V0KHN0YXJ0LCBuciwgQ0hVTktT
SVpFKTsNCn0NCg0KI2RlZmluZSBwYWdlX29mZnNldChidWYsIG9mZikgKHVu
c2lnbmVkKSgodW5zaWduZWQgbG9uZykoYnVmKSsob2ZmKS0odW5zaWduZWQg
bG9uZykobWFwcGluZykpDQoNCnN0YXRpYyBpbnQgY2h1bmtvcmRlcltOUkNI
VU5LU107DQpzdGF0aWMgY2hhciAqbWFwcGluZzsNCg0Kc3RhdGljIGludCBv
cmRlcihpbnQgbnIpDQp7DQoJaW50IGk7DQoJaWYgKG5yIDwgMCB8fCBuciA+
PSBOUkNIVU5LUykNCgkJcmV0dXJuIC0xOw0KCWZvciAoaSA9IDA7IGkgPCBO
UkNIVU5LUzsgaSsrKQ0KCQlpZiAoY2h1bmtvcmRlcltpXSA9PSBucikNCgkJ
CXJldHVybiBpOw0KCXJldHVybiAtMjsNCn0NCg0Kc3RhdGljIHZvaWQgY2hl
Y2ttZW0odm9pZCAqYnVmLCBpbnQgbnIpDQp7DQoJdW5zaWduZWQgaW50IHN0
YXJ0ID0gfjB1LCBlbmQgPSAwOw0KCXVuc2lnbmVkIGNoYXIgYyA9IG5yLCAq
cCA9IGJ1ZiwgZGlmZmVycyA9IDA7DQoJaW50IGk7DQoJZm9yIChpID0gMDsg
aSA8IENIVU5LU0laRTsgaSsrKSB7DQoJCXVuc2lnbmVkIGNoYXIgZ290ID0g
KnArKzsNCgkJaWYgKGdvdCAhPSBjKSB7DQoJCQlpZiAoaSA8IHN0YXJ0KQ0K
CQkJCXN0YXJ0ID0gaTsNCgkJCWlmIChpID4gZW5kKQ0KCQkJCWVuZCA9IGk7
DQoJCQlkaWZmZXJzID0gZ290Ow0KCQl9DQoJfQ0KCWlmIChzdGFydCA8IGVu
ZCkgew0KCQlwcmludGYoIkNodW5rICVkIGNvcnJ1cHRlZCAoJXUtJXUpICAo
JXgtJXgpICAgICAgICAgICAgXG4iLCBuciwgc3RhcnQsIGVuZCwNCgkJCXBh
Z2Vfb2Zmc2V0KGJ1Ziwgc3RhcnQpLCBwYWdlX29mZnNldChidWYsIGVuZCkp
Ow0KCQlwcmludGYoIkV4cGVjdGVkICV1LCBnb3QgJXVcbiIsIGMsIGRpZmZl
cnMpOw0KCQlwcmludGYoIldyaXR0ZW4gYXMgKCVkKSVkKCVkKVxuIiwgb3Jk
ZXIobnItMSksIG9yZGVyKG5yKSwgb3JkZXIobnIrMSkpOw0KCX0NCn0NCg0K
c3RhdGljIGNoYXIgKnJlbWFwKGludCBmZCwgY2hhciAqbWFwcGluZykNCnsN
CglpZiAobWFwcGluZykgew0KCQltdW5tYXAobWFwcGluZywgU0laRSk7DQoJ
CXBvc2l4X2ZhZHZpc2UoZmQsIDAsIFNJWkUsIFBPU0lYX0ZBRFZfRE9OVE5F
RUQpOw0KCX0NCglyZXR1cm4gbW1hcChOVUxMLCBTSVpFLCBQUk9UX1JFQUQg
fCBQUk9UX1dSSVRFLCBNQVBfU0hBUkVELCBmZCwgMCk7DQp9DQoNCmludCBt
YWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCnsNCglpbnQgZmQsIGk7DQoN
CgkvKg0KCSAqIE1ha2Ugc29tZSByYW5kb20gb3JkZXJpbmcgb2Ygd3JpdGlu
ZyB0aGUgY2h1bmtzIHRvIHRoZQ0KCSAqIG1lbW9yeSBtYXAuLg0KCSAqDQoJ
ICogU3RhcnQgd2l0aCBmdWxseSBvcmRlcmVkLi4NCgkgKi8NCglmb3IgKGkg
PSAwOyBpIDwgTlJDSFVOS1M7IGkrKykNCgkJY2h1bmtvcmRlcltpXSA9IGk7
DQoNCgkvKiAuLmFuZCB0aGVuIG1peCBpdCB1cCByYW5kb21seSAqLw0KCXNy
YW5kb20odGltZShOVUxMKSk7DQoJZm9yIChpID0gMDsgaSA8IE5SQ0hVTktT
OyBpKyspIHsNCgkJaW50IGluZGV4ID0gKHVuc2lnbmVkIGludCkgcmFuZG9t
KCkgJSBOUkNIVU5LUzsNCgkJaW50IG5yID0gY2h1bmtvcmRlcltpbmRleF07
DQoJCWNodW5rb3JkZXJbaW5kZXhdID0gY2h1bmtvcmRlcltpXTsNCgkJY2h1
bmtvcmRlcltpXSA9IG5yOw0KCX0NCg0KCWZkID0gb3BlbigibWFwZmlsZSIs
IE9fUkRXUiB8IE9fVFJVTkMgfCBPX0NSRUFULCAwNjY2KTsNCglpZiAoZmQg
PCAwKQ0KCQlyZXR1cm4gLTE7DQoJaWYgKGZ0cnVuY2F0ZShmZCwgU0laRSkg
PCAwKQ0KCQlyZXR1cm4gLTE7DQoJbWFwcGluZyA9IHJlbWFwKGZkLCBOVUxM
KTsNCglpZiAoLTEgPT0gKGludCkobG9uZyltYXBwaW5nKQ0KCQlyZXR1cm4g
LTE7DQoNCglmb3IgKGkgPSAwOyBpIDwgTlJDSFVOS1M7IGkrKykgew0KCQlp
bnQgY2h1bmsgPSBjaHVua29yZGVyW2ldOw0KCQlwcmludGYoIldyaXRpbmcg
Y2h1bmsgJWQvJWQgKCVkJSUpICglMDh4KSAgICAgXHIiLA0KCQkJY2h1bmss
IE5SQ0hVTktTLA0KCQkJMTAwKmkvTlJDSFVOS1MsDQoJCQlwYWdlX29mZnNl
dChtYXBwaW5nLCBjaHVuayAqIENIVU5LU0laRSkpOw0KCQlmaWxsbWVtKG1h
cHBpbmcgKyBjaHVuayAqIENIVU5LU0laRSwgY2h1bmspOw0KCX0NCglwcmlu
dGYoIlxuIik7DQoNCgkvKiBVbm1hcCwgZHJvcCwgYW5kIHJlbWFwLi4gKi8N
CgltYXBwaW5nID0gcmVtYXAoZmQsIG1hcHBpbmcpOw0KDQoJLyogLi4gYW5k
IGNoZWNrICovDQoJZm9yIChpID0gMDsgaSA8IE5SQ0hVTktTOyBpKyspIHsN
CgkJaW50IGNodW5rID0gaTsNCgkJcHJpbnRmKCJDaGVja2luZyBjaHVuayAl
ZC8lZCAoJWQlJSkgKCUwOHgpICAgIFxyIiwNCgkJCWksIE5SQ0hVTktTLA0K
CQkJMTAwKmkvTlJDSFVOS1MsDQoJCQlwYWdlX29mZnNldChtYXBwaW5nLCBp
ICogQ0hVTktTSVpFKSk7DQoJCWNoZWNrbWVtKG1hcHBpbmcgKyBjaHVuayAq
IENIVU5LU0laRSwgY2h1bmspOw0KCX0NCglwcmludGYoIlxuIik7DQoNCgkv
KiBDbGVhbiB1cCBmb3IgbmV4dCB0aW1lICovDQoJc2xlZXAoNSk7DQoJc3lu
YygpOw0KCXNsZWVwKDUpOw0KCW11bm1hcChtYXBwaW5nLCBTSVpFKTsNCglj
bG9zZShmZCk7DQoJdW5saW5rKCJtYXBmaWxlIik7DQoJDQoJcmV0dXJuIDA7
DQp9DQo=

---1463790079-1565940707-1167356318=:4473--
