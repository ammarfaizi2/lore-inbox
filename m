Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWADR1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWADR1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbWADR1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:27:37 -0500
Received: from solarneutrino.net ([66.199.224.43]:1796 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S965232AbWADR1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:27:35 -0500
Date: Wed, 4 Jan 2006 12:27:27 -0500
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060104172727.GA320@tau.solarneutrino.net>
References: <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com> <20051212165443.GD17295@tau.solarneutrino.net> <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org> <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org> <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net> <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net> <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 06:21:39PM +0200, Kai Makisara wrote:
> On Mon, 26 Dec 2005, Ryan Richter wrote:
> 
> > On Thu, Dec 15, 2005 at 08:01:43PM -0800, James Bottomley wrote:
> > > On Thu, 2005-12-15 at 14:09 -0500, Ryan Richter wrote:
> > > > On Mon, Dec 12, 2005 at 12:24:42PM -0600, James Bottomley wrote:
> > > > > I'll find a fix for the real problem, but this patch isn't the cause.
> > > > 
> > > > Is the patch set you posted yesterday supposed to fix this?  If so, is
> > > > it available in patch form anywhere?
> > > 
> > > No, I've been too busin integrating other people's patches to work on
> > > ones of my own.  Try this.
> > 
> > It was looking good, but...
> > 
> > 
> >                    Bad page state at free_hot_cold_page (in process 'taper', page ffff8100040e22e8)
> > flags:0x010000000000000c mapping:ffff810102bba238 mapcount:2 count:0
> > Backtrace:
> > 
> Looks familiar ;-(
> 
> I don't have any new ideas but I will tell you what I have tried. In order 
> to get more information about what is happening, I inserted the patch at 
> the end of this message to my kernel. The purpose of the patch was to 
> print something about the page mappings (prt_pages) and to catch possible 
> double freeing from st earlier (clear page pointers).
> 
> Running dump gave me the following output:

Here's what I got:


 st: page attributes before page_release 8
 0: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1392956
 1: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1397945
 2: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1537473
 3: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1398161
 4: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1398261
 5: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1392778
 6: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1402858
 7: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1396799
Bad page state at free_hot_cold_page (in process 'taper', page ffff81000427ff60)
flags:0x010000000000000c mapping:ffff810102bbaaf0 mapcount:2 count:0
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff80150c3f>{free_hot_cold_page+105}
       <ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'taper', page ffff810003ed9290)
flags:0x010000000000000c mapping:ffff810102bbaaf0 mapcount:2 count:0
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff80150c3f>{free_hot_cold_page+105}
       <ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}

Trying to fix it up, but a reboot is needed
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/swap.c:49
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in: bonding
Pid: 2892, comm: taper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff8015751c>] <ffffffff8015751c>{put_page+96}
RSP: 0018:ffff81017a247e18  EFLAGS: 00010256
RAX: 0000000000000000 RBX: 00000000000000c0 RCX: ffff81000427ff60
RDX: ffff81000427ff60 RSI: 0000000000000001 RDI: ffff81000427ff60
RBP: 0000000000000006 R08: ffff81017a246000 R09: 0000000000000001
R10: ffff8100f6f31aa0 R11: 0000000000000046 R12: 0000000000000008
R13: ffff8100f6f9e068 R14: 0000000000000000 R15: 0000000000008000
FS:  00002aaaab53d880(0000) GS:ffffffff804a9880(0000) knlGS:00000000556b6920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 00000001722be000 CR4: 00000000000006e0
Process taper (pid: 2892, threadinfo ffff81017a246000, task ffff81017e63a140)
Stack: 010000000000000c ffffffff8028c534 0000000000008000 0000000000008000
       ffff8100f6f9e000 ffff810004840200 0000000000008000 0000000000000040
       0000000000008000 ffffffff8028826d
Call Trace:<ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}


Code: 0f 0b 68 ae b1 36 80 c2 31 00 f0 83 42 08 ff 0f 98 c0 84 c0
RIP <ffffffff8015751c>{put_page+96} RSP <ffff81017a247e18>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/rmap.c:486
invalid operand: 0000 [2] SMP
CPU 1
Modules linked in: bonding
Pid: 2892, comm: taper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff80163736>] <ffffffff80163736>{page_remove_rmap+19}
RSP: 0018:ffff81017a247aa0  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff81000427ff60 RCX: 0000000000000020
RDX: 80000000e6db4067 RSI: 80000000e6db4067 RDI: ffff81000427ff60
RBP: 80000000e6db4067 R08: 0000000000000020 R09: 00002aaaaaafe000
R10: 00000000000e6db4 R11: 0000000000000000 R12: ffff810101c25480
R13: ffff8101722a07f0 R14: 00002aaaaaafe000 R15: 0000000000000000
FS:  00002aaaab53d880(0000) GS:ffffffff804a9880(0000) knlGS:00000000556b6920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 00000001722be000 CR4: 00000000000006e0
Process taper (pid: 2892, threadinfo ffff81017a246000, task ffff81017e63a140)
Stack: ffffffff8015be23 ffff81017a247ae8 ffff81010190d310 ffffffc100000000
       ffff81017f078180 ffff81017a247bb8 00002aaaaab62000 ffff81017d039368
       00002aaaaab62000 ffff810172296aa8
Call Trace:<ffffffff8015be23>{zap_pte_range+464} <ffffffff8015c0ff>{unmap_page_range+476}
       <ffffffff8015c24e>{unmap_vmas+238} <ffffffff8016167b>{exit_mmap+114}
       <ffffffff8012d638>{mmput+34} <ffffffff8013214a>{do_exit+489}
       <ffffffff8010f203>{die_nmi+0} <ffffffff8010f587>{do_invalid_op+145}
       <ffffffff8015751c>{put_page+96} <ffffffff803448db>{thread_return+0}
       <ffffffff8010e49d>{error_exit+0} <ffffffff8015751c>{put_page+96}
       <ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}


Code: 0f 0b 68 b0 b2 36 80 c2 e6 01 48 83 ce ff bf 20 00 00 00 e9
RIP <ffffffff80163736>{page_remove_rmap+19} RSP <ffff81017a247aa0>
 <1>Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request at 0000000000100108 RIP:
<ffffffff80150d53>{buffered_rmqueue+120}
PGD 170d24067 PUD 1551d3067 PMD 0
Oops: 0002 [3] SMP
CPU 1
Modules linked in: bonding
Pid: 2898, comm: dumper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff80150d53>] <ffffffff80150d53>{buffered_rmqueue+120}
RSP: 0018:ffff8100bcc17a98  EFLAGS: 00010002
RAX: ffff810003ed92b8 RBX: ffff81010287a340 RCX: 0000000000200200
RDX: 0000000000100100 RSI: 0000000000000000 RDI: ffff81000000f300
RBP: ffff81000000f300 R08: 0000000000000000 R09: 000000000000095b
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: ffff810003ed9290 R15: 00000000000200d2
FS:  00002aaaab53d8e0(0000) GS:ffffffff804a9880(0000) knlGS:00000000556b6920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 000000017d27f000 CR4: 00000000000006e0
Process dumper (pid: 2898, threadinfo ffff8100bcc16000, task ffff8100bd0d4140)
Stack: ffff81011ae74810 000000001ae74810 0000000000000282 ffff810100001c18
       0000000000000044 0000000000000000 0000000000000000 ffff810100001c10
       0000000000000002 ffffffff80150fe3
Call Trace:<ffffffff80150fe3>{get_page_from_freelist+130} <ffffffff80151067>{__alloc_pages+86}
       <ffffffff8014e7f9>{generic_file_buffered_write+402}
       <ffffffff80134113>{current_fs_time+97} <ffffffff8014ef95>{__generic_file_aio_write_nolock+891}
       <ffffffff802ea7fb>{sock_common_recvmsg+45} <ffffffff802e7724>{sock_aio_read+252}
       <ffffffff8014f1ff>{generic_file_aio_write+105} <ffffffff801a2979>{ext3_file_write+22}
       <ffffffff8016d8d5>{do_sync_write+202} <ffffffff8017e9e8>{__pollwait+0}
       <ffffffff80142cca>{autoremove_wake_function+0} <ffffffff8017f22a>{sys_select+952}
       <ffffffff8016d9bc>{vfs_write+173} <ffffffff8016dac8>{sys_write+69}
       <ffffffff8010d762>{system_call+126}

Code: 48 89 4a 08 48 89 11 48 c7 40 08 00 02 20 00 48 c7 00 00 01
RIP <ffffffff80150d53>{buffered_rmqueue+120} RSP <ffff8100bcc17a98>
CR2: 0000000000100108
 <1>Unable to handle kernel paging request at 0000000000100108 RIP:
<ffffffff80150d53>{buffered_rmqueue+120}
PGD 170d24067 PUD 1551d3067 PMD 0
Oops: 0002 [4] SMP
CPU 1
Modules linked in: bonding
Pid: 2898, comm: dumper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff80150d53>] <ffffffff80150d53>{buffered_rmqueue+120}
RSP: 0018:ffff81010289bca8  EFLAGS: 00010002
RAX: ffff810003ed92b8 RBX: ffff81010287a340 RCX: 0000000000200200
RDX: 0000000000100100 RSI: 0000000000000000 RDI: ffff81000000f300
RBP: ffff81000000f300 R08: 0000000000000000 R09: 000000000000095b
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: ffff810003ed9290 R15: 0000000000020020
FS:  00002aaaab53d8e0(0000) GS:ffffffff804a9880(0000) knlGS:00000000556b6920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 000000017d27f000 CR4: 00000000000006e0
Process dumper (pid: 2898, threadinfo ffff8100bcc16000, task ffff8100bd0d4140)
Stack: ffff8100e78d55f8 0000000000000000 0000000000000082 ffff810100000c08
       0000000000000044 0000000000000000 0000000000000000 ffff810100000c00
       0000000000000002 ffffffff80150fe3
Call Trace: <IRQ> <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff801545b1>{kmem_getpages+88}
       <ffffffff80155789>{cache_grow+195} <ffffffff801559d0>{cache_alloc_refill+408}
       <ffffffff80155feb>{__kmalloc+100} <ffffffff802eb11b>{__alloc_skb+83}
       <ffffffff802663a6>{tg3_alloc_rx_skb+186} <ffffffff80266630>{tg3_rx+338}
       <ffffffff80266998>{tg3_poll+135} <ffffffff802f0a85>{net_rx_action+129}
       <ffffffff801342b8>{__do_softirq+80} <ffffffff8010eae3>{call_softirq+31}
       <ffffffff80110384>{do_softirq+47} <ffffffff8010e34a>{apic_timer_interrupt+98}
        <EOI> <ffffffff8034566b>{__down_read+147} <ffffffff803455ea>{__down_read+18}
       <ffffffff8012d6f3>{mm_release+30} <ffffffff801316a0>{exit_mm+43}
       <ffffffff8013214a>{do_exit+489} <ffffffff8011d3c6>{do_page_fault+1215}
       <ffffffff801affef>{do_get_write_access+1277} <ffffffff8010e49d>{error_exit+0}
       <ffffffff80150d53>{buffered_rmqueue+120} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff8014e7f9>{generic_file_buffered_write+402}
       <ffffffff80134113>{current_fs_time+97} <ffffffff8014ef95>{__generic_file_aio_write_nolock+891}
       <ffffffff802ea7fb>{sock_common_recvmsg+45} <ffffffff802e7724>{sock_aio_read+252}
       <ffffffff8014f1ff>{generic_file_aio_write+105} <ffffffff801a2979>{ext3_file_write+22}
       <ffffffff8016d8d5>{do_sync_write+202} <ffffffff8017e9e8>{__pollwait+0}
       <ffffffff80142cca>{autoremove_wake_function+0} <ffffffff8017f22a>{sys_select+952}
       <ffffffff8016d9bc>{vfs_write+173} <ffffffff8016dac8>{sys_write+69}
       <ffffffff8010d762>{system_call+126}

Code: 48 89 4a 08 48 89 11 48 c7 40 08 00 02 20 00 48 c7 00 00 01
RIP <ffffffff80150d53>{buffered_rmqueue+120} RSP <ffff81010289bca8>
CR2: 0000000000100108
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


-ryan
