Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbULXEJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbULXEJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 23:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbULXEJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 23:09:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18924 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261366AbULXEJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 23:09:02 -0500
Date: Thu, 23 Dec 2004 22:27:32 -0500 (EST)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: Nathan Scott <nathans@sgi.com>
cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] XFS crash using Realtime Preemption patch
In-Reply-To: <20041223105858.C702917@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.60-041.0412232224000.9915@unix49.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu>
 <20041221104042.GA31843@elte.hu> <20041222093242.B674830@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.60-041.0412220246390.11361@unix49.andrew.cmu.edu>
 <20041223105858.C702917@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Nathan Scott wrote:

> On Wed, Dec 22, 2004 at 02:50:20AM -0500, Nathaniel W. Filardo wrote:
>> I added
>>          BUG_ON( (mrp->mr_writer != 0) && (mrp->mr_writer != 1) );
>> to mrlock.h : mrunlock() to see if it was corruption and got the following
>
> Good thinkin.
>
>> instead.  It's a similar call pathway, but somewhat different.
>
> Thats exactly the same call path right?  There is no call to
> down_trylock from xfs_iunlock (goes directly to up_write) so
> I think that must just be leftover stack junk, and we should
> assume the path was xfs_iunlock->(inline)mrunlock->up_write,
> which means your BUG_ON didn't trigger... (put a printk of the
> value there, maybe we'll get lucky and get some recognisable
> hex pattern).

If the BUG_ON didn't trigger, we shouldn't get a recognisable hex pattern 
- we'll get a 1 or a 0 every time, yes?

I'll believe that it's the same trace.  I changed the value for mr_writer
in a writer state from 1 to 128 (leaving readers as 0) and got the same 
dump, which means that the new
 	BUG_ON( (mrp->mr_writer != 0) && (mrp->mr_writer != 128 ) );
didn't fire.  So I don't think it's memory corruption unless my RAM is 
psychic. =)

It looks like it might be a buggy attempt to upgrade a reader lock to a 
writer, or a more general failure of the locking semantics...  Is the 
former possible along this path?

>> kernel BUG at kernel/rt.c:1210!
>> invalid operand: 0000 [#1]
>> PREEMPT
>> Modules linked in: uhci_hcd rtc eth1394 ohci1394 ieee1394 pcmcia
>> hostap_pci hostap 8139too mii yenta_socket pcmcia_core ehci_hcd
>> i2c_ali15x3 i2c_core ohci_hcd usbcore tun crc32
>> CPU:    0
>> EIP:    0060:[<c01308ac>]    Not tainted VLI
>> EFLAGS: 00010286   (2.6.10-rc3-mm1-V0.7.33-04-tcfq17)
>> EIP is at up_write+0x8c/0xa0
>> eax: 00000019   ebx: d039171c   ecx: 00000000   edx: 00000000
>> esi: 00000008   edi: d039168c   ebp: 00000000   esp: cf8a6cdc
>> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
>> Process rm (pid: 8661, threadinfo=cf8a6000 task=d5014370)
>> Stack: c0357dbb c035a1f6 000004ba c0130ddf 00000010 00000286 d039171c
>> c01d2d8c
>>         cf8a6000 d038dec8 d020bb44 d039168c d038dec8 d020bb44 c01d735c
>> cf8a6d38
>>         cf8a6d3c 00000000 00000000 d6c3eb4c 00000000 d6c3ec00 00000002
>> c7af1700
>> Call Trace:
>>   [<c0130ddf>] down_trylock+0x1f/0xb0 (16)
>>   [<c01d2d8c>] xfs_iunlock+0x6c/0x130 (16)
>>   [<c01d735c>] xfs_iflush+0x1cc/0x440 (28)
>
> --
> Nathan
>
>
