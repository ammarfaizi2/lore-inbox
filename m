Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUDSQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUDSQn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:43:26 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:41618 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261479AbUDSQm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:42:59 -0400
Message-ID: <4084017C.5080706@colorfullife.com>
Date: Mon, 19 Apr 2004 18:42:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Andreas Gruenbacher <agruen@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
References: <1082383751.6746.33.camel@f235.suse.de> <20040419162533.GR29954@dualathlon.random>
In-Reply-To: <20040419162533.GR29954@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>/mirror/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc4/broken-out/slab-alignment-rework.patch
>
>I don't think this is right:
>
>  
>
>>-	if (flags & SLAB_HWCACHE_ALIGN) {
>>-		/* Need to adjust size so that objs are cache aligned. */
>>-		/* Small obj size, can get at least two per cache line. */
>>+	if (!align) {
>>+		/* Default alignment: compile time specified l1 cache size.
>>+		 * Except if an object is really small, then squeeze multiple
>>+		 * into one cacheline.
>>+		 */
>>+		align = cache_line_size();
>> 		while (size <= align/2)
>> 			align /= 2;
>>-		size = (size+align-1)&(~(align-1));
>> 	}
>>+	size = ALIGN(size, align);
>> 
>>    
>>
>
>I want anon-vma to really use only 12 bytes, period.
>
Then pass "4" as the align parameter to kmem_cache_create. That's the 
main point of the patch: it's now possible to explicitely specify the 
requested alignment. 32 for the 3rd level page tables, the optimal 
number for the pte_chains, etc.

> No best-guess must
>be made automatically by the slab code, rounding it to 16 bytes.
>
If you pass 0 as align to kmem_cache_create, then it's rounded to L2 
size. It's questionable if that's really the best thing - on 
uniprocessor, 16-byte might result is better performance - there is no 
risk of false sharing.

--
    Manfred

