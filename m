Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVAWGMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVAWGMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 01:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVAWGMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 01:12:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23596
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261231AbVAWGLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 01:11:55 -0500
Date: Sun, 23 Jan 2005 07:11:54 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Valdis.Kletnieks@vt.edu
Cc: Rik van Riel <riel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050123061154.GN7587@dualathlon.random>
References: <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz> <20050122172542.GF7587@dualathlon.random> <20050122194242.GB21719@elf.ucw.cz> <20050122233418.GH7587@dualathlon.random> <Pine.LNX.4.61.0501221943050.7152@chimarrao.boston.redhat.com> <20050123005213.GK7587@dualathlon.random> <200501230443.j0N4h6DA023479@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501230443.j0N4h6DA023479@turing-police.cc.vt.edu>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 11:43:06PM -0500, Valdis.Kletnieks@vt.edu wrote:
> It's a poor idea to confuse "secure" with "can't break out of the sandbox".

The only point I'm making with seccomp, is that if it can't break out of
the sandbox it's secure. I didn't mean that the only way to make it
secure is to put it in the sandbox of course.

> And they don't even depend on seccomp or ptrace for the security either...

Indeed.

> Security people probably won't be interested, specifically because it's
> way too inflexible.  Very few real-life applications can be made to fit
> into a "open all the files you might need, then shut yourself into a 
> read/write syscalls only" model.

This exactly correct. Recycled matter is of lower quality. Not
everything is going to be printed on recycled paper, your vacation
photos cannot be printed with recyled paper. But a few may actually
appreciate recycled paper at a much cheaper price for a extremely tiny
niche of apps. It'll be a mess to be able to use it the first time, but
after they start using it they'll get a ton of it very cheap and it
might work as good as first quality paper for them. Perhaps somebody not
buying paper because was too expensive, may also start buying the
recyled paper because it gets affordable (yeah after the initial
dealing with the recycled matter conversion).

> In fact, a case could be made that the unnatural contortions needed to
> restructure applications into a seccomp model actually *decrease* the
> overall security, because of more complicated setup code being more
> vulnerable to attack.  Also, the fact that you need to keep open() out

All setup code before the execve of the loader (and the loader is few
lines of C only) is not in C/C++, which means first of all no buffer
overflows. It's a quite small piece of code as well. Sure there can be
still a bug there, but clearly somehow a software must exists to start
the seccomp mode. But this software won't be the binfmt_elf.c and it
will not be written in C (which is also why using ptrace is way
annoying, since it'd require more C code), it'll be small, and it will
be written with security in mind. I've already uploaded that software in
the website if you want to check it (ignore the gui part, it's obsolete).

Just the fact it's not in C rules out 90% of possible exploits.

> of the permitted set for seccomp to make any sense means that you need to
> open all the possible files up front.  So now you're handing the program
> *more* access to files than they should....

They're not files, they're pipes. There are only two open, fd 0 and fd 1
and no data emitted and recevied by those two pipes is being
computed outside seccomp. It's like if you push .mpeg data into fd 0 and
you read from fd 1 and you write it in the framebuffer. Even if
something goes wrong into the library, as worse you'll see garbage on
the screen.

I don't think a model like this can decrease security.

The last YOU update I did, fetched an update of some decoding library,
now if it was running under seccomp it couldn't do any damage. The same
is true for the zlib trouble some time ago.

I'm not suggesting everything should run inside seccomp, and of course
such an update would be happening anyway since not every app will run
under seccomp, but certainly if you've a _special_ critical app that you
don't want to risk to be exploited by a libz bug, then seccomp may help
and it's going to be a lot more handy to use than ptrace.

> Oh, come *ON*, Andrea.  This is a red herring and you *know* it.  The only
> people who will be hardcoding syscall numbers are the same idiots that
> hardcoded capability masks instead of "#include <linux/capability.h>" and
> using the CAP_* defines.

I didn't mean hardcoding in terms of numbers, I mean in terms of
__NR_read. Just read the 32bit emulation code, I had to use ifdef
TIF_IA32, that's the best I could do, and I doubt you would be able to
write much cleaner code in userland either.

> And if a filename has a runtime dependency on the untrusted data (consider
> any sort of web server or browser or mail program or anything else that
> accepts a "suggested filename" as input), things get very difficult very quickly.
> 
> I can pass ptrace a SYSCALL_OPEN, and then call my untrusted code, and then
> look at the filename at runtime and see if there's something hinky going on.
> I can even apply heuristics like "The first file opened should be THIS one,
> then THOSE 4 shared libraries in order, then THIS file, and then the NEXT file
> is dependent on user input, but has to start with $USER/tmp/workdir, and then
> there's two other opens of files X and Y, and then no others should happen".
> Using seccomp, you don't get that choice.  You either have to jump through
> hoops to get all that set up beforehand, or allow open() in all its glory.

I don't get what you mean here. Anyway the filedescriptors inside
seccomp are never going to be files, and there will be only two. I can
add some documentation if it gets merged.

But the point you're making that nobody is going to use seccomp except
me may very well be right, I'm not trying to disagree with that. I never
stated that others will certainly use it. I only said "...there's a
chance that...". So you may be very well right that nobody else will use
it ever.

We can backout seccomp 3 years in the future if I don't even need it
anymore myself. Stuff gets backed out all the time if nobody uses it and
seccomp is trivial to backout by grepping for the word seccomp.

Thanks for your feedback!
