Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSHIOgP>; Fri, 9 Aug 2002 10:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSHIOgP>; Fri, 9 Aug 2002 10:36:15 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:50700 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S313087AbSHIOgO>;
	Fri, 9 Aug 2002 10:36:14 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208091439.g79Edte70468@saturn.cs.uml.edu>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: cmadams@hiwaay.net (Chris Adams)
Date: Fri, 9 Aug 2002 10:39:55 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20020809080023.A518925@hiwaay.net> from "Chris Adams" at Aug 09, 2002 08:00:23 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Adams writes:
> Once upon a time, Albert D. Cahalan <acahalan@cs.uml.edu> said:

>> BTW, let's start with: not only "ps" is affected.
>> Off the top of my head: netstat, fuser, top, pstree...
>
> netstat: already wraps around and loses formatting when PIDs are shown
>     (so no changes)

Sure, but no need to make it worse.

> fuser: already has enough columns (because it uses "kernel" some places)
>     (so no changes)
> top: two line change

Still this is screwing the common case for the truly unusual.

> pstree: PIDs are displayed in "()" after process name (not formatted
>     columns) (so no changes)
>
> How many people actually _use_ PIDs on a regular basis?  When I did our
> upgrade from Tru64 4.x to 5.x and got bigger PIDs, it took awhile before
> anyone else even noticed.  Almost always when I'm doing something to
> processes, I'm scripting it, not typing numbers.

I'm not counting Aunt Tillie.

Anybody on a terminal without cut-and-paste will suffer.

>> I almost put 99999, but then I realized that that's silly.
>> For years Linux had a hard limit of about 4000 processes,
>> and not many people complained. It sure would be nice to
>> gain back a few of the columns lost to other stuff, so
>> that people could once again see command arguments.
>
> We're talking one or two more columns.

It's as many as 25 character-columns. Linus was using
0x3fffffff as a mask. There are 5 field-columns with
PID data in the "ps j" format.

> That's not going to magically
> make it possible to see the command arguments.  If someone wants to see
> the arguments, they're going to have to use "w" anyway (also, "normal"
> ps with no arguments still has lots of space).

Huh? Try "ps -jf", which BTW has 4 PID columns. Also try "ps j".
I'm seeing arguments, and won't if PIDs get too wide.

>> The two real-word usage examples close at hand:
>> 
>> a. My full GNOME desktop has 48 processes.
>> 
>> b. The main UNIX shell server for CS students
>>    at this university has 79 processes.
>>    (Tru64, several hundred CS students, 2:25 am)
>
> My GNOME desktop has 72 processes, and I've only got Mozilla and a
> couple of xterms running right now.

Same as me, but I run Debian. Still, 72 is well below 9999.

> My Tru64 server, with only 9 users
> at 7:40 am, has 443 processes (during the business day we typically get
> a lot more processes - we'll have 50-75 users logged in, lots of POP
> checks running, and the usually at least once per day spam attack adding
> a couple of hundred extra sendmail processes - that's when we hit 1000+
> processes).

While I think this would fit under 9999, you're welcome
to adjust your system for any limit you like. I just don't
think the default should cater to systems that are both
rare and likely to have a real paid admin. It's your job to
increase the limit if you feel a need for more PID space.

>> The problem is screen space, pure and simple. If the
>> default limit goes to over 1 billion, then "ps" output
>> must wrap lines. There is no alternative, unless you
>> think "System going down to reset PID numbers!" is OK.
>
> Adding just one column (and going to 19 bits) allows 16
> times as many PIDs (or a sparse space 16 times as large).

Yes, and it trashes many common formats.

>>> $ ps -lf | head -2
>>>        F S           UID    PID   PPID %CPU PRI  NI  RSS WCHAN    STARTED         TIME COMMAND
>>> 80c08001 I           200 272363 301021  0.0  44   0 520K wait     20:47:46     0:00.09 -bash (bash)
>> 
>> Eeew. That's broken; it won't display right on a normal
>> 80x24 terminal. Linux "ps -lf" will just barely fit.
>
> Why does every possible output format of ps have to fit each process on
> one line?  How often are these output formats used by normal people?

How often are thousands of PIDs used by normal people?

>>> $ ps j | head -2
>>> USER        PID   PPID   PGID   SESS JOBC S    TTY             TIME COMMAND
>>> cmadams  272363 301021 272363 272363    0 I    pts/1        0:00.09 -bash (bash)
>
> Note: one reason this one wrapped (instead of chopping the command) is
> that Tru64 ps automatically displays everything (like lots of "w"
> options) when output is not a TTY.

It's either that or assume 80, unless you have a way to
get info from the controlling tty. I haven't looked into
that yet.

>> It's not just "ps", and I'm not saying you couldn't
>> adjust your system for a higher limit. I do think that
>> the out-of-box default shouldn't screw up formatting.
>> If you need to go past 9999, then you'll want to tweak
>> a few other settings as well. Low process counts are
>> the common case, and shouldn't be hurt by the fact that
>> a few people wish to run a billion processes.
>
> I'm not talking about a billion processes.

That's what Linus was testing with.

> Also, are you going to make
> all those other programs (well, "top" is the only one named above that
> has to be changed) handle variable width PIDs now too?  That argument
> cuts both ways.

Perhaps. You, with the odd case, can do without those programs.

> I think setting things based on formatting of some modes of a couple of
> programs that not that many users actually use is not the right way to
> go.  We don't limit usernames to 8 characters anymore just because "ls"
> truncates the name (not a kernel issue but the same concept).  If a
> larger PID space works better for PID allocation, then go with a larger
> PID space.

Arrrgh! That's a bug in ls, and yes you should limit usernames.
Think about:

Albert_Roberts
Albert_Robertson
Albert_Robbens

I think this is a much more popular problem than PID issues.
Lots of people with an NT background don't see why a long
username might cause problems. (names may be assigned by
corporate policy, and Linux admins must adapt) Maybe I could
do something about this if the default PID limit was 9999.
