Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031508AbWK3VTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031508AbWK3VTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 16:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031519AbWK3VTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 16:19:13 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:12967 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031508AbWK3VTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 16:19:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=U7YQi3WEtFuV5LysZ0yEUfhC1eEONP/H/pLWz1NSvqsNvMn8BXeh7XVzgarHBfaTTpNLDt/jJj6ypsgzzrbz85z1LloWf87HOiBm2pbJzdQiCWWsuD3xYEdpgDBldjLcgu161V/OJ9cPmZpgdVeTp7kibbKxhE7rLpSnLHi3Fq8=  ;
X-YMail-OSG: dbo5vEsVM1lb_V7dZKhfe1Vhhx2D093SV34k_FN6USQjLwTSuTgkg.lF3vcdHFBhbOggsJjgPzk6.AcqEPc3y090cdDRUNzwm5Ids_nFmzcgf2GQGQaMXZT8qpNuA8RQ4KNV6W6MWscg540-
Message-ID: <456F4A95.2090503@yahoo.com.au>
Date: Fri, 01 Dec 2006 08:18:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: Sonic Zhang <sonic.adi@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, vapier.adi@gmail.com
Subject: Re: The VFS cache is not freed when there is not enough free memory
 to allocate
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>	 <1164185036.5968.179.camel@twins>	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>	 <456A964D.2050004@yahoo.com.au>	 <4e5ebad50611282317r55c22228qa5333306ccfff28e@mail.gmail.com>	 <6d6a94c50611290127u2b26976en1100217a69d651c0@mail.gmail.com>	 <456D5347.3000208@yahoo.com.au> <6d6a94c50611300454g22196d2frec54e701abaebf17@mail.gmail.com>
In-Reply-To: <6d6a94c50611300454g22196d2frec54e701abaebf17@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> On 11/29/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> That was the order-9 allocation failure. Which is not going to be
>> solved properly by just dropping caches.
>>
>> But Sonic apparently saw failures with 4K allocations, where the
>> caches weren't getting shrunk properly. This would be more interesting
>> because it would indicate a real problem with the kernel.
>>
> I have done several test cases. when cat /proc/meminfo show MemFree < 
> 8192KB,
> 
> 1) malloc(1024 * 4),  256 times = 8MB, allocation successful.
> 2) malloc(1024 * 16),  64 times = 8MB, allocation successful.
> 3) malloc(1024 * 64),  16 times = 8MB, allocation successful.
> 4) malloc(1024 * 128),  8 times = 8MB, allocation failed.
> 5) malloc(1024 * 256),  4 times = 8MB, allocation failed.
> 
>> From those results,  we know, when allocation <=64K, cache can be
> 
> shrunk properly.
> That means the malloc size of an application on nommu should be
> <=64KB. That's exactly our problem. Some video programmes need a big
> block which has contiguous physical address. But yes, as you said, we
> must keep malloc not to alloc a big block to make the current kernel
> working robust on nommu.
> 
> So, my question is, Can we improve this issue? why malloc(64K) is ok
> but malloc(128K) not? Is there any existing parameters about this
> issue? why not kernel attempt to shrunk cache no matter how big memory
> allocation is requested?
> 
> Any thoughts?

The pattern you are seeing here is probably due to the page allocator
always retrying process context allocations which are <= order 3 (64K
with 4K pages).

You might be able to increase this limit a bit for your system, but it
could easily cause problems. Especially fragmentation on nommu systems
where the anonymous memory cannot be paged out.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
