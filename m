Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933356AbWKWJQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbWKWJQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbWKWJQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:16:08 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:24078 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S933356AbWKWJQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:16:05 -0500
Message-ID: <456566D3.2000107@shadowen.org>
Date: Thu, 23 Nov 2006 09:16:03 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] silence unused pgdat warning from alloc_bootmem_node
 and friends
References: <79c5d936eb213ae3169202f5f4c7e992@pinky> <20061122132414.1db3c22f.akpm@osdl.org>
In-Reply-To: <20061122132414.1db3c22f.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 22 Nov 2006 14:38:51 +0000
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>> silence unused pgdat warning from alloc_bootmem_node and friends
>>
>> x86 NUMA systems only define bootmem for node 0.  alloc_bootmem_node()
>> and friends therefore ignore the passed pgdat and use NODE_DATA(0)
>> in all cases.  This leads to the following warnings as we are not
>> using the passed parameter:
>>
>>   .../mm/page_alloc.c: In function 'zone_wait_table_init':
>>   .../mm/page_alloc.c:2259: warning: unused variable 'pgdat'
>>
>> One option would be to define all variables used with these macros
>> __attribute__ ((unused)), but this would leave us exposed should
>> these become genuinely unused.
>>
>> The key here is that we _are_ using the value, we ignore it but that
>> is a deliberate action.  This patch adds a nested local variable
>> within the alloc_bootmem_node helper to which the pgdat parameter is
>> assigned making it 'used'.  The nested local is marked __attribute__
>> ((unused)) to silence this same warning for it.
>>
>> Against 2.6.19-rc5-mm2.
>>
>> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
>> ---
>> diff --git a/include/asm-i386/mmzone.h b/include/asm-i386/mmzone.h
>> index 61b0733..3503ad6 100644
>> --- a/include/asm-i386/mmzone.h
>> +++ b/include/asm-i386/mmzone.h
>> @@ -120,13 +120,26 @@ static inline int pfn_valid(int pfn)
>>  	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
>>  #define alloc_bootmem_low_pages(x) \
>>  	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
>> -#define alloc_bootmem_node(ignore, x) \
>> -	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
>> -#define alloc_bootmem_pages_node(ignore, x) \
>> -	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
>> -#define alloc_bootmem_low_pages_node(ignore, x) \
>> -	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
>> -
>> +#define alloc_bootmem_node(pgdat, x)					\
>> +({									\
>> +	struct pglist_data  __attribute__ ((unused))			\
>> +				*__alloc_bootmem_node__pgdat = (pgdat);	\
>> +	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES,	\
>> +						__pa(MAX_DMA_ADDRESS));	\
>> +})
>> +#define alloc_bootmem_pages_node(pgdat, x)				\
>> +({									\
>> +	struct pglist_data  __attribute__ ((unused))			\
>> +				*__alloc_bootmem_node__pgdat = (pgdat);	\
>> +	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE,		\
>> +						__pa(MAX_DMA_ADDRESS))	\
>> +})
>> +#define alloc_bootmem_low_pages_node(pgdat, x)				\
>> +({									\
>> +	struct pglist_data  __attribute__ ((unused))			\
>> +				*__alloc_bootmem_node__pgdat = (pgdat);	\
>> +	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0);		\
>> +})
>>  #endif /* CONFIG_NEED_MULTIPLE_NODES */
>>  
> 
> Can these be switched to functions, or do they actually need to be macros?

I did first attempt to make them inline functions, that leads us to some
new dependancies such as on MAX_DMA_ADDRESS.  I must admit to backing
off at that point, the dependancy problems between mmzone.h and mm.h
caused huge amounts of problems for me in the past and I was shy of
playng with them again.

I'll take a look see if thats the only one or if it is indeed still
endemic.  I know some of the issues were fixed with additional headers.

-apw
