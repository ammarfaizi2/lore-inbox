Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTJEJXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTJEJXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:23:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48256
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263050AbTJEJXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:23:21 -0400
Date: Sun, 5 Oct 2003 11:23:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1
Message-ID: <20031005092326.GA1561@velociraptor.random>
References: <20031002152648.GB1240@velociraptor.random> <Pine.LNX.4.44.0310042347190.1666-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310042347190.1666-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 11:50:07PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Thu, 2 Oct 2003, Andrea Arcangeli wrote:
> 
> > URL:
> > Only in 2.4.23pre6aa1: 00_e-nodev-1
> > 
> > 	s/NODEV/ENODEV/ fixes from Vojtech.
> > 
> > Only in 2.4.23pre6aa1: 00_get_request_wait-race-1
> > 
> > 	Add missing smb_mb().
> 
> > Only in 2.4.23pre6aa1: 00_proc-readlink-1
> > 
> > 	Remeber to free tmp buffer (from spender)
> > 
> > Only in 2.4.23pre6aa1: 00_sync-buffer-scale-1
> > 
> > 	Don't take the bkl (the same paths runs w/o the bkl elsewhere), from
> > 	Chris Mason.
> > 
> > Only in 2.4.23pre6aa1: 01_softirq-nowait-1
> > 
> > 	We must really keep executing softirqs or it may take
> > 	a too long time before ksoftirqd gets some cpu time.
> > 	For an embedded device you may want to remove this,
> > 	on a server we need this still.
> > 
> > Only in 2.4.23pre6aa1: 30_19-nfs-kill-unlock-1
> > 
> > 	Ignore errors on exiting lock cleanups. From Trond.
> > 
> > Only in 2.4.23pre6aa1: 9999900_BH_Sync-remove-1
> > 
> > 	To really be able to help and not just waste some
> > 	seek and cpu, wait_on_buffer should honour the
> > 	BH_Sync, but this is late in 2.4, and so I prefer
> > 	to get rid of it instead of giving it the full power
> > 	it should have.
> > 
> > Only in 2.4.23pre6aa1: 9999_z-execve-race-1
> > 
> > 	Fix race in exit_mmap.
> 
> Andrea,
> 
> What about trying to merge this in mainline ? 
> 
> Will I have to look at them and merge them manually like I did with the VM 
> changes ? 

I recall I sent one of these to you privately already (though not all of
them). the ones to merge are these:

	00_e-nodev-1
	00_get_request_wait-race-1
	00_proc-readlink-1
	00_sync-buffer-scale-1
	30_19-nfs-kill-unlock-1
	9999900_BH_Sync-remove-1
	9999_z-execve-race-1

I benchmarked BH_Sync as a worthless logic, it increases cpu usage and
slowdown I/O a little due suprious unplugs, basically it makes no sense
until we change wait_on_buffer not to call run_task_queue if the BH is
BH_Sync, but personally I prefer to nuke it than to go mangle
wait_on_buffer, it wouldn't be a huge optimization anyways (and it's a
noop without more than one spindle running).

as you know I tried to fix the execve race w/o removing the fast path,
but the lazy tlb code didn't work correctly, I'm unsure exactly what
went wrong with it. The above fix is obviously safe instead and it
indeed works fine. I'll be busy today and early next week. If something
doesn't apply cleanly let me know and I can fix it for you.

the checksum fix as well doesn't need to be merged since the bug was
fixed on a 2.4.19 based kernel, but 2.4.20 already has an alternate fix,
but I believe the fix Andi did is much better since it's zerocost for
the common aligned case, we only must avoid generating an invalid page
fault, reading garbage from the next page has always been safe, since
the garbage will be discared by the asm. So I'm evaluating if to drop
the fix in 2.4.20 and to retain only Andi's one for performance reason.
It's obvious Andi's fix won't alter performance for the 99% of common
cases so personally I prefer it.

thanks!

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
