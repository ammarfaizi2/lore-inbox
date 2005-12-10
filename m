Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVLJCQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVLJCQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVLJCQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:16:55 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33505
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751276AbVLJCQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:16:54 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Fri, 9 Dec 2005 18:22:40 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <87mzjf2gxs.fsf@mid.deneb.enyo.de> <20051206112127.GE10574@merlin.emma.line.org>
In-Reply-To: <20051206112127.GE10574@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091822.41278.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 05:21, Matthias Andree wrote:
> On Tue, 06 Dec 2005, Florian Weimer wrote:
> > From a vendor POV, the lack of official kernel.org advisories may be a
> > feature.  I find it rather disturbing, and I'm puzzled that the kernel
> > developer community doesn't view this a problem.  I know I'm alone,
>
> You're not alone in viewing this as a problem, but QA is a burden kernel
> developers are not interested in. But it is necessary.

If you want to run a big automated regression test against the kernel, 
exercising the full API and immediately catching any regressions, go right 
ahead.  Nobody's stopping you and you don't need our permission anyway.  The 
Linux Test Project is working on something like this already, and ODSL does 
some of this to.  (It's not like QA is being ignored.)

The problem is that the bulk of the kernel code is device drivers, and nobody 
has all the strange and esoteric hardware that the drivers push.  Nope, not 
even IBM.  I doubt any one organization anywhere on the planet has 
_everything_ the kernel has been used to drive.
.

> QA has to happen at all levels if it is supposed to be affordable or
> scalable. The development process was scaled up, but QA wasn't.
>
> How about the Signed-off-by: lines? Those people who pass on the changes
> also pass on the bugs, and they are responsible for the code - not only
> license-wise, but also quality-wise. That's the latest point where
> regression tests MUST happen.

I can't test your setup for you.  I haven't got your setup.  All I can tell 
you is that it worked for me.

I spent most of a week last month fighting to get User Mode Linux 2.6.15-rc1 
through rc4 to compile and run on both x86 ubuntu and x86-64 PLD.  Different 
versions of GCC compiled the darn interface code differently (there's a 
section where it switches stacks and gcc kept trying to touch the stack in 
the middle of this, and segfaulting).  Worked fine for Jeff Dike and 
Blaisorblade, because they weren't using a semi-obsolete version of ubuntu.

Over on PLD, I had a fight just to get it to _compile_, because the header 
files were all different (PLD uses Mazur's cleaned up 2.6 headers which 
uClibc systems also use, while most things use the glibc package, and at one 
point they had userspace and kernel space headers reversed and it worked fine 
with the glibc kernel headers but Mazur's headers really are cleaned up and 
don't leak nearly so much kernel stuff into userspace).  And then /lib wasn't 
a symlink to /lib64 (it is on Fedora and Debian, but on PLD they're separate 
directories) so the link path had to be adjusted (/lib64 was the correct 
directory for a 64-bit build and should be checked first).  Then getting it 
to run had another half-dozen problems with various interface code: for some 
reason on PLD page_size was linked as a function call when they expected it 
to be a constant...

Another fun little thing is just a performance issue: UML gets its "physical 
memory" from an mmap file (easy to share between processes), but if that file 
isn't on tmpfs then every page UML dirties gets scheduled for writeout, over 
and over again, keeping the hard drive constantly busy and slowing the system 
to a crawl.   Of course it _works_, but so it's hard to pin down what the 
problem is.  (UML isn't slowed down, the rest of the system is by the 
unnecessary I/O.)  Again, on Jeff's system /tmp is a tmpfs mount.  On most 
systems, /dev/shm is a tmpfs mount and /tmp inherits /.  (Meaning on knoppix 
it's tmpfs, but on Fedora or Ubuntu or Gentoo, it isn't by default.  Unless 
the sysadmin has changed it, which many sysadmins will.)  And strangely, on 
the PLD system I'm borrowing /dev/shm isn't tmpfs, so changing the default is 
the right thing but it needed an improved error message.

It all worked just _fine_ for the people who wrote it.  (And continues to.)  
And all of this is why there was an -rc1, so people like me could try it and 
report that it didn't work the same way for us and spend a week figuring out 
all the various different _ways_ it didn't work.

This isn't the full set of bugs I plowed through.  I had a version at one 
point that ran fine, gave me a command shell (init=/bin/sh) and I reported 
success and then came back the next day with "nope, fork segfaults".  
(Actually it was exec segfaulting.)  The shell _did_ come up fine.  (And echo 
$USER hadn't actually had to exec anything...)  But that wasn't the end of 
it.

The thing is, me spending all this time making sure it worked _for_me_ was 
something that I did on my own time, voluntarily.  I'm not really a UML 
developer, I have too much to do elsewhere.  If I hadn't done this, would it 
work on ubuntu and PLD right now?  Maybe.  I don't know.  But it already 
worked for Jeff Dike when he checked it in.  Worked just fine.  Because he 
didn't have the environment I had.  He could find _none_ of these problems 
because the bugs only manifest in an environment he doesn't have.

And all this is a _rounding_error_ compared to the kernel as a whole.  This is 
just one little corner of it, in one little release, where one person spent 
one week debugging on just two systems.

And this wasn't even hardware dependent!  (Or an intermittent problem that you 
_think_ is fixed because you haven't seen it, or something requiring a 
particularly arduous reproduction sequence like a 40 hour calculation, or 
access to a machine that's only available thursdays from 2-4 am...)

You seem to _deeply_ misunderstand nature of the problem.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
