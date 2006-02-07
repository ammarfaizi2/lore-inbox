Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWBGNVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWBGNVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWBGNVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:21:06 -0500
Received: from ns1.suse.de ([195.135.220.2]:33257 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965031AbWBGNVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:21:05 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 14:14:30 +0100
User-Agent: KMail/1.8.2
Cc: steiner@sgi.com, Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071343.59384.ak@suse.de> <20060207125845.GB634@elte.hu>
In-Reply-To: <20060207125845.GB634@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071414.31119.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 13:58, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Tuesday 07 February 2006 13:30, Ingo Molnar wrote:
> > 
> > > you are a bit biased towards low-latency NUMA setups i guess (read: 
> > > Opterons) :-) 
> > 
> > Well they are the vast majority of NUMA systems Linux runs on.
> >
> > And there are more than just Opterons, e.g. IBM Summit. And even the 
> > majority of Altixes are not _that_ big.
> > 
> > Of course we need to deal somehow with the big systems, but for the 
> > good defaults the smaller systems are more important.
> 
> i'm not sure i understand your point. You said that for small systems 
> with a low NUMA factor it doesnt really matter where the pagecache is 
> placed. 

I meant it's not that big an issue if it's remote, but it's
bad if it fills up the local node.

Also pagecache = unmapped file cache here. And d/icache. 
For mapped anonymous memory it's different of course.


> I mostly agree with that. And since placement makes no  
> difference there, we can freely shape things for the systems where it 
> does make a difference. It will probably make a small win on smaller 
> systems too, as a bonus. Ok?

No because filling up the local node is a problem on the small systems
too because it prevents the processes from getting enough anonymous
memory. For anonymous memory memory placement is important even for 
small systems.

Basically you have to consider the frequency of access:

Mapped memory is very frequently accessed. For it memory placement 
is really important. Optimizing it at the cost of everything
else is a good default strategy

File cache is much less frequently accessed (most programs buffer
read/write well) and when it is accessed it is using functions
that are relatively latency tolerant (kernel memcpy). So memory
placement is much less important here.

And d/inode are also very infrequently accessed compared to local memory,
so the occasionally additional latency is better than competing too much
with local memory allocation.

> > Big systems tend to have capable administrators who are willing to 
> > tweak them. But that's rarely the case with the small systems. So I 
> > think as long as the big system can be somehow made to work with 
> > special configuration and ignoring corner cases that's fine. But for 
> > the low NUMA systems it should perform as well as possibly out of the 
> > box.
> 
> i also mentioned software-based clusters in the previous mail, so it's 
> not only about big systems. Caching attributes are very much relevant 
> there. Tightly integrated clusters can be considered NUMA systems with a 
> NUMA factor of 1000 or so (or worse).

To be honest I don't think systems with such a NUMA factor will ever work 
well in the general case. So I wouldn't recommend considering them
much if at all in your design thoughts. The result would likely not
be a good balanced design.

> > > Obviously with a low NUMA factor, we dont have to deal  
> > > with memory access assymetries all that much.
> > 
> > That is why I proposed "nearby policy". It can turn a system with a 
> > large NUMA factor into a system with a small NUMA factor.
> 
> well, would the "nearby policy" make a difference on the small systems? 

Probably not.
> 
> Small systems (to me) are just a flat and symmetric hierarchy of nodes - 
> the next step from SMP. So there's really just two distances: local to 
> the node, and one level of 'alien'. Or do you include systems in this 
> category that have bigger assymetries?

Even a 4 way Opteron has two hierarchies (although the kernel
often doesn't know about them because most BIOS have broken SLIT tables) 
and a 8 way Opteron has three. Similar let's say a 4 node x460.
But these systems have still a reasonably small NUMA factor.

-Andi
