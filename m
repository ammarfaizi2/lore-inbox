Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272343AbTHFUCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272355AbTHFUCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:02:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:24839 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S272343AbTHFUCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:02:17 -0400
Date: Wed, 6 Aug 2003 22:09:24 +0200
To: Timothy Miller <miller@techsource.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: Interactivity improvements
Message-ID: <20030806200924.GA5956@hh.idb.hist.no>
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051306.38180.kernel@kolivas.org> <3F2F21DF.1050601@cyberone.com.au> <3F314D6B.9090302@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F314D6B.9090302@techsource.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 02:48:11PM -0400, Timothy Miller wrote:
> Here's a kooky idea...
> 
> I'm not sure about this detail, but I would guess that the int 
> schedulers are trying to determine relatively stable priority values for 
> processes.  A process does not instantly come to its correct priority 
> level, because it gets there based on accumulation of behavioral patterns.
> 
> Well, it occurs to me that we could benefit from situations where 
> priority changes are underdamped.  The results would sometimes be an 
> oscillation in priority levels.  In the short term, a given process may 
> be given different amounts of CPU time when it is run, although in the 
> long term, it should average out.
>
Possibly a good idea...
 
> At the same time, certain tasks can only be judged correctly over the 
> long term, like X, for example.  Its long-term behavior is interactive, 
> but now and then, it will become a CPU hog, and we want to LET it.
>
Possibly, but getting this detection right isn't easy.  There
are many other cases where processes such as the compiler do
so much disk access that it is interactive for some time, but
we definitely don't want it to become a hog at interactive
priority - ever.

There are also those who think that if X ever has so much to do 
(usually not because of graphichs acceleration) then it had
better wait because the X user isn't the only one waiting anyway.
(I.e. the machine is also a web/db/login server
or some such - so other people are waiting as well.)

> The idea I'm proposing, however poorly formed, is that if we allow some 
> "excessive" oscillation early on in the life of a process, we may be 
> able to more quickly get processes to NEAR its correct priority, OR get 
> its CPU time over the course of three times being run for the 
> underdamped case to be about the same as it would be if we knew in 
> advance what the priority should be.  But in the underdamped case, the 
> priority would continue to oscillate up and down around the correct 
> level, because we are intentionally overshooting the mark each time we 
> adjust priority.

More oscillation in the start than later will behave as you describe,
wether we want that is another issue.  Processes _can_
change between being hogs and interactive, and we want the
scheduler to pick up that fact quickly.

Example: a word processor is mostly interactive.  Sometimes it
does a heavy job like typesetting an entire book though, this is cpu
intensive and should schedule as such even if the word processor
has been "interactive" for a week.  (I never close it, linux
is so stable...)  It should do its heavy work with low priority
so it don't interfere with the interactive work (or gameplaying)
I do while waiting for the .pdf to appear.
I definitely don't want a 5-minute
typesetting run to monopolize the cpu just because the task
has been sooo nice over the last week.

Helge Hafting
