Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbTK0B5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 20:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTK0B5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 20:57:53 -0500
Received: from evrtwa1-ar2-4-35-049-074.evrtwa1.dsl-verizon.net ([4.35.49.74]:60289
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S264425AbTK0B5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 20:57:49 -0500
Message-ID: <3FC55A10.2040704@candelatech.com>
Date: Wed, 26 Nov 2003 17:57:36 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Fast timestamps
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>	<p73fzgbzca6.fsf@verdi.suse.de>	<20031126113040.3b774360.davem@redhat.com>	<3FC505F4.2010006@google.com>	<20031126120316.3ee1d251.davem@redhat.com>	<20031126232909.7e8a028f.ak@suse.de>	<20031126143620.5229fb1f.davem@redhat.com>	<20031126235641.36fd71c1.ak@suse.de>	<20031126151352.160b4734.davem@redhat.com>	<3FC53A40.8010904@candelatech.com> <20031126160129.32855a15.davem@redhat.com>
In-Reply-To: <20031126160129.32855a15.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 26 Nov 2003 15:41:52 -0800
> Ben Greear <greearb@candelatech.com> wrote:
> 
> 
>>I'll try to write up a patch that uses the TSC and lazy conversion
>>to timeval as soon as I get the rx-all and rx-fcs code happily
>>into the kernel....
>>
>>Assuming TSC is very fast and the conversion is accurate enough, I think
>>this can give good results....
> 
> 
> I'm amazed that you will be able to write a fast_timestamp
> implementation without even seeing the API I had specified
> to the various arch maintainers :-)

Well, I would only aim at x86, with generic code for the
rest of the architectures.  The truth is, I'm sure others would
be better/faster at it than me, but we keep discussing it, and it
never gets done, so unless someone beats me to it, I'll take a stab
at it...  Might be after Christmas though, busy December coming up!

I agree with your approach below.  One thing I was thinking about:
is it possible that two threads ask for the timestamp of a single skb
concurrently?  If so, we may need a lock if we want to cache the conversion
to gettimeofday units....  Of course, the case where multiple readers want
the timestamp for a single skb may be too rare to warrant caching...

Ben

> 
> ====================
> 
> But at the base I say we need three things:
> 
> 1) Some kind of fast_timestamp_t, the property is that this stores
>    enough information at time "T" such that at time "T + something"
>    the fast_timestamp_t can be converted what the timeval was back at
>    time "T".
> 
>    For networking, make skb->stamp into this type.
> 
> 2) store_fast_timestamp(fast_timestamp_t *)
> 
>    For networking, change do_gettimeofday(&skb->stamp) into
>    store_fast_timestamp(&skb->stamp)
> 
> 3) fast_timestamp_to_timeval(arch_timestamp_t *, struct timeval *)
> 
>    For networking, change things that read the skb->stamp value
>    into calls to fast_timestamp_to_timeval().
> 
> It is defined that the timeval given by fast_timestamp_to_timeval()
> needs to be the same thing that do_gettimeofday() would have recorded
> at the time store_fast_timestamp() was called.
> 
> Here is the default generic implementation that would go into
> asm-generic/faststamp.h:
> 
> 1) fast_timestamp_t is struct timeval
> 2) store_fast_timestamp() is gettimeofday()
> 3) fast_timestamp_to_timeval() merely copies the fast_timestamp_t
>    into the passed in timeval.
> 
> And here is how an example implementation could work on sparc64:
> 
> 1) fast_timestamp_t is a u64
> 
> 2) store_fast_timestamp() reads the cpu cycle counter
> 
> 3) fast_timestamp_to_timeval() records the difference between the
>    current cpu cycle counter and the one recorded, it takes a sample
>    of the current xtime value and adjusts it accordingly to account
>    for the cpu cycle counter difference.
> 
> This only works because sparc64's cpu cycle counters are synchronized
> across all cpus, they increase monotonically, and are guarenteed not
> to overflow for at least 10 years.
> 
> Alpha, for example, cannot do it this way because it's cpu cycle counter
> register overflows too quickly to be useful.
> 
> Platforms with inter-cpu TSC synchronization issues will have some
> troubles doing the same trick too, because one must handle properly
> the case where the fast timestamp is converted to a timeval on a different
> cpu on which the fast timestamp was recorded.
> 
> Regardless, we could put the infrastructure in there now and arch folks
> can work on implementations.  The generic implementation code, which is
> what everyone will end up with at first, will cancel out to what we have
> currently.
> 
> This is a pretty powerful idea that could be applied to other places,
> not just the networking.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


