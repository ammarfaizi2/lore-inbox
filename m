Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbSJ1JlB>; Mon, 28 Oct 2002 04:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSJ1JlB>; Mon, 28 Oct 2002 04:41:01 -0500
Received: from alcor.twinsun.com ([198.147.65.9]:20066 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id <S263232AbSJ1Jk7>;
	Mon, 28 Oct 2002 04:40:59 -0500
Date: Mon, 28 Oct 2002 01:47:09 -0800 (PST)
From: Paul Eggert <eggert@twinsun.com>
Message-Id: <200210280947.g9S9l9H01162@sic.twinsun.com>
To: andrew@pimlott.net
CC: linux-kernel@vger.kernel.org
In-reply-to: <20021027153651.GB26297@pimlott.net> (andrew@pimlott.net)
Subject: nanosecond file timestamp resolution in filesystems, GNU make, etc.
References: <20021027153651.GB26297@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 27 Oct 2002 10:36:51 -0500
> From: Andrew Pimlott <andrew@pimlott.net>
> 
> I thought I'd forward these in case you'd like to add anything.
> Andi Kleen is adding nanosecond timestamps to Linux (finally!), and
> I have some concerns about how his implementation might affect
> programs like make....

Thanks for mentioning this, as I don't normally read linux-kernel.
I'll add my comments below and CC: to linux-kernel.  Please reply to
me as well as to linux-kernel if you want me in on the thread.


> From: Andi Kleen (ak@suse.de)
> Date: Sun Oct 27 2002 - 02:01:25 EST

> When an inode is flushed on an old fs with only second resolution the 
> subsecond part is truncated. This has the drawback that an inode
> timestamp can jump backwards on reload as seen by user space.

I see this as a real flaw.  Several programs (and not just GNU make)
rely on file timestamps not being altered.  For example, GNU diff uses
file timestamps to decide whether two files might be the same file; if
their timestamps differ, then they must not be the same file.  If a
file's timestamp might snap back to the previous second, a
nanosecond-aware GNU diff will go astray.  Similarly, GNU tar uses
file timestamps to decide whether a file has changed and needs to be
dumped; if the file timestamp jumps back, a nanosecond-aware GNU tar
will erroneously decide that the file has changed and will dump it
unnecessarily.

> Another way would be to round on flush, but that also has some problems :-

Rounding is even worse.  GNU Make assumes truncation, i.e. it assumes
that a timestamp is truncated (floored, actually) when it is stored on
a non-nanosecond-aware filesystem.

> In my current patchkit I just chose to truncate because that was the 
> easiest and the other more complicated solutions didn't offer any 
> compeling advantage.

Can't you truncate/floor to filesystem timestamp resolution
immediately, i.e., before the inode is flushed?  That would address
the problems that I see.


> Date:	Sun, 27 Oct 2002 10:20:38 -0500
> From:	Andrew Pimlott <andrew@pimlott.net>

> Even the messages to the GNU make mailing list when Paul Eggert
> implemented nanosecond support didn't include a specific rationale.

Partly because it was there.  But also because it avoids some bugs
when "make" assumes that a file is up-to-date because its timestamp
equals some other file's timestamp.  E.g.:

   cp foo1.c foo.c
   make foo.o
   cp foo2.c foo.c
   make foo.o

This works only if timestamps have sufficient resolution.
Admittedly this small example is strained, but I hope you get the idea.
   

> I tend to prefer the proposal to set the nanosecond field to 10^9-1.

We used this trick in one place in GNU make (look for the comment in
remake.c that says "Avoid spurious rebuilds due to low resolution time
stamps") but it is an application-specific hack; I'm dubious that it
is a good idea in general-purpose filesystem code.

My personal experience is that it's hard to read and write code that
futzes with timestamps of various resolutions, and there is a real
advantage to sticking with a simple rule that always takes the floor
when going to a lower-precision timestamp, even if that rule has
suboptimal results in some cases.
