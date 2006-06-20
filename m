Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWFTFgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWFTFgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWFTFgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:36:01 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:19629 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932497AbWFTFgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:36:00 -0400
Date: Mon, 19 Jun 2006 22:35:46 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
In-Reply-To: <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>
 <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Andrew Morton wrote:

| On Mon, 19 Jun 2006 13:39:44 +0200
| Ingo Molnar <mingo@elte.hu> wrote:
| 
| > 
| > * Andrew Morton <akpm@osdl.org> wrote:
| > 
| > > > The write_trylock + __delay in the loop is not a problem or a bug, as 
| > > > the trylock will at most _increase_ the delay - and our goal is to not 
| > > > have a false positive, not to be absolutely accurate about the 
| > > > measurement here.
| > > 
| > > Precisely.  We have delays of over a second (but we don't know how 
| > > much more than a second).  Let's say two seconds.  The NMI watchdog 
| > > timeout is, what?  Five seconds?
| > 
| > i dont see the problem.
| 
| It's taking over a second to acquire a write_lock.  A lock which is
| unlikely to be held for more than a microsecond anywhere.  That's really
| bad, isn't it?  Being on the edge of an NMI watchdog induced system crash
| is bad, too.
| 
| > We'll have tried that lock hundreds of thousands 
| > of times before this happens. The NMI watchdog will only trigger if we 
| > do this with IRQs disabled.
| 
| tree_lock uses write_lock_irq().
| 
| > And it's not like the normal 
| > __write_lock_failed codepath would be any different: for heavily 
| > contended workloads the overhead is likely in the cacheline bouncing, 
| > not in the __delay().
| 
| Yes, it might also happen with !CONFIG_DEBUG_SPINLOCK.  We need to find out
| if that's so and if so, why.
| 
| > > That's getting too close.  The result will be a total system crash.  
| > > And RH are shipping this.
| > 
| > I dont see a connection. Pretty much the only thing the loop condition 
| > impacts is the condition under which we print out a 'i think we 
| > deadlocked' message.
| 
| I'm assuming that the additional delay in the debug code has worsened the
| situation.
| 
| > Have i missed your point perhaps?
| 
| I get that impression ;) If it takes 1-2 seconds to get this lock then it
| can take five seconds.  a) that's just gross and b) the NMI watchdog will
| nuke the box.
| 
| Why is it taking so long to get the lock?
| 
| Does it happen in non-debug mode?
| 
| What do we do about it?

It seems possible that this might be the cause of problems we've had
with our InfiniPath hardware/software, and also Mellanox/OpenIB hardware/software
on some quad-socket/dual core opteron systems (8 cpu cores).

We'll see very long delays when 8 MPI processes exit "simultaneously", and sometimes
get NMI, sometimes system hangs, and sometimes just hung up for many seconds (and
often in that state, doing sysrq-P or sysrq-T will make things happy again).

A typical trace looks like this (on an fc4 2.6.16 kernel):

[root@quad-00 ~]# NMI Watchdog detected LOCKUP on CPU 0
CPU 0                                                  
Modules linked in: nfs nfsd exportfs lockd nfs_acl ipv6 autofs4 sunrpc ib_sdp(U)
ib_cm(U) ib_umad(U) ib_uverbs(U) ib_ipoib(U) ib_sa(U) ib_ipath(U) ib_mad(U)
ib_core(U) video button battery ac i2c_nforce2 i2c_core ipath_core(U) e1000
floppy sg dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod sata_nv libata aic79xx
scsi_transport_spi sd_mod scsi_mod
Pid: 4239, comm: mpi_multibw Not tainted 2.6.16-1.2096_FC4.rootsmp #1
RIP: 0010:[<ffffffff80213a30>] <ffffffff80213a30>{_raw_write_lock+161}
RSP: 0018:ffff810078e07c18  EFLAGS: 00000086                          
RAX: 000000008f100300 RBX: ffff81007b7bea58 RCX: 00000000002dc5a0
RDX: 0000000000927efd RSI: 0000000000000001 RDI: ffff81007b7bea58
RBP: ffff81007b7bea40 R08: ffff810002e3ae80 R09: 00000000fffffffa
R10: 0000000000000003 R11: ffffffff801644e2 R12: ffff81007b7bea58
R13: 00002aaaad800000 R14: ffff810002e3aec0 R15: 00002aaabba6f000
FS:  0000000040a00960(0000) GS:ffffffff80514000(0000) knlGS:00000000f7fc86c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b                           
CR2: 00000033f38bdaf0 CR3: 0000000000101000 CR4: 00000000000006e0
Process mpi_multibw (pid: 4239, threadinfo ffff810078e06000, task ffff810079d8a040)
Stack: ffff810002e3aec0 ffffffff8016452b 0000000078ebb067 00002aaaad757000 
       ffff810078dccab8 ffffffff8016b840 0000000000000000 ffff810078e07d38 
       ffffffffffffffff 0000000000000000                                   
Call Trace: <ffffffff8016452b>{__set_page_dirty_nobuffers+73}
       <ffffffff8016b840>{unmap_vmas+1042} <ffffffff8016e638>{exit_mmap+124}
       <ffffffff80132b07>{mmput+37} <ffffffff80138373>{do_exit+584}         
       <ffffffff801416dc>{__dequeue_signal+459} <ffffffff80138af0>{sys_exit_group+0}
       <ffffffff80142af3>{get_signal_to_deliver+1568}
<ffffffff8010a14a>{do_signal+116}
       <ffffffff80195dc1>{__pollwait+0} <ffffffff80196b0c>{sys_select+934}
       <ffffffff8010aa87>{sysret_signal+28}
<ffffffff8010ad73>{ptregscall_common+103}
     
Code: 84 c0 75 7f f0 81 03 00 00 00 01 f3 90 48 83 c1 01 48 8b 15 
Kernel panic - not syncing: nmi watchdog               


And a sysrq-P often looks like this:

SysRq : Show Regs
CPU 0:
Modules linked in: nfs nfsd exportfs lockd nfs_acl ipv6 autofs4 sunrpc ib_sdp(U)
ib_cm(U) ib_umad(U) ib_uverbs(U) ib_ipoib(U) ib_sa(U) ib_ipath(U) ib_mad(U)
ib_core(U) video button battery ac i2c_nforce2 i2c_core ipath_core(U) e1000
floppy sg dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod sata_nv libata aic79xx
scsi_transport_spi sd_mod scsi_mod
Pid: 3702, comm: mpi_multibw Not tainted 2.6.16-1.2096_FC4.rootsmp #1
RIP: 0010:[<ffffffff8013b0fe>] <ffffffff8013b0fe>{__do_softirq+81}
RSP: 0018:ffffffff8048f868  EFLAGS: 00000206
RAX: 0000000000000022 RBX: 0000000000000022 RCX: 0000000000000300
RDX: 0000000000000000 RSI: 00000000000000c0 RDI: ffff81007a60a860
RBP: ffffffff8052bf80 R08: 0000000000000211 R09: 0000000000000008
R10: ffff8100dff92ac8 R11: 0000000000000000 R12: ffffffff8057ad80
R13: 0000000000000000 R14: 000000000000000a R15: 00002aaabba6f000
FS:  00002aaaabc5bd60(0000) GS:ffffffff80514000(0000) knlGS:00000000f7f9dbb0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaab9b1af0 CR3: 00000000de70a000 CR4: 00000000000006e0

Call Trace: <IRQ> <ffffffff8010be46>{call_softirq+30}
       <ffffffff8010cdcc>{do_softirq+44}
<ffffffff8010b7a0>{apic_timer_interrupt+132} <EOI>
       <ffffffff80354016>{_write_unlock_irq+14}
<ffffffff80164599>{__set_page_dirty_nobuffers+183}
       <ffffffff8016b840>{unmap_vmas+1042} <ffffffff8016e638>{exit_mmap+124}
       <ffffffff80132b07>{mmput+37} <ffffffff80138373>{do_exit+584}
       <ffffffff801416dc>{__dequeue_signal+459} <ffffffff80138af0>{sys_exit_group+0}
       <ffffffff80142af3>{get_signal_to_deliver+1568}
<ffffffff8010a14a>{do_signal+116}
       <ffffffff80195dc1>{__pollwait+0} <ffffffff80196b0c>{sys_select+934}
       <ffffffff8010aa87>{sysret_signal+28}
<ffffffff8010ad73>{ptregscall_common+103}

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
