Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVAOFXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVAOFXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVAOFXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:23:34 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:61573 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262208AbVAOFXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:23:14 -0500
Date: Sat, 15 Jan 2005 06:23:11 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-ID: <20050115052311.GC22863@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de> <1105765760.12263.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105765760.12263.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 04:09:19PM +1100, Rusty Russell wrote:
> On Sat, 2005-01-15 at 05:09 +0100, Andi Kleen wrote:
> > Fix boot up SMP race in timer setup on i386/x86-64.
> > 
> > This fixes a long standing race in 2.6 i386/x86-64 SMP boot.
> > The per CPU timers would only get initialized after an secondary
> > CPU was running. But during initialization the secondary CPU would
> > already enable interrupts to compute the jiffies. When a per 
> > CPU timer fired in this window it would run into a BUG in timer.c
> > because the timer heap for that CPU wasn't fully initialized.
> > 
> > The race only happens when a CPU takes a long time to boot
> > (e.g. very slow console output with debugging enabled).
> > 
> > To fix I added a new cpu notifier notifier command CPU_UP_PREPARE_EARLY
> > that is called before the secondary CPU is started. timer.c
> > uses that now to initialize the per CPU timers early before
> > the other CPU runs any Linux code.
> 
> Andi, that's horrible.  I suspect you know it's horrible and were hoping
> someone would fix it properly.  The semantics of CPU_UP_PREPARE are
> supposed to do this already.

I shortly considered redoing the boot process, but then it looked 
too risky to me. 

e.g. I guess on x86-64 it wouldn't be that difficult, just a bit of work,
but on i386 with all the weird hardware it could be quite destabilizing.
But doing it on x86-64 only is not a good solution.


> 
> The cause of this bug is that (1) i386 and x86_64 actually bring the
> secondary CPUs up at boot before the core code officially brings them up
> using cpu_up(), after the appropriate callbacks, and (2) they call into
> core code tp process timer interrupts before they've been officially
> brought up.
> 
> The former is because I just added a shim rather than rewriting the x86
> boot process, because it would have broken too much.  The fix is do the
> boot process properly, or to suppress the call to do_timer before the
> CPU is actually "up".

I don't see a better short term solution.

If you had done it properly in 2.5 it would be working and tested
by now ;-) , but doing it in the middle of 2.6 would seem a bit misplaced
to me.

-Andi
