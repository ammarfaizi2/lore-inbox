Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266858AbUFYWrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266858AbUFYWrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUFYWrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:47:08 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:58640 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S266858AbUFYWrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:47:02 -0400
Date: Fri, 25 Jun 2004 23:46:29 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] convert uses of ZONE_HIGHMEM to is_highmem
Message-ID: <6414A31D4B20A018DC917653@[192.168.0.7]>
In-Reply-To: <20040625152711.60fa7ee1.akpm@digeo.com>
References: <200406252203.i5PM3m6s031728@voidhawk.shadowen.org>
 <20040625152711.60fa7ee1.akpm@digeo.com>
X-Mailer: Mulberry/3.1.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 25 June 2004 15:27 -0700 Andrew Morton <akpm@digeo.com> wrote:

> Andy Whitcroft <apw@shadowen.org> wrote:
>>
>> As the comments in mmzone.h indicate is_highmem() is designed to
>> reduce the proliferation of the constant ZONE_HIGHMEM.  This patch
>> updates three references to ZONE_HIGHMEM to use is_highmem().
>> None appear to be on critical paths.
>>
>> Revision: $Rev: 305 $
>>
>>  void __init set_highmem_pages_init(int bad_ppro)
>>  {
>>  # ifdef CONFIG_HIGHMEM
>> -	int nid;
>> +	struct zone *zone;
>>
>> -	for (nid = 0; nid < numnodes; nid++) {
>> +	for_each_zone(zone) {
>>  		unsigned long node_pfn, node_high_size, zone_start_pfn;
>>  		struct page * zone_mem_map;
>>  		
>> -		node_high_size =
>> NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].spanned_pages; -		zone_mem_map
>> = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_mem_map; -
>> 	zone_start_pfn =
>> NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_start_pfn; +		if
>> (!is_highmem(zone))
>> +			continue;
>> +
>> +		printk("Initializing %s for node %d\n", zone->name,
>> +			zone->zone_pgdat->node_id);
>> +
>> +		node_high_size = zone->spanned_pages;
>> +		zone_mem_map = zone->zone_mem_map;
>> +		zone_start_pfn = zone->zone_start_pfn;
>>
>> -		printk("Initializing highpages for node %d\n", nid);
>>  		for (node_pfn = 0; node_pfn < node_high_size; node_pfn++) {
>>  			one_highpage_init((struct page *)(zone_mem_map + node_pfn),
>>  					  zone_start_pfn + node_pfn, bad_ppro);
>
> Fair enough.
>
>> @@ -930,11 +930,12 @@ unsigned int nr_free_pagecache_pages(voi
>>  # ifdef CONFIG_HIGHMEM
>>  unsigned int nr_free_highpages (void)
>>  {
>> -	pg_data_t *pgdat;
>> +	struct zone *zone;
>>  	unsigned int pages = 0;
>>
>> -	for_each_pgdat(pgdat)
>> -		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
>> +	for_each_zone(zone)
>> +		if (is_highmem(zone))
>> +			pages += zone->free_pages;
>
> but that's slower.

Yes.  Although I didn't think any of the users were particularly 
performance critical.  The routine counts the number of free pages in the 
zones which count as highmem, ie memory not direct mapped into KVA.  In 
theory there could be more than one zone per node which was highmem, 
ZONE_HIGHMEM is currently the only one.

I'll have a think if there is a more performant way to 'fix' that.

-apw



