Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318254AbSHIM4t>; Fri, 9 Aug 2002 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSHIM4t>; Fri, 9 Aug 2002 08:56:49 -0400
Received: from fly.hiwaay.net ([208.147.154.56]:9993 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S318254AbSHIM4s>;
	Fri, 9 Aug 2002 08:56:48 -0400
Date: Fri, 9 Aug 2002 08:00:23 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020809080023.A518925@hiwaay.net>
References: <20020808222638.B296691@hiwaay.net> <200208090704.g7974Td55043@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208090704.g7974Td55043@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Fri, Aug 09, 2002 at 03:04:28AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Albert D. Cahalan <acahalan@cs.uml.edu> said:
> BTW, let's start with: not only "ps" is affected.
> Off the top of my head: netstat, fuser, top, pstree...

netstat: already wraps around and loses formatting when PIDs are shown
    (so no changes)
fuser: already has enough columns (because it uses "kernel" some places)
    (so no changes)
top: two line change
pstree: PIDs are displayed in "()" after process name (not formatted
    columns) (so no changes)

How many people actually _use_ PIDs on a regular basis?  When I did our
upgrade from Tru64 4.x to 5.x and got bigger PIDs, it took awhile before
anyone else even noticed.  Almost always when I'm doing something to
processes, I'm scripting it, not typing numbers.

> I almost put 99999, but then I realized that that's silly.
> For years Linux had a hard limit of about 4000 processes,
> and not many people complained. It sure would be nice to
> gain back a few of the columns lost to other stuff, so
> that people could once again see command arguments.

We're talking one or two more columns.  That's not going to magically
make it possible to see the command arguments.  If someone wants to see
the arguments, they're going to have to use "w" anyway (also, "normal"
ps with no arguments still has lots of space).

> The two real-word usage examples close at hand:
> 
> a. My full GNOME desktop has 48 processes.
> 
> b. The main UNIX shell server for CS students
>    at this university has 79 processes.
>    (Tru64, several hundred CS students, 2:25 am)

My GNOME desktop has 72 processes, and I've only got Mozilla and a
couple of xterms running right now.  My Tru64 server, with only 9 users
at 7:40 am, has 443 processes (during the business day we typically get
a lot more processes - we'll have 50-75 users logged in, lots of POP
checks running, and the usually at least once per day spam attack adding
a couple of hundred extra sendmail processes - that's when we hit 1000+
processes).

> The problem is screen space, pure and simple. If the
> default limit goes to over 1 billion, then "ps" output
> must wrap lines. There is no alternative, unless you
> think "System going down to reset PID numbers!" is OK.

Adding just one column (and going to 19 bits) allows 16 times as many
PIDs (or a sparse space 16 times as large).

> > $ ps -lf | head -2
> >        F S           UID    PID   PPID %CPU PRI  NI  RSS WCHAN    STARTED         TIME COMMAND
> > 80c08001 I           200 272363 301021  0.0  44   0 520K wait     20:47:46     0:00.09 -bash (bash)
> 
> Eeew. That's broken; it won't display right on a normal
> 80x24 terminal. Linux "ps -lf" will just barely fit.

Why does every possible output format of ps have to fit each process on
one line?  How often are these output formats used by normal people?

> > $ ps j | head -2
> > USER        PID   PPID   PGID   SESS JOBC S    TTY             TIME COMMAND
> > cmadams  272363 301021 272363 272363    0 I    pts/1        0:00.09 -bash (bash)

Note: one reason this one wrapped (instead of chopping the command) is
that Tru64 ps automatically displays everything (like lots of "w"
options) when output is not a TTY.

> It's not just "ps", and I'm not saying you couldn't
> adjust your system for a higher limit. I do think that
> the out-of-box default shouldn't screw up formatting.
> If you need to go past 9999, then you'll want to tweak
> a few other settings as well. Low process counts are
> the common case, and shouldn't be hurt by the fact that
> a few people wish to run a billion processes.

I'm not talking about a billion processes.  Also, are you going to make
all those other programs (well, "top" is the only one named above that
has to be changed) handle variable width PIDs now too?  That argument
cuts both ways.

I think setting things based on formatting of some modes of a couple of
programs that not that many users actually use is not the right way to
go.  We don't limit usernames to 8 characters anymore just because "ls"
truncates the name (not a kernel issue but the same concept).  If a
larger PID space works better for PID allocation, then go with a larger
PID space.

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
