Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTLKAvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 19:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTLKAvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 19:51:23 -0500
Received: from [195.255.196.126] ([195.255.196.126]:16836 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S264270AbTLKAvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 19:51:18 -0500
Date: Thu, 11 Dec 2003 02:50:20 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Driver API (was Re: Linux GPL and binary module exception clause?)
In-Reply-To: <Pine.LNX.4.58.0312101108150.29676@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
 <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100959180.29676@home.osdl.org> <20031210180822.GI6896@work.bitmover.com>
 <Pine.LNX.4.58.0312101016010.29676@home.osdl.org> <20031210183833.GJ6896@work.bitmover.com>
 <Pine.LNX.4.58.0312101108150.29676@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Linus Torvalds wrote:

> I'd like to make it clear that I'm actually much softer on this than many
> other people - I've been making it clear that I think that binary-only
> modules _are_ ok, but that the burden of proof of ok'ness is squarely on
> the shoulders of the company that makes them.
Ok. That makes perfect sense.

It would be fair to have an official list of kernel services that are 100%
OK for use by binary-only device drivers (or kernel modules in general).
If anybody needs to use a service outside this list they know they may be
on thin ice. What I'm proposing into this kind of list are the basic
services needed to implement a character device driver (driver entry
points, kmalloc/vmalloc, mutex and sleep primitives, device I/O, userspace
access and few others). These all are primitives that can be found from
any "generic" kernel programming text book. Also they are available in
every operating system I have been worked with. So it would be very hard
to argue that using them could make aything "derived work".
I don't use anything but the charcater device interface so I can't say if
there is anything else that could/should be listed.

Even better would be a proper device driver ABI for "loosely integrated"
device drivers. It's possible to hide differences between kernel releases
so that the same driver can work with wide range of kernel versions).
There are some performance penalties but they are not significant. And the
drivers included in the kernel source tree don't need to use this
interface so I don't see there any _technical_ reasons against this idea.
I can volunteer to implement this interface if it's OK. Some motivation
for the ABI as well as some technical ideas will be at the end of this
message.

I don't make any statement about the correctness of the "derived work"
issue. However I think it's at least fair to avoid using kernel internals
in a way kernel developers don't like. It would be best for the future of
Linux that there is some agreement about this issue.

Developing software under GPL is everybody's right but not responsibility.
In distant future it may happen that all software gets distributed under
GPL or a similar license. However before that moment there will always be
some kind of gray zone between the open source and the closed source
worlds. And for various reasons somebody must live on the "right" side.
For example in my case we can't GPL our product for reasons that are beyond
our control (for example large parts of the source code are licensed from
hardware manufacturers and other companies under NDA). So I don't see it
fair that some developers think they have the right to enforce everybody
else to work under GPL.

-----
Why a driver ABI is required?

The reason wy I propose the driver ABI is that the current LKM mechanism
is quite unacceptable. It was fairly good sometimes around 1.2.x and
2.0.0 days but for some reason things have gotten worse and worse after
that. We  have learned to live with it. It just causes some waste of time
that could otherwise be spent on something productive. However for many
companies without prior LKM experience it's a big challenge.

Today there are 50-100 different kernel images released by numerous Linux
distribution vendors. In most Linux systems there are no development tools
installed so it's "impossible" to install any kernel modules from the
sources.  This is true also with "pure GPL" modules. To be able to compile
the module the user needs to install first the kernel sources, gcc,
binutils and make (if they have that much of free disk space left). After
figuring out what and how to install he also needs to figure out how to
configure the kernel (headers) in the right way. This is not something an
average Linux user can do. Many of them don't even know how to get to the
command line. For this reason companies making kernel modules must
distribute a precompiled module for each of the 50-100 different
distribution kernel images that are in active use (or a subset of them).
The number is very large because many distribution vendors release 2 to 8
different kernel images (SMP/UP, athlon/PIII/P4/etc) every time. And this
must be done also if the driver sources are under GPL.

There is not a problem if the module is compiled by the maintainer of
the distribution or if the user has compiled his kernel himself. However
it's impossible idea that drivers for every possible device could be
included in the kernel source tree or in some other way be compiled by the
distribution vendor. It can happen with devices that are in "mass"
production. However the world is full of other devices that are
interesting to about 0.0001% of all Linux users.

In the current way it's pretty impossible to produce Linux drivers (even
under GPL) because installing it would be too demanding. Things would be
much easier if the same driver image works with most (or every) kernels.
Another approach would be having the development tools and the properly
configured kernel sources included in the minimum configurations of each
Linux distribution but I would call this massive overkill.

Yet another problem is that there is no way to know which symbols are
only for kernel internal use and which ones can be safely used in some
drivers. Some routines change between kernel versions which often makes
drivers uncompilable. It's not difficult to find examples of this from
the net. Many companies have released Linux drivers for their hardware
but have then forgotten them. The result is that the driver sources are
available from the manufacturer but they don't compile any more. It's
usually difficult to fix them because they use unknown kernel routines
that have not been in the kernel since year 0. Having a stable driver
API or ABI very much eliminates this problem.

I understand that many of the kernel team members are against any kind of
non-GPL kernel space code. But I can't understand how making it difficult
to use it could make Linux better as an operating system. OTOH making it
easier to use binary only modules will also make it easier to use GPL
modules too.

Technical stuff
---------------

It's not true that kernel space code cannot be compiled without using the
kernel headers. OSS (Open Sound System) has for some time been compiled
against the standard (libc) headers. Just one of the source files contains
all the kernel dependent stuff and gets compiled against the kernel
headers. The reason is not trying to avoid any GPL issues. This is just
the only way to do that because otherwise the whole driver has to be
recompiled separately for each possible kernel (OK, it would have to be
shipped with sources too). We compile it against the libc headers to make
sure that no kernel inline code gets accidently called (which would cause
serious incompatibility problems). Also it's easier to set up the
compiling environment in this way (kernel headers often contain headers
that conflict with some other headers). The system headers are
required just because they contain values for some important constants.

The remaining "wrapper" module needs to be compiled against the right
kernel headers. It's kind of kernel ABI module. Instead of being a part
of the kernel it's part of our product (which is not the right place).

In it's current form the wrapper contains just wrappers around some
fundamental kernel routines and methods to access the required
fields of some kernel structures. The "client" driver sees the kernel
structures as some kind of cookies. It needs to call the right method to
read/write a field in this structure.

This kind of "1:1" wrapper is actually rather silly mechanism but it's
easy to implement. I'm currently re-designing the wrapper so that it
provides higher level of abstraction. In this way there is less overhead
because fewer calls need to be done between the wrapper and the client
driver. This wrapper will be released under LGPL (or GPL) so it will be
available for use by everybody who needs it. It can also be included in
the kernel sources.

Implementing drivers on top of this kind of wrapper causes some
performance impact. However it's not an issue. Many drivers actually
make other kernel calls rather infrequently so usually there is no inpact
at all. Most of time they spend by doing register I/O and things like
that. HW access can be done with the usual kernel inline routines without
any risk. Or the inline functions can be implemented inside the driver.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
