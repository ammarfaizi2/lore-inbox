Return-Path: <linux-kernel-owner+w=401wt.eu-S1751029AbXAFAbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXAFAbz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbXAFAbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:31:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:6311 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbXAFAby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:31:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tUjXdfz6EGGd94r/LvTqBoRdoHRW/fkUgAtc9VTh5w2VSTRBSH2uo2MoOPpYrNR/S01V4IOBwtQ8wk2ZrKmxzsJIQBY+ig8z+qpBfGkKZ1nGYXJ9ist41Jzv9gumrfSdQQ/+mLbYZWOpKYqR2tfNl5KHABtuoWgM/Cg/K6QVt5c=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: open(O_DIRECT) on a tmpfs?
Date: Sat, 6 Jan 2007 01:30:13 +0100
User-Agent: KMail/1.8.2
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
References: <459CEA93.4000704@tls.msk.ru> <200701042317.02908.vda.linux@googlemail.com> <459E7AB3.8080802@tmr.com>
In-Reply-To: <459E7AB3.8080802@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701060130.13903.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 17:20, Bill Davidsen wrote:
> Denis Vlasenko wrote:
> > But O_DIRECT is _not_ about cache. At least I think it was not about
> > cache initially, it was more about DMAing data directly from/to
> > application address space to/from disks, saving memcpy's and double
> > allocations. Why do you think it has that special alignment requirements?
> > Are they cache related? Not at all!

> I'm not sure I can see how you find "don't use cache" not cache related. 
> Saving the resources needed for cache would seem to obviously leave them 
> for other processes.

I feel that word "direct" has nothing to do with caching (or lack thereof).
"Direct" means that I want to avoid extra allocations and memcpy:

	write(fd, hugebuf, 100*1024*1024);

Here application uses 100 megs for hugebuf, and if it is not sufficiently
aligned, even smartest kernel in this universe cannot DMA this data
to disk. No way. So it needs to allocate ANOTHER, aligned buffer,
memcpy the data (completely flushing L1 and L2 dcaches), and DMA it
from there. Thus we use twice as much RAM as we really need, and do
a lot of mostly pointless memory moves! And worse, application cannot
even detect it - it works, it's just slow and eats a lot of RAM and CPU.

That's where O_DIRECT helps. When app wants to avoid that, it opens fd
with O_DIRECT. App in effect says: "I *do* want to avoid extra shuffling,
because I will write huge amounts of data in big blocks."

> > But _conceptually_ "direct DMAing" and "do-not-cache-me"
> > are orthogonal, right?
>
> In the sense that you must do DMA or use cache, yes.

Let's say I implemented a heuristic in my cp command:
if source file is indeed a regular file and it is
larger than 128K, allocate aligned 128K buffer
and try to copy it using O_DIRECT i/o.

Then I use this "enhanced" cp command to copy a large directory
recursively, and then I run grep on that directory.

Can you explain why cp shouldn't cache the data it just wrote?
I *am* going to use it shortly thereafter!

> > That's why we also have bona fide fadvise and madvise
> > with FADV_DONTNEED/MADV_DONTNEED:
> >
> > http://www.die.net/doc/linux/man/man2/fadvise.2.html
> > http://www.die.net/doc/linux/man/man2/madvise.2.html
> >
> > _This_ is the proper way to say "do not cache me".
>
> But none of those advisories says how to cache or not, only what the 
> expected behavior will be. So FADV_NOREUSE does not control cache use, 
> it simply allows the system to make assumptions.

Exactly. If you don't need the data, Just let kernel know that.
When you use O_DIRECT, you are saying "I want direct DMA to disk without
extra copying". With fadvise(FADV_DONTNEED) you are saying
"do not expect access in the near future" == "do not try to optimize
for possible accesses in near future" == "do not cache"!.

Again: with O_DIRECT:

write(fd, hugebuf, 100*1024*1024);

kernel _has _difficulty_ caching these data, simply because
data isn't copied into kernel pages anyway, and if user will
continue to use hugebuf after write(), kernel simply cannot
cache that data - it _hasn't_ the data.

But if user will unmap the hugebuf? What then? Should kernel
forget that data in these pages is in effect a cached data from
the file being written to? Not necessarily.

Four years ago Linus wrote an email about it:

http://lkml.org/lkml/2002/5/11/58

btw, as an Oracle DBA on my day job, I completely agree
with Linus on the "deranged monkey" comparison in that mail...
--
vda
