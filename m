Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWFBVfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWFBVfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWFBVfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:35:08 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:55973 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751474AbWFBVfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:35:06 -0400
Date: Fri, 2 Jun 2006 17:34:55 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       "Christopher S. Aker" <caker@theshore.net>
Subject: Re: [uml-devel] non-scalar ktime addition and subtraction broken
Message-ID: <20060602213455.GA5889@ccure.user-mode-linux.org>
References: <20060602030825.GA8006@ccure.user-mode-linux.org> <1149231262.20582.119.camel@localhost.localdomain> <20060602151916.GC4708@ccure.user-mode-linux.org> <200606022028.38510.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606022028.38510.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 08:28:37PM +0200, Blaisorblade wrote:
> Ok, since I now I'll never finish it:
> $ ll old-patch-scripts/patches/uml-fix-timers.patch
> -rw-r--r-- 1 paolo paolo 6763 2005-07-24 06:41 
> old-patch-scripts/patches/uml-fix-timers.patch
> 
> I'm attaching this incomplete patch. It won't apply (it was written likely 
> before 2.6.13 but surely after git was born), it likely introduces bugs and I

> *) Rename timer() since it's a global and such a name is a "shooting 
> offense".  Also, it's difficult to find the def with ctags
> currently, because people miss fantasy.

This is now gone, replaced by get_time.  I can rename that if you feel
it's objectionable.

> *) do_timer must be called with xtime_lock held. I'm not sure
> boot_timer_handler needs this, however I don't think it hurts: it simply
> disables irq and takes a spinlock.

Fixed.

> *) wall_to_monotonic must be normalized and have a posititive ts_nsec part,
> see wall_to_monotonic definition and i386 usage in arch/i386/kernel/time.c.
> Otherwise you can get negative tv_nsec results with
> do_posix_clock_monotonic_gettime and its callers, including
> sys_timer_gettime.

Bah, you almost completely diagnosed the bug.  Fixed now.

> *) Remove um_time() and um_stime() syscalls since they are identical to
> system-wide ones.

Fixed.  sys_time64 seems to be gone on x86_64, so I deleted it from
here as well.

> *) Move clock_was_set() from do_gettimeofday to do_settimeofday. Not
> only from the name you guess this is needed, but I indeed verified
> that for i386 it's in arch/i386/kernel/time.c:do_settimeofday().

I had already fixed this.

> *) XXX: Probably do_settimeofday should be copied from i386 to
> replace the current version.
>
> *) XXX: do_[gs]ettimeofday() should use seqlocks like in i386,
> instead of timer_lock() like they do. They also don't synchronize
> with the rest, beyond the performance problems!

You're probably right.  These two are related, and I'm not sure what
to do with them offhand.

				Jeff
