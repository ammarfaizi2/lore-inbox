Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274745AbRIUDPT>; Thu, 20 Sep 2001 23:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274670AbRIUDPK>; Thu, 20 Sep 2001 23:15:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22278 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S274669AbRIUDO7>; Thu, 20 Sep 2001 23:14:59 -0400
Date: Thu, 20 Sep 2001 23:10:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <9o2vct$889$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1010920225654.26679A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>,
> Rik van Riel  <riel@conectiva.com.br> wrote:
> >On 16 Sep 2001, Michael Rothwell wrote:
> >
> >> Is there a way to tell the VM to prune its cache? Or a way to limit
> >> the amount of cache it uses?
> >
> >Not yet, I'll make a quick hack for this when I get back next
> >week. It's pretty obvious now that the 2.4 kernel cannot get
> >enough information to select the right pages to evict from
> >memory.
> 
> Don't be stupid.
> 
> The desribed behaviour has nothing to do with limiting the cache or
> anything else "cannot get enough information", except for the fact that
> the kernel obviously cannot know what will happen in the future.

I think that's very harsh, because while the kernel can't predict the
future, in many cases the sysadmin can, and some of the tools used to act
on that information are not gone due to "enhancement." Most particularly,
the free pages are now not settable, leaving the admin to diddle with
*unrelated* things trying to get correct function, instead of setting the
free required and letting the kernel do a balance between buffes, cache,
etc. So if I know I have an application which will need 12MB suddenly to
maintain good response, I have lost my tool to just tell the system that
much free is needed. And honestly the fact that the kernel makes good
overall choices pales when the worst case is to blatently bad.
 
> The kernel _correctly_ swapped out tons of pages that weren't touched in
> a long long time. That's what you want to happen - the fact that they
> then all became active on logout is sad.

It reflects poor decisions in the kernel. To balance program and i/o pages
the kernel should track the i/o rate while increasing the cache used. When
the i/o rate stops getting better, the kernel should assume that the
program is not reusing the data pages at this time. Obviously this need
hysterisis to keep the program vs. data ratio from changing too fast after
some good initial setting, but having a file copy or CD rip push programs
out of memory shows that the kernel is not making optimal use of the
information it has.
 
> The fact that the "use-once" logic didn't kick in is the problem. It's
> hard to tell _why_ it didn't kick in, possibly because the MP3 player
> read small chunks of the pages (touching them multiple times). 
> 
> THAT is worth looking into. But blathering about "reverse mappings will
> help this" is just incredibly stupid. You seem to think that they are a
> panacea for all problems, ranging from MP3 playback to world peace and
> re-building the WTC.

Sorry, I think the problem is that the existing logic is just not working.
When you trade a small gain in overall performance for a really bad worst
case you are balancing a gain which is measured rather than felt with a
loss which is instantly painful.

Please rethink, the use-once is elegant, but it just doesn't work, and
until the kernel makes some effort to avoid paging out text for data when
it doesn't help performance you will have these ugly pauses. I will note
that we were doing just this type of balance of space in 1968 in GECOS (as
in the arcane GECOS password field).

Hopefully you will find this criticism constructive...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

