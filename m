Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTDGT2o (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTDGT2o (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:28:44 -0400
Received: from mail.casabyte.com ([209.63.254.226]:15364 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263610AbTDGT2k (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 15:28:40 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>,
       "Mark Mielke" <mark@mark.mielke.cc>
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Thomas Schlichter" <schlicht@rumms.uni-mannheim.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: An idea for prefetching swapped memory...
Date: Mon, 7 Apr 2003 12:39:21 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGKEIGCGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3E91C826.8000806@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DISCLAIMER: Without having actually looked at the code...

I would say that being able to mark a process or executable as a "should be
speculatively  reloaded" is... wait for it... a "very bad" idea.  It would
become far too easy for someone to configure a hugely anti-optimal system by
just flagging some giant pig-dog program as "favorable for residency" and
then have the system end up aggressively reloading parts of that program's
data set that aren't even being used.

Consider:  you flag Mozilla and the system starts aggressively loading the
composer and mail client (etc.) code while all you are doing is looking at a
help file.

Degenerate cases abound.

[These issues are, BTW, why the use of the "text sticky bit" pretty much
deprecated itself.]

On the other hand, presuming for the moment that the VM system works
something vaguely like the one in a Sun SVR4 system (because, remember, I
haven't read the code 8-).  That is, let's say there is a pointer traversing
along through memory that looks at each page and considers it for writing
out to swap.  And there is another pointer that cycles through memory behind
it and, if it hasn't been modified since the first pointer passed, it does
the write-to-swap and then puts the page on the reclaim-or-overwrite list.
When a process accesses a page, if it is normal then it is normal, if it is
on the reclaim-or-overwrite list it reclaims its page, if it isn't on the
list, the system takes the first page off the list and fills it with the
swapped-in contents.

Now lets change that list from a list to a priority queue....

It would be interesting to have the system keep track of page faults for
each process and then make a ratio of Page_Faults/Program_Size (or maybe
RSS?).  The smaller this number is the higher its pages are on the priority
queue.

Now, programs that are experiencing a large amount of paging (because they
are large and they are actively getting hit) will tend to have their pages
preserved on the reclaim/overwrite list.  That is, they are more likely to
be able to reclaim their pages instead of having to swap them in.

The nice parts:

- Small programs that are being intensely used tend to stay in memory
because of that use.  (e.g. actively grep(ing) a file, not a large data set
but the continuous use keeps its pages off the queue naturally.

- Large, inactive programs tend to leave memory quickly.

- Small, moderately inactive programs tend to profile competitively with
larger active more-active programs (so the large active programs don't
completely trample over their smaller kin.)

- New (just initiated) programs will tend to profile themselves quickly,
which will tend to let initialization time code and data subside gracefully.

- As system run state evolves (people and processes come and go) the
heuristic can keep up because the processes are only judged against one
another.

[ASIDE: The tracking might actually be better by "memory image" instead of
"process" so that multi-threaded code will compete based on the sum of their
threads activities...?]

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Chris Friesen
Sent: Monday, April 07, 2003 11:49 AM
To: Mark Mielke
Cc: Helge Hafting; Thomas Schlichter; linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...


Mark Mielke wrote:
> On Mon, Apr 07, 2003 at 10:19:25AM -0400, Chris Friesen wrote:

> Chris: Based on your usage patterns, how would Linux know that you were
> going to be opening up Mozilla, and not that you were going to tweak the
> kernel source and compile it again?

Because it would read my mind and figure out what I wanted!   ;-)

Maybe it would be possible to have some way to tell the kernel, "I would
prefer
this process to be in memory, unless you're running short, at which point
you
can swap it out."

This would be very similar to the niceness value, except it would control
what
memory gets swapped out.  You could tie it in to what processes have been
running, such that if the system goes idle you could start preferentially
swapping back in the processes with the memory niceness set.  If you left it
at
zero you get the current behaviour (not swapped in until needed) while
positive
(or negative, to align with niceness) values would swap that process in
preferentially when the system goes idle.

This would give similar benefits as mlock without actually robbing the
kernel of
the ability to swap out under memory pressure.

Does this sound at all useful, or am I blowing smoke?

Chris



--
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

