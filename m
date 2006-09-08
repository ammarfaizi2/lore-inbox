Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751943AbWIHAVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbWIHAVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbWIHAVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:21:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751943AbWIHAVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:21:20 -0400
Date: Thu, 7 Sep 2006 17:21:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Om Narasimhan" <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is the expected behaviour under extreme high load.
Message-Id: <20060907172116.452ff45d.akpm@osdl.org>
In-Reply-To: <6b4e42d10609061653p608a2947g1943b3d752855dfe@mail.gmail.com>
References: <6b4e42d10609061653p608a2947g1943b3d752855dfe@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006 16:53:55 -0700
"Om Narasimhan" <om.turyx@gmail.com> wrote:

> Hi,
> I am running a stress test on my SunFire 4600 (8x2core, 64G) using the
> mem_test available from
> http://carpanta.dc.fi.udc.es/~quintela/memtest. I am using SuSE
> enterprise 9 SP3.
> 
> I am wondering what is the expected behaviour of a machine under
> extreme VM stress.
> When I stress the system to the limits, it practically becomes
> unresponsive. It runs for almost half an hour and then it crashes
> because of a CPU lockup.
> 
> Any pointers from where I can start debugging this issue?

It's an old kernel.  Newer ones might be better.

> >From top,
> load average: 190.70, 132.45, 60.43
> # cat /proc/sys/vm/overcommit_memory
> 0
> 
> The final crashing message on the ser. console is,
> 
> ...
>
> Free swap:            0kB

It ran out of swapspace.  oom-killing is the correct behaviour.

> 16777208 pages of RAM
> 430115 reserved pages
> 69705619 pages shared
> 32 pages swap cached
> Out of Memory: Killed process 12726 (mtest).
> NMI Watchdog detected LOCKUP on CPU14, registers:
> CPU 14
> Pid: 12756, comm: mtest Tainted: G   U   (2.6.5-7.244-smp-dbg )
> RIP: 0010:[<ffffffff80180342>] <ffffffff80180342>{.text.lock.vmscan+18}
> RSP: 0000:0000010dfbd31a38  EFLAGS: 00000082
> RAX: 0000010603945a10 RBX: 0000000000000000 RCX: 0000010601cb7128
> RDX: 0000010dfbd31b48 RSI: 0000010600004408 RDI: 0000000000000000
> RBP: 0000010600004380 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000064 R11: 0000000000000080 R12: 0000010600004380
> R13: 0000010600004400 R14: 0000010dfbd31b48 R15: 0000010dfbd31b28
> FS:  0000002a95894b00(0000) GS:ffffffff80610c80(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000002ae2f57010 CR3: 00000001fff2d000 CR4: 00000000000006e0
> Process mtest (pid: 12756, threadinfo 0000010dfbd30000, task 0000010dfede0280)
> Stack: 0000000000000000 0000000100000000 0000010dfbd31c08 0000008000000246
>        0000000000000246 0000000000000246 0000010dfede0280 0000000000000286
>        0000010975a5ad30 ffffffff805353e0
> Call Trace:<ffffffff8017f5c2>{shrink_zone+226}
> <ffffffff8017fed8>{try_to_free_pages+280}
>        <ffffffff80140cb0>{autoremove_wake_function+0}
> <ffffffff80174a0f>{__alloc_pages+559}
>        <ffffffff80185393>{handle_mm_fault+2323}
> <ffffffff80123e80>{do_page_fault+0}
>        <ffffffff80124054>{do_page_fault+468} <ffffffff8013be17>{thread_return+0}
>        <ffffffff80111465>{error_exit+0}
> 

That isn't.  Could be that the scanner simply spent too long with
interrupts disabled.  Or some interaction with the oom-killer caused the
scanner to lock up.

But that's an awfully old kernel - it could be that whatever problem caused
this has been fixed in the intervening years.

