Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUHTHhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUHTHhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUHTHhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:37:22 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22936 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262071AbUHTHhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:37:19 -0400
Message-ID: <4125AA35.6020900@namesys.com>
Date: Fri, 20 Aug 2004 00:37:25 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: cherry@osdl.org, linux-kernel@vger.kernel.org, zam@namesys.com,
       demidov@namesys.com
Subject: Re: 2.6.8.1-mm2
References: <20040819014204.2d412e9b.akpm@osdl.org>	<1092927166.29916.0.camel@cherrybomb.pdx.osdl.net>	<4125A2F6.5050308@namesys.com> <20040820001629.387715be.akpm@osdl.org>
In-Reply-To: <20040820001629.387715be.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>John Cherry wrote:
>>
>>    
>>
>>>The new "errors" are from reiser4 code and they all appear to be...
>>>
>>>fs/reiser4/reiser4.h:18:2: #error "Please turn 4k stack off"
>>>
>>> 
>>>
>>>      
>>>
>>zam, can you or Mr. Demidov work on using kmalloc to reduce stack usage?
>>
>>Andrew suggested that for statically sized objects kmalloc is quite fast 
>>(one instruction I think he said), so my objection to kmallocing a lot 
>>has faded.
>>    
>>
>
>err, not that quick - but it's pretty quick.
>
>With a kmalloc with a constant size and, preferably, a constant gfp mask
>we'll jump directly into __cache_alloc() and in the common case we'll pluck
>an entry directly out of the cpu-local head array:
>
>So the kmalloc fastpath is, effectively:
>
>	local_irq_save(save_flags);
>	ac = ac_data(cachep);
>	if (likely(ac->avail)) {
>		ac->touched = 1;
>		objp = ac_entry(ac)[--ac->avail];
>	}
>	local_irq_restore(save_flags);
>	return objp;
>
>
>Not bad...
>
>
>  
>
but not trivial.  Sigh.  It means determining whether we can get below 
4k without performance loss requires detailed code examination to 
determine what is using up the stack in practice, and discussion.

Well, maybe zam has a comment.

Hans
