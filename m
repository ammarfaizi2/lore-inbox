Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUITVC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUITVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUITVC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:02:56 -0400
Received: from holomorphy.com ([207.189.100.168]:26561 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267350AbUITVCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:02:13 -0400
Date: Mon, 20 Sep 2004 14:01:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Andrew Morton OSDL <akpm@osdl.org>, Craig Small <csmall@debian.org>,
       Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040920210159.GW9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <20040920023452.GR9106@holomorphy.com> <1095653925.4969.100.camel@cube> <20040920074731.GS9106@holomorphy.com> <1095692447.4969.174.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095692447.4969.174.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 03:47, William Lee Irwin III wrote: 
>> I didn't touch this. Also, procps FTBFS on sparc64; I see no evidence
>> of passing -m64 or whatever to either the compilation or linking phase
>> in virgin procps.

On Mon, Sep 20, 2004 at 11:00:47AM -0400, Albert Cahalan wrote:
> Debian compiles sparc and sparc64 on the same box,
> and fails to distinguish them. Therefore, Debian
> disables -m64 during the build. The package itself
> will disable -m64 if it is unable to successfully
> link a dummy.c file with ncurses when using it.
> If you compile from the *.tar.gz file and have a
> working 64-bit ncurses, you should get a 64-bit
> executable. If you don't, please tell me what I
> need to do to make it work.

Reread the above.

I used make CC="gcc -m64" to make it work on the pristine sources.
It did not work on pristine sources otherwise.


On Mon, 2004-09-20 at 03:47, William Lee Irwin III wrote: 
>> It gets better, though. On SuSE's x86-64 userspace,
>> procps and stat(1) are compiled 64-bit yet the inode numbers overflow,
>> as all /proc/$PID entries have identical inode numbers as reported.

On Mon, Sep 20, 2004 at 11:00:47AM -0400, Albert Cahalan wrote:
> Hmmm... who cares about the inode numbers?
> If the answer is "glibc readdir", then the numbers
> should be taken from distinct number spaces for the
> /proc, /proc/*/task, and /proc/*/fd directories.
> Re-use within a directory may be the most trouble.
> If it's not even that, then the fake_ino() macro
> shouldn't pretend that the numbers matter. Simply
> make it be a constant.

I don't need to answer this beyond "stock userspace pukes on it".
The patch writer bears the burden of proof.


On Mon, 2004-09-20 at 03:47, William Lee Irwin III wrote: 
>> x86-64 and ia64 are highly unusual in that 64-bit compilation is
>> useful for basic apps, and alpha an exception in that it has no 32-bit
>> ABI; for most 64-bit architectures making such large fractions of
>> userspace 64-bit applictions is undesirable.

On Mon, Sep 20, 2004 at 11:00:47AM -0400, Albert Cahalan wrote:
> MIPS at least has N32, which is a distinct ABI for
> the ILP32 model on 64-bit hardware. This offers the
> best performance while not making 32-bit users suffer.

For whatever merits the n32 ABI may have, biarch userspace generally
involves reusing most of the 32-bit userspace.


On Mon, 2004-09-20 at 03:47, William Lee Irwin III wrote: 
>> It's UltraSPARC. 32-bit userspace is used there. Recompiling top(1) as
>> a 64-bit app produces nonempty process lists.
>> And telling sparc32 users that has already been done for far more
>> severe slowdowns, in particular udiv emulation.

On Mon, Sep 20, 2004 at 11:00:47AM -0400, Albert Cahalan wrote:
> You mean it traps instead of directly calling
> a routine in libgcc?

Yes. There is some instruction that's emulated (udiv) instead of having
library calls generated.


On Mon, Sep 20, 2004 at 11:00:47AM -0400, Albert Cahalan wrote:
> Admittedly on x86, profiling has shown that handling
> 64-bit values with a 32-bit ABI is truly horrible.
> So both sparc and sparc64 are being hurt if 32-bit
> sparc binaries have to support 64-bit kernels.

sparc32 is legacy enough that the true 32-bit systems are
irrelevant as performance considerations. I also very explicitly
discussed the ia32 case being the sole exception among all emulated
32-bit ABI's; it is so grossly inferior the 64-bit ABI dominates it in
performance as it does nowhere else.


On Mon, Sep 20, 2004 at 11:00:47AM -0400, Albert Cahalan wrote:
> If 32-bit is so good, you'll want to get a 32-bit
> kernel on your hardware ASAP.

This may be one reason why non-Linux kernels have chosen to use 32-bit
kernels on 64-bit cpus in various instances. But in general this
assertion is pure gibberish. That's not how biarch userspace is done;
if you care to change that, petition the distribution maintainers.

As for e.g. UltraSPARC userspace, it doesn't come any other way but
biarch and mostly 32-bit. If you would like to petition distributions
to ship procps as 64-bit those Debian project members I added to the
cc: list here may be relevant.


On Mon, 2004-09-20 at 03:47, William Lee Irwin III wrote: 
>> Proper use of
>> O_LARGEFILE etc. is actually unlikely to hurt sparc32 in any
>> significant way, as it has a decent number of registers,

On Mon, Sep 20, 2004 at 11:00:47AM -0400, Albert Cahalan wrote:
> More than O_LARGEFILE would be involved.
> All the /proc parsing code would have to be 64-bit.
> The overhead of strtoull() and the libgcc division
> functions is really bad. It can show up at the top
> of a profile.
> Here's just a small amount of 64-bit usage:
> Each sample counts as 0.01 seconds.
>   %   cumulative   self              self     total           
>  time   seconds   seconds    calls  ns/call  ns/call  name    
>  16.26      0.20     0.20                             __udivdi3
> That was merely an accidental 64-bit usage. It gets
> far, far worse when trying to support a 64-bit kernel
> from a 32-bit app.

This is undoubtedly architecture-specific. I am thoroughly unimpressed
by ia32 results. The effect of double-precision arithmetic on inferior,
register-starved ISA's/ABI's is very predictable and not applicable to
any other architecture. Also, your concerns have been expressed before
and are motivators of the canonical -D_FILE_OFFSET_BITS=64 arrangement,
where apps do not explicitly use any 64-bit types or 64-bit aware
library routines, but are rather redirected to such depending on whether
-D_FILE_OFFSET_BITS=64 is passed as a compilation flag or not.

I strongly suggest the following:
(a) Stop fiddling with the compilation flags since it doesn't work
	anyway and is undone by packagers just to get it to build.
	Furthermore, they also find your attempt to force 64-bit
	compilation undesirable. As a reminder, the compiletest
	demonstrating build failure from prior posts was on pristine
	sources, not Debian-altered sources.
(b) Make O_LARGEFILE a compile-time option; merely use off_t etc. instead
	of unsigned long and the types and fs syscalls will be switched
	between single and double precision depending on whether
	-D_FILE_OFFSET_BITS=64 is used. No overhead will be created
	for 32-bit ia32 unless someone is so foolish as to e.g. use
	-D_FILE_OFFSET_BITS=64 on an inferior, register-starved ISA/ABI.
(c) The compiler spews more warnings than are reasonable, and some of
	them are likely bugs. Cleaning those up may help.
(d) If your patch is triggering some bug in glibc, diagnose it and send
	a bugreport to glibc maintainers.
(e) This should have been rather easily anticipated given that you're
	shifting (pid+1) << BITS_PER_LONG/2. I expect the maintainers
	of most/all arches with 32-bit emulation (essentially all
	64-bit except alpha) to have conniption fits if this gets
	anywhere near mainline. Such shifts are tantamount to 32-bit
	emulated stat(2) always returning -EOVERFLOW in lieu of results.


-- wli
