Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRGEM7k>; Thu, 5 Jul 2001 08:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbRGEM7a>; Thu, 5 Jul 2001 08:59:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:10254 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265100AbRGEM7Q>; Thu, 5 Jul 2001 08:59:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Dan Maas" <dmaas@dcine.com>
Subject: Re: VM Requirement Document - v0.0
Date: Thu, 5 Jul 2001 15:02:51 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <fa.e66agbv.hn0u1v@ifi.uio.no> <002501c104f4$c40619b0$0701a8c0@morph>
In-Reply-To: <002501c104f4$c40619b0$0701a8c0@morph>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: <linux-kernel@vger.kernel.org>, Tom spaziani <digiphaze@deming-os.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
Message-Id: <0107051502510F.03760@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 July 2001 03:49, you wrote:
> > Getting the user's "interactive" programs loaded back
> > in afterwards is a separate, much more difficult problem
> > IMHO, but no doubt still has a reasonable solution.
>
> Possibly stupid suggestion... Maybe the interactive/GUI programs should
> wake up once in a while and touch a couple of their pages? Go too far with
> this and you'll just get in the way of performance, but I don't think it
> would hurt to have processes waking up every couple of minutes and touching
> glibc, libqt, libgtk, etc so they stay hot in memory... A very slow
> incremental "caress" of the address space could eliminate the
> "I-just-logged-in-this-morning-and-dammit-everything-has-been-paged-out"
> problem.

Personally, I'm in idea collection mode for that one.  First things first, 
from my point of view, our basic replacement policy seems to be broken.  The 
algorithms seem to be burning too much cpu and not doing enough useful work.  
Worse, they seem to have a nasty tendency to livelock themselves, i.e., get 
into situations where the mm is doing little other than scanning and 
transfering pages from list to list.  IMHO, if these things were fixed much 
of the 'interactive problem' would go away because reloading the working set 
for the mouse, for example, would just take a few milliseconds.  If not then 
we should take a good hard look at why the desktops have such poor working 
set granularity.

Furthermore, approaches that rely on applications touching what they believe 
to be their own working sets aren't going to work very well if the mm 
incorrectly processes the page reference information, or incorectly balances 
it against other things that might be going on, so lets be sure the basics 
are working properly.  Marcello has the right idea with his attention to 
better memory management statistical monitoring.  How nice it would be if he 
got together with the guy working on the tracing module...

That said, yes, it's good to think about hinting ideas, and maybe bless the 
idea of applications 'touching themselves' (yes, the allusion was 
intentional).

Here's an idea I just came up with while I was composing this... along the 
lines of using unused bandwidth for something that at least has a chance of 
being useful.  Suppose we come to the end of a period of activity, the 
general 'temperature' starts to drop and disks fall idle.  At this point we 
could consult a history of which currently running processes have been 
historically active and grow their working sets by reading in from disk.  
Otherwise, the memory and the disk bandwidth is just wasted, right?  This we 
can do inside the kernel and not require coders to mess up their apps with 
hints.  Of course, they should still take the time to reengineer them to 
reduce the cache footprint.

/me decides to stop spouting and write some code

--
Daniel
