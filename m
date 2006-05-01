Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWEARSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWEARSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWEARSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:18:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:49283 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932167AbWEARSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:18:21 -0400
Subject: Re: 2.6.17-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@google.com>, apw@shadowen.org,
       linuxppc64-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>,
       ak@suse.de
In-Reply-To: <20060501100731.051f4eff.akpm@osdl.org>
References: <4450F5AD.9030200@google.com>
	 <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com>
	 <20060501100731.051f4eff.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 01 May 2006 10:19:20 -0700
Message-Id: <1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 10:07 -0700, Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@google.com> wrote:
> >
> > Andrew Morton wrote:
> > > (I did s/linux-kernel@google.com/linux-kernel@vger.kernel.org/)
> > > 
> > > Martin Bligh <mbligh@google.com> wrote:
> > > 
> > >>Still crashes in LTP on x86_64:
> > >>(introduced in previous release)
> > >>
> > >>http://test.kernel.org/abat/29674/debug/console.log
> > > 
> > > 
> > > What a mess.  A doublefault inside an NMI watchdog timeout.  I think.  It's
> > > hard to see.  Some CPUs are stuck on a CPU scheduler lock, others seem to
> > > be stuck in flush_tlb_others.  One of these could be a consequence of the
> > > other, or both could be a consequence of something else.
> > 
> > OK, well the latest one seems cleaner, on -rc3-mm1.
> > http://test.kernel.org/abat/30007/debug/console.log
> > 
> > Just has the double fault, with no NMI watchdog timeouts. Not that
> > it means any more to me, but still ;-) mtest01 seems to be able to
> > reproduce this every time, but I don't have an appropriate box here
> > to diagnose it with (this was a 4x Opteron inside IBM), and it's
> > definitely something in -mm that's not in mainline.
> > 
> > M.
> > 
> > double fault: 0000 [1] SMP
> > last sysfs file: /devices/pci0000:00/0000:00:06.0/resource
> > CPU 0
> > Modules linked in:
> > Pid: 20519, comm: mtest01 Not tainted 2.6.17-rc3-mm1-autokern1 #1
> > RIP: 0010:[<ffffffff8047c8b8>] <ffffffff8047c8b8>{__sched_text_start+1856}
> > RSP: 0000:0000000000000000  EFLAGS: 00010082
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff805d9438
> > RDX: ffff8100db12c0d0 RSI: ffffffff805d9438 RDI: ffff8100db12c0d0
> > RBP: ffffffff805d9438 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: ffff8100e39bd440 R14: ffff810008003620 R15: 000002b02751726c
> > FS:  0000000000000000(0000) GS:ffffffff805fa000(0063) knlGS:00000000f7dd0460
> > CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> > CR2: fffffffffffffff8 CR3: 00000000da399000 CR4: 00000000000006e0
> > Process mtest01 (pid: 20519, threadinfo ffff8100b1bb4000, task 
> > ffff8100db12c0d0)
> > Stack: ffffffff80579e20 ffff8100db12c0d0 0000000000000001 ffffffff80579f58
> >         0000000000000000 ffffffff80579e78 ffffffff8020b0b2 ffffffff80579f58
> >         0000000000000000 ffffffff80485520
> > Call Trace: <#DF> <ffffffff8020b0b2>{show_registers+140}
> >         <ffffffff8020b357>{__die+159} <ffffffff8020b3cc>{die+50}
> >         <ffffffff8020bba6>{do_double_fault+115} 
> > <ffffffff8020aa91>{double_fault+125}
> >         <ffffffff8047c8b8>{__sched_text_start+1856} <EOE>
> > 
> > Code: e8 4c ba d8 ff 65 48 8b 34 25 00 00 00 00 4c 8b 46 08 f0 41
> > RIP <ffffffff8047c8b8>{__sched_text_start+1856} RSP <0000000000000000>
> >   -- 0:conmux-control -- time-stamp -- May/01/06  3:54:37 --
> 
> I was not able to reproduce this on the 4-way EMT64 machine.  Am a bit stuck.

I ran mtest01 multiple times with various options on my 4-way AMD64 box.
So far couldn't reproduce the problem (2.6.17-rc3-mm1).

Are there any special config or test options you are testing with ?

Thanks,
Badari

