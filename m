Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWC3F70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWC3F70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWC3F70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:59:26 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:9328 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750967AbWC3F70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:59:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CcJXjjFKSl4gWVwE+NmlTP0lXgKMZs8996+ZjvylshzDG62Y+tM0MmrSqpQ3sNFp8I3vOyns64PoF35hxJFRk5jq/J33u9iZ8hyjlYY3Wck+L/iMt+XHNlUTXKIMqj0aVD0kthfxaQXBNjwTOVvHy/IoOsdCuck3QITuVZoISgQ=  ;
Message-ID: <442B4890.6000905@yahoo.com.au>
Date: Thu, 30 Mar 2006 13:55:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: emin ak <eminak71@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10 crash on ppc
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com> <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com> <44288FB3.5030208@yahoo.com.au> <20060329150815.GA24741@elte.hu>
In-Reply-To: <20060329150815.GA24741@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>>I'm not very familiar with the -rt tree, but possibly what should be 
>>happening, if interrupts are executed in process context and allowed 
>>to schedule, is that their memory allocations should also be allowed 
>>to reclaim memory.
>>
>
>indeed - very good point. Emin, could you try the patch below [which 
>isnt a full solution but should be a good first approximation], does it 
>make any difference?
>
>
>>OTOH, I guess for a deterministic realtime system, you need to 
>>allocate fixed minimum amounts of memory for each element of the 
>>system so you never run out like this.
>>
>
>yeah, preallocation is pretty much the only way to go for deterministic 
>workloads. Still, networking (and other complex subsystems) can still be 
>used in parallel to deterministic tasks - and those should not be 
>starved easier when PREEMPT_RT is enabled. In fact, with the patch below 
>it could become much more robust - we could in fact achieve to never 
>fail an allocation due to being in an atomic context.
>
>

Yes, that patch is basically what I had in mind.

Is -rt ever allocating memory from really-hard-don't-preempt-me context?
I guess not, unless the zone->lock is one of those locks too, right?

Should you add a

  #else
     BUG_ON(_really_dont_preempt_me());
  #endif

just for safety, or will such misusage get caught elsewhere (eg. when
attempting to take zone->lock).

Thanks,
Nick

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
