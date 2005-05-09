Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVEIXEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVEIXEX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVEIXEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:04:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2225 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261341AbVEIXES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:04:18 -0400
Message-ID: <427FEC57.8060505@austin.ibm.com>
Date: Mon, 09 May 2005 18:03:51 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: akpm@osdl.org, anton@samba.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linuxppc64-dev@ozlabs.org, olof@lixom.net, paulus@samba.org
Subject: Re: sparsemem ppc64 tidy flat memory comments and fix benign mempresent
 call
References: <E1DVAVE-00012m-Pq@pinky.shadowen.org>
In-Reply-To: <E1DVAVE-00012m-Pq@pinky.shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -upN reference/arch/ppc64/mm/init.c current/arch/ppc64/mm/init.c
> --- reference/arch/ppc64/mm/init.c
> +++ current/arch/ppc64/mm/init.c
> @@ -631,18 +631,19 @@ void __init do_init_bootmem(void)
>  
>  	max_pfn = max_low_pfn;
>  
> -	/* add all physical memory to the bootmem map. Also, find the first
> -	 * presence of all LMBs*/
> +	/* Add all physical memory to the bootmem map, mark each area
> +	 * present.  The first block has already been marked present above.
> +	 */
>  	for (i=0; i < lmb.memory.cnt; i++) {
>  		unsigned long physbase, size;
>  
>  		physbase = lmb.memory.region[i].physbase;
>  		size = lmb.memory.region[i].size;
> -		if (i) { /* already created mappings for first LMB */
> +		if (i) {
>  			start_pfn = physbase >> PAGE_SHIFT;
>  			end_pfn = start_pfn + (size >> PAGE_SHIFT);
> +			memory_present(0, start_pfn, end_pfn);
>  		}
> -		memory_present(0, start_pfn, end_pfn);
>  		free_bootmem(physbase, size);
>  	}

Instead of moving all that around why don't we just drop the duplicate 
and the if altogether?  I tested and sent a patch back in March that 
cleaned up the non-numa case pretty well.

http://sourceforge.net/mailarchive/message.php?msg_id=11320001

