Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWBGKyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWBGKyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 05:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWBGKyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 05:54:33 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:36275 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964846AbWBGKyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 05:54:32 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: implement swap prefetching
Date: Tue, 7 Feb 2006 21:54:12 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
References: <200602071028.30721.kernel@kolivas.org> <200602071702.20233.kernel@kolivas.org> <43E8436F.2010909@yahoo.com.au>
In-Reply-To: <43E8436F.2010909@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602072154.13062.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 17:51, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Tue, 7 Feb 2006 04:00 pm, Nick Piggin wrote:
> >>Con Kolivas wrote:
> >>>On Tue, 7 Feb 2006 02:08 pm, Nick Piggin wrote:
> >>>>prefetch_get_page is doing funny things with zones and nodes /
> >>>> zonelists (eg. 'We don't prefetch into DMA' meaning something like
> >>>> 'this only works on i386 and x86-64').
> >>>
> >>>Hrm? It's just a generic thing to do; I'm not sure I follow why it's
> >>> i386 and x86-64 only. Every architecture has ZONE_NORMAL so it will
> >>> prefetch there.
> >>
> >>I don't think every architecture has ZONE_NORMAL.
> >
> > !ZONE_DMA they all have, no?
>
> Don't think so. IIRC ppc64 has only ZONE_DMA although may have picked up
> DMA32 now (/me boots the G5). 

/me looks around desperately for some hardware he has that Nick might not and 
sees only a VIC20 and decides this won't represent him very well in the 
underwear bulge stakes

Andrew I think I see why your G5 didn't see any benefit with swap prefetching.

> >>Workstations can have 2 or more dual core CPUs with multiple threads or
> >>NUMA these days. Desktops and laptops will probably eventually gain more
> >>cores and threads too.
> >
> > While I am aware of the hardware changes out there I still doubt the
> > scalability issues you're concerned about affect a desktop. The code cost
> > and complexity will increase substantially yet I'm not sure that will be
> > for any gain to the targetted users.
>
> Possibly. Why wouldn't you want swap prefetching on servers though?
> Especially on some kind of shell server, or other internet server
> where load could be really varied.

One of the users describing benefit from the current patch runs it on a 
multiuser X server where the time taken for login is substantially reduced 
after another user has logged out. The fact that the pages are back in ram, 
be it on the wrong numa node or not, far outweighs the speed disadvantage of 
reading from swap. I don't imagine that having per pgdat sets of 
swap_prefetch data is worth it. Once we've hit swap we really bugger it all 
up anyway. I'm not even sure what exactly you want swap prefetching to do 
here instead? I could make the accounting more numa aware but the accounting 
doesn't need to be remotely accurate, just conservative.

> >>What if you want to prefetch when there is slight activity going on
> >> though?
> >
> > I don't. I want this to not cost us anything during any activity.
>
> So if you have say some networking running (p2p or something), then it
> may not ever prefetch?

Where to draw the line could be debated to death. The difference between a p2p 
app running slowly in the background and a low bandwidth samba server would 
be indistinguishable. Avoiding swap prefetching with any activity is 
definitely going to do the least harm regardless of the workload.

> >>What if your pagecache has filled memory with useless stuff (which would
> >>appear to be the case with updatedb).
> >
> > There is no way the vm will ever be smart enough to say "this is crap,
> > throw it out and prefetch some good stuff", so it doesn't matter.
>
> It can do a lot better about throwing out updatedb type stuff.

Indeed some of the clock pro patches certainly seem to be heading that way. A 
pipe dream is to get some variant of those included and have clock pro 
swapped data to select the prefetched pages smarter than just 
most-recently-used. Clearly that can wait since even our VM doesn't have it 
yet.

> Actually I had thought the point of this was to page in stuff after the
> updatedb run, but it would appear that it won't do this because updatedb
> will leave the pagecache full...

The most common scenario where it does help is after running some memory 
intensive hog and then stopping the memory intensive work. Opening and 
closing openoffice is a beautiful example. Another real world one that hits 
me regularly is printing a high resolution picture needs heaps of ram but 
only for a short time.  After this time most everything else is swapped out. 
I find swap prefetching helps massively here. Some people's machines seem to 
swap easily just copying an ISO image or encoding a video.

> > I'm open to code suggestions and appreciate any outside help.
>
> Hopefully you have a bit to go on. 

I do and thank you for your comments.

> I still see difficult problems that 
> I'm not sure how can be solved.

Haha I seem to _only_ ever hack on things that you describe as having 
difficult problems :P

> >>If it is going to be off by default, why couldn't they
> >>echo 10 > /proc/sys/vm/swappiness rather than turning it on?
> >
> > Because we still swap no matter what the sysctl setting is, which makes
> > it even more useful in my opinion for those who aggressively set this
> > tunable.
>
> Sounds like we need to do more basic VM tuning as well.

That would be a given at any time in the past, present or future.

Cheers,
Con
