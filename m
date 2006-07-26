Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWGZUkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWGZUkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWGZUkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:40:42 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:29090 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751135AbWGZUkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:40:41 -0400
Date: Wed, 26 Jul 2006 21:39:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] vm/agp: remove private page protection map
In-Reply-To: <Pine.LNX.4.64.0607181905140.26533@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0607262135440.11629@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0607181905140.26533@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Jul 2006 20:40:18.0454 (UTC) FILETIME=[B4DCAB60:01C6B0F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006, Dave Airlie wrote:
> AGP keeps its own copy of the protection_map, upcoming DRM changes
> will also require access to this map from modules.

I'm happy with the intent of your vm_get_page_prot() patch (and would
like to extend it to other places after, minimizing references to the
protection_map[]).  But there's a few aspects which distress me - the
u8 type nowhere else in mm, the requirement that caller mask the arg,
agp_convert_mmap_flags still using its own conversion from PROT_ to VM_
while there's an inline in mm.h (though why someone thought to optimize
and so obscure that version puzzles me!).  Would you be happy to insert
your Sign-off in the replacement below?


AGP keeps its own copy of the protection_map, upcoming DRM changes will
also require access to this map from modules.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 drivers/char/agp/frontend.c |   27 ++-------------------------
 include/linux/mm.h          |    1 +
 mm/mmap.c                   |    7 +++++++
 3 files changed, 10 insertions(+), 25 deletions(-)

--- 2.6.18-rc2-git6/drivers/char/agp/frontend.c	2006-07-16 00:17:07.000000000 +0100
+++ linux/drivers/char/agp/frontend.c	2006-07-26 20:32:10.000000000 +0100
@@ -151,35 +151,12 @@ static void agp_add_seg_to_client(struct
 	client->segments = seg;
 }
 
-/* Originally taken from linux/mm/mmap.c from the array
- * protection_map.
- * The original really should be exported to modules, or
- * some routine which does the conversion for you
- */
-
-static const pgprot_t my_protect_map[16] =
-{
-	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
-	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
-};
-
 static pgprot_t agp_convert_mmap_flags(int prot)
 {
-#define _trans(x,bit1,bit2) \
-((bit1==bit2)?(x&bit1):(x&bit1)?bit2:0)
-
 	unsigned long prot_bits;
-	pgprot_t temp;
-
-	prot_bits = _trans(prot, PROT_READ, VM_READ) |
-	    _trans(prot, PROT_WRITE, VM_WRITE) |
-	    _trans(prot, PROT_EXEC, VM_EXEC);
-
-	prot_bits |= VM_SHARED;
 
-	temp = my_protect_map[prot_bits & 0x0000000f];
-
-	return temp;
+	prot_bits = calc_vm_prot_bits(prot) | VM_SHARED;
+	return vm_get_page_prot(prot_bits);
 }
 
 static int agp_create_segment(struct agp_client *client, struct agp_region *region)
--- 2.6.18-rc2-git6/include/linux/mm.h	2006-07-16 00:17:31.000000000 +0100
+++ linux/include/linux/mm.h	2006-07-26 20:33:59.000000000 +0100
@@ -1012,6 +1012,7 @@ static inline unsigned long vma_pages(st
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
+pgprot_t vm_get_page_prot(unsigned long vm_flags);
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 struct page *vmalloc_to_page(void *addr);
 unsigned long vmalloc_to_pfn(void *addr);
--- 2.6.18-rc2-git6/mm/mmap.c	2006-07-16 00:17:39.000000000 +0100
+++ linux/mm/mmap.c	2006-07-26 20:40:12.000000000 +0100
@@ -60,6 +60,13 @@ pgprot_t protection_map[16] = {
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	return protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
+}
+EXPORT_SYMBOL(vm_get_page_prot);
+
 int sysctl_overcommit_memory = OVERCOMMIT_GUESS;  /* heuristic overcommit */
 int sysctl_overcommit_ratio = 50;	/* default is 50% */
 int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
