Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293407AbSCKAaA>; Sun, 10 Mar 2002 19:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293409AbSCKA3s>; Sun, 10 Mar 2002 19:29:48 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:35844
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S293407AbSCKA3m>; Sun, 10 Mar 2002 19:29:42 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200203110032.g2B0WPx07017@www.hockin.org>
Subject: Re: [PATCH] syscall interface for cpu affinity
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 10 Mar 2002 16:32:25 -0800 (PST)
Cc: thockin@hockin.org (Tim Hockin), rml@tech9.net (Robert Love),
        aj@suse.de (Andreas Jaeger), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C8BF593.A5F5BE19@mandrakesoft.com> from "Jeff Garzik" at Mar 10, 2002 07:08:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If we are going to pick an affinity system, please, let's consider sysmp().
> 
> Not too bad.  I picked a random sysmp(2) man page off the net (attached
> for ease of other's reference).
 
so, there are actually two parts to sysmp().  The Way SGI used to it is
with Pset (MP_PSET to sysmp()).  They seem to have dropped exported support
for PSets - don't know why.  The idea is this.

At boot the system creates a PSet with ALL processors, and one set for each
single CPU.  Root can define extra sets with specified CPUs, too.
Processes can then run (commandline tool = 'runon') on a specific Pset.

runon 3 yes 	# runs on PSET #3

This is ok, but it has several drawbacks:
* user can not run on an arbitrary set of procs
* defining a set for every combination of procs is ludicrous

However, it has several upsides
* disabling a CPU is as simple as removing it from a pset struct, not
iterating over all tasks
* conceptually hides the 'bitmask of CPUs'

> It duplicates some stuff set elsewhere, and seems more than a bit like
> ioctl(2) by another name, but doesn't seem too bad.  Note we should be
> careful not to overengineer the interface, either...

At some point Ralf Baechle asked me to extend it more for IRIX
compatibility.  We may want to just drop that altogether.  Several of the
sysmp() interfaces can be handled at the library layer and re-routed to
their existing interfaces.

> Just setting a bitmask does seem a bit limiting when thinking about the
> future, agreed.

What is the future of the existing CPUs bitmask?  Is it becoming something
else? 

Perhaps we want to keep sysmp() in name and form, perhaps just in name,
perhaps not at all.  This is an area in which I have (had, but could get
again) a lot of interest, but before I waste any more time on it, I'd like
to actually co-design a feature set.

What do we want:
* unpriviliged ability to change current->pset?
	- any user can call sysmp(MP_RUNON) anytime
* privileged ability only (runon becomes suid)
	- can "trap" processes to a CPU - it has been requested a lot
* processor sets or just bitmasks/lists?
	- someone was working on memory sets, similarly to psets

If we really want this, I definately want to help. :)
Tim
