Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWCOL66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWCOL66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWCOL66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:58:58 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:9365 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751868AbWCOL65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:58:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IMC6eWkqCAmN1/3+m4lLg3Lr0AGdDvJ90xZqd9UroHp8LVpFe0WyacOtYTZFmhSmEZqCdAS/wV47RJd1p4ai43jE5tyTGRGWzzmK8C4IN52eNTJroastRjFDpwHTA8DDII3QfPlqDMhKVWngLaFn3bl8xgyCOLG7pquyP9cddUQ=  ;
Message-ID: <4417FFC2.8040909@yahoo.com.au>
Date: Wed, 15 Mar 2006 22:51:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <44110E93.8060504@yahoo.com.au>  <16835.1141936162@warthog.cambridge.redhat.com> <14886.1142421018@warthog.cambridge.redhat.com>
In-Reply-To: <14886.1142421018@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Isn't the Alpha's split caches a counter-example of your model,
>>because the coherency itself is out of order?
> 
> 
> I'd forgotten I need to adjust my documentation to deal with this. It seems
> this is the reason for read_barrier_depends(), and that read_barrier_depends()
> is also a partial cache sync.
> 
> Do you know of any docs on Alpha's split caches? The Alpha Arch Handbook
> doesn't say very much about cache operation on the Alpha.
> 
> I've looked around for what exactly is meant by "split cache" in conjunction
> with Alpha CPUs, and I've found three different opinions of what it means:
> 
>  (1) Separate Data and Instruction caches.
> 
>  (2) Serial data caches (CPU -> L1 Cache -> L2 Cache -> L3 Cache -> Memory).
> 
>  (3) Parallel linked data caches, where a CPU's request can be satisfied by
>      either data cache, in which whilst one data cache is being interrogated by
>      the CPU, the other one can use the memory bus (at least, that's what I
>      understand).
> 

I don't have any docs myself, Paul might be the one to talk to as he's
done the most recent research on this (though some of it directly with
Alpha engineers, if I remember correctly).

IIRC some alpha models have split cache close to what you describe in
#3, however I'm not sure of the fine details (eg. I don't think the
split caches are redundant, but just treated as two entities by the
cache coherence protocol).

Again, I don't have anything definitive that you can put in your docco,
sorry.

> 
>>Why do you need to include caches and queues in your model? Do
>>programmers care? Isn't the following sufficient...
> 
> 
> I don't think it is sufficient, given the number of times the way the cache
> interacts with everything has come up in this discussion.
> 
> 
>>         :    | m |
>>   CPU -----> | e |
>>         :    | m |
>>         :    | o |
>>   CPU -----> | r |
>>         :    | y |
>>
>>... and bugger the implementation details?
> 
> 
> Ah, but if the cache is on the CPU side of the dotted line, does that then mean
> that a write memory barrier guarantees the CPU's cache to have updated memory?
> 

I don't think it has to[*]. It would guarantee the _order_ in which
"global memory" of this model ie. visibility for other "CPUs" see the
writes, whether that visibility ultimately be implemented by cache
coherency protocol or something else, I don't think matters (for a
discussion of memory ordering). If anything it confused the matter
for the case of Alpha.

All the programmer needs to know is that there is some horizon (memory)
beyond which stores are visible to other CPUs, and stores can travel
there at different speeds so later ones can overtake earlier ones. And
likewise loads can come from memory to the CPU at different speeds too,
so later loads can contain earlier results.

[*] Nor would your model require a smp_wmb() to update CPU caches either,
I think: it wouldn't have to flush the store buffer, just order it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
