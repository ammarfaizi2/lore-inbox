Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRDAGEj>; Sun, 1 Apr 2001 01:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131992AbRDAGEa>; Sun, 1 Apr 2001 01:04:30 -0500
Received: from ha1.rdc2.bc.wave.home.com ([24.2.10.68]:47826 "EHLO
	mail.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S131988AbRDAGEQ> convert rfc822-to-8bit; Sun, 1 Apr 2001 01:04:16 -0500
Message-Id: <l03130300b6ec6062bf7d@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Sat, 31 Mar 2001 22:03:28 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Revised memory-management stuff (was: OOM killer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's clearly been lots of discussion about OOM (and memory management in
general) over the last week, so it looks like it's time to summarise it and
work out the solution that's actually going to find it's way into the
kernel.

Issue 1:
	The OOM killer was activating too early.  I have a 4-line fix for
this problem, which has already appeared on the list.  Maybe I should
forward a copy directly to Alan and/or Linus.

Issue 2:
	Applications are not warned when memory is running low, either in
terms of reserved or allocated memory.  I have implemented an improvement
on this state of affairs, which makes memory reservation (whether by fork
or malloc type operations) fail for applications which are larger than 4
times the unallocated space available.  This also applies to reserved
memory, but the memory-accounting code needs debugging before this will
work reliably.  The reason for stopping large processes short of the hard
OOM line is so that smaller (mostly interactive) processes can still be
started and run reliably.

I will probably need some help with debugging the memory-accounting code,
since it goes into bits of the kernel I know nothing (rather than "very
little") about.

Some posters suggested SIGDANGER, a feature from AIX, to warn processes
when the system became dangerously low on memory.  Other posters pointed
out some disadvantages of SIGDANGER, which however (thankfully) only apply
when SIGDANGER is used in isolation.  For example, a malicious process
designed to reserve memory within it's SIGDANGER handler could be thwarted
by malloc() simply failing cleanly as above.  If the process had already
reserved memory and merely attempted to allocate it (by accessing it), the
non-memory-overcommit code could defeat it by guaranteeing that the
reserved memory was already available to be allocated.  Without the
non-memory-overcommit code, the OOM killer would be triggered - but with
the improved algorithm I came up with as promised, the effects would be
less severe on average (and most likely kill the malicious process in
preference to a valuable batch job or system daemon).

I have not implemented SIGDANGER, but I don't see any reason why it
shouldn't be implemented.  Certain implementation details will need some
care.

Issue 3:
	The OOM killer was frequently killing the "wrong" process.  I have
developed an improved badness selector, and devised a possible means of
specifying "don't touch" PIDs at runtime.  PID 1 is never selected for
killing.  I am debating whether to allow selection of *any* process
labelled "init" and running as root for the chop, since one of the "unusual
but frequently encountered" scenarios is for a second init to be running
during an install or recovery procedure.  This might make it's way in as an
optional feature.

Issue 4:
	Memory overcommit.  I totally agree with those posters who point
out that there are situations where this is a Bad ThingÅ, specifically in
mission-critical environments.  However, for the "average" system, I still
quite firmly believe it has some advantages.  Since the
non-memory-overcommit code needs a fair amount of debugging (after I
hacksawed it in to fit the latest kernels), I hope the solutions to the
first 3 issues are sufficient to satisfy most people for the time being.

Issue 5:
	VM balancing needs a *lot* of work.  During my exercising of the
memory-management code, I noticed that memory-hogging applications could
completely stall the machine, even when there is a lot of physical RAM
available.  I'm considering some simple algorithms to help alleviate this -
these generally amount to a variation on the "suspend some processes when
thrashing" theory.  I'll need to think about these for a bit though, and
try to implement them when I have time.

Expect to see patches (containing the fixes mentioned above) on the list soon.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


