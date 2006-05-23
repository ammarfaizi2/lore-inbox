Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWEWXnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWEWXnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 19:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWEWXnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 19:43:52 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:5530 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932188AbWEWXnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 19:43:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qfmtPIBmwWG4PJNpog0C1d1tQHTe58NbpIGToRmotLYySRLcuF6HjKDdKuhDLdDeF+vkudWllZq4NYDPZ1Szbd5YJQOeavN08s4781xW8WqDe2/bWaXb+pETmHMhtUn0hw4wruIIqADa6PQJvTAnCguRUdJLe40iHSAqKeCs8mE=  ;
Message-ID: <44739E2D.60406@yahoo.com.au>
Date: Wed, 24 May 2006 09:43:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com, ak@suse.de,
       linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov
Subject: Re: [PATCH (try #3)] mm: avoid unnecessary OOM kills
References: <200605230032.k4N0WCIU023760@calaveras.llnl.gov> <4472A006.2090006@yahoo.com.au> <7.0.0.16.2.20060523094646.02429fd8@llnl.gov>
In-Reply-To: <7.0.0.16.2.20060523094646.02429fd8@llnl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:
> At 10:39 PM 5/22/2006, Nick Piggin wrote:
> 
>>Does this fix observed problems on real (or fake) workloads? Can we have
>>some more information about that?

[snip]

OK, thanks.

>>I still don't quite understand why all this mechanism is needed. Suppose
>>that we single-thread the oom kill path (which isn't unreasonable, unless
>>you need really good OOM throughput :P), isn't it enough to find that any
>>process has TIF_MEMDIE set in order to know that an OOM kill is in progress?
>>
>>down(&oom_sem);
>>for each process {
>> if TIF_MEMDIE
>>    goto oom_in_progress;
>> else
>>   calculate badness;
>>}
>>up(&oom_sem);
> 
> 
> That would be another way to do things.  It's a tradeoff between either
> 
>     option A: Each task that enters the OOM code path must loop over all
>               tasks to determine whether an OOM kill is in progress.
> 
>     or...
> 
>     option B: We must declare an oom_kill_in_progress variable and add
>               the following snippet of code to mmput():
> 
>                 put_swap_token(mm);
> +               if (unlikely(test_bit(MM_FLAG_OOM_NOTIFY, &mm->flags)))
> +                       oom_kill_finish();  /* terminate pending OOM kill */
>                 mmdrop(mm);
> 
> I think either option is reasonable (although I have a slight preference
> for B since it eliminates substantial looping through the tasklist).

Don't you have to loop through the tasklist anyway? To find a task
to kill?

Either way, at the point of OOM, usually they should have gone through
the LRU lists several times, so a little bit more CPU time shouldn't
hurt.

> 
> 
>>Is all this really required? Shouldn't you just have in place the
>>mechanism to prevent concurrent OOM killings in the OOM code, and
>>so the page allocator doesn't have to bother with it at all (ie.
>>it can just call into the OOM killer, which may or may not actually
>>kill anything).
> 
> 
> I agree it's desirable to keep the OOM killing logic as encapsulated
> as possible.  However unless you are holding the oom kill semaphore
> when you make your final attempt to allocate memory it's a bit racy.
> Holding the OOM kill semaphore guarantees that our final allocation
> failure before invoking the OOM killer occurred _after_ any previous
> OOM kill victim freed its memory.  Thus we know we are not shooting
> another process prematurely (i.e. before the memory-freeing effects
> of our previous OOM kill have been felt).

But there is so much fudge in it that I don't think it matters:
pages could be freed from other sources, some reclaim might happen,
the point at which OOM is declared is pretty arbitrary anyway, etc.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
