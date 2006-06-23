Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWFWOrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFWOrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWFWOrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:47:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:59712 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWFWOrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:47:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=nZQN/LYgGsum6qJogj+0KvWtk5QNQtKcAEwyHsdWpnqRbJrB28cy+/RWotDyWOwXMlidWgzlzN5/x0ELfqU7wfcTMeuhYBLtDgFUUBhPYdMx171o4w8owKRpdkq9JwLzZDchtx1GsDoV8aqgJaaUvmhJFq5gKjI/hPMm4TjtYrI=
Message-ID: <449C001F.6030107@innova-card.com>
Date: Fri, 23 Jun 2006 16:52:15 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@skynet.ie>
CC: Franck Bui-Huu <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com> <20060623134634.GA6071@skynet.ie>
In-Reply-To: <20060623134634.GA6071@skynet.ie>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On (23/06/06 14:22), Franck Bui-Huu didst pronounce:
>> Mel Gorman wrote:
>>> On (22/06/06 19:25), Franck Bui-Huu didst pronounce:
>>>>> I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary
>>>>> with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied.
>>>> yes it seems so. But ARCH_PFN_OFFSET has been used before your patch
>>>> has been sent. So your patch seems to be incomplete...
>>> Difficult to argue with that logic.
>>>
>> sorry, I was just meaning that ARCH_PFN_OFFSET had been introduced to
>> solve this before your patch has been sent. So the requirement for
>> memory to start at pfn 0 is already solved.
>>
> 
> In that case, the patch is as simple as you suggested earlier (patch
> below). The only downside is that we hold onto ARCH_PFN_OFFSET which is a
> bit of an obscure #define if you ask me. The obscurity can be lived with of
> course, but it'd be nice to kick away ARCH_PFN_OFFSET if possible.
> 

yes with the patch below it seems useless. But it's also a good way
for all arch to use the same name for defining the start of the
memory.

>> IMHO the question is now, which method is the best one ?
> 
> My method should very slightly reduce the size of the kernel and have a
> very minor performance improvement. How measurable it is depends on how
> often page_to_pfn and pfn_to_page are called.
> 
>> the we probably need to get ride of the previous method and add yours
>> (but don't forget to modify arch such ARM which are currently using
>> ARCH_PFN_OFFSET).
>>
> 
> If we decide to simply hold onto ARCH_PFN_OFFSET, the fix is simply;

here is the patch I'm using, which is mainly yours.

-- >8 --
[PATCH] flatmem: tiny optimisation when memory do not start at 0

The FLATMEM memory model assumes that memory is in one contigious area
based at pfn 0. Some archictectures, like ARM, use ARCH_PFN_OFFSET to
relax this requirement. This involves one more operation during
page/pfn conversions.

Instead this patch modifies the address of mem_map to make
mem_map[ARCH_PFN_OFFSET] pointing at NODE_DATA(0)->node_mem_map.
This results in a slight gain on kernel code size.

---
 include/asm-generic/memory_model.h |    6 +++---
 mm/page_alloc.c                    |   15 +++++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index 0cfb086..2faa12f 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -34,9 +34,9 @@ #else
  */
 #if defined(CONFIG_FLATMEM)
 
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
-				 ARCH_PFN_OFFSET)
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
+
 #elif defined(CONFIG_DISCONTIGMEM)
 
 #define pfn_to_page(pfn)			\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 253a450..ed6a40f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2118,15 +2118,16 @@ static void __init free_area_init_core(s
 
 static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
+	struct page *map = pgdat->node_mem_map;
+
 	/* Skip empty nodes */
 	if (!pgdat->node_spanned_pages)
 		return;
 
-#ifdef CONFIG_FLAT_NODE_MEM_MAP
 	/* ia64 gets its own node_mem_map, before this, without bootmem */
-	if (!pgdat->node_mem_map) {
+	if (!map) {
 		unsigned long size, start, end;
-		struct page *map;
 
 		/*
 		 * The zone's endpoints aren't required to be MAX_ORDER
@@ -2147,7 +2148,13 @@ #ifdef CONFIG_FLATMEM
 	 * With no DISCONTIG, the global mem_map is just set as node 0's
 	 */
 	if (pgdat == NODE_DATA(0))
-		mem_map = NODE_DATA(0)->node_mem_map;
+		/*
+		 * mem_map is assumed to be based at pfn 0 such that
+		 * 'pfn = page* - mem_map' is true. Adjust map
+		 * relative to node_mem_map to maintain this
+		 * relationship.
+		 */
+		mem_map = map - ARCH_PFN_OFFSET;
 #endif
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
-- 
1.4.0.g64e8

