Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUHHFNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUHHFNa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUHHFNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:13:30 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:35583 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265127AbUHHFN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:13:28 -0400
Date: Sun, 8 Aug 2004 01:17:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
In-Reply-To: <Pine.LNX.4.58.0408072157500.1793@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408080110280.19619@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408072157500.1793@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, Linus Torvalds wrote:

> On Sun, 8 Aug 2004, Zwane Mwaikambo wrote:
> >
> > Pulled from the -tiny tree,
>
> Hmm.
>
> You really shouldn't use %ebx for flags. Use %edx instead.
>
> %ebx is call-save, so by forcing gcc to use %edx, you're guaranteeing that
> the compiler has to save/restore the register even for a simple function
> that wouldn't otherwise need it.

Thanks i'll change that.

> Also, why export the "failed" ones:

Actually that's now dead code since i had two variants but trimmed it, the
other had the fast path acquisition code inline and called the failed
procedures on contention. It'll have to go.

> > +#ifdef CONFIG_COOL_SPINLOCK
> > +extern void asmlinkage __spin_lock_failed(spinlock_t *);
> > +extern void asmlinkage __spin_lock_failed_flags(spinlock_t *, unsigned long);
> > +extern void asmlinkage __spin_lock_loop(spinlock_t *);
> > +extern void asmlinkage __spin_lock_loop_flags(spinlock_t *, unsigned long);
> > +EXPORT_SYMBOL(__spin_lock_failed);
> > +EXPORT_SYMBOL(__spin_lock_failed_flags);
> > +EXPORT_SYMBOL(__spin_lock_loop);
> > +EXPORT_SYMBOL(__spin_lock_loop_flags);
> > +#endif
>
> that looks just broken.

_raw_spin_lock will have the symbol __spin_lock_loop{,_flags} when used in
symbols, modules won't load otherwise.
