Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbUKVXTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUKVXTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUKVXRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:17:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19167 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261257AbUKVXNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:13:33 -0500
Date: Mon, 22 Nov 2004 16:15:21 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041122231521.GA5966@tesore.ph.cox.net>
Mail-Followup-To: Jesse Allen <the3dfxdude@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
	Daniel Jacobowitz <dan@debian.org>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Mike Hearn <mh@codeweavers.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
References: <20041119212327.GA8121@nevyn.them.org> <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net> <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de> <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 10:23:41PM -0800, Linus Torvalds wrote:
> 
> Ok, how about this patch?
> 
> It does basically two things:
> 
>  - it makes the x86 version of ptrace be a lot more careful about the TF 
>    bit in eflags, and in particular it never touches it _unless_ the 
>    tracer has explicitly asked for it (ie we set TF only when doing a
>    PTRACE_SINGESTEP, and we clear it only when it has been set by us, not 
>    if it has been set by the program itself).
> 
>    This patch also cleans up the codepaths by doing all the common stuff
>    in set_singlestep()/clear_singlestep().
> 
>  - It clarifies signal handling, and makes it clear that we always push 
>    the full eflags onto the signal stack, _except_ if the TF bit was set 
>    by an external ptrace user, in which case we hide it so that the tracee 
>    doesn't see it when it looks at its stack contents.
> 
>    It also adds a few comments, and makes it clear that the signal handler
>    itself is always set up with TF _clear_. But if we were single-stepped 
>    into it, we will have notified the debugger, so the debugger obviously 
>    can (and often will) decide to continue single-stepping.
> 
> IMHO, this is a nice cleanup, and it also means that I can actually debug 
> my "program from hell":
> 
> 	[torvalds@evo ~]$ gdb ./a.out 
> 	GNU gdb Red Hat Linux (6.1post-1.20040607.41rh)
> 	Copyright 2004 Free Software Foundation, Inc.
> 	GDB is free software, covered by the GNU General Public License, and you are
> 	welcome to change it and/or distribute copies of it under certain conditions.
> 	Type "show copying" to see the conditions.
> 	There is absolutely no warranty for GDB.  Type "show warranty" for details.
> 	This GDB was configured as "i386-redhat-linux-gnu"...(no debugging symbols 
> 	found)...Using host libthread_db library "/lib/tls/libthread_db.so.1".
> 
> 	(gdb) run
> 	Starting program: /home/torvalds/a.out 
> 	Reading symbols from shared object read from target memory...(no debugging 
> 	symbols found)...done.
> 	Loaded system supplied DSO at 0xffffe000
> 	(no debugging symbols found)...(no debugging symbols found)...
> 	Program received signal SIGTRAP, Trace/breakpoint trap.
> 	0x08048480 in main ()
> 	(gdb) signal SIGTRAP
> 	Continuing with signal SIGTRAP.
> 
> 	Program received signal SIGTRAP, Trace/breakpoint trap.
> 	0x08048487 in main ()
> 	(gdb) signal SIGTRAP
> 	Continuing with signal SIGTRAP.
> 
> 	Program received signal SIGTRAP, Trace/breakpoint trap.
> 	0x08048488 in smc ()
> 	(gdb) signal SIGTRAP
> 	Continuing with signal SIGTRAP.
> 	Copy protected: ok
> 
> 	Program exited with code 01.
> 	(gdb) 
> 
> which I think is a sign that this patch actually fixes ptrace.
> 
> Does this help with wine? I dunno. Maybe some wine people can comment..
> 


For the wine app in question, it does make a difference.  However, there is 
a new problem.  The program gets stuck at the loading screen at 100% CPU.
It's making a call to select, timing out, and then tries select again, 
repeats.  It's waiting for something that seems to never happen.

I've captured a log, "loop.log.bz2", and shortened to have only the relevent
information after the CMS32_MUTEX is created.  Look for occurances of
 "select()" -- I think the second one is where it starts.  It's on my ftp if 
anyone wants to take a look.  It probably can be compared to the working-
version log where this doesn't occur, but it might be a pain to spot the 
working particular instance.


Jesse
