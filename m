Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVDNLyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVDNLyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 07:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDNLyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 07:54:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:62920 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261479AbVDNLyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 07:54:12 -0400
Message-ID: <425E4D23.4060008@colorfullife.com>
Date: Thu, 14 Apr 2005 12:59:47 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, axboe@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch 1/9] GFP_ZERO fix
References: <425BC262.1070500@yahoo.com.au>	<425BC387.3080703@yahoo.com.au> <20050412124741.366caee3.akpm@osdl.org>
In-Reply-To: <20050412124741.366caee3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>  
>
>>  #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
>> -			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
>> -			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
>> +			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL| \
>> +			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO)
>>    
>>
>
>Passing GFP_ZERO into kmem_cache_alloc() is such a bizarre thing to do,
>perhaps a BUG is the correct response.
>
>I guess it could be argued that the kmem_cache_alloc() callers "knows" that
>the ctor will be zeroing out all the objects, but it would seem cleaner to
>me to pass the "you should use GFP_ZERO" hint into kmem_cache_create()
>rather than kmem_cache_alloc().
>  
>
Right now, slab is not really suitable for GFP_ZERO:
- if debug is enabled, then objects are definitively not 0-initialized.
- if a ctor is used for zero initialization, then objects would have to 
be zeroed before kmem_cache_free: The ctor is only called at object 
creation, not before object reuse. But memset(,0,) just before free 
would be a bit silly.

Probably a BUG_ON or WARN_ON should be added into kmem_flagcheck() and 
into kmem_cache_create().

Should I write a patch?
--
    Manfred

