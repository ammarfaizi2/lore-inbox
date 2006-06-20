Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWFTGkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWFTGkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbWFTGkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:40:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965087AbWFTGkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:40:00 -0400
Date: Mon, 19 Jun 2006 23:39:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Olson <olson@unixfolk.com>
Cc: mingo@elte.hu, ccb@acm.org, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
Message-Id: <20060619233947.94f7e644.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>
	<fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>
	<Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 22:35:46 -0700 (PDT)
Dave Olson <olson@unixfolk.com> wrote:

> | 
> | I get that impression ;) If it takes 1-2 seconds to get this lock then it
> | can take five seconds.  a) that's just gross and b) the NMI watchdog will
> | nuke the box.
> | 
> | Why is it taking so long to get the lock?
> | 
> | Does it happen in non-debug mode?
> | 
> | What do we do about it?
> 
> It seems possible that this might be the cause of problems we've had
> with our InfiniPath hardware/software, and also Mellanox/OpenIB hardware/software
> on some quad-socket/dual core opteron systems (8 cpu cores).
> 
> We'll see very long delays when 8 MPI processes exit "simultaneously", and sometimes
> get NMI, sometimes system hangs, and sometimes just hung up for many seconds (and
> often in that state, doing sysrq-P or sysrq-T will make things happy again).
> 

OK.  I assume these processes have done a mmap(MAP_SHARED) of a lot of
memory?

> A typical trace looks like this (on an fc4 2.6.16 kernel):

fc4?  You seem to have an RH-FCx which doesn't enable
CONFIG_DEBUG_SPINLOCK.  Or maybe we didn't have all that debug code in
2.6.16.  Doesn't matter, really.

> [root@quad-00 ~]# NMI Watchdog detected LOCKUP on CPU 0
> CPU 0                                                  
> Modules linked in: nfs nfsd exportfs lockd nfs_acl ipv6 autofs4 sunrpc ib_sdp(U)
> ib_cm(U) ib_umad(U) ib_uverbs(U) ib_ipoib(U) ib_sa(U) ib_ipath(U) ib_mad(U)
> ib_core(U) video button battery ac i2c_nforce2 i2c_core ipath_core(U) e1000
> floppy sg dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod sata_nv libata aic79xx
> scsi_transport_spi sd_mod scsi_mod
> Pid: 4239, comm: mpi_multibw Not tainted 2.6.16-1.2096_FC4.rootsmp #1
> RIP: 0010:[<ffffffff80213a30>] <ffffffff80213a30>{_raw_write_lock+161}
> RSP: 0018:ffff810078e07c18  EFLAGS: 00000086                          
> RAX: 000000008f100300 RBX: ffff81007b7bea58 RCX: 00000000002dc5a0
> RDX: 0000000000927efd RSI: 0000000000000001 RDI: ffff81007b7bea58
> RBP: ffff81007b7bea40 R08: ffff810002e3ae80 R09: 00000000fffffffa
> R10: 0000000000000003 R11: ffffffff801644e2 R12: ffff81007b7bea58
> R13: 00002aaaad800000 R14: ffff810002e3aec0 R15: 00002aaabba6f000
> FS:  0000000040a00960(0000) GS:ffffffff80514000(0000) knlGS:00000000f7fc86c0
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b                           
> CR2: 00000033f38bdaf0 CR3: 0000000000101000 CR4: 00000000000006e0
> Process mpi_multibw (pid: 4239, threadinfo ffff810078e06000, task ffff810079d8a040)
> Stack: ffff810002e3aec0 ffffffff8016452b 0000000078ebb067 00002aaaad757000 
>        ffff810078dccab8 ffffffff8016b840 0000000000000000 ffff810078e07d38 
>        ffffffffffffffff 0000000000000000                                   
> Call Trace: <ffffffff8016452b>{__set_page_dirty_nobuffers+73}
>        <ffffffff8016b840>{unmap_vmas+1042} <ffffffff8016e638>{exit_mmap+124}
>        <ffffffff80132b07>{mmput+37} <ffffffff80138373>{do_exit+584}         
>        <ffffffff801416dc>{__dequeue_signal+459} <ffffffff80138af0>{sys_exit_group+0}
>        <ffffffff80142af3>{get_signal_to_deliver+1568}
> <ffffffff8010a14a>{do_signal+116}
>        <ffffffff80195dc1>{__pollwait+0} <ffffffff80196b0c>{sys_select+934}
>        <ffffffff8010aa87>{sysret_signal+28}
> <ffffffff8010ad73>{ptregscall_common+103}
>      
> Code: 84 c0 75 7f f0 81 03 00 00 00 01 f3 90 48 83 c1 01 48 8b 15 
> Kernel panic - not syncing: nmi watchdog               

blam, dead box, that's the one, thanks.

With our current rwlock semantics I don't know if this is fixable. 
Probably we need to go back to a spinlock on tree_lock.

With a -stable backport.  I suspect this is triggerable on demand.

<tries it, fails>

