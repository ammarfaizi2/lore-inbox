Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262273AbSJKB7N>; Thu, 10 Oct 2002 21:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262274AbSJKB7N>; Thu, 10 Oct 2002 21:59:13 -0400
Received: from netrealtor.ca ([216.209.85.42]:39946 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262273AbSJKB7M>;
	Thu, 10 Oct 2002 21:59:12 -0400
Date: Thu, 10 Oct 2002 22:04:49 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Robert Love <rml@tech9.net>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on O_STREAMING (goodby read pauses)
Message-ID: <20021011020449.GA19600@mark.mielke.cc>
References: <20021009222349.GA2353@werewolf.able.es> <1034203433.794.152.camel@phantasy> <20021010034057.GC8805@mark.mielke.cc> <20021010143927.GA2193@werewolf.able.es> <20021010180108.GB16962@mark.mielke.cc> <20021010225052.GE1676@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010225052.GE1676@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 12:50:52AM +0200, J.A. Magallon wrote:
> On 2002.10.10 Mark Mielke wrote:
> >I don't think this is right. Prove me wrong by explaining how kswapd works,
> >but if a page isn't dirty, there is no need to write it out to disk.
> You suppose it is a page of code ? What about data that programs malloc() ???
> You can also send data memory to swap. If you do not write it on disk,
> how do you recover it ???

Unless you are telling me that you have 1Gb of dirty pages in your
swap, it doesn't matter. The majority of the pages are not dirty, and
they are only in use because the 1Gb+ file was read from front to
back.

> >Clean read-only pages should *never* be written to swap. They can be re-read
> >from their source.
> That is your fault, <read-only>. Pages maped read-only are those from 
> binary executables or shared libraries, but, again, what about data ?

I shouldn't have said read only. The real qualifier is the 'clean' adjective.

It doesn't matter if a page is read-write or read-only, if the page
came directly from disk, and no modifications have been made to the
page, the page can safely be turfed and should _never_ be written to
swap.

> >I _think_ what you are seeing is that kswapd is not cleaning pages out
> >fast enough, which means that *other* tasks executing need to have their
> >*swapped out* pages *read* from disk. I.e. the churning you hear is probably
> >mostly reads - not writes.
> I look at gnome system monitor graph for mem. I start with a tiny amount of
> used memory. Start the 1Gb read without O_STREAM, the blue area in monitor
> starts to grow linearly in time, stars (*) from the reader appear at a
> given rate, and as soon as it touches the top limit the stars stop, the disk
> begins to thrash, and swap space used grows. After a 2-4 seconds, the stars
> go again with the same rate. Tell me what is this but swapper writing pages,
> and reading the new pages for my giga.
> With O_STREAM, the 'blue bar' does not move from its place, and star rate
> (ie, read rate from disk), stays uniform.

It sounds like your kernel is broken.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

