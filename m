Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWGFT4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWGFT4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWGFT4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:56:03 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:1489 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1750788AbWGFT4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:56:01 -0400
Date: Thu, 6 Jul 2006 20:55:59 +0100
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
Message-ID: <20060706195558.GA13225@skynet.ie>
References: <20060706095103.31772.49822.sendpatchset@skynet.skynet.ie> <44AD1F90.10103@innova-card.com> <Pine.LNX.4.64.0607061556470.3895@skynet.skynet.ie> <cda58cb80607061101l4698f1afr799e9814688903cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <cda58cb80607061101l4698f1afr799e9814688903cf@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006, Franck Bui-Huu wrote:

> 2006/7/6, Mel Gorman <mel@csn.ul.ie>:
>> 
>> I think my patch does the job of moving ARCH_PFN_OFFSET out of the hot
>> path in a less risky fashion. However, if you are sure that callers to
>> free_area_init() and ARCH_PFN_OFFSET are ok after your patch, I'd be happy
>> to go with it. If you're not sure, I reckon my patch would be the way to
>> go.
>> 
>
> Ok I try to explain better what I have in mind. Your patch changes the
> behaviour of free_area_init_node() in the sense that it doesn't work
> as expected if its fourth parameter is different from ARCH_PFN_OFFSET,
> it even becomes boggus IMHO. And I think it's valid to use it when
> FLATMEM model is selected.

I'm missing something silly here.

Before the patch, we have the following
  o Call free_area_initSOMETHING()
  o Set mem_map to NODE_DATA(0)->node_mem_map
  o At each call to page_to_pfn() or pfn_to_page(), offset mem_map by 
    ARCH_PFN_OFFSET

After the patch, we have

  o Call free_area_initSOMETHING()
  o Set mem_map to NODE_DATA(0)->node_mem_map - ARCH_PFN_OFFSET
  o At each call to page_to_pfn() or pfn_to_page(), use mem_map without 
    any additional offset

I don't see how free_area_init_node() changed except for callers 
using mem_map directly.

....

using mem_map directly. uh uh

Both of our patches are broken.

page_to_pfn() and pfn_to_page() both need ARCH_PFN_OFFSET to get PFNs,
that's fine. However, I forgot that another assumption of the FLATMEM memory
model is that mem_map[0] is the first valid struct page in the system. A
number of architectures walk mem_map[] directly (cris and frv are examples)
without offsetting based on this assumption.

This means that any patch that moves mem_map without altering every direct
user of the mem_map[] array will break further down the line. If nothing else,
this shows that ARCH_PFN_OFFSET could have done with a comment :) .

> <rest of mail snipped>


diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/include/asm-generic/memory_model.h linux-2.6.17-mm6-documentarchpfn/include/asm-generic/memory_model.h
--- linux-2.6.17-mm6-clean/include/asm-generic/memory_model.h	2006-07-05 14:31:17.000000000 +0100
+++ linux-2.6.17-mm6-documentarchpfn/include/asm-generic/memory_model.h	2006-07-06 20:48:46.000000000 +0100
@@ -6,6 +6,16 @@
 
 #if defined(CONFIG_FLATMEM)
 
+/*
+ * The FLATMEM memory model assumes that memory is one contiguous block of
+ * memory starting at PFN 0 with the first valid struct page at mem_map[0].
+ * mem_map is initialised to point to NODE_DATA(0)->node_mem_map.
+ *
+ * Architectures that do not start memory at PFN 0 are required to
+ * define ARCH_PFN_OFFSET so that __page_to_pfn(&mem_map[0]) == 0 and
+ * __pfn_to_page(0) == &mem_map[0]
+ *
+ */
 #ifndef ARCH_PFN_OFFSET
 #define ARCH_PFN_OFFSET		(0UL)
 #endif

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab

