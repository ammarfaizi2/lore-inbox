Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281237AbRKEQxa>; Mon, 5 Nov 2001 11:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281240AbRKEQxU>; Mon, 5 Nov 2001 11:53:20 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:53805 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S281237AbRKEQxH>; Mon, 5 Nov 2001 11:53:07 -0500
Message-Id: <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 05 Nov 2001 08:38:10 -0800
To: dalecki@evision.ag, "Albert D. Cahalan" <acahalan@cs.uml.edu>
From: Stephen Satchell <satch@concentric.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Cc: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
In-Reply-To: <3BE676AB.D777C9A0@evision-ventures.com>
In-Reply-To: <200111042213.fA4MDoI229389@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:23 PM 11/5/01 +0100, Martin Dalecki wrote:
>Every BASTARD out there telling the world, that parsing ASCII formatted
>files
>is easy should be punished to providing a BNF definition of it's syntax.
>Otherwise I won't trust him. Having a struct {} with a version field,
>indicating
>possible semantical changes wil always be easier faster more immune
>to errors to use in user level programs.

I would love for the people who write the code that generates the /proc 
info to be required to document the layout of the information.  The best 
place for that documentation is the source, and in English or other 
accepted human language, in a comment block.  Not in "header lines" or 
other such nonsense.  I don't need no stinkin' BNF, just a reasonable 
description of what each field is would suffice.  I would go so far as to 
say there needs to be a standard established in how /proc data is formatted 
so that we can create templates for the standard tools.

(I have to ask, have you ever used flex?  I used to hand-code scanners, but 
I find that flex is so much easier and generates smaller faster code than I 
can do by hand.  Changes are easy, too)

As for version fields:  I HATE THEM.  So much of my older code has bloat 
because of "version fields" that require that I have multiple blocks of 
code for the same damn thing.  POSIX code that has to determine which 
version of POSIX is implemented, and tailor the code at run-time to the 
whims of the OS gods.  BLOAT BLOAT BLOAT.  Besides, you already have a 
"version field", or is the release level of Linux too coarse for you?

As for easier:  EASIER FOR WHOM?  The sysadmin who is trying to figure out 
why his system is behaving in a strange manner?  You expect sysadmins to 
grow C compilers and header files in order to read /proc?  You can bet that 
my next point will require sysadmins to look at the hidden proc files 
sooner or later.  To wit:

The absolute worst part of this proposal is that it provides yet another 
for separate mechanism to do the same thing, and there is no clean way to 
use the ASCII /proc mechanism to generate the binary.  That inflates the 
opportunities for error by an unmanageable amount -- you will end up 
breaking BOTH methods of extracting information.  Which is more 
important:  getting the right information at the cost of a flex/bison 
scanner and some CPU time, or getting the WRONG information in the blink of 
the CPU's eye?  What happens when the ASCII version is broken and the 
binary version is right?  Who is going to take up the task of verifying 
that the ASCII and the binary match?

That version field thing:  you have to be willing to guarantee complete 
backward compatibility of your structures, so that you can only extend the 
structures, not manipulate already-defined fields.  In addition, you would 
need to define, for every single field, a value that indicates that no 
value is present.  This means that fields that are deprecated will still 
have a value, but the value that would be returned would be "no 
value"...and the applications that use your structures would have to know 
and understand and test for this not-a-value value and react appropriately.

One think I like about SNMP is that I can parse a MIB and probe for the 
information I need without worrying about versions.  It's there, I know its 
type, and I know what to expect in the way of values.  I'm also told when 
there is no value to report, either because the OS chooses not to return 
one, or because the state of the system says that returning a value is 
meaningless.  There is already a BNF definition of a MIB, too, which 
satisfies your other requirement.  New version?  New 
MIB.  Cross-checking?  Yes, I can be sure that the version of the MIB I'm 
using matches the version the system is using to generate the data.

Oh, the bloat thing:  why do you want to bloat the kernel even more than it 
is?  /proc is not cheap, and there have been times when I have been tempted 
to generate kernels without it.  Doubling up on the /proc filesystem may 
drive me to do it yet, and explore the wonders of sysctl.

I applaud the proponents of the idea for identifying a problem and 
proposing an interesting fix.  It's the wrong fix, but interesting anyway.

Stephen Satchell

