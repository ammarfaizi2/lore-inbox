Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSHIHA5>; Fri, 9 Aug 2002 03:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318177AbSHIHA5>; Fri, 9 Aug 2002 03:00:57 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:4103 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318176AbSHIHA4>;
	Fri, 9 Aug 2002 03:00:56 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208090704.g7974Td55043@saturn.cs.uml.edu>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: cmadams@hiwaay.net (Chris Adams)
Date: Fri, 9 Aug 2002 03:04:28 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020808222638.B296691@hiwaay.net> from "Chris Adams" at Aug 08, 2002 10:26:38 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Adams writes:
> Once upon a time, Albert D. Cahalan <acahalan@cs.uml.edu> said:

>> Mind sharing what "ps -fj", "ps -lf", and "ps j" look like?
>> The standard tty is 80x24 BTW, and we already have serious
>> problems due to ever-expanding tty names.
>>
>> How about a default limit of 9999, to be adjusted by
>> sysctl as needed?
>
> I hope you meant 99999 (since we already have 5 digit PIDs).  It would
> also seem to me that if it is adjustable, then "ps" would have to handle
> it anyway, and making "ps" deal with adjustable size PIDs would be more
> complex and error-prone.

BTW, let's start with: not only "ps" is affected.
Off the top of my head: netstat, fuser, top, pstree...

I almost put 99999, but then I realized that that's silly.
For years Linux had a hard limit of about 4000 processes,
and not many people complained. It sure would be nice to
gain back a few of the columns lost to other stuff, so
that people could once again see command arguments.

The two real-word usage examples close at hand:

a. My full GNOME desktop has 48 processes.

b. The main UNIX shell server for CS students
   at this university has 79 processes.
   (Tru64, several hundred CS students, 2:25 am)

For "ps", adjustable width is a trivial addition.
Notice the UID ("ps -l", "ps -lf) handling, and
notice what signals ("ps s") do on a wide screen.
I could also just let the output be ugly, since
no normal system will have so many processes.

The problem is screen space, pure and simple. If the
default limit goes to over 1 billion, then "ps" output
must wrap lines. There is no alternative, unless you
think "System going down to reset PID numbers!" is OK.

> Tru64 Unix 5.x uses 19 bit pids (up to 524288, so up to six digits - the
> rest of the 32 bits go for cluster node, node sequence, and an unused
> sign bit) without significant problems.  Their "ps" args aren't an exact
> match, but they're close (lots of processes snipped):
> 
> $ ps -fj | head -2
> UID         PID   PPID    C STIME    TTY             TIME CMD
> cmadams  272363 301021  0.0 20:47:46 pts/1        0:00.09 -bash (bash)

Linux (and all SysV if I remember right) has 4 columns
of PID info that would need to expand:

UID        PID  PPID  PGID   SID  C STIME TTY          TIME CMD
albert   12975 12966 12975 12975  0 Aug02 pts/1    00:00:00 bash

> $ ps -lf | head -2
>        F S           UID    PID   PPID %CPU PRI  NI  RSS WCHAN    STARTED         TIME COMMAND
> 80c08001 I           200 272363 301021  0.0  44   0 520K wait     20:47:46     0:00.09 -bash (bash)

Eeew. That's broken; it won't display right on a normal
80x24 terminal. Linux "ps -lf" will just barely fit.

> $ ps j | head -2
> USER        PID   PPID   PGID   SESS JOBC S    TTY             TIME COMMAND
> cmadams  272363 301021 272363 272363    0 I    pts/1        0:00.09 -bash (bash)

For historic reasons, Linux has a whopping 5 columns
of PID info for this format:

 PPID   PID  PGID   SID TTY      TPGID STAT   UID   TIME COMMAND
    1   770   770   770 tty1     12893 S     1000   0:00 -bash
  770 12893 12893   770 tty1     12893 S     1000   0:00 /bin/sh /usr/bin/X11/st

> I routinely have 1000+ processes running on this server (many of them
> short-lived things like POP checks, short CGIs, sendmail background
> delivery, etc.), so having a larger PID space is important (having the
> same PID reused within 15-30 seconds would be annoying).

Increase the limit on this server if you wish. Problem?
I only suggest 9999 as the default. (which would actually
be just enough for you)

> I would like to see Linux running on this server (or at least this class
> of server), and limiting the number of PIDs because of "ps" formatting
> is not the way to go.

It's not just "ps", and I'm not saying you couldn't
adjust your system for a higher limit. I do think that
the out-of-box default shouldn't screw up formatting.
If you need to go past 9999, then you'll want to tweak
a few other settings as well. Low process counts are
the common case, and shouldn't be hurt by the fact that
a few people wish to run a billion processes.

