Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316232AbSFZBiB>; Tue, 25 Jun 2002 21:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSFZBiA>; Tue, 25 Jun 2002 21:38:00 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:11026 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316300AbSFZBh7>;
	Tue, 25 Jun 2002 21:37:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206260137.g5Q1bjF96576@saturn.cs.uml.edu>
Subject: Re: another new version of pageattr caching conflict fix for
To: richard.brunner@amd.com
Date: Tue, 25 Jun 2002 21:37:45 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org,
       unlisted-recipients:;;;;@amd.com;;; (no To-header on input)
In-Reply-To: <39073472CFF4D111A5AB00805F9FE4B609BA6712@txexmta9.amd.com> from "richard.brunner@amd.com" at Jun 17, 2002 04:07:11 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner writes:
> [Albert Cahalan]

>> You can do whatever you want, as long as...
>>
>> 1. you have cache control instructions and use them
>> 2. the bridge ignores the coherency protocol (no machine check)
>>
>> Most likely you should make the AGP memory write-back
>> cacheable. This requires some care regarding cache lines,
>> but ought to be faster.

> Making the AGP Aperture write-back cacheable is not good from
> a performance perspective. (I can't comment on which is better 
> from a Linux Kernel perspective).
> 
> An Aperture Page can be made
> cache-coherent depending on the implementation
> and the AGP 3.0 spec provides an
> architectural way of specifying and controlling these as
> well.  But, by default the area is not made cache-coherent
> due to the performance loss and the lack of software to take
> advantage of it -- the two play off against each
> other. 
> 
> Making it cache-coherent causes every AGP access to
> snoop processor caches and this can be quite a hit in
> performance when you consider the predominant AGP software
> model. Most software that takes advantage of AGP is still
> using the old Intel model of uncacheable, the majority of
> data placed in the Aperture are read-only structures for the
> AGP device -- such as vertex lists, locked vertex arrays,
> and texture data. For the most part this fits the current
> paradigm of throwing textures and vertices at the graphics
> device. The only graphics area found so far that could
> benefit from a coherent aperture is video capture data which
> streams in from the graphics device and requires CPU
> post-processing.

I didn't suggest enabling coherency.

You can cache your _incoherent_ memory as long as the CPU
has instructions that manipulate cache lines. This gives
you write-combining without AGP snooping overhead. If you
can have the CPU be incoherent too, you should do so.

I'm used to working with PowerPC, so maybe you'll tell me
that x86 is too lame to handle this. Hopefully AMD supports
most of these useful operations:

a. mark a cache line valid (with junk data)
b. cause immediate write-back
c. mark a cache line invalid (discard data)
d. prefetch for load
e. prefetch for store (leave clean)
f. create a zero-filled dirty cache line
g. write-back, then invalidate
h. mark some memory as "cached, but NOT coherent"

So you can work like this:

1. mark a cache line valid (with junk data)
2. modify the data the regular way
3. write-back, then invalidate
4. tell the video card to read the data

For data coming the other way:

1. ensure that the cache line isn't dirty
2. tell the video card to write data
3. ensure that the cache line isn't valid
4. prefetch for read
5. see what the video card had to say
