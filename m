Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSI2FAG>; Sun, 29 Sep 2002 01:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262393AbSI2FAG>; Sun, 29 Sep 2002 01:00:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:6049 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262391AbSI2FAF>;
	Sun, 29 Sep 2002 01:00:05 -0400
Message-ID: <3D968A07.902B8B4@digeo.com>
Date: Sat, 28 Sep 2002 22:05:11 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: thunder7@xs4all.nl, Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: 2.5.39, SMP, pre-empt: snd_ctl_iotcl 'sleeping function called from 
 illegal context'
References: <20020929044638.GB739@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2002 05:05:12.0377 (UTC) FILETIME=[CA5DBA90:01C26775]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
> 
> Sleeping function called from illegal context at slab.c:1374
> f6b6fbfc c0118554 c02df2e0 c02e3d90 0000055e f7b32390 c0135dd3 c02e3d90
>        0000055e 0000004c f7bafe08 f6b6fcec f7b32390 00000002 c1b0f3f0 c0254345
>        0000004c 000001d0 f7b32360 f6b6fcec c0255903 0000004c 000001d0 bffff628
> Call Trace:
>  [<c0118554>]__might_sleep+0x54/0x58
>  [<c0135dd3>]kmalloc+0x5b/0x1d4
>  [<c0254345>]snd_kcalloc+0x11/0x38
>  [<c0255903>]snd_ctl_notify+0xf3/0x1c0
>  [<c02567f2>]snd_ctl_elem_write+0x17a/0x230
>  [<c0256ce1>]snd_ctl_ioctl+0x175/0x310
>  [<c01544e9>]sys_ioctl+0x28d/0x2dc
>  [<c0107c5d>]error_code+0x2d/0x38
>  [<c01071fb>]syscall_call+0x7/0xb
> 
> This is with an EMU10K1 card, and the ALSA drivers in the kernel.
> 

snd_ctl_elem_write() calls snd_ctl_notify() under
read_lock(&card->control_rwlock);

But snd_ctl_notify() does a GFP_KERNEL allocation.

Also, snd_ctl_notify() does read_lock_irqsave(&card->control_rwlock, flags);
even though the caller has already taken a read_lock on that lock.
It is not legal to take a read_lock twice in this manner.  Because
if another CPU comes in and asks for a write_lock in that window,
deadlock.  (I think - there's been some talk about changing the
rwlock implementation so that nested read_locks are safe).

Also, snd_ctl_notify() is performing a GFP_KERNEL allocation
inside spin_lock(&ctl->read_lock);
