Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUITPFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUITPFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUITPFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:05:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:52714 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266650AbUITPFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:05:16 -0400
Subject: Re: 2.6.9-rc2-mm1
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton OSDL <akpm@osdl.org>, Craig Small <csmall@debian.org>,
       Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040920074731.GS9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org>
	 <20040920023452.GR9106@holomorphy.com> <1095653925.4969.100.camel@cube>
	 <20040920074731.GS9106@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095692447.4969.174.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Sep 2004 11:00:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 03:47, William Lee Irwin III wrote: 
> On Sun, 2004-09-19 at 22:34, William Lee Irwin III wrote:
> >> top(1) shows no tasks on sparc64.
> 
> On Mon, Sep 20, 2004 at 12:18:45AM -0400, Albert Cahalan wrote:
> > It would be nice if I had such a box. I can't even
> > find a user account on one. I have 32-bit ppc, plus
> > non-root accounts on alpha, i386, and x86_64 boxes
> > with obsolete kernels.

> On Mon, Sep 20, 2004 at 12:18:45AM -0400, Albert Cahalan wrote:
> > In no place does procps itself care about ino_t.
> > Perhaps your 32-bit glibc chokes on 64-bit inode numbers.
> > If so, yuck. It's really sad that we have a zillion
> > versions of stat(), many with oversize dev_t, and still
> > we use 32-bit ino_t in many places.
> > Whether or not that's the problem...
> > 1. install a 64-bit or bi-arch gcc
> > 2. install a 64-bit libc
> > 3. install a 64-bit ncurses
> > 4. install a 64-bit procps
> > (suggestion: keep going until /bin is done)
> > That's pretty much it. The procps package goes to
> > great lengths to compile itself 64-bit, even passing
> > the -m64 option and installing to /lib64 as needed.
> > If you've broken this, you get to keep the pieces.
> 
> I didn't touch this. Also, procps FTBFS on sparc64; I see no evidence
> of passing -m64 or whatever to either the compilation or linking phase
> in virgin procps.

Debian compiles sparc and sparc64 on the same box,
and fails to distinguish them. Therefore, Debian
disables -m64 during the build. The package itself
will disable -m64 if it is unable to successfully
link a dummy.c file with ncurses when using it.

If you compile from the *.tar.gz file and have a
working 64-bit ncurses, you should get a 64-bit
executable. If you don't, please tell me what I
need to do to make it work.

> It gets better, though. On SuSE's x86-64 userspace,
> procps and stat(1) are compiled 64-bit yet the inode numbers overflow,
> as all /proc/$PID entries have identical inode numbers as reported.

Hmmm... who cares about the inode numbers?

If the answer is "glibc readdir", then the numbers
should be taken from distinct number spaces for the
/proc, /proc/*/task, and /proc/*/fd directories.
Re-use within a directory may be the most trouble.

If it's not even that, then the fake_ino() macro
shouldn't pretend that the numbers matter. Simply
make it be a constant.

> x86-64 and ia64 are highly unusual in that 64-bit compilation is
> useful for basic apps, and alpha an exception in that it has no 32-bit
> ABI; for most 64-bit architectures making such large fractions of
> userspace 64-bit applictions is undesirable.

MIPS at least has N32, which is a distinct ABI for
the ILP32 model on 64-bit hardware. This offers the
best performance while not making 32-bit users suffer.

> On Mon, Sep 20, 2004 at 12:18:45AM -0400, Albert Cahalan wrote:
> > In other words: seriously unsupported
> > I see no reason why 32-bit SPARC users should have
> > to suffer the pain of running code bloated up to
> > handle 64-bit SPARC. The 32-bit SPARC hardware is
> > slow enough already. Just try to look a 32-bit SPARC
> > user in the eye and tell him "Your system should run
> > even slower now, so that my hot new hardware can keep
> > running old 32-bit executables meant for you"
> 
> It's UltraSPARC. 32-bit userspace is used there. Recompiling top(1) as
> a 64-bit app produces nonempty process lists.
> 
> And telling sparc32 users that has already been done for far more
> severe slowdowns, in particular udiv emulation.

You mean it traps instead of directly calling
a routine in libgcc?

Admittedly on x86, profiling has shown that handling
64-bit values with a 32-bit ABI is truly horrible.
So both sparc and sparc64 are being hurt if 32-bit
sparc binaries have to support 64-bit kernels.

If 32-bit is so good, you'll want to get a 32-bit
kernel on your hardware ASAP.

> Proper use of
> O_LARGEFILE etc. is actually unlikely to hurt sparc32 in any
> significant way, as it has a decent number of registers,

More than O_LARGEFILE would be involved.

All the /proc parsing code would have to be 64-bit.
The overhead of strtoull() and the libgcc division
functions is really bad. It can show up at the top
of a profile.

Here's just a small amount of 64-bit usage:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total           
 time   seconds   seconds    calls  ns/call  ns/call  name    
 16.26      0.20     0.20                             __udivdi3

That was merely an accidental 64-bit usage. It gets
far, far worse when trying to support a 64-bit kernel
from a 32-bit app.


