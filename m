Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUCSUTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCSUTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:19:24 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:2826 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S261928AbUCSUTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:19:16 -0500
Date: Fri, 19 Mar 2004 13:19:13 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: linux-raid@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <760890000.1079727553@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC trimmed since all those on the CC line appear to be on the lists ... ]

Lets take a step back and focus on a few of the points to which we can
hopefully all agree:

o Any successful solution will have to have "meta-data modules" for
  active arrays "core resident" in order to be robust.  This
  requirement stems from the need to avoid deadlock during error
  recovery scenarios that must block "normal I/O" to the array while
  meta-data operations take place.

o It is desirable for arrays to auto-assemble based on recorded
  meta-data.  This includes the ability to have a user hot-insert
  a "cold spare", have the system recognize it as a spare (based
  on the meta-data resident on it) and activate it if necessary to
  restore a degraded array.

o Child devices of an array should only be accessible through the
  array while the array is in a configured state (bd_claim'ed).
  This avoids situations where a user can subvert the integrity of
  the array by performing "rogue I/O" to an array member.

Concentrating on just these three, we come to the conclusion that
whether the solution comes via "early user fs" or kernel modules,
the resident size of the solution *will* include the cost for
meta-data support.  In either case, the user is able to tailor their
system to include only the support necessary for their individual
system to operate.

If we want to argue the merits of either approach based on just the
sheer size of resident code, I have little doubt that the kernel
module approach will prove smaller:

 o No need for "mdadm" or some other daemon to be locked resident in
   memory.   This alone saves you having a locked copy of klibc or
   any other user libraries core resident.  The kernel modules
   leverage the kernel APIs that already have to be core resident
   to satisfy the needs of other parts of the kernel which also
   helps in reducing its size.

 o Initial RAM disk data can be discarded after modules are loaded at
   boot time.

Putting the size argument aside for a moment, lets explore how a
userland solution could satisfy just the above three requirements.

How is meta-data updated on child members of an array while that
array is on-line?  Remember that these operations occur with some
frequency.  MD includes "safe-mode" support where redundant arrays
are marked clean any time writes cease for a predetermined, fairly
short, amount of time.  The userland app cannot access the component
devices directly since they are bd_claim'ed.  Even if that mechanism
is somehow subverted, how do we guarantee that these meta-data
writes do not cause a deadlock?  In the case of a transition from
Read-only to Write mode, all writes are blocked to the array (this
must be the case for "Dirty" state to be accurate).  It seems to
me that you must then provide extra code to not only pre-allocate
buffers for the userland app to do its work, but also provide a
"back-door" interface for these operations to take place.

The argument has also been made that shifting some of this code out
to a userland app "simplifies" the solution and perhaps even makes
it easier to develop.  Comparing the two approaches we have:

UserFS:
      o Kernel Driver + "enhanced interface to userland daemon"
      o Userland Daemon (core resident)
      o Userland Meta-Data modules
      o Userland Management tool
	 - This tool needs to interface to the daemon and
	   perhaps also the kernel driver.

Kernel:
      o Kernel RAID Transform Drivers
      o Kernel Meta-Data modules
      o Simple Userland Mangement
	tool with no meta-data knowledge

So two questions arise from this analysis:

1) Are meta-data modules easier to code up or more robust as user
   or kernel modules?  I believe that doing these outside the kernel
   will make them larger and more complex while also losing the
   ability to have meta-data modules weigh in on rapidly occurring
   events without incurring performance tradeoffs.  Regardless of
   where they reside, these modules must be robust.  A kernel Oops
   or a segfault in the daemon is unacceptable to the end user.
   Saying that a segfault is less harmful in some way than an Oops
   when we're talking about the users data completely misses the
   point of why people use RAID.

2) What added complexity is incurred by supporting both a core
   resident daemon as well as management interfaces to the daemon
   and potentially the kernel module?  I have not fully thought
   through the corner cases such an approach would expose, so I
   cannot quantify this cost.  There are certainly more components
   to get right and keep synchronized.

In the end, I find it hard to justify inventing all of the userland
machinery necessary to make this work just to avoid roughly ~2K
lines of code per-metadata module from being part of the kernel.
The ASR module for example, which is only required by those that
need support for this meta-data type, is only 19K with all of its
debugging printks and code enabled, unstripped.  Are there benefits
to the userland approach that I'm missing?

--
Justin

