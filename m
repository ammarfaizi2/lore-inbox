Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266766AbUG1CWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266766AbUG1CWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 22:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUG1CWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 22:22:36 -0400
Received: from holomorphy.com ([207.189.100.168]:27528 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266766AbUG1CWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 22:22:01 -0400
Date: Tue, 27 Jul 2004 19:21:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-ID: <20040728022131.GL2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20040728004030.GK2334@holomorphy.com> <2479.1090979285@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2479.1090979285@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 11:48:05AM +1000, Keith Owens wrote:
> rwlocks are already a issue on i386, but not a big one.  The return
> address from __write_lock_failed/__read_lock_failed is pointing into
> the out of line code, not the code that really took the rwlock.  The
> nearest label is LOCK_SECTION_NAME, i.e. .text.lock.KBUILD_BASENAME.  A
> backtrace through a contended rwlock on i386 looks like this
>   interrupt
>   __write_lock_failed/__read_lock_failed
>   .text.lock.KBUILD_BASENAME
>   caller of routine that took the lock
>   ...
> when it should really be
>   interrupt
>   __write_lock_failed/__read_lock_failed
>   .text.lock.KBUILD_BASENAME
>   routine that took the look  <=== missing information
>   caller of routine that took the lock
>   ...
> IOW we only get the name of the object, not the function within the
> object that took the lock.  i386 gets away with this because
> .text.lock.KBUILD_BASENAME is usually enough information to determine
> which lock is the problem, and the i386 backtrace algorithm has enough
> redundancy to get back in sync for the rest of the trace, even with the
> missing function entry.

IMHO the out-of-line call to the rwlock contention code in the lock
section is completely worthless bloat and rwlocks should just call the
out-of-line contention case directly from the inline path.

The patch I used to determine the maximum aggregate text size
reduction achievable literally made normal C function entrypoints for
spin_lock(), read_lock(), and all the various spinlocking functions
for spinlocks and rwlocks, moving all of the spinlocking code from
include/linux/spinlock.h to a new kernel/spinlock.c, using the normal
inline _raw_spin_lock()/etc. to avoid unnecessary call frames. This is
what resulted in the aggregate kernel size reduction of 220KB, i.e.
almost 1/4 of 1MB, and had no effect on performance, positive or
negative, in some non-rigorous benchmarking. This obviously
interoperates quite well with backtracing and so on, but doesn't appear
to be under consideration at the moment, and may also have issues with
architectures (e.g. sparc/sparc64) which need the interrupt disablement
in e.g. spin_lock_irqsave() to be done in the same call frame as the
spin_unlock_irqrestore() etc.


On Wed, Jul 28, 2004 at 11:48:05AM +1000, Keith Owens wrote:
> OTOH, ia64 unwind is incredibly sensitive to the exact instruction
> pointer and there is zero redundancy in the unwind data.  If the return
> ip is not known to the unwind code, then the ia64 unwinder cannot
> backtrace correctly.  Which meant that I had to get the ia64 out of
> line code exactly right, close enough was not good enough.
> With Zwane's patch, any contended spinlock on i386 will look like
> rwsem, it will be missing the routine that took the look.  Good enough
> for most cases.
> kdb does unwind through out of line spinlock code exactly right, simply
> because I added extra heuristics to kdb to cope with this special case.
> When people complain that the kdb i386 backtrace code is too messy,
> they are really saying that they do not care about getting exact data
> for all the hand crafted assembler in the kernel.
> BTW, if anybody is planning to switch to dwarf for debugging the i386
> kernel then you _must_ have valid dwarf data for the out of line code.

This is a different issue. That should definitely be looked at for the
consolidated contention case out-of-line strategies now being
considered or others involving nonstandard calling conventions. IMHO we
are truly best off using normal calling conventions to invoke the
out-of-line cases regardless of their role. Confusing debuggers and the
extra bloat to push the return address on the stack and the extra jump
are just not worth it.


-- wli
