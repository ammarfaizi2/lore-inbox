Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSFRRov>; Tue, 18 Jun 2002 13:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSFRRou>; Tue, 18 Jun 2002 13:44:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7274 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317520AbSFRRos>; Tue, 18 Jun 2002 13:44:48 -0400
To: richard.brunner@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: another new version of pageattr caching conflict fix for 2.4
References: <39073472CFF4D111A5AB00805F9FE4B609BA6712@txexmta9.amd.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Jun 2002 11:34:45 -0600
In-Reply-To: <39073472CFF4D111A5AB00805F9FE4B609BA6712@txexmta9.amd.com>
Message-ID: <m1lm9ctrre.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner@amd.com writes:

> Making the AGP Aperture write-back cacheable is not good from
> a performance perspective. (I can't comment on which is better 
> from a Linux Kernel perspective).

Mainly I was arguing from.  
- Make the common case fast.
- The common case is write-back.
- AGP is not the common case.
- AGP has performance limitations.  

>From the kernel side, the caching attributes don't particularly matter
because physical aliasing is introduced, with the AGP aperture.  So
the cache coherency protocols cannot make our lives simpler.
 
> An Aperture Page can be made
> cache-coherent depending on the implementation
> and the AGP 3.0 spec provides an
> architectural way of specifying and controlling these as
> well.  But, by default the area is not made cache-coherent
> due to the performance loss and the lack of software to take
> advantage of it -- the two play off against each
> other. 

Cache coherency is tricky, so there is some argument there.
 
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

I hadn't thought of the snooping from the AGP side, but even then given
that the AGP aperture is a fixed region it would probably work to just
have a fixed snoop on the AGP region, and only do something when AGP
traffic comes in.  Though I will buy the argument it may not be
possible to do it at full performance unless the AGP card knows
something about cache coherency.  Though mostly I suspect it is a cost
tradeoff issue.

If the area is purely uncacheable, then writing to that area cannot go
at full memory speed.  So we should at the very least mark the region
as write-combining.  This should be get the cpu putting data in there
at about 1400MB/s with PC2100, and moving data there just short of
2100MB/s.  This doesn't help directly AGP performance, but it does
allow the cpu to spend it's cycles on more important things, much
sooner.

I don't believe there is a memory caching attribute that would get the
data copy from the AGP aperture sped up except write-back.  Which is
where I guess video capture comes in.

Eric



