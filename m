Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbTIAR7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbTIAR7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:59:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2214
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263243AbTIAR7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:59:05 -0400
Date: Mon, 1 Sep 2003 19:59:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
Message-ID: <20030901175942.GL11503@dualathlon.random>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 04:11:49PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Sat, 30 Aug 2003, Marcelo Tosatti wrote:
> 
> >
> > > that's true for only one patch, the others are pretty orthogonal after
> > > Andrew helped splitting them:
> > > 05_vm_03_vm_tunables-4
> > > 05_vm_05_zone_accounting-2
> > > 05_vm_06_swap_out-3
> > > 05_vm_07_local_pages-4
> > > 05_vm_08_try_to_free_pages_nozone-4
> > > 05_vm_09_misc_junk-3
> > > 05_vm_10_read_write_tweaks-3
> > > 05_vm_13_activate_page_cleanup-1
> > > 05_vm_15_active_page_swapout-1
> > > 05_vm_16_active_free_zone_bhs-1
> > > 05_vm_17_rest-10
> > > 05_vm_18_buffer-page-uptodate-1
> > > 05_vm_20_cleanups-3
> > > 05_vm_21_rt-alloc-1
> > > 05_vm_22_vm-anon-lru-1
> > > 05_vm_23_per-cpu-pages-3
> > > 05_vm_24_accessed-ipi-only-smp-1
> > > 05_vm_25_try_to_free_buffers-invariant-1
> >
> > Indeed, you are right.
> >
> > I'll start looking at them Monday. I'll keep you in touch. Thanks.
> 
> Andrea,
> 
> Would you mind to explain me 05_vm_06_swap_out-3 ?
> 
> I see you change shrink_cache, try_to_free_pages_zone, etc.

that achieves multiple things. It avoids oom deadlocks by not wasting
time in the pagetable walking anymore after we failed once, it protects
init from being killed, and most important it avoids failed oom kills if
a task has been killed under us (or if plenty of ram has been freed
under us for whatever else reason). See the check_classzone_need_balance
checks.

Then it gives classzone awareness to refill_inactive so we make sure to
make progress for non highmem allocs too and to shrink stuff properly,
the lists are global. Plus it checkpoints the point in the active list
where it stopped the last time.

It also changes the shrink_cache function to shrink the vfs lists
internally if needed.

The max_scan etc.. in shrink_cache are as well classzone aware, since
the lists are global but we skip over the non interesting pages (like in
refill_inactive).

Andrea
