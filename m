Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWFWPCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWFWPCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWFWPCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:02:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51300 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751164AbWFWPB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:01:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=gzLCEAq6ImnmTjSJs5U/WSrneVWQhgp9XfumHgDCxjVN/BNCpR+xopnDTYiTPSi6BrBQ/MOX4lYlP6xnHPvctWM40spr5eOjJoPePU95joW+g4g0x9db+jv+aJwv/oTJbzzH6dCNNeQJADTVlkG0UFBi8UCuM7JpBlEbbIhXUmc=
Message-ID: <449C036D.6060004@innova-card.com>
Date: Fri, 23 Jun 2006 17:06:21 +0200
Reply-To: franck.bui-huu@innova-card.com
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

what do you think about this use of ARCH_PFN_OFFSET ?

diff --git a/mm/bootmem.c b/mm/bootmem.c
index d213fed..fd28eed 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -377,11 +377,11 @@ unsigned long __init free_all_bootmem_no
 	return(free_all_bootmem_core(pgdat));
 }
 
-unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
+unsigned long __init init_bootmem(unsigned long start, unsigned long pages)
 {
 	max_low_pfn = pages;
 	min_low_pfn = start;
-	return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
+	return init_bootmem_core(NODE_DATA(0), start, ARCH_PFN_OFFSET, pages);
 }
 
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ed6a40f..43abaeb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2154,7 +2154,7 @@ #ifdef CONFIG_FLATMEM
 		 * relative to node_mem_map to maintain this
 		 * relationship.
 		 */
-		mem_map = map - ARCH_PFN_OFFSET;
+		mem_map = map - pgdat->node_start_pfn;
 #endif
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
@@ -2181,8 +2181,7 @@ #endif
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_node(0, NODE_DATA(0), zones_size,
-			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
+	free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, NULL);
 }
 
 #ifdef CONFIG_PROC_FS
