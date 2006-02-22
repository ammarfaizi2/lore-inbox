Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWBVDYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWBVDYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWBVDYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:24:21 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17285 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751275AbWBVDYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:24:20 -0500
Message-ID: <43FBD995.20601@jp.fujitsu.com>
Date: Wed, 22 Feb 2006 12:25:09 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove zone_mem_map
References: <43FBAEBA.2020300@jp.fujitsu.com> <Pine.LNX.4.64.0602211900450.23557@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0602211900450.23557@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 22 Feb 2006, KAMEZAWA Hiroyuki wrote:
> 
>> This patch removes zone_mem_map.
> 
> Note that IA64 does not seem to depend on zone_mem_map...
> 
Oh, yes. ia64 doesn't includes asm-generic/memory_model.h when DISCONTIGMEM.

>> Index: test/include/asm-generic/memory_model.h
>> ===================================================================
>> --- test.orig/include/asm-generic/memory_model.h
>> +++ test/include/asm-generic/memory_model.h
>> @@ -47,9 +47,9 @@ extern unsigned long page_to_pfn(struct
>>
>>  #define page_to_pfn(pg)			\
>>  ({	struct page *__pg = (pg);		\
>> -	struct zone *__zone = page_zone(__pg);	\
>> -	(unsigned long)(__pg - __zone->zone_mem_map) +	\
>> -	 __zone->zone_start_pfn;			\
>> +	struct pglist_data *__pgdat = NODE_DATA(page_to_nid(__pg));	\
>> +	(unsigned long)(__pg - __pgdat->node_mem_map) +	\
>> +	 __pgdat->node_start_pfn;			\
>>  })
> 
> NODE_DATA is an arch specific lookup, If it always is a table lookup
> then the performance will be comparable to page_zone because that also 
> involves one table lookup.
> 
There are several types of NODE_DATA definitions.
1. #define NODE_DATA(node)	(&node_data[node]) alpha,arm,
2. #define NODE_DATA(node)      (node_data[node]) i386,powerpc,x86_64,m32r
3. #define NODE_DATA(node)	(&node_data[node]->pgdat) parisc,mips
4. #define NODE_DATA(node)	(per-cpu-page has node_data[nid] pointer array) ia64

BTW, ia64 looks very special. Does it make sensible performance gain ?

-- Kame

