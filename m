Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbSJJRz7>; Thu, 10 Oct 2002 13:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262050AbSJJRz7>; Thu, 10 Oct 2002 13:55:59 -0400
Received: from findaloan-online.cc ([216.209.85.42]:41993 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262034AbSJJRz6>;
	Thu, 10 Oct 2002 13:55:58 -0400
Date: Thu, 10 Oct 2002 14:01:08 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Robert Love <rml@tech9.net>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on O_STREAMING (goodby read pauses)
Message-ID: <20021010180108.GB16962@mark.mielke.cc>
References: <20021009222349.GA2353@werewolf.able.es> <1034203433.794.152.camel@phantasy> <20021010034057.GC8805@mark.mielke.cc> <20021010143927.GA2193@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010143927.GA2193@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 04:39:27PM +0200, J.A. Magallon wrote:
> On 2002.10.10 Mark Mielke wrote:
> >I assume the stall is not 'while pages are sent to disk', but rather
> >until kswapd gets around to freeing enough pages to allow memory to
> >fill again. The stall is due to the pages being fully analyzed to
> >determine which ones should go, and which ones shouldn't. O_STREAMING
> >removes the pages ahead of time, so no analysis is ever required.
> I can _hear_ the disk activity when the stall happens, so selecting what
> to drop is fast, but then you have to write it...

I don't think this is right. Prove me wrong by explaining how kswapd works,
but if a page isn't dirty, there is no need to write it out to disk.

My (perhaps incorrect) assumption is that kswapd prefers to swap on clean
pages over dirty pages. If your pages are mostly clean, there is nothing
to write to disk the clear majority of the time.

Clean read-only pages should *never* be written to swap. They can be re-read
from their source.

I _think_ what you are seeing is that kswapd is not cleaning pages out
fast enough, which means that *other* tasks executing need to have their
*swapped out* pages *read* from disk. I.e. the churning you hear is probably
mostly reads - not writes.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

