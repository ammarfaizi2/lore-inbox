Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288541AbSADIS0>; Fri, 4 Jan 2002 03:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288539AbSADISR>; Fri, 4 Jan 2002 03:18:17 -0500
Received: from codepoet.org ([166.70.14.212]:33551 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288538AbSADISB>;
	Fri, 4 Jan 2002 03:18:01 -0500
Date: Fri, 4 Jan 2002 01:18:02 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020104081802.GC5587@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020103190219.B27938@thyrsus.com> <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu> <20020103195207.A31252@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103195207.A31252@thyrsus.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 03, 2002 at 07:52:07PM -0500, Eric S. Raymond wrote:
> Alexander Viro <viro@math.psu.edu>:
> > It's more than just a name.
> > 	a) granularity.  Current "all or nothing" policy in procfs has
> > a lot of obvious problems.
> > 	b) tree layout policy (lack thereof, to be precise).
> > 	c) horribly bad layout of many, many files.  Any file exported by
> > kernel should be treated as user-visible API.  As it is, common mentality
> > is "it's a common dump; anything goes here".  Inconsistent across
> > architectures for no good reason, inconsistent across kernel versions,
> > just plain stupid, choke-full of buffer overruns...
> > 
> > Fixing these problems will _hurt_.  Badly.  We have to do it, but it
> > won't be fast and it certainly won't happen overnight.
> 
> I'm willing to work on this.  Is there anywhere I can go to read up on 
> current proposals before I start coding?

I once wrote up /dev/ps and /dev/mounts drivers to eliminate proc
for embedded systems (pointer available if you care).  It was not
warmly received, but I did form some opinions in the process.

The main things to think about are
    1) machine readability
	Generally speaking the kernel gods have decided that
	ASCII is good, binary structures and such are bad (think
	endiannes, nfs exports, and similar oddness).
    2) typing
	Right now, if some /proc file prints a number, user space
	has to go digging about in the kernel sources to find
	what type that thing is -- int, uint, long, long long, etc.
	Cant tell without digging in the source.  And what if
	someone then changes the type next week -- userspace
	then overflows.
    3) field length
	When coping a string from /proc (say /proc/mounts),
	userspace has to go digging in the kernel source to
	find the field length.  So if I copy things into a
	static buffer, I may be fine.  Till someone changes
	the kernel to print out a bit more stuff.  Then I've
	either got a buffer overflow (if I can't code) or a
	truncated string.  Either way, its a problem.

So what is needed is a kernelfs virtual filesystem that provides
kernel info to user space.

It needs a format that provides information as an organized
directory hierarchy, which each directory and filename
identifying the nature of the provided information.  Files should
provide information in ASCII with one value per file (to avoid
all the tedious parsing), but also provides along with that bit
of information type and or/length information.  

In some cases I guess we may also need more complex classes on
information.  (lists of key-value stuff for example).

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
