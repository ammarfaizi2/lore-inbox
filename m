Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTIOMiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTIOMiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:38:50 -0400
Received: from dyn-ctb-210-9-244-189.webone.com.au ([210.9.244.189]:7686 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261338AbTIOMin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:38:43 -0400
Message-ID: <3F65B2BD.9000206@cyberone.com.au>
Date: Mon, 15 Sep 2003 22:38:21 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <200309151146.h8FBkXcw001170@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200309151146.h8FBkXcw001170@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Bradford wrote:

snip

>>No, debug the kernel while its running on the 386.
>>
>
>What if the 386 is a wristwatch, or similar embedded device?
>

You might be right. I'm not sure how the embedded software process goes.
I'd think that most of the time you'd be fine compiling different
kernels for each: you probably want a lot more options in your debug
kernel anyway.

I guess more specialised users would be able to edit the cache line
size themselves. I wouldn't be adverse to a kconfig setting under the
embedded menu though.

>
>>And what of my other
>>concerns?
>>
>
>Since nobody seemed to agree with me, I was sparing the list the
>bandwidth, but...
>

Ahh, they don't have to read it ;)

>
>>1. It doesn't appear to be simple and elegant.
>>
>
>Well, it's obviously not as simple as just using 128 byte padding all
>the time, but the basic idea of, 'choose required work-arounds, and
>optimisations independently of each other', is fairly simple, (in
>concept), and elegant, (as it lets you compile the most finely tuned
>binary).
>

OK, the reason why I don't like the sound of this is because the size
of your option set has now been squared, and its no longer "make these
CPUs work".

I can see an argument for cache line size but thats about it. I can't
think of my optimisations that should be done on one architecture but
not another.

>
>Maybe we are not thinking along the same lines.
>
>Up to now, selecting a CPU to compile for basically means, "Use
>compiler optimisations for this CPU, and don't care about
>compatibility with anything before it".  Adrian's patch to change this
>to an arbitrary bitmap selection of CPUs to support seems like a good
>idea to me for two reasons, firstly with increasing numbers of
>work-arounds, it's silly to include them all in a kernel for a 386.
>Secondly, ever since we included support for optimising for the 686,
>the idea that a kernels compiled for progressively more recent CPUs
>would be faster than each other on the same hardware has been false -
>a kernel compiled for a Pentium is slower on a 686 than a kernel
>compiled for a 486 is.
>

I think its a great idea. I hope it gets included in some form. For an
end user (including distros) its a lot simpler and more logical than the
current scheme.

>
>So, if we move from selecting a range of CPUs to support, I.E. 386 ->
>whatever, to selecting individual CPUs, E.G. 386, PIV, and Athlon,
>there is no question about which workarounds we should include.  By
>the way, I am talking about including them at compile time, not
>checking at run time whether they are needed - maybe I wasn't clear
>about that.  I don't see the point in checking at runtime - any kernel
>

No I definitely agree. Except sometimes you'll have to check at runtime:
a kernel compiled for all cpus for example needs Andi's Athlon prefetch
scheme. You'd really want some good helpers to either do runtime check
or always, or never. Something like this optimises down OK if cpu and
archmask are constant.

static inline void ifcpu(const int cpumask, void (*func)(void))
{
        if ((cpumask&archmask) && ((~cpumask)&archmask)) {
                if (cpumask&current_cpu)
                        func();
        } else if (cpumask&archmask) {
                func();
        }
}

ifcpu(K7||K8, &prefetch_workaround);

You then need to get kconfig to generate cpu and archmask nicely.
You obviously still need to ifdef your prefetch_workaround to get the
space saving.

>
>that supports multiple CPUs is not optimial anyway, so why bother
>trying to optimise it at all?  I know there is another way of looking
>at it, that distributions will want a kernel that runs on anything,
>(well, these days, probably a 486 or higher CPU), that is not
>particularly sub-optimial on any CPU, so that users can just install
>it, and have it work.  In that case, I totally agree with you that 128
>byte padding is the most sensible way to go, but that is a
>distribution thing.  Anybody who compiles their own kernel is probably
>going to want to compile it for the processor it's destined to run on,
>rather than make a generic kernel, unless they are making a boot disk
>for emergencies, in which case performance is not usually an issue.
>So, the question of which workarounds to include is simple, but what
>to do about optimisation?  In the current model, where you are
>selecting a range of CPUs to support, (E.G. 386->Pentium), the
>question is answered by saying, OK, we'll optimise for the most recent
>processor in that range.  With an arbitrary selection, E.G. PIV and
>Athlon, which do you pad for?  Whichever is least harmful to
>performance on the others?  This is what I meant by simple and elegant
>- you just present independent choice to the user in the
>configurator.
>
>
>>2. It would drive developers nuts if it was used for anything other than
>>   a couple of critical functions (cache size would be one).
>>
>
>OK, well by using the 'optimisation' setting simply for setting cache
>size alone, you'd still get a nice tunable kernel.  Much better than
>just setting it to an arbitrary value.
>

I'll give that to you. I'm all for more tunability if it can be coded
nicely.

>
>>3. Are there valid situations where you would need it? This isn't a
>>   rhetorical question. Your example would be fine if somebody really
>>   needed to do that.
>>
>
>Personally, I compile specific kernels for all of my boxes separately.
>No box runs any kind of generic kernel in normal use, so I'd like to
>see as many unnecessary workarounds removed from the code as possible
>at compile time, and appropriate compiler optimisations for only the
>specific CPU the kernel is destined for.  That maximises kernel
>performance on that mahcine.  On the other hand, if I'm working on an
>embedded project with a 386 or a 486, I'm usually running the same
>environment on a more powerful box as well, for testing purposes, so I
>need workarounds for the, (E.G. Athlon), CPU in the development box,
>but I don't want performance optimisations for that faster CPU,
>especially if they have a negative effect on the embedded CPU.
>

Maybe for the cache size. Anything more and I think it gets too complex.
Then again, I don't know of any other optimisations with the properties
of the L1_CACHE_SHIFT.


