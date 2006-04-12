Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWDLNoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWDLNoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWDLNoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:44:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:935 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932171AbWDLNoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:44:04 -0400
Message-ID: <443D0408.7010204@austin.ibm.com>
Date: Wed, 12 Apr 2006 08:43:36 -0500
From: jschopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Mike Kravetz <mjkravetz@verizon.net>, Andrew Morton <akpm@osdl.org>,
       Arnd Bergmann <arnd@arndb.de>, Joel H Schopp <jschopp@us.ibm.com>,
       haveblue@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparsemem interaction with memory add bug fixes
References: <20060412023347.GA9343@w-mikek2.ibm.com> <443CFF30.1090801@shadowen.org>
In-Reply-To: <443CFF30.1090801@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Mike Kravetz wrote:
>> This patch fixes two bugs with the way sparsemem interacts with memory
>> add.  They are:
>> - memory leak if memmap for section already exists
>> - calling alloc_bootmem_node() after boot
>> These bugs were discovered and a first cut at the fixes were provided by
>> Arnd Bergmann <arnd@arndb.de> and Joel Schopp <jschopp@us.ibm.com>.
>>
>> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
>>
>> diff -Naupr linux-2.6.17-rc1-mm2/mm/sparse.c linux-2.6.17-rc1-mm2.work/mm/sparse.c
>> --- linux-2.6.17-rc1-mm2/mm/sparse.c	2006-04-03 03:22:10.000000000 +0000
>> +++ linux-2.6.17-rc1-mm2.work/mm/sparse.c	2006-04-11 23:32:10.000000000 +0000
>> @@ -32,7 +32,10 @@ static struct mem_section *sparse_index_
>>  	unsigned long array_size = SECTIONS_PER_ROOT *
>>  				   sizeof(struct mem_section);
>>  
>> -	section = alloc_bootmem_node(NODE_DATA(nid), array_size);
>> +	if (system_state == SYSTEM_RUNNING)
>> +		section = kmalloc_node(array_size, GFP_KERNEL, nid);
>> +	else
>> +		section = alloc_bootmem_node(NODE_DATA(nid), array_size);
>>  
>>  	if (section)
>>  		memset(section, 0, array_size);
>> @@ -281,9 +284,9 @@ int sparse_add_one_section(struct zone *
>>  
>>  	ret = sparse_init_one_section(ms, section_nr, memmap);
>>  
>> +out:
>>  	if (ret <= 0)
>>  		__kfree_section_memmap(memmap, nr_pages);
>> -out:
>>  	pgdat_resize_unlock(pgdat, &flags);
>>  	return ret;
>>  }
> 
> First change looks sane.  For the second it makes it obvious that we are
> freeing the alloc'd section within the pgdat resize lock.  Doesn't seem
> to make any sense to do that to me?  Perhaps it should be more like the
> attached.
> 
> -apw
> 
> 
> 
> ------------------------------------------------------------------------
> 
>  sparse.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> diff -upN reference/mm/sparse.c current/mm/sparse.c
> --- reference/mm/sparse.c
> +++ current/mm/sparse.c
> @@ -281,9 +281,9 @@ int sparse_add_one_section(struct zone *
>  
>  	ret = sparse_init_one_section(ms, section_nr, memmap);
>  
> -	if (ret <= 0)
> -		__kfree_section_memmap(memmap, nr_pages);
>  out:
>  	pgdat_resize_unlock(pgdat, &flags);
> +	if (ret <= 0)
> +		__kfree_section_memmap(memmap, nr_pages);
>  	return ret;
>  }

Whatever, I don't really care.  It doesn't matter functionally if we free under the 
pgdat_resize lock or not.  This looks fine, as does the original patch.  If resizing 
pgdats was a hot path we might prefer this way outside the lock.

-Joel
