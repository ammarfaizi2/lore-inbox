Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290775AbSARSQ5>; Fri, 18 Jan 2002 13:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290774AbSARSQi>; Fri, 18 Jan 2002 13:16:38 -0500
Received: from [208.251.209.245] ([208.251.209.245]:20470 "EHLO
	y2k.freesoft.org") by vger.kernel.org with ESMTP id <S290775AbSARSQ2>;
	Fri, 18 Jan 2002 13:16:28 -0500
From: baccala@freesoft.org
Date: Fri, 18 Jan 2002 13:12:59 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: new virtualization syscall to improve uml performance?
Message-ID: <Pine.LNX.4.44.0201181312150.1000-100000@y2k.freesoft.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------- Forwarded message ----------
Date: Fri, 18 Jan 2002 13:08:29 -0500 (EST)
From: baccala@freesoft.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.rutgers.edu
Subject: new virtualization syscall to improve uml performance?

Hi -

First, kudos to everyone who worked on user mode linux.  I need to
build distribution RPMs for a couple of pieces of free software I help
maintain, and have this absurd dilemma about running recent RedHat
releases (to get the latest code) or running older releases (to
compile RPMs that will install on both older and newer systems).  I've
been trying to accommodate both needs by selectively picking and
choosing older and newer RPMs to install on my system, and the result
is a mess that won't compile anything!  Anyway, I installed UML with
the distributed RedHat 6.2 filesystem, fired it up, installed a few
missing RPMs like make, and the software built fine.  I think I've
solved my dilemma...

Anyway, I was reading about the design of UML, and it seems to me that
its performance could be improved by adding a split privilege concept
to Linux processes.  A "normal" process would be "privileged".
However, to support things like UML, a new syscall could put the
process into "unprivileged" mode, which would cause any traps or
faults (like syscalls or SEGVs) to drop the process into "privileged"
mode at a controlled entry point.  Adding an extra bit to the
mmap/mprotect protection flags could specify memory mappings only
accessible from privileged mode.  Then, instead of all this hacking
around with ptrace, we just put all the UML processes into
unprivileged mode and trap their syscalls into their own addressing
space.  Thus, this sequence (which seems pretty common for UML):

        syscall trap -> process switch -> ptrace -> process switch
            -> getpid executes -> process switch -> ptrace -> process switch

would be replaced with:

	syscall trap

Would this be just more kernel bloat to support one application?
Perhaps not.  I have other utilities (a user-space HTTP file system,
and code to do Plan 9-ish directory overlays) that need to intercept
system calls.  I currently do this using the LD_PRELOAD function of
the shared library.  This has the following disadvantages:

	1. a specially compiled glibc must be installed, because
	   the standard one doesn't export all the needed symbols,
	2. newer versions of the OS/glibc cause problems if they
	   introduce new syscalls (like open64) that don't get
	   caught until you add more code just for them, and
	3. it's impossible to have any security, because the user
	   code could just bypass glibc and make the syscalls directly

UML has made me reconsider my approach.  If I get around to it, I'll
steal some of your code and try using a ptrace handler thread to catch
the system calls instead.

Since I now know of two completely different pieces of code that could
be dramatically improved by adding user-process-level virtualization
to the kernel, it might be something to consider.  I spent some time
in college working at an IBM VM shop, and am convinced that
virtualization is a good_thing(tm).  Until now, I had been thinking
that the only real way to do it was through hardware processor
support, that the broken Intel architecture just can't handle it, and
that made hacks like VMware/plex86 necessary.  I'm starting to
reconsider that.  Maybe you can add some basic virtualization support
to the process model and win something.  No, you can't completely
mimic a standalone processor, but if you can add some specialized
support to your slave kernel/OS/syscall handler/whatever, then you've
got the ability to run a virtualized Linux, or to intercept and replug
your system calls.

Anyway, I don't read mailing lists much (sorry), so I apologize if
this has already been discussed before.  In the case, maybe you could
direct me to a URL where the email is archived.  If not, I welcome
your comments...


                                        -bwb
                                        Brent Baccala
                                        baccala@freesoft.org
==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
    mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================


