Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSEJBGu>; Thu, 9 May 2002 21:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315750AbSEJBGt>; Thu, 9 May 2002 21:06:49 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:45500 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315748AbSEJBGs>; Thu, 9 May 2002 21:06:48 -0400
Date: Fri, 10 May 2002 03:06:45 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020510030645.A2922@averell>
In-Reply-To: <3CD9E8A7.D524671D@zip.com.au> <5.1.0.14.2.20020509193347.02ff6dc8@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <m31yck9700.fsf@averell.firstfloor.org> <3CDB18CF.82DD6D6B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 02:48:15AM +0200, Andrew Morton wrote:
> Andi Kleen wrote:
> > 
> > Andrew Morton <akpm@zip.com.au> writes:
> > 
> > > For bulk read() and write() I/O the best sized buffer is 8 kbytes.  4k is
> > > pretty good, too.  Anything larger blows the user-side buffer out of L1.
> > > This is for x86.
> > 
> > Modern x86 support prefetch hints for the CPU to tell it to not
> > pollute the caches with "streaming data". I bet using them would
> > be a big win.
> 
> Maybe.  For your basic:
> 
> 	for (many) {
> 		read(fd1, buf, 8192);
> 		write(fd2, buf, 8192);
> 	}
> 
> you want `buf' cached, but not the pagecache for fd1 and fd2.
> If the prefetch hints can express that then yes, nice.

SSE has prefetchnta

3dnow has something similar.

In addition you can use movnti* for stores. These should be faster
because they use write combining and avoid the latency of fetching
the cache line of the destination just to overwrite it.

The tricky bit is to avoid prefetches over the boundary of your copy.
Prefetching from an uncached area or write combined area (like the 
AGP gart which could start in next page) triggers hardware bugs in
various boxes. This unfortunately complicates the prefetching loops
a bit.

> 
> > The rep ; movsl loop used in copy*user isn't
> > very good on modern x86 anyways (it is ok on PPro, but loses on Athlon
> > and P4)
> 
> On PII and PIII, rep;movsl is slower than an open-coded
> duff-device copy for all src/dest alignments except for
> the case where both are eight-byte-aligned.  By up to
> 20%, iirc.  four-byte-aligned to four-byte-aligned isn't
> too bad.

That's surprising. AFAIK on PPro rep ; movs does magic prefetch
tricks in microcode, so it should be eventually faster if you do
not use explicit prefetching and you're not cache hot for 
bigger copies (in smaller ones the setup overhead may dominate)

On Athlon rep ; movs loses clearly compared to an unrolled loop.

-Andi
