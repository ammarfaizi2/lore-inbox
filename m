Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUITHsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUITHsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 03:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUITHsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 03:48:05 -0400
Received: from holomorphy.com ([207.189.100.168]:45244 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266133AbUITHrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 03:47:47 -0400
Date: Mon, 20 Sep 2004 00:47:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Andrew Morton OSDL <akpm@osdl.org>, Craig Small <csmall@debian.org>,
       Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040920074731.GS9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <20040920023452.GR9106@holomorphy.com> <1095653925.4969.100.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095653925.4969.100.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 22:34, William Lee Irwin III wrote:
>> top(1) shows no tasks on sparc64.

On Mon, Sep 20, 2004 at 12:18:45AM -0400, Albert Cahalan wrote:
> It would be nice if I had such a box. I can't even
> find a user account on one. I have 32-bit ppc, plus
> non-root accounts on alpha, i386, and x86_64 boxes
> with obsolete kernels.

On Sun, 2004-09-19 at 22:34, William Lee Irwin III wrote:
>> Large negative inode numbers appear
>> to be showing up for /proc/stat and other /proc/ special files on
>> 64-bit irrespective of endianness, and all processes appear to have the
>> same inode number once again irrespective of endianness.

On Sun, 2004-09-19 at 22:34, William Lee Irwin III wrote:
> The inode numbering patch looks sane enough...

It may be userspace. stat(1) on SuSE/x86-64 reports large negative
inode numbers and identical inode numbers for all processes similarly
to that of Debian, yet it is compiled as a 64-bit application. So even
with of 64-bit-ness of userspace something has gone wrong.


On Sun, 2004-09-19 at 22:34, William Lee Irwin III wrote:
>> It's unclear
>> why top(1) enumerates tasks on x86-64 and does not do so on sparc64,
>> unless 2.6.9-rc2-mm1 shows some behavior procps-3.2.3 is sensitive to
>> that 3.2.1 is not, or some numbers are overflowing on 32-bit apps but
>> not 64-bit ones (top(1) is 64-bit on x86-64 but 32-bit on sparc64)

On Mon, Sep 20, 2004 at 12:18:45AM -0400, Albert Cahalan wrote:
> In no place does procps itself care about ino_t.
> Perhaps your 32-bit glibc chokes on 64-bit inode numbers.
> If so, yuck. It's really sad that we have a zillion
> versions of stat(), many with oversize dev_t, and still
> we use 32-bit ino_t in many places.
> Whether or not that's the problem...
> 1. install a 64-bit or bi-arch gcc
> 2. install a 64-bit libc
> 3. install a 64-bit ncurses
> 4. install a 64-bit procps
> (suggestion: keep going until /bin is done)
> That's pretty much it. The procps package goes to
> great lengths to compile itself 64-bit, even passing
> the -m64 option and installing to /lib64 as needed.
> If you've broken this, you get to keep the pieces.

I didn't touch this. Also, procps FTBFS on sparc64; I see no evidence
of passing -m64 or whatever to either the compilation or linking phase
in virgin procps. It gets better, though. On SuSE's x86-64 userspace,
procps and stat(1) are compiled 64-bit yet the inode numbers overflow,
as all /proc/$PID entries have identical inode numbers as reported.

So you may be getting bitten by -EOVERFLOW from 32-bit emulated stat(2)
or otherwise glibc's struct stat sans O_LARGEFILE, even though I
couldn't see it with strace(1). Perhaps silent truncation is going on
for the case of inode numbers that would overflow 32-bit integers. IIRC
stat(2) will be replaced by stat64(2) if O_LARGEFILE is passed, which
should probably be done for this case. Having made this a requirement
for 32-bit apps on 64-bit systems may be considered undesirable.
Perhaps a method of generating inode numbers different from assigning
fixed numerical ranges to tasks of a given pid would be more
appropriate, particularly as you've observed that numbers so large in
absolute terms have undesirable side effects. It's likewise readily
observable that these inode number space reservations are ridiculous
for systems running well under 100 tasks.

x86-64 and ia64 are highly unusual in that 64-bit compilation is
useful for basic apps, and alpha an exception in that it has no 32-bit
ABI; for most 64-bit architectures making such large fractions of
userspace 64-bit applictions is undesirable.

Furthermore, this bit of userspace policy isn't my decision and I don't
care to override it, particularly as it would break automated upgrades.
I just don't dork around much with userspace. Maintainers of the Debian
procps package and sparc64 Debian kernel package cc:'d here, as they do
care somewhat more and make more of the decisions. I'm not sure who the
SuSE counterparts are, but they surely have similar concerns as their
userspace is likewise affected.


On Mon, Sep 20, 2004 at 12:18:45AM -0400, Albert Cahalan wrote:
> In other words: seriously unsupported
> I see no reason why 32-bit SPARC users should have
> to suffer the pain of running code bloated up to
> handle 64-bit SPARC. The 32-bit SPARC hardware is
> slow enough already. Just try to look a 32-bit SPARC
> user in the eye and tell him "Your system should run
> even slower now, so that my hot new hardware can keep
> running old 32-bit executables meant for you"

It's UltraSPARC. 32-bit userspace is used there. Recompiling top(1) as
a 64-bit app produces nonempty process lists.

And telling sparc32 users that has already been done for far more
severe slowdowns, in particular udiv emulation. Proper use of
O_LARGEFILE etc. is actually unlikely to hurt sparc32 in any
significant way, as it has a decent number of registers, unlike the
32-bit counterparts of some architectures for whose sake O_LARGEFILE is
omitted where considered feasible. On the contrary, compiling it 64-bit
would be a minor (though I can't imagine it being significant) slowdown
for users of UltraSPARC (the 64-bit cpus). O_LARGEFILE for 32-bit apps
is far more likely to hurt x86 biarch userspace than SPARC or other
standard 64-bit architectures' biarch userspace, though in that case it
would still be unusual, as its policy is generally 64-bit by default.


-- wli
