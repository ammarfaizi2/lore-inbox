Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290009AbSAKQrX>; Fri, 11 Jan 2002 11:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290010AbSAKQrN>; Fri, 11 Jan 2002 11:47:13 -0500
Received: from [64.209.222.100] ([64.209.222.100]:35589 "HELO
	mx1.gc.ny.otec.com") by vger.kernel.org with SMTP
	id <S290009AbSAKQq7>; Fri, 11 Jan 2002 11:46:59 -0500
Date: Fri, 11 Jan 2002 11:46:41 -0500 (EST)
From: dan kelley <dkelley@otec.com>
X-X-Sender: <djk@nixon.bos.otec.net>
To: Ingo Molnar <mingo@elte.hu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -H6
In-Reply-To: <Pine.LNX.4.33.0201111803580.4987-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201111146000.29661-100000@nixon.bos.otec.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.17 w/ H6 still oopses on my dual xeon.  oops:

>>EIP; c02cc482 <stext_lock+506/8cf2>   <=====
Trace; c0114b1e <__wake_up+86/dc>
Trace; c0127292 <schedule_task+e2/e8>
Trace; c012711a <call_usermodehelper+c6/dc>
Trace; c012702c <__call_usermodehelper+0/28>
Trace; c012702c <__call_usermodehelper+0/28>
Trace; c027c905 <net_run_sbin_hotplug+79/84>
Trace; c028150f <rtmsg_ifinfo+73/78>
Trace; c0281a42 <rtnetlink_event+32/40>
Trace; c027c558 <register_netdevice+198/1a4>
Trace; c01da1e6 <register_netdev+5e/70>
Trace; c01d33b6 <vortex_probe1+ba6/c1c>
Trace; c01d2801 <vortex_init_one+35/44>
Trace; c0246d6e <pci_announce_device+36/54>
Trace; c0246dd4 <pci_register_driver+48/60>
Trace; c01050f3 <init+5b/1d8>
Trace; c01056b8 <kernel_thread+28/38>
Code;  c02cc482 <stext_lock+506/8cf2>
00000000 <_EIP>:
Code;  c02cc482 <stext_lock+506/8cf2>   <=====
   0:   80 39 00                  cmpb   $0x0,(%ecx)   <=====
Code;  c02cc485 <stext_lock+509/8cf2>
   3:   f3 90                     repz nop
Code;  c02cc487 <stext_lock+50b/8cf2>
   5:   7e f9                     jle    0 <_EIP>
Code;  c02cc489 <stext_lock+50d/8cf2>
   7:   e9 77 70 e4 ff            jmp    ffe47083 <_EIP+0xffe47083>
c0113505 <tr
y_to_wake_up+61/344>
Code;  c02cc48e <stext_lock+512/8cf2>
   c:   80 3a 00                  cmpb   $0x0,(%edx)
Code;  c02cc491 <stext_lock+515/8cf2>
   f:   f3 90                     repz nop
Code;  c02cc493 <stext_lock+517/8cf2>
  11:   7e f9                     jle    c <_EIP+0xc> c02cc48e
<stext_lock+512/8
cf2>
Code;  c02cc495 <stext_lock+519/8cf2>
  13:   e9 00 00 00 00            jmp    18 <_EIP+0x18> c02cc49a
<stext_lock+51e


> the -H6 patch is available:
>
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre11-H6.patch
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-H6.patch
>
> the most important fix is from DaveM, we should not send an IPI to
> ourselves. That fix was the last bug on Sparc boxes it appears.
>
> overall stability status: all the previous bug reports about runtime
> lockups (which happen in -pre11 as well) are fixed in this patchset. The
> only open issue is the boot-time lockup some people are seeing with the
> 2.4 patch only (not the 2.5 patch), there is a chance that it's fixed in
> this patch too.
>
> Changes:
>
>  - DaveM's the man: check for p->cpu != smp_processor_id() before doing a
>    smp_send_reschedule(p->cpu). Doh!
>
>  - task_interactive() test is done properly now - the H5 would mis-detect
>    every nice +19 task as interactive. I'd like to ask everyone who had
>    interactivity problems to re-test under -H6. It's all very smooth on my
>    systems.
>
>  - Rusty Russell: add comment to expire_task.
>
>  - fix main.c in the 2.4.17 patch. (this should fix the bootup-lockups.)
>
> Bug reports, comments, suggestions welcome. (any patch/fix that is not in
> -H6 has gone lost in my mailqueue. The influx is rather high.)
>
> 	Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

