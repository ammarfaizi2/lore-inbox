Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTBXLCK>; Mon, 24 Feb 2003 06:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTBXLCK>; Mon, 24 Feb 2003 06:02:10 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:57874 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266868AbTBXLCH>;
	Mon, 24 Feb 2003 06:02:07 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200302241112.h1OBCBX273068@saturn.cs.uml.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
To: procps-list@redhat.com
Date: Mon, 24 Feb 2003 06:12:11 -0500 (EST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
       alexl@redhat.com, viro@math.psu.edu, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.44.0302241020010.20069-100000@localhost.localdomain> from "Ingo Molnar" at Feb 24, 2003 10:28:06 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> On Sun, 23 Feb 2003, Albert D. Cahalan wrote:

>> Surely you realize that I have seen this code?
>
> have you actually tried it?
>
>> Proper "ps m" behavior groups threads in the output. The hacked-up
>> procps being used by Red Hat fails to do this. You chould change that...
>> at the cost of reading all processes and sorting them. There goes all of
>> your performance improvement.
>
> Albert, the new code properly reads all threads and sorts them, in the
> "ps m" case. Had you truly read my emails you'd notice where the overhead
> lies, and what steps were taken to get rid of it.

I see that for default output, unpatched procps-2.x.xx is
forced to read and sort all tasks. Ignoring fault counts
and wchan for the moment, you made this work unnecessary by
adding some whole-process values. You also sped up /proc
directory operations in general, so not "all" I guess.

In the "ps m" and "ps -m" cases, you revert to the
"loose tasks" behavior. Neither "ps -L" nor "ps -T"
have been implemented. In some of these cases, the
threads should be grouped. Without subdirectories,
user code must do something bloated and slow to get
the grouping. (unless you care to guarantee the order
of tasks in a /proc directory listing, and relying on
such an ordering would prevent some other optimizations)

By grouping I mean something roughly like this:

PID TID
123 123
123 222
444 444
444 456

Not this:

PID TID
123 123
444 444
123 222
444 456

Header names and meanings may vary, etc. I'm not about to
dig out my notes regarding correct behavior for this email.

Anyway, to quote Linus:

----- begin -----
Well, part of the problem (I think) is that you added all the threads to 
the same main directory.

Putting a "." in front of the name doesn't fix the /proc level directory
scalability issues, it only means that you can avoid some of the user- 
level scalability ones.

So to offset that bad design, you then add other cruft, like the lookup
cursor and the "." marker. Which is not a bad idea in itself, but I claim
that if you'd made the directory structure saner you wouldn't have needed
it in the first place.

It would just be _so_ much nicer if the threads would show up as 
subdirectories ie /proc/<tgid>/<tid>/xxx. More scalable, more readable, 
and just generally more sane.
----- end -----

