Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbULVHul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbULVHul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 02:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbULVHul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 02:50:41 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:25035 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261853AbULVHu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 02:50:27 -0500
Date: Wed, 22 Dec 2004 02:50:20 -0500 (EST)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: Nathan Scott <nathans@sgi.com>
cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] XFS crash using Realtime Preemption patch
In-Reply-To: <20041222093242.B674830@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.60-041.0412220246390.11361@unix49.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu>
 <20041221104042.GA31843@elte.hu> <20041222093242.B674830@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added
         BUG_ON( (mrp->mr_writer != 0) && (mrp->mr_writer != 1) );
to mrlock.h : mrunlock() to see if it was corruption and got the following 
instead.  It's a similar call pathway, but somewhat different.

kernel BUG at kernel/rt.c:1210!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: uhci_hcd rtc eth1394 ohci1394 ieee1394 pcmcia 
hostap_pci hostap 8139too mii yenta_socket pcmcia_core ehci_hcd 
i2c_ali15x3 i2c_core ohci_hcd usbcore tun crc32
CPU:    0
EIP:    0060:[<c01308ac>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc3-mm1-V0.7.33-04-tcfq17)
EIP is at up_write+0x8c/0xa0
eax: 00000019   ebx: d039171c   ecx: 00000000   edx: 00000000
esi: 00000008   edi: d039168c   ebp: 00000000   esp: cf8a6cdc
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process rm (pid: 8661, threadinfo=cf8a6000 task=d5014370)
Stack: c0357dbb c035a1f6 000004ba c0130ddf 00000010 00000286 d039171c 
c01d2d8c
        cf8a6000 d038dec8 d020bb44 d039168c d038dec8 d020bb44 c01d735c 
cf8a6d38
        cf8a6d3c 00000000 00000000 d6c3eb4c 00000000 d6c3ec00 00000002 
c7af1700
Call Trace:
  [<c0130ddf>] down_trylock+0x1f/0xb0 (16)
  [<c01d2d8c>] xfs_iunlock+0x6c/0x130 (16)
  [<c01d735c>] xfs_iflush+0x1cc/0x440 (28)
  [<c01d8670>] xfs_inode_item_push+0x10/0x20 (60)
  [<c01ebdda>] xfs_trans_push_ail+0x1aa/0x1e0 (8)
  [<c01ddbad>] xlog_grant_push_ail+0x14d/0x180 (68)
  [<c01dcacc>] xfs_log_reserve+0x9c/0xc0 (60)
  [<c01f7639>] kmem_zone_alloc+0x39/0xa0 (8)
  [<c01ea96a>] xfs_trans_reserve+0x8a/0x1e0 (20)
  [<c01aed86>] xfs_bmap_finish+0xc6/0x170 (40)
  [<c01d589a>] xfs_itruncate_finish+0x27a/0x390 (48)
  [<c01ece3b>] xfs_trans_ijoin+0x2b/0x80 (96)
  [<c01f273a>] xfs_inactive+0x3ea/0x4c0 (20)
  [<c02024b0>] vn_rele+0x50/0xe0 (44)
  [<c0202537>] vn_rele+0xd7/0xe0 (24)
  [<c017154a>] dput+0x8a/0x2a0 (4)
  [<c0200c8f>] linvfs_clear_inode+0xf/0x20 (20)
  [<c01738d8>] clear_inode+0x158/0x160 (8)
  [<c017483f>] generic_delete_inode+0xef/0x110 (24)
  [<c013100a>] atomic_dec_and_spin_lock+0x1a/0x70 (8)
  [<c01749f7>] iput+0x57/0x90 (16)
  [<c016a5a1>] sys_unlink+0xc1/0x120 (24)
  [<c0102fb3>] syscall_call+0x7/0xb (84)
Code: 08 e8 d9 a7 fe ff e8 b4 34 fd ff eb a6 c7 04 24 bb 7d 35 c0 b8 ba 04 
00 00 89 44 24 08 b8 f6 a1 35 c0 89 44 24 04 e8 b4 a7 fe ff <0f> 0b ba 04 
f6 a1 35 c0 eb 85 8d 76 00 8d bc 27 00 00 00 00 83

--nwf;

On Wed, 22 Dec 2004, Nathan Scott wrote:

> On Tue, Dec 21, 2004 at 11:40:43AM +0100, Ingo Molnar wrote:
>>
>> * Nathaniel W. Filardo <nwf@andrew.cmu.edu> wrote:
>>
>>> Hello all.
>>>
>>> Using 2.6.10-rc3-mm1-V0.7.33-04 and TCFQ ver 17, I get the following
>>> crash while trying to sync the portage tree, though the system seems
>>> stable under interactive load (read: an rm command went OK prior to
>>> this crash).
>>>
>>> Machine is a 933MHz transmeta laptop with IDE disk.
>>>
>>> Any more information you need?
>>> --nwf;
>>>
>>> kernel BUG at kernel/rt.c:1210!
>>
>> Seems like an XFS bug at first sight. The BUG() means that an up_write()
>> was done while a down_read() was active for the lock. Does XFS really do
>> this?
>
> That should definately not happen.  Something has gone wrong in
> mrlock.h if so - or it could be the incore xfs_inode has been
> trampled on, and the mrlock writer state has become inappropriately
> set.. that would cause the wrong branch to be taken and we'd end
> up with the situation you've described here.
>
> cheers.
>
> --
> Nathan
>
>
