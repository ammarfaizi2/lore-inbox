Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbULDQox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbULDQox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 11:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbULDQox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 11:44:53 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:32644 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262558AbULDQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 11:43:54 -0500
Date: Sat, 4 Dec 2004 17:43:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Voluspa <lista4@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041204164353.GE32635@dualathlon.random>
References: <200412041242.iB4CgsN07246@d1o408.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412041242.iB4CgsN07246@d1o408.telia.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 01:42:54PM +0100, Voluspa wrote:
> 
> On 2004-12-04 8:08:40 Andrea Arcangeli wrote:
> 
> > You can try to put back a might_slee_if(wait), but if it deadlocks 
> with
> > that change sure it's not a bug in my patch, it's instead a bug
> > somewhere else that calls alloc_pages w/o GFP_ATOMIC. Ingo's
> > lowlatency patch would expose the same bug too since they're aliasing
> > the might_sleep to cond_resched.
> 
> Putting it back doesn't alter the outcome - hanging. And the original 
> patch, (hope it was the right one) from:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110204117506557&w=2

yes it's the right one ;)

> root:loke:/usr/src/linux-2.6.9-oomkill# patch -Np1 -i ../oomkill.patch 
> patching file mm/oom_kill.c
> patching file mm/page_alloc.c
> Hunk #1 succeeded at 608 (offset -3 lines).
> Hunk #3 succeeded at 681 (offset -3 lines).
> patching file mm/swap_state.c
> patching file mm/vmscan.c
> 
> has been tried with the following variations. With and without 
> optimizing for size, with and without preempt, with and without kernel 
> boot params (cfq, lapic), cold and hot starts, and then I threw in a smp 
> compile for measure. All have the same behaviour:
> 
> [...]
> Checking 'hlt' instruction... OK.
> 
> [10 minutes wait. Then a long callback trace
>  scrolls off the screen ending like Thomas']
> 
> <0>Kernel panic - not syncing: Fatal exception in interrupt
> 
> My toolchain (well, the whole software system) is quite contemporary 
> within the stable branches. Built from scratch with gcc-3.4.3, glibc-
> 20041011 (nptl) and binutils-2.15.92.0.2
> 
> No energy control, acpi-pm or whatever it's called, is used here. The 
> machine is extremely stable. Running with 100 percent utilization 24/7.
> 
> Don't shoot the messenger ;)

I trust you of course but I've absolutely no idea how can my patch ever
change any code that runs at that point during boot. mm/oom_kill.c can
be obviously ruled out. The changes in mm/swap_state.c (two printk in
show_swap_cache_info) as well can be obviously ruled out. The change in
mm/vmscan.c as well only makes a difference during an oom condition.

This mean it has to be the change in mm/page_alloc.c that broke
something. But even that should never run during boot (except for the
cond_resched instead of might_sleep_if that you already tried to backout
separately from the rest). There's simply not enough memory pressure at
boot in order to recall try_to_free_pages and run the modified code.

If try_to_free_pages is being recalled during boot them we've a problem
somewhere else, it should never happen!

Plus it works like a charm here.

Can you send me your .config so that I will try to send you privately a
kernel image built on my machine? (and before sending I'll try to boot
it locally ;) My .config sure is happily running.

Many thanks.
