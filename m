Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUKBReG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUKBReG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKBReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:34:06 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:34226 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261289AbUKBRdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:33:18 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5 (networking problems)
Date: Tue, 2 Nov 2004 18:34:26 +0100
User-Agent: KMail/1.6.2
Cc: Bill Huey <bhuey@lnxw.com>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
References: <20041027001542.GA29295@elte.hu> <20041102114522.GA7874@elte.hu> <20041102120211.GA9436@elte.hu>
In-Reply-To: <20041102120211.GA9436@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411021834.26772.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 02 November 2004 13:02 schrieb Ingo Molnar:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > > http:590 BUG: lock held at task exit time!
> > >  [c03f9e84] {r:0,a:-1,kernel_sem.lock}
> > >  .. held by:              http/  590 [dc0508a0, 121]
> > >  ... acquired at:  __schedule+0x3ac/0x850
> >
> > hm. Something called do_exit() with the BKL held which is a no-no. Do
> > you have a stacktrace, is this sys_exit() or some other code calling
> > do_exit()?
>
> i've uploaded -V0.6.7 with a bug fixed in the new priority code
> (affecting RT tasks and probably causing some of the deadlocks reported
> while running Jackd or other RT apps). I also fixed another networking
> deadlock.
>
Hi

This showed via netconsole when shutting down V0.6.7 (maybe already fixed in 
V0.6.8?):
>>>>>> some noise while in runlevel 5, just for context:
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
loop: loaded (max 8 devices)
>>>>>> Here or...
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
trying access hardware directly.
>>>>>> ...here the shutdown takes over
usbcore: deregistering driver snd-usb-usx2y
ALSA /home/ka/kernel/2.6/linux-2.6.9-mm1-RT-V0.6.7/sound/usb/usbmidi.c:154: 
urb status -108
ALSA /home/ka/kernel/2.6/linux-2.6.9-mm1-RT-V0.6.7/sound/usb/usbmidi.c:139: 
usb_submit_urb: -90
VIA 82xx Audio 0000:00:07.5: Device was removed without properly calling 
pci_disable_device(). This may need fixing.
>>>>>> (I think there was nothing mounted via nfs, so) this looks odd to me:
nfsd:2468 BUG: lock held at task exit time!
 [c032d2e4] {r:0,a:-1,kernel_sem.lock}
.. held by:              nfsd/ 2468 [ce1a3750, 116]
... acquired at:  __sched_text_start+0x36b/0x6d0
nfsd/2468: BUG in __up_write 
at /home/ka/kernel/2.6/linux-2.6.9-mm1-RT-V0.6.7/lib/rwsem-generic.c:1058
BUG: sleeping function called from invalid context nfsd(2468) 
at /home/ka/kernel/2.6/linux-2.6.9-mm1-RT-V0.6.7/kernel/mutex.c:30
in_atomic():1 [00000003], irqs_disabled():0
 [<c0107923>] dump_stack+0x23/0x30 (20)
 [<c011a5aa>] __might_sleep+0xca/0xe0 (36)
 [<c0134b89>] __mutex_lock+0x39/0x60 (24)
 [<c0134bcd>] _mutex_lock+0x1d/0x30 (16)
 [<c01494d5>] kmem_cache_alloc+0x45/0x110 (32)
 [<c0277388>] alloc_skb+0x28/0xf0 (32)
 [<c02894e6>] find_skb+0x36/0xb0 (24)
 [<c0289671>] netpoll_send_udp+0x41/0x2b0 (48)
 [<d08d106a>] write_msg+0x6a/0x120 [netconsole] (52)
 [<c011de6e>] __call_console_drivers+0x6e/0x70 (32)
 [<c011dfa6>] call_console_drivers+0xb6/0x160 (40)
 [<c011e3c1>] release_console_sem+0x71/0x110 (36)
 [<c011e260>] vprintk+0x110/0x180 (36)
 [<c011e13d>] printk+0x1d/0x30 (16)
 [<c01bb9d6>] __up_write+0x186/0x540 (68)
 [<c01bc798>] up+0x78/0xd0 (36)
 [<c02dcc46>] __sched_text_start+0x606/0x6d0 (84)
 [<c0120852>] do_exit+0x2d2/0x560 (40)
 [<c01381a1>] __module_put_and_exit+0x51/0x70 (16)
 [<d0929574>] nfsd+0x2d4/0x3b0 [nfsd] (72)
 [<c0105325>] kernel_thread_helper+0x5/0x10 (836747284)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c02dc68e>] .... __sched_text_start+0x4e/0x6d0
.....[<c0120852>] ..   ( <= do_exit+0x2d2/0x560)
.. [<c01bc743>] .... up+0x23/0xd0
.....[<c02dcc46>] ..   ( <= __sched_text_start+0x606/0x6d0)
.. [<c01bbd04>] .... __up_write+0x4b4/0x540
.....[<c01bc798>] ..   ( <= up+0x78/0xd0)
.. [<c01368ad>] .... print_traces+0x1d/0x60
.....[<c0107923>] ..   ( <= dump_stack+0x23/0x30)

 [<c0107923>] dump_stack+0x23/0x30 (20)
 [<c01bb9db>] __up_write+0x18b/0x540 (68)
 [<c01bc798>] up+0x78/0xd0 (36)
 [<c02dcc46>] __sched_text_start+0x606/0x6d0 (84)
 [<c0120852>] do_exit+0x2d2/0x560 (40)
 [<c01381a1>] __module_put_and_exit+0x51/0x70 (16)
 [<d0929574>] nfsd+0x2d4/0x3b0 [nfsd] (72)
 [<c0105325>] kernel_thread_helper+0x5/0x10 (836747284)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c02dc68e>] .... __sched_text_start+0x4e/0x6d0
.....[<c0120852>] ..   ( <= do_exit+0x2d2/0x560)
.. [<c01bc743>] .... up+0x23/0xd0
.....[<c02dcc46>] ..   ( <= __sched_text_start+0x606/0x6d0)
.. [<c01bbd04>] .... __up_write+0x4b4/0x540
.....[<c01bc798>] ..   ( <= up+0x78/0xd0)
.. [<c01368ad>] .... print_traces+0x1d/0x60
.....[<c0107923>] ..   ( <= dump_stack+0x23/0x30)

nfsd: last server has exited
nfsd: unexporting all filesystems
<<<<<<

Best,
Karsten
