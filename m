Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWERF0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWERF0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWERF0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:26:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:18593 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751212AbWERF0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:26:33 -0400
Date: Wed, 17 May 2006 22:26:32 -0700 (PDT)
From: Dave Olson <olson@pathscale.com>
Reply-To: olson@pathscale.com
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 35 of 53] ipath - some interrelated
 stability and cleanliness fixes
In-Reply-To: <Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com>
Message-ID: <Pine.LNX.4.64.0605172219490.17570@topaz.pathscale.com>
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
 <fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no> <Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
 <ada4pzo5xti.fsf@cisco.com> <Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Dave Olson wrote:

| On Wed, 17 May 2006, Roland Dreier wrote:
| 
| | Am I understanding correctly that you see a hang or watchdog timeout
| | even with the mthca driver?
| 
| Yes.   That is, the symptoms are the same, although the cause
| may be different.
| 
| | Is there any possibility of posting the test case to reproduce this?
| 
| It's the MPI job mpi_multibw (based on the OSU osu_bw, but changed
| to do messaging rate), running 8 copies per dual-core 4-socket opteron,
| both on InfiniPath MPI, and MVAPICH (built for gen2).

Here's the typical case where the watchdog fires (with infinipath MPI),
on FC4 2.6.16 2108 (without kprobes, with kprobes things are slightly
different, but not much; I'm running without since we were often in
the kprobes code from the exit code, but I think that's just a red-herring).

The sysrq p was some seconds prior to the watchdog.  It's almost as
though something is looping far too many times during the close cleanup.

The other 7 exitting processes are typically in
	sys_exit_group -> do_exit -> __up_red --> __spin_lock_irqsave -> __up_read (or __down_read)
(from what sysrq t prints).  They are all runnable on the other 7
processors.  

The infinipath driver does mmap both memory and device pages for each of
these processes.

SysRq : Show Regs
CPU 0:           
Modules linked in: ib_sdp(U) ib_cm(U) ib_umad(U) ib_uverbs(U) ib_ipath(U) ib_ipoib(U) ib_sa(U) ib_mad(U) ib_core(U) ipath_core(U) nfs(U) nfsd(U) exportfs(U) lockd(U) nfs_acl(U) ipv6(U) autofs4(U) sunrpc(U) video(U) button(U) battery(U) ac(U) i2c_nforce2(U) i2c_core(U) e1000(U) floppy(U) sg(U) dm_snapshot(U) dm_zero(U) dm_mirror(U) ext3(U) jbd(U) dm_mod(U) sata_nv(U) libata(U) aic79xx(U) scsi_transport_spi(U) sd_mod(U) scsi_mod(U)
Pid: 23788, comm: mpi_multibw Not tainted 2.6.16-1.2108_FC4.rootsmp #1           
RIP: 0010:[<ffffffff8013c50e>] <ffffffff8013c50e>{__do_softirq+81}    
RSP: 0018:ffffffff8048d368  EFLAGS: 00000206                      
RAX: 0000000000000022 RBX: 0000000000000022 RCX: 0000000000000080
RDX: 0000000000000000 RSI: 00000000000000c0 RDI: ffff81007f1fd0c0
RBP: ffffffff80528f80 R08: 0000000000000200 R09: 0000000000000002
R10: ffffffff804a6a38 R11: 0000000000000000 R12: ffffffff80577c80
R13: 0000000000000000 R14: 000000000000000a R15: 00002aaabba6c000
FS:  00002aaaab32ffa0(0000) GS:ffffffff80511000(0000) knlGS:00000000f7fc86c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b                           
CR2: 000055555565ebe8 CR3: 000000007ac6d000 CR4: 00000000000006e0
                                                                 
Call Trace: <IRQ> <ffffffff8010c076>{call_softirq+30}
       <ffffffff8010d82c>{do_softirq+44} <ffffffff8010b9d0>{apic_timer_interrupt+132} <EOI>
       <ffffffff80355226>{_write_unlock_irq+14} <ffffffff801659d9>{__set_page_dirty_nobuffers+183}
       <ffffffff8016cc80>{unmap_vmas+1042} <ffffffff8016fa78>{exit_mmap+124}
       <ffffffff80133f17>{mmput+37} <ffffffff80139783>{do_exit+584}         
       <ffffffff80142aec>{__dequeue_signal+459} <ffffffff80139f00>{sys_exit_group+0}
       <ffffffff80143f03>{get_signal_to_deliver+1568} <ffffffff8010a37a>{do_signal+116}
       <ffffffff80197151>{__pollwait+0} <ffffffff80197e9c>{sys_select+934}             
       <ffffffff8010acb7>{sysret_signal+28} <ffffffff8010afa3>{ptregscall_common+103}

[ perhaps 20 or 30 seconds later, NMI fires; we had already been sort of
stuck for 60 seconds or so when I did the sysrq p above ]

NMI Watchdog detected LOCKUP on CPU 1                                                
CPU 1                                
Modules linked in: ib_sdp(U) ib_cm(U) ib_umad(U) ib_uverbs(U) ib_ipath(U) ib_ipoib(U) ib_sa(U) ib_mad(U) ib_core(U) ipath_core(U) nfs(U) nfsd(U) exportfs(U) lockd(U) nfs_acl(U) ipv6(U) autofs4(U) sunrpc(U) video(U) button(U) battery(U) ac(U) i2c_nforce2(U) i2c_core(U) e1000(U) floppy(U) sg(U) dm_snapshot(U) dm_zero(U) dm_mirror(U) ext3(U) jbd(U) dm_mod(U) sata_nv(U) libata(U) aic79xx(U) scsi_transport_spi(U) sd_mod(U) scsi_mod(U)
Pid: 23789, comm: mpi_multibw Not tainted 2.6.16-1.2108_FC4.rootsmp #1           
RIP: 0010:[<ffffffff80214bd0>] <ffffffff80214bd0>{_raw_write_lock+161}
RSP: 0018:ffff81007c5b5c18  EFLAGS: 00000086                          
RAX: 000000008f02e600 RBX: ffff810037cec680 RCX: 00000000002c2671
RDX: 0000000000927190 RSI: 0000000000000001 RDI: ffff810037cec680
RBP: ffff810037cec668 R08: ffff810002d6b500 R09: 00000000fffffffa
R10: 0000000000000003 R11: ffffffff80165922 R12: ffff810037cec680
R13: 00002aaaac200000 R14: ffff810002d6b540 R15: 00002aaabba6c000
FS:  00002aaaaaae6080(0000) GS:ffff81011fc466c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b                           
CR2: 00000033f38bdaf0 CR3: 000000007c296000 CR4: 00000000000006e0
Process mpi_multibw (pid: 23789, threadinfo ffff81007c5b4000, task ffff8100030557a0)
Stack: ffff810002d6b540 ffffffff8016596b 0000000075ad5067 00002aaaac1b4000          
       ffff81007d451da0 ffffffff8016cc80 0000000000000000 ffff81007c5b5d38 
       ffffffffffffffff 0000000000000000                                   
Call Trace: <ffffffff8016596b>{__set_page_dirty_nobuffers+73}
       <ffffffff8016cc80>{unmap_vmas+1042} <ffffffff8016fa78>{exit_mmap+124}
       <ffffffff80133f17>{mmput+37} <ffffffff80139783>{do_exit+584}         
       <ffffffff80142aec>{__dequeue_signal+459} <ffffffff80139f00>{sys_exit_group+0}
       <ffffffff80143f03>{get_signal_to_deliver+1568} <ffffffff8010a37a>{do_signal+116}
       <ffffffff80197151>{__pollwait+0} <ffffffff80197e9c>{sys_select+934}             
       <ffffffff8010acb7>{sysret_signal+28} <ffffffff8010afa3>{ptregscall_common+103}
                                                                                     
Code: 84 c0 75 7f f0 81 03 00 00 00 01 f3 90 48 83 c1 01 48 8b 15 
Kernel panic - not syncing: nmi watchdog    
