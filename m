Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422760AbWJPQ3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbWJPQ3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422766AbWJPQ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65454 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422760AbWJPQ2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:43 -0400
Subject: Re: Strange SIGSEGV problem around dmcrypt, evms and jfs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, dm-crypt@saout.de,
       mingo@elte.hu, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.63.0610161737250.14187@alpha.polcom.net>
References: <Pine.LNX.4.63.0610161737250.14187@alpha.polcom.net>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 11:28:35 -0500
Message-Id: <1161016116.6997.24.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 18:12 +0200, Grzegorz Kulewski wrote:
> Hi,
> 
> I was begining to play with dmcrypt, evms and jfs on one spare disk I 
> have (currently empty and only for tests). I produced some partitions with 
> evms and made volumes on them. Nothing strange, normal configuration. The 
> partition layout seems ok. Then I used dmcrypt mappings on top of two of 
> them to make encrypted swaps and swapon'ed them. Still everything was ok. 
> Then I tested different ciphers performance by doing dmcrypt mappings on 
> top of some other volume with different settings and dd'ed data from and 
> to them to test the speed. Then I choosen one cipher setup and and did the 
> final mapping and created and mounted  jfs on it. Then I copied one large 
> (like 4GB) file on it several times to make sure everything is ok. I 
> checked sha1sums and everything was indeed ok.
> 
> But then all big applications (firefox, oo2, acroread, ..., opera was the 
> notable exception) couldn't start being killed by SIGSEGVs out of nowhere. 
> I reproduced it two time already (after a clean reboot): today and 
> yesterday. Maybe someone knows what is happening? For me it looks like 
> something broken some kernel memory and the kernel started doing stupid 
> things. But nothing strange has shown in logs.
> 
> One time I couldn't even shut down the machine normally, only SysRQ-B 
> worked (shutdown scripts were probably killed too or something). Every 
> application works ok (and did so for at least a year) before I will start 
> playing with dmcrypt and jfs. I am not sure where exactly the problems 
> start but will be investigating it shortly.
> 
> I am rather sure that my hardware is ok. Everything was and is fine till I 
> will start doing these tests.

What were you running before?  jfs?  evms?  Is dm-crypt the only new
element?  Trying a different file system on the same partition should
give you an idea whether jfs is a factor or not.

> Including that testing disk (tested with 
> smart and dd and some others). My setup is:
> - Athlon (Barton) XP 2000MHz
> - Abit KW7 KT880 board
> - 1GB DDR 133
> - main disk is 80GB Samsung @ IDE (VIA southbridge)
> - testing disk is 250GB Seagate @ SATA (VIA southbridge).
> 
> This behavoiur was observed on 2.6.18-ck1 + vesafb-tng patch. Kernel was 
> tainted by nvidia and kqemu modules. Now I am trying to recreate this 
> problem with 2.6.18.1 with nearly all kernel debuging options turned on
> and without any proprietary modules loaded. But since I don't know exactly 
> how to reproduce the problem it may take some time so any suggestions what 
> can be wrong are welcome.
> 
> Further info available on request.
> 
> BTW. Why booting my machine with 2.6.18.1 with nearly all debuging on I 
> got the following. While I am nearly sure it is not the problem I am 
> writing about I will report it:
> 
> Oct 16 17:29:33 kangur [   74.485627] =============================================
> Oct 16 17:29:33 kangur [   74.485767] [ INFO: possible recursive locking detected ]
> Oct 16 17:29:33 kangur [   74.485840] ---------------------------------------------

This is caused by CONFIG_DEBUG_LOCKDEP.  This will show false positives
against code that hasn't been annotated for lockdep.  I know the jfs
code hasn't been annotated yet, and from the look of this, neither has
the device-mapper code.  You should disable that option, since I doubt
it would be very helpful in tracking down a segfault, even if the code
was properly annotated.  The lockdep code is primarily for detecting
possible opportunities for a deadlock.

> Oct 16 17:29:33 kangur [   74.485912] evms_activate/2346 is trying to acquire lock:
> Oct 16 17:29:33 kangur [   74.485985]  (&md->io_lock){----}, at: [<f8d95458>] dm_request+0x18/0x150 [dm_mod]
> Oct 16 17:29:33 kangur [   74.486269]
> Oct 16 17:29:33 kangur [   74.486270] but task is already holding lock:
> Oct 16 17:29:33 kangur [   74.486406]  (&md->io_lock){----}, at: [<f8d95458>] dm_request+0x18/0x150 [dm_mod]
> Oct 16 17:29:33 kangur [   74.486673]
> Oct 16 17:29:33 kangur [   74.486674] other info that might help us debug this:
> Oct 16 17:29:33 kangur [   74.486813] 1 lock held by evms_activate/2346:
> Oct 16 17:29:33 kangur [   74.486883]  #0:  (&md->io_lock){----}, at: [<f8d95458>] dm_request+0x18/0x150 [dm_mod]
> Oct 16 17:29:33 kangur [   74.487191]
> Oct 16 17:29:33 kangur [   74.487192] stack backtrace:
> Oct 16 17:29:33 kangur [   74.487475]  [<c01043ad>] show_trace_log_lvl+0x18d/0x1b0
> Oct 16 17:29:33 kangur [   74.487606]  [<c0104af2>] show_trace+0x12/0x20
> Oct 16 17:29:33 kangur [   74.487728]  [<c0104b59>] dump_stack+0x19/0x20
> Oct 16 17:29:33 kangur [   74.487851]  [<c0136193>] __lock_acquire+0x813/0xd80
> Oct 16 17:29:33 kangur [   74.488044]  [<c0136a65>] lock_acquire+0x75/0xa0
> Oct 16 17:29:33 kangur [   74.488230]  [<c013298a>] down_read+0x3a/0x50
> Oct 16 17:29:33 kangur [   74.488413]  [<f8d95458>] dm_request+0x18/0x150 [dm_mod]
> Oct 16 17:29:33 kangur [   74.488543]  [<c0211517>] generic_make_request+0x147/0x1c0
> Oct 16 17:29:33 kangur [   74.489020]  [<f8d9443d>] __map_bio+0x4d/0xa0 [dm_mod]
> Oct 16 17:29:33 kangur [   74.489141]  [<f8d9517a>] __split_bio+0x34a/0x380 [dm_mod]
> Oct 16 17:29:33 kangur [   74.489263]  [<f8d95514>] dm_request+0xd4/0x150 [dm_mod]
> Oct 16 17:29:33 kangur [   74.489384]  [<c0211517>] generic_make_request+0x147/0x1c0
> Oct 16 17:29:33 kangur [   74.489745]  [<c0213bc2>] submit_bio+0x72/0x120
> Oct 16 17:29:33 kangur [   74.490112]  [<c016ee8a>] submit_bh+0xca/0x120
> Oct 16 17:29:33 kangur [   74.490358]  [<c0171f58>] block_read_full_page+0x258/0x2d0
> Oct 16 17:29:33 kangur [   74.490602]  [<c0174ecf>] blkdev_readpage+0xf/0x20
> Oct 16 17:29:33 kangur [   74.490851]  [<c0154740>] __do_page_cache_readahead+0x1b0/0x260
> Oct 16 17:29:33 kangur [   74.491071]  [<c0154852>] blockable_page_cache_readahead+0x62/0xe0
> Oct 16 17:29:33 kangur [   74.491288]  [<c0154a9d>] page_cache_readahead+0x11d/0x1d0
> Oct 16 17:29:33 kangur [   74.491504]  [<c014e6b2>] do_generic_mapping_read+0x462/0x4e0
> Oct 16 17:29:33 kangur [   74.491718]  [<c014f0de>] __generic_file_aio_read+0xee/0x220
> Oct 16 17:29:33 kangur [   74.491929]  [<c015048d>] generic_file_read+0x8d/0xb0
> Oct 16 17:29:33 kangur [   74.492141]  [<c016d94d>] vfs_read+0xad/0x180
> Oct 16 17:29:33 kangur [   74.492377]  [<c016ddbd>] sys_read+0x3d/0x70
> Oct 16 17:29:33 kangur [   74.492616]  [<c01030ed>] sysenter_past_esp+0x56/0x8d
> Oct 16 17:29:33 kangur [   74.492736]  [<b7f19410>] 0xb7f19410
> 
> 
> Thanks in advance,
> 
> Grzegorz Kulewski
> 
-- 
David Kleikamp
IBM Linux Technology Center

