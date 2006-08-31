Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWHaSaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWHaSaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWHaSaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:30:01 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62357 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932437AbWHaSaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:30:00 -0400
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
From: Badari Pulavarty <pbadari@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200608312010.20874.ak@suse.de>
References: <20060820013121.GA18401@fieldses.org>
	 <200608311716.08786.ak@suse.de>
	 <1157047877.22667.11.camel@dyn9047017100.beaverton.ibm.com>
	 <200608312010.20874.ak@suse.de>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 11:33:13 -0700
Message-Id: <1157049193.22667.19.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 20:10 +0200, Andi Kleen wrote:

> Should be fixed in .19

Andi,

I am looking at the "validity" of the stack traces. What I 
find is that "unwinder" is skipping few stack frames..

As you can see from the following stack - it shows 

	msync_interval() -> 
		set_page_dirty() -> 
			__set_page_dirty_buffers()

But actual trace is (looking at the code):

	msync_interval() -> 
	 	msync_page_range() ->
		   msync_pud_range() -> 
		      msync_pgd_range() ->
			 msync_pte_range() ->	
				set_page_dirty() -> 
					__set_page_dirty_buffers()

Why is it skipping all msync_page/pud/pgd/pte_range() routines ?

Thanks,
Badari

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at include/linux/buffer_head.h:132
invalid opcode: 0000 [1] SMP
CPU 0
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc
scsi_mod ipv6 thermal processor fan button battery ac dm_mod floppy
parport_pc lp parport
Pid: 4130, comm: fsx-linux Not tainted 2.6.18-rc4 #19
RIP: 0010:[<ffffffff802850fe>]  [<ffffffff802850fe>]
__set_page_dirty_buffers+0x3e/0xe0
RSP: 0018:ffff810173cebe38  EFLAGS: 00010246
RAX: ffff81017334a5b0 RBX: ffff81017fdb3d98 RCX: 00002b122cb37000
RDX: ffff81017334a490 RSI: ffff8101ded2bb80 RDI: ffff8101de579588
RBP: ffff810173cebe48 R08: ffff810173cebf48 R09: 1b89bb89bd895589
R10: 8b89748986893089 R11: 0000000000000246 R12: ffff8101de579518
R13: 0000000000000011 R14: 00002b122cb3d000 R15: ffff81017fdb3d98
FS:  00002b122cdc76d0(0000) GS:ffffffff806f8000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b122cb3c000 CR3: 00000001c01c9000 CR4: 00000000000006e0
Process fsx-linux (pid: 4130, threadinfo ffff810173cea000, task
ffff810173ed2040)
Stack:  ffff8101df16b9b8 00002b122cb37000 ffff810173cebe58
ffffffff8025de8b
 ffff810173cebf18 ffffffff8026d34b ffff810173cebf28 ffff810173cebf48
 00002b122cb3d000 ffff810179d2f978 ffff8101c01c92b0 0000000000000000
Call Trace:
 [<ffffffff8025de8b>] set_page_dirty+0x3b/0x60
 [<ffffffff8026d34b>] msync_interval+0x2cb/0x420
 [<ffffffff8026d5ab>] sys_msync+0x10b/0x2b0
 [<ffffffff80209d5a>] system_call+0x7e/0x83
 [<00002b122cc53510>]
 [<ffffffff8025de8b>] set_page_dirty+0x3b/0x60
 [<ffffffff8026d34b>] msync_interval+0x2cb/0x420
 [<ffffffff8026d5ab>] sys_msync+0x10b/0x2b0
 [<ffffffff80209d5a>] system_call+0x7e/0x83

Thanks,
Badari

