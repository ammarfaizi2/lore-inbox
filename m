Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269897AbRHTXsW>; Mon, 20 Aug 2001 19:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269905AbRHTXsL>; Mon, 20 Aug 2001 19:48:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:46085 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269897AbRHTXsI>; Mon, 20 Aug 2001 19:48:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Tue, 21 Aug 2001 01:54:53 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108201857400.538-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108201857400.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820234822Z16360-32383+599@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 21, 2001 12:05 am, Marcelo Tosatti wrote:
> On Tue, 21 Aug 2001, Daniel Phillips wrote:
> > On August 20, 2001 11:50 pm, Marcelo Tosatti wrote:
> > > On Tue, 21 Aug 2001, Daniel Phillips wrote:
> > 
> > > > If you've seen streaming IO pages getting evicted before being used,
> > > > I'd like to know about it because something is broken in that case.
> > > 
> > > I've seen the first page read by "swapin_readahead()" (which is the
> > > actual
> > > page we want to swapin) be evicted _before_ we could actually use it (so
> > > the read_swap_cache_async() call had to read the same page _again_ from
> > > disk).
> > 
> > is that even with yesterday's SetPageReferenced patch to do_swap_page?
> 
> No. It will not help: the call to read_swap_cache_async() is before the
> SetPageReferenced call.

Sure it will.  The readahead page will have to go all the way from one end of 
the inactive_dirty list to the other, then all the way down the 
inactive_clean list.  That should be plenty of time for the SetPageReferenced 
to catch it.  The main possibility to screw up is if we scan the inactive 
lists too fast, which probably happens sometimes because it's all grossly 
uncalibrated right now.

That's another issue, it needs fixing.  We'll never have really consistent, 
predictable aging or any other vm behaviour until the list scanning is 
operating in a rock-solid way.

As long as it isn't happening frequently we will be ok for now.

--
Daniel
