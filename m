Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266550AbRGLXnX>; Thu, 12 Jul 2001 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbRGLXnN>; Thu, 12 Jul 2001 19:43:13 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24334 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266550AbRGLXnF>; Thu, 12 Jul 2001 19:43:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>, Dan Maas <dmaas@dcine.com>
Subject: Re: VM Requirement Document - v0.0
Date: Fri, 13 Jul 2001 01:46:54 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <002501c104f4/mnt/sendme701a8c0@morph> <20010709121736.B39@toy.ucw.cz>
In-Reply-To: <20010709121736.B39@toy.ucw.cz>
MIME-Version: 1.0
Message-Id: <0107130146540H.00409@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 July 2001 14:17, Pavel Machek wrote:
> > Possibly stupid suggestion... Maybe the interactive/GUI programs
> > should wake up once in a while and touch a couple of their pages?
> > Go too far with this and you'll just get in the way of performance,
> > but I don't think it would hurt to have processes waking up every
> > couple of minutes and touching glibc, libqt, libgtk, etc so they
> > stay hot in memory... A very slow incremental "caress" of the
> > address space could eliminate the
> > "I-just-logged-in-this-morning-and-dammit-everything-has-been-paged
> >-out" problem.
>
> Ugh... Ouch.... Ugly, indeed.
>
> What you might want to do is
>
> while true; do
> cat /usr/lib/libc* > /dev/null; sleep 1m
> cat /usr/lib/qt* > /dev/null; sleep 1m
> ...
> done
>
> running on your system...

90%+ of what you touch that way is likely to be outside your working 
set, and only the libraries get pre-loaded, not the application code or 
data.  An approach where the application 'touches itself' has more 
chance of producing a genuine improvement in response, but is that 
really what we want application programmers spending their time 
writing?  Not to mention the extra code bloat and maintainance overhead.

Maybe there are a some applications out there - perhaps a database that 
for some reason needs to minimize its latency - where the effort is 
worth it, but they're few and far between.  IMHO, only a generic 
facility in the operating system is going to result in anything that's 
worth the effort to implement it.

What would be needed is some kind of memory of swapped out process 
pages so that after one application terminates some pages of another, 
possibly idle process could be read back in.  Naturally, this would 
only be done if the system resources were otherwise unused.  This 
optimization in the same category as readahead - it serves to reduce 
latency - but it provides a benefit only in one specific circumstance.  
On the other hand, the place where it does improve things is highly 
visible, so I don't know, it might be worth trying some experiments 
here.  Not now though, a mature, well-understood vm system is a 
prerequisite.

Well, I just thought of one relatively simple thing that could be done 
in the desktop - redraw the screen after a big app exits and the system 
is otherwise idle.  That at least would page some bitmaps back in and 
touch some drawing methods.  The responsibility for detecting the 
relevant condition would lie with the OS and there would be some 
as-yet-undefined mechanism for notifying the desktop.

This is firmly in the flight-of-fancy category.  What would be real and 
worth doing right now is for some application developers to profile 
their wonderful creations and find out why they're touching so darn 
much memory.  Who hasn't seen their system go into a frenzy as the 
result of bringing up a simple configuration dialog in KDE?  Or 
right-clicking one of the window buttons in Gnome?  It's uncalled for, 
a little effort on that front would make the restart latency problem 
mostly go away.

--
Daniel
