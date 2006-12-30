Return-Path: <linux-kernel-owner+w=401wt.eu-S1755150AbWL3QD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbWL3QD6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 11:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755151AbWL3QD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 11:03:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:1752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbWL3QD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 11:03:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Tn9pbUKY9mQzovWf5OWliIINRqJL4p9RNkfIJwc8MnBmd0GFIBs3scEKn6XP7ghl0CSteL9zSc8mOz+Z7pw7M+CfIlq9WUkPkkCcLG89qxTLEIzmWC62kq1kvgMwieAOTXnc/ZABGLlRg0jMuc0SW3CKk2W9SdrxaTpdUpoYz9E=
Message-ID: <6d6a94c50612300803u48928a80yafb79bd65fffdcdb@mail.gmail.com>
Date: Sun, 31 Dec 2006 00:03:54 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: [RFC][PATCH] A new memory algorithm for the embedded linux system
Cc: "Getz, Robin" <Robin.Getz@analog.com>,
       "Zhang, Sonic" <Sonic.Zhang@analog.com>,
       "Frysinger, Michael" <Michael.Frysinger@analog.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_99129_12591454.1167494634958"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_99129_12591454.1167494634958
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

We know the buddy algorithm is very good at performance and deal with
the external fragmentation about linux memory management. But IMHO
it's not a best algorithm for the embedded linux system, especially on
NOMMU arches.

Here I wrote a memory algorithm and I really hope it's a starting
point to spawn a new memory algorithm for the embedded linux system.

My thoughts is based on the current SLOB algorithm in the linux kernel
and the new one is a replacement of buddy system and can work with
both SLAB and SLOB well.

Now it's a patch against 2.6.16 and most of modification is in
mm/page_alloc.c. But It's easily ported to the newest kernel and I can
create a new option in the kernel to enable it.

I'll try my best to change as least as the current code in mm/page_alloc.c
The basic implementation is as follows:

1) maintain a (struct list_head) list in the zone, every piece of free
pages is added to the list in sequence by the place of the pages in
the memory.

2) when free pages, __free_one_page() function try to merge it as long
as the near pages on the list is contiguous with it, no matter if the
size of them is different or not. If it can't be merged, it will be
placed to the list alone.

3) When allocate pages, __rmqueue() function search the zone list and
find a exact fit page block or the first available one.

4) buddyinfo is kept to show the fragmentation of the system.

The patch is below and the attachment as well.

I really appreciate any comments, suggestions, bug-fixes, and improvement.

Thanks,
-Aubrey
-------------------------------------------------------------------------------------------------------
--- /home/aubrey/cvs/kernel/branch/uClinux-dist/linux-2.6.x/mm/page_alloc.c	2006-12-19
16:18:46.000000000 +0800
+++ mm/page_alloc.c	2006-12-30 23:03:56.000000000 +0800
@@ -323,37 +323,57 @@ static inline void __free_one_page(struc
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	struct list_head *p_cake_list;
+	struct page *cur_page = NULL, *prev_page;
+	unsigned long new_size;

 	if (unlikely(PageCompound(page)))
 		destroy_compound_page(page, order);

 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);

-	BUG_ON(page_idx & (order_size - 1));
+//	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));

 	zone->free_pages += order_size;
-	while (order < MAX_ORDER-1) {
-		unsigned long combined_idx;
-		struct free_area *area;
-		struct page *buddy;
-
-		buddy = __page_find_buddy(page, page_idx, order);
-		if (!page_is_buddy(page, buddy, order))
-			break;		/* Move the buddy up one level. */
-
-		list_del(&buddy->lru);
-		area = zone->free_area + order;
-		area->nr_free--;
-		rmv_page_order(buddy);
-		combined_idx = __find_combined_index(page_idx, order);
-		page = page + (combined_idx - page_idx);
-		page_idx = combined_idx;
-		order++;
-	}
-	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	
+	list_for_each(p_cake_list, &zone->cake_list) {
+		cur_page = list_entry(p_cake_list, struct page, cake_piece);
+		if (cur_page > page)
+			break;
+	}
+	prev_page = list_entry(p_cake_list->prev, struct page, cake_piece);
+
+	/*
+	 * case 1: best case, the inserted page is exactly conjoint
+         *	   with prev_page and cur_page
+	 */
+	if ((prev_page + prev_page->private == page) &&
+		(page + order_size == cur_page)) {
+		new_size = prev_page->private + order_size + cur_page->private;
+		set_page_order(prev_page, new_size);
+		list_del(p_cake_list);
+	/*
+	 * case 2: the inserted page will be conjoint with prev_page
+	 */
+	} else if (prev_page + prev_page->private == page) {
+		new_size = prev_page->private + order_size;
+		set_page_order(prev_page, new_size);
+	/*
+	 * case 3: the inserted page will be conjoint with cur_page
+	 */
+	} else if (page + order_size == cur_page) {
+		new_size = order_size + cur_page->private;
+		set_page_order(page, new_size);
+		list_add_tail(&page->cake_piece, p_cake_list);
+		list_del(p_cake_list);
+	/*
+	 * case 4: worst case, the inserted page is alone.
+	 */
+	} else {
+		set_page_order(page, order_size);
+		list_add_tail(&page->cake_piece, p_cake_list);
+	}
 }

 static inline int free_pages_check(struct page *page)
@@ -555,25 +575,62 @@ static int prep_new_page(struct page *pa
  */
 static struct page *__rmqueue(struct zone *zone, unsigned int order)
 {
-	struct free_area * area;
-	unsigned int current_order;
-	struct page *page;
+	struct page *page, *new_page = NULL;
+	struct list_head *p_cake_list, *first = NULL;
+	unsigned int order_size = 1 << order;
+	int i, flag = 1;
+	/*
+	 * Find the exact fit block or the first available block
+	 */	
+	list_for_each(p_cake_list, &zone->cake_list) {
+		page = list_entry(p_cake_list, struct page, cake_piece);
+		if (page->private == order_size) {
+			list_del(p_cake_list);
+			goto got_page;
+		}
+		if (flag && page->private > order_size) {
+			new_page = page;
+			first = p_cake_list;
+			flag = 0;
+		}
+	}

-	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
-			continue;
+	if (!new_page) {/* no block */
+		printk("CAKE DEBUG:NO block available\n");
+		return NULL;
+	} else {
+		page = new_page;
+		p_cake_list = first;
+	}
+	
+	/*
+ 	 * blah blah blah, but page should be 2-page aligned,
+ 	 * because task stack should be on the 8K boundary
+	 */
+	if (order_size > 1) {
+		new_page = page + order_size;
+		set_page_order(new_page, page->private - order_size);
+		list_add(&new_page->cake_piece, p_cake_list);
+		list_del(p_cake_list);
+	} else if (page->private == 2) {
+		set_page_order(page, 1);
+		page ++;
+	} else {
+		new_page = page + 2;
+		set_page_order(new_page, page->private - 2);
+		list_add(&new_page->cake_piece, p_cake_list);
+		set_page_order(page, 1);
+		page ++;
+	}

-		page = list_entry(area->free_list.next, struct page, lru);
-		list_del(&page->lru);
-		rmv_page_order(page);
-		area->nr_free--;
-		zone->free_pages -= 1UL << order;
-		expand(zone, page, order, current_order, area);
-		return page;
+got_page:
+	for(i=0;i< order_size;i++){
+		rmv_page_order(page+i);
+		set_page_count(page, 0);
 	}

-	return NULL;
+	zone->free_pages -= 1UL << order;
+	return page;
 }

 /*
@@ -1777,6 +1834,7 @@ void __meminit memmap_init_zone(unsigned
 		reset_page_mapcount(page);
 		SetPageReserved(page);
 		INIT_LIST_HEAD(&page->lru);
+		INIT_LIST_HEAD(&page->cake_piece);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
 		if (!is_highmem_idx(zone))
@@ -1793,6 +1851,7 @@ void zone_init_free_lists(struct pglist_
 		INIT_LIST_HEAD(&zone->free_area[order].free_list);
 		zone->free_area[order].nr_free = 0;
 	}
+	INIT_LIST_HEAD(&zone->cake_list);
 }

 #define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
@@ -2190,18 +2249,25 @@ static int frag_show(struct seq_file *m,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	int order;
+	int num = 1;
+	struct list_head *p_cake_list;
+      	struct page *page;

 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!populated_zone(zone))
 			continue;

 		spin_lock_irqsave(&zone->lock, flags);
-		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order)
-			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+		seq_printf(m, "--------Node %d, zone %s--------\n",
+				pgdat->node_id, zone->name);
+		__list_for_each(p_cake_list, &zone->cake_list){
+			page = list_entry(p_cake_list, struct page, cake_piece);
+			seq_printf(m, "No.%-4d Page addr: 0x%-8x num: %-5d buddy addr:0x%-8x\n",
+				num++, (int)page_to_virt(page), (int)page->private,
+					(int)page_to_virt(page + page->private));
+		}
+		seq_printf(m, "-------------End----------------\n");
 		spin_unlock_irqrestore(&zone->lock, flags);
-		seq_putc(m, '\n');
 	}
 	return 0;
 }
--- /home/aubrey/cvs/kernel/branch/uClinux-dist/linux-2.6.x/include/linux/mm.h	2006-06-06
11:32:09.000000000 +0800
+++ include/linux/mm.h	2006-12-29 01:59:16.000000000 +0800
@@ -250,6 +250,7 @@ struct page {
 	struct list_head lru;		/* Pageout list, eg. active_list
 					 * protected by zone->lru_lock !
 					 */
+	struct list_head cake_piece;
 	/*
 	 * On machines where all RAM is mapped into kernel address space,
 	 * we can simply calculate the virtual address. On machines with
--- /home/aubrey/cvs/kernel/branch/uClinux-dist/linux-2.6.x/include/linux/mmzone.h	2006-12-30
23:02:02.000000000 +0800
+++ include/linux/mmzone.h	2006-12-30 23:02:54.000000000 +0800
@@ -145,6 +145,7 @@ struct zone {
 	seqlock_t		span_seqlock;
 #endif
 	struct free_area	free_area[MAX_ORDER];
+	struct list_head	cake_list;

 	ZONE_PADDING(_pad1_)
---------------------------------------------------------------------------------------------------------------------------------

------=_Part_99129_12591454.1167494634958
Content-Type: application/octet-stream; name=cake.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ewc83vkr
Content-Disposition: attachment; filename="cake.diff"

LS0tIC9ob21lL2F1YnJleS9jdnMva2VybmVsL2JyYW5jaC91Q2xpbnV4LWRpc3QvbGludXgtMi42
LngvbW0vcGFnZV9hbGxvYy5jCTIwMDYtMTItMTkgMTY6MTg6NDYuMDAwMDAwMDAwICswODAwCisr
KyBtbS9wYWdlX2FsbG9jLmMJMjAwNi0xMi0zMCAyMzowMzo1Ni4wMDAwMDAwMDAgKzA4MDAKQEAg
LTMyMywzNyArMzIzLDU3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2ZyZWVfb25lX3BhZ2Uoc3Ry
dWMKIHsKIAl1bnNpZ25lZCBsb25nIHBhZ2VfaWR4OwogCWludCBvcmRlcl9zaXplID0gMSA8PCBv
cmRlcjsKKwlzdHJ1Y3QgbGlzdF9oZWFkICpwX2Nha2VfbGlzdDsKKwlzdHJ1Y3QgcGFnZSAqY3Vy
X3BhZ2UgPSBOVUxMLCAqcHJldl9wYWdlOworCXVuc2lnbmVkIGxvbmcgbmV3X3NpemU7CiAKIAlp
ZiAodW5saWtlbHkoUGFnZUNvbXBvdW5kKHBhZ2UpKSkKIAkJZGVzdHJveV9jb21wb3VuZF9wYWdl
KHBhZ2UsIG9yZGVyKTsKIAogCXBhZ2VfaWR4ID0gcGFnZV90b19wZm4ocGFnZSkgJiAoKDEgPDwg
TUFYX09SREVSKSAtIDEpOwogCi0JQlVHX09OKHBhZ2VfaWR4ICYgKG9yZGVyX3NpemUgLSAxKSk7
CisvLwlCVUdfT04ocGFnZV9pZHggJiAob3JkZXJfc2l6ZSAtIDEpKTsKIAlCVUdfT04oYmFkX3Jh
bmdlKHpvbmUsIHBhZ2UpKTsKIAogCXpvbmUtPmZyZWVfcGFnZXMgKz0gb3JkZXJfc2l6ZTsKLQl3
aGlsZSAob3JkZXIgPCBNQVhfT1JERVItMSkgewotCQl1bnNpZ25lZCBsb25nIGNvbWJpbmVkX2lk
eDsKLQkJc3RydWN0IGZyZWVfYXJlYSAqYXJlYTsKLQkJc3RydWN0IHBhZ2UgKmJ1ZGR5OwotCi0J
CWJ1ZGR5ID0gX19wYWdlX2ZpbmRfYnVkZHkocGFnZSwgcGFnZV9pZHgsIG9yZGVyKTsKLQkJaWYg
KCFwYWdlX2lzX2J1ZGR5KHBhZ2UsIGJ1ZGR5LCBvcmRlcikpCi0JCQlicmVhazsJCS8qIE1vdmUg
dGhlIGJ1ZGR5IHVwIG9uZSBsZXZlbC4gKi8KLQotCQlsaXN0X2RlbCgmYnVkZHktPmxydSk7Ci0J
CWFyZWEgPSB6b25lLT5mcmVlX2FyZWEgKyBvcmRlcjsKLQkJYXJlYS0+bnJfZnJlZS0tOwotCQly
bXZfcGFnZV9vcmRlcihidWRkeSk7Ci0JCWNvbWJpbmVkX2lkeCA9IF9fZmluZF9jb21iaW5lZF9p
bmRleChwYWdlX2lkeCwgb3JkZXIpOwotCQlwYWdlID0gcGFnZSArIChjb21iaW5lZF9pZHggLSBw
YWdlX2lkeCk7Ci0JCXBhZ2VfaWR4ID0gY29tYmluZWRfaWR4OwotCQlvcmRlcisrOwotCX0KLQlz
ZXRfcGFnZV9vcmRlcihwYWdlLCBvcmRlcik7Ci0JbGlzdF9hZGQoJnBhZ2UtPmxydSwgJnpvbmUt
PmZyZWVfYXJlYVtvcmRlcl0uZnJlZV9saXN0KTsKLQl6b25lLT5mcmVlX2FyZWFbb3JkZXJdLm5y
X2ZyZWUrKzsKKwkKKwlsaXN0X2Zvcl9lYWNoKHBfY2FrZV9saXN0LCAmem9uZS0+Y2FrZV9saXN0
KSB7CisJCWN1cl9wYWdlID0gbGlzdF9lbnRyeShwX2Nha2VfbGlzdCwgc3RydWN0IHBhZ2UsIGNh
a2VfcGllY2UpOworCQlpZiAoY3VyX3BhZ2UgPiBwYWdlKQorCQkJYnJlYWs7CisJfSAKKwlwcmV2
X3BhZ2UgPSBsaXN0X2VudHJ5KHBfY2FrZV9saXN0LT5wcmV2LCBzdHJ1Y3QgcGFnZSwgY2FrZV9w
aWVjZSk7CisKKwkvKgorCSAqIGNhc2UgMTogYmVzdCBjYXNlLCB0aGUgaW5zZXJ0ZWQgcGFnZSBp
cyBleGFjdGx5IGNvbmpvaW50IAorICAgICAgICAgKgkgICB3aXRoIHByZXZfcGFnZSBhbmQgY3Vy
X3BhZ2UKKwkgKi8KKwlpZiAoKHByZXZfcGFnZSArIHByZXZfcGFnZS0+cHJpdmF0ZSA9PSBwYWdl
KSAmJiAKKwkJKHBhZ2UgKyBvcmRlcl9zaXplID09IGN1cl9wYWdlKSkgeworCQluZXdfc2l6ZSA9
IHByZXZfcGFnZS0+cHJpdmF0ZSArIG9yZGVyX3NpemUgKyBjdXJfcGFnZS0+cHJpdmF0ZTsKKwkJ
c2V0X3BhZ2Vfb3JkZXIocHJldl9wYWdlLCBuZXdfc2l6ZSk7CisJCWxpc3RfZGVsKHBfY2FrZV9s
aXN0KTsKKwkvKgorCSAqIGNhc2UgMjogdGhlIGluc2VydGVkIHBhZ2Ugd2lsbCBiZSBjb25qb2lu
dCB3aXRoIHByZXZfcGFnZQorCSAqLworCX0gZWxzZSBpZiAocHJldl9wYWdlICsgcHJldl9wYWdl
LT5wcml2YXRlID09IHBhZ2UpIHsKKwkJbmV3X3NpemUgPSBwcmV2X3BhZ2UtPnByaXZhdGUgKyBv
cmRlcl9zaXplOworCQlzZXRfcGFnZV9vcmRlcihwcmV2X3BhZ2UsIG5ld19zaXplKTsKKwkvKiAK
KwkgKiBjYXNlIDM6IHRoZSBpbnNlcnRlZCBwYWdlIHdpbGwgYmUgY29uam9pbnQgd2l0aCBjdXJf
cGFnZQorCSAqLworCX0gZWxzZSBpZiAocGFnZSArIG9yZGVyX3NpemUgPT0gY3VyX3BhZ2UpIHsK
KwkJbmV3X3NpemUgPSBvcmRlcl9zaXplICsgY3VyX3BhZ2UtPnByaXZhdGU7CisJCXNldF9wYWdl
X29yZGVyKHBhZ2UsIG5ld19zaXplKTsKKwkJbGlzdF9hZGRfdGFpbCgmcGFnZS0+Y2FrZV9waWVj
ZSwgcF9jYWtlX2xpc3QpOworCQlsaXN0X2RlbChwX2Nha2VfbGlzdCk7CisJLyoKKwkgKiBjYXNl
IDQ6IHdvcnN0IGNhc2UsIHRoZSBpbnNlcnRlZCBwYWdlIGlzIGFsb25lLgorCSAqLworCX0gZWxz
ZSB7CisJCXNldF9wYWdlX29yZGVyKHBhZ2UsIG9yZGVyX3NpemUpOworCQlsaXN0X2FkZF90YWls
KCZwYWdlLT5jYWtlX3BpZWNlLCBwX2Nha2VfbGlzdCk7CisJfQogfQogCiBzdGF0aWMgaW5saW5l
IGludCBmcmVlX3BhZ2VzX2NoZWNrKHN0cnVjdCBwYWdlICpwYWdlKQpAQCAtNTU1LDI1ICs1NzUs
NjIgQEAgc3RhdGljIGludCBwcmVwX25ld19wYWdlKHN0cnVjdCBwYWdlICpwYQogICovCiBzdGF0
aWMgc3RydWN0IHBhZ2UgKl9fcm1xdWV1ZShzdHJ1Y3Qgem9uZSAqem9uZSwgdW5zaWduZWQgaW50
IG9yZGVyKQogewotCXN0cnVjdCBmcmVlX2FyZWEgKiBhcmVhOwotCXVuc2lnbmVkIGludCBjdXJy
ZW50X29yZGVyOwotCXN0cnVjdCBwYWdlICpwYWdlOworCXN0cnVjdCBwYWdlICpwYWdlLCAqbmV3
X3BhZ2UgPSBOVUxMOworCXN0cnVjdCBsaXN0X2hlYWQgKnBfY2FrZV9saXN0LCAqZmlyc3QgPSBO
VUxMOworCXVuc2lnbmVkIGludCBvcmRlcl9zaXplID0gMSA8PCBvcmRlcjsKKwlpbnQgaSwgZmxh
ZyA9IDE7CisJLyoKKwkgKiBGaW5kIHRoZSBleGFjdCBmaXQgYmxvY2sgb3IgdGhlIGZpcnN0IGF2
YWlsYWJsZSBibG9jaworCSAqLwkKKwlsaXN0X2Zvcl9lYWNoKHBfY2FrZV9saXN0LCAmem9uZS0+
Y2FrZV9saXN0KSB7CisJCXBhZ2UgPSBsaXN0X2VudHJ5KHBfY2FrZV9saXN0LCBzdHJ1Y3QgcGFn
ZSwgY2FrZV9waWVjZSk7CisJCWlmIChwYWdlLT5wcml2YXRlID09IG9yZGVyX3NpemUpIHsKKwkJ
CWxpc3RfZGVsKHBfY2FrZV9saXN0KTsKKwkJCWdvdG8gZ290X3BhZ2U7CisJCX0KKwkJaWYgKGZs
YWcgJiYgcGFnZS0+cHJpdmF0ZSA+IG9yZGVyX3NpemUpIHsKKwkJCW5ld19wYWdlID0gcGFnZTsK
KwkJCWZpcnN0ID0gcF9jYWtlX2xpc3Q7CisJCQlmbGFnID0gMDsKKwkJfQorCX0KIAotCWZvciAo
Y3VycmVudF9vcmRlciA9IG9yZGVyOyBjdXJyZW50X29yZGVyIDwgTUFYX09SREVSOyArK2N1cnJl
bnRfb3JkZXIpIHsKLQkJYXJlYSA9IHpvbmUtPmZyZWVfYXJlYSArIGN1cnJlbnRfb3JkZXI7Ci0J
CWlmIChsaXN0X2VtcHR5KCZhcmVhLT5mcmVlX2xpc3QpKQotCQkJY29udGludWU7CisJaWYgKCFu
ZXdfcGFnZSkgey8qIG5vIGJsb2NrICovCisJCXByaW50aygiQ0FLRSBERUJVRzpOTyBibG9jayBh
dmFpbGFibGVcbiIpOworCQlyZXR1cm4gTlVMTDsKKwl9IGVsc2UgeworCQlwYWdlID0gbmV3X3Bh
Z2U7CisJCXBfY2FrZV9saXN0ID0gZmlyc3Q7CisJfQorCQorCS8qIAorIAkgKiBibGFoIGJsYWgg
YmxhaCwgYnV0IHBhZ2Ugc2hvdWxkIGJlIDItcGFnZSBhbGlnbmVkLAorIAkgKiBiZWNhdXNlIHRh
c2sgc3RhY2sgc2hvdWxkIGJlIG9uIHRoZSA4SyBib3VuZGFyeSAKKwkgKi8KKwlpZiAob3JkZXJf
c2l6ZSA+IDEpIHsKKwkJbmV3X3BhZ2UgPSBwYWdlICsgb3JkZXJfc2l6ZTsKKwkJc2V0X3BhZ2Vf
b3JkZXIobmV3X3BhZ2UsIHBhZ2UtPnByaXZhdGUgLSBvcmRlcl9zaXplKTsKKwkJbGlzdF9hZGQo
Jm5ld19wYWdlLT5jYWtlX3BpZWNlLCBwX2Nha2VfbGlzdCk7CisJCWxpc3RfZGVsKHBfY2FrZV9s
aXN0KTsKKwl9IGVsc2UgaWYgKHBhZ2UtPnByaXZhdGUgPT0gMikgeworCQlzZXRfcGFnZV9vcmRl
cihwYWdlLCAxKTsKKwkJcGFnZSArKzsKKwl9IGVsc2UgeworCQluZXdfcGFnZSA9IHBhZ2UgKyAy
OworCQlzZXRfcGFnZV9vcmRlcihuZXdfcGFnZSwgcGFnZS0+cHJpdmF0ZSAtIDIpOworCQlsaXN0
X2FkZCgmbmV3X3BhZ2UtPmNha2VfcGllY2UsIHBfY2FrZV9saXN0KTsKKwkJc2V0X3BhZ2Vfb3Jk
ZXIocGFnZSwgMSk7CisJCXBhZ2UgKys7CisJfQogCi0JCXBhZ2UgPSBsaXN0X2VudHJ5KGFyZWEt
PmZyZWVfbGlzdC5uZXh0LCBzdHJ1Y3QgcGFnZSwgbHJ1KTsKLQkJbGlzdF9kZWwoJnBhZ2UtPmxy
dSk7Ci0JCXJtdl9wYWdlX29yZGVyKHBhZ2UpOwotCQlhcmVhLT5ucl9mcmVlLS07Ci0JCXpvbmUt
PmZyZWVfcGFnZXMgLT0gMVVMIDw8IG9yZGVyOwotCQlleHBhbmQoem9uZSwgcGFnZSwgb3JkZXIs
IGN1cnJlbnRfb3JkZXIsIGFyZWEpOwotCQlyZXR1cm4gcGFnZTsKK2dvdF9wYWdlOgorCWZvcihp
PTA7aTwgb3JkZXJfc2l6ZTtpKyspeworCQlybXZfcGFnZV9vcmRlcihwYWdlK2kpOworCQlzZXRf
cGFnZV9jb3VudChwYWdlLCAwKTsKIAl9CiAKLQlyZXR1cm4gTlVMTDsKKwl6b25lLT5mcmVlX3Bh
Z2VzIC09IDFVTCA8PCBvcmRlcjsKKwlyZXR1cm4gcGFnZTsKIH0KIAogLyogCkBAIC0xNzc3LDYg
KzE4MzQsNyBAQCB2b2lkIF9fbWVtaW5pdCBtZW1tYXBfaW5pdF96b25lKHVuc2lnbmVkCiAJCXJl
c2V0X3BhZ2VfbWFwY291bnQocGFnZSk7CiAJCVNldFBhZ2VSZXNlcnZlZChwYWdlKTsKIAkJSU5J
VF9MSVNUX0hFQUQoJnBhZ2UtPmxydSk7CisJCUlOSVRfTElTVF9IRUFEKCZwYWdlLT5jYWtlX3Bp
ZWNlKTsKICNpZmRlZiBXQU5UX1BBR0VfVklSVFVBTAogCQkvKiBUaGUgc2hpZnQgd29uJ3Qgb3Zl
cmZsb3cgYmVjYXVzZSBaT05FX05PUk1BTCBpcyBiZWxvdyA0Ry4gKi8KIAkJaWYgKCFpc19oaWdo
bWVtX2lkeCh6b25lKSkKQEAgLTE3OTMsNiArMTg1MSw3IEBAIHZvaWQgem9uZV9pbml0X2ZyZWVf
bGlzdHMoc3RydWN0IHBnbGlzdF8KIAkJSU5JVF9MSVNUX0hFQUQoJnpvbmUtPmZyZWVfYXJlYVtv
cmRlcl0uZnJlZV9saXN0KTsKIAkJem9uZS0+ZnJlZV9hcmVhW29yZGVyXS5ucl9mcmVlID0gMDsK
IAl9CisJSU5JVF9MSVNUX0hFQUQoJnpvbmUtPmNha2VfbGlzdCk7CiB9CiAKICNkZWZpbmUgWk9O
RVRBQkxFX0lOREVYKHgsIHpvbmVfbnIpCSgoeCA8PCBaT05FU19TSElGVCkgfCB6b25lX25yKQpA
QCAtMjE5MCwxOCArMjI0OSwyNSBAQCBzdGF0aWMgaW50IGZyYWdfc2hvdyhzdHJ1Y3Qgc2VxX2Zp
bGUgKm0sCiAJc3RydWN0IHpvbmUgKnpvbmU7CiAJc3RydWN0IHpvbmUgKm5vZGVfem9uZXMgPSBw
Z2RhdC0+bm9kZV96b25lczsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwotCWludCBvcmRlcjsKKwlp
bnQgbnVtID0gMTsKKwlzdHJ1Y3QgbGlzdF9oZWFkICpwX2Nha2VfbGlzdDsKKyAgICAgIAlzdHJ1
Y3QgcGFnZSAqcGFnZTsKIAogCWZvciAoem9uZSA9IG5vZGVfem9uZXM7IHpvbmUgLSBub2RlX3pv
bmVzIDwgTUFYX05SX1pPTkVTOyArK3pvbmUpIHsKIAkJaWYgKCFwb3B1bGF0ZWRfem9uZSh6b25l
KSkKIAkJCWNvbnRpbnVlOwogCiAJCXNwaW5fbG9ja19pcnFzYXZlKCZ6b25lLT5sb2NrLCBmbGFn
cyk7Ci0JCXNlcV9wcmludGYobSwgIk5vZGUgJWQsIHpvbmUgJThzICIsIHBnZGF0LT5ub2RlX2lk
LCB6b25lLT5uYW1lKTsKLQkJZm9yIChvcmRlciA9IDA7IG9yZGVyIDwgTUFYX09SREVSOyArK29y
ZGVyKQotCQkJc2VxX3ByaW50ZihtLCAiJTZsdSAiLCB6b25lLT5mcmVlX2FyZWFbb3JkZXJdLm5y
X2ZyZWUpOworCQlzZXFfcHJpbnRmKG0sICItLS0tLS0tLU5vZGUgJWQsIHpvbmUgJXMtLS0tLS0t
LVxuIiwgCisJCQkJcGdkYXQtPm5vZGVfaWQsIHpvbmUtPm5hbWUpOworCQlfX2xpc3RfZm9yX2Vh
Y2gocF9jYWtlX2xpc3QsICZ6b25lLT5jYWtlX2xpc3QpeworCQkJcGFnZSA9IGxpc3RfZW50cnko
cF9jYWtlX2xpc3QsIHN0cnVjdCBwYWdlLCBjYWtlX3BpZWNlKTsKKwkJCXNlcV9wcmludGYobSwg
Ik5vLiUtNGQgUGFnZSBhZGRyOiAweCUtOHggbnVtOiAlLTVkIGJ1ZGR5IGFkZHI6MHglLTh4XG4i
LCAKKwkJCQludW0rKywgKGludClwYWdlX3RvX3ZpcnQocGFnZSksIChpbnQpcGFnZS0+cHJpdmF0
ZSwgCisJCQkJCShpbnQpcGFnZV90b192aXJ0KHBhZ2UgKyBwYWdlLT5wcml2YXRlKSk7CisJCX0K
KwkJc2VxX3ByaW50ZihtLCAiLS0tLS0tLS0tLS0tLUVuZC0tLS0tLS0tLS0tLS0tLS1cbiIpOwog
CQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ6b25lLT5sb2NrLCBmbGFncyk7Ci0JCXNlcV9wdXRj
KG0sICdcbicpOwogCX0KIAlyZXR1cm4gMDsKIH0KLS0tIC9ob21lL2F1YnJleS9jdnMva2VybmVs
L2JyYW5jaC91Q2xpbnV4LWRpc3QvbGludXgtMi42LngvaW5jbHVkZS9saW51eC9tbS5oCTIwMDYt
MDYtMDYgMTE6MzI6MDkuMDAwMDAwMDAwICswODAwCisrKyBpbmNsdWRlL2xpbnV4L21tLmgJMjAw
Ni0xMi0yOSAwMTo1OToxNi4wMDAwMDAwMDAgKzA4MDAKQEAgLTI1MCw2ICsyNTAsNyBAQCBzdHJ1
Y3QgcGFnZSB7CiAJc3RydWN0IGxpc3RfaGVhZCBscnU7CQkvKiBQYWdlb3V0IGxpc3QsIGVnLiBh
Y3RpdmVfbGlzdAogCQkJCQkgKiBwcm90ZWN0ZWQgYnkgem9uZS0+bHJ1X2xvY2sgIQogCQkJCQkg
Ki8KKwlzdHJ1Y3QgbGlzdF9oZWFkIGNha2VfcGllY2U7CiAJLyoKIAkgKiBPbiBtYWNoaW5lcyB3
aGVyZSBhbGwgUkFNIGlzIG1hcHBlZCBpbnRvIGtlcm5lbCBhZGRyZXNzIHNwYWNlLAogCSAqIHdl
IGNhbiBzaW1wbHkgY2FsY3VsYXRlIHRoZSB2aXJ0dWFsIGFkZHJlc3MuIE9uIG1hY2hpbmVzIHdp
dGgKLS0tIC9ob21lL2F1YnJleS9jdnMva2VybmVsL2JyYW5jaC91Q2xpbnV4LWRpc3QvbGludXgt
Mi42LngvaW5jbHVkZS9saW51eC9tbXpvbmUuaAkyMDA2LTEyLTMwIDIzOjAyOjAyLjAwMDAwMDAw
MCArMDgwMAorKysgaW5jbHVkZS9saW51eC9tbXpvbmUuaAkyMDA2LTEyLTMwIDIzOjAyOjU0LjAw
MDAwMDAwMCArMDgwMApAQCAtMTQ1LDYgKzE0NSw3IEBAIHN0cnVjdCB6b25lIHsKIAlzZXFsb2Nr
X3QJCXNwYW5fc2VxbG9jazsKICNlbmRpZgogCXN0cnVjdCBmcmVlX2FyZWEJZnJlZV9hcmVhW01B
WF9PUkRFUl07CisJc3RydWN0IGxpc3RfaGVhZAljYWtlX2xpc3Q7CiAKIAlaT05FX1BBRERJTkco
X3BhZDFfKQogCg==
------=_Part_99129_12591454.1167494634958--
