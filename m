Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVEZEWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVEZEWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVEZEWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:22:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:23014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261181AbVEZEVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:21:53 -0400
Date: Wed, 25 May 2005 21:20:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: dtor_core@ameritech.net, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3
Message-Id: <20050525212044.67271b83.akpm@osdl.org>
In-Reply-To: <6.2.3.0.2.20050402153905.01c9ea08@tornado.reub.net>
References: <fa.h3qui0k.n6uf30@ifi.uio.no>
	<4247DCBE.7020900@reub.net>
	<20050328120200.C9847@flint.arm.linux.org.uk>
	<200503301341.59976.dtor_core@ameritech.net>
	<6.2.3.0.2.20050402153905.01c9ea08@tornado.reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> >
> >Reuben, could you please try the patch below? Thanks!
> >
> >Russell, could you please tell me if ldisc->write_wakeup (tty_wakwup) and
> >ldisc->read are allowed to be called from an IRQ context? IOW I wonder if
> >I can use spil_lock_bh instead of spil_lock_irqsave to protect serport
> >flags.
> >
> >--
> >Dmitry
> >
> >  serport.c |   98 
> > +++++++++++++++++++++++++++++++++++++++++++-------------------
> >  1 files changed, 68 insertions(+), 30 deletions(-)
> >
> >Index: dtor/drivers/input/serio/serport.c
> >===================================================================
> >--- dtor.orig/drivers/input/serio/serport.c
> >+++ dtor/drivers/input/serio/serport.c
> >@@ -27,11 +27,15 @@ MODULE_LICENSE("GPL");
> >  MODULE_ALIAS_LDISC(N_MOUSE);
> 
> 
> I've done some testing this afternoon and it seems that this patch 
> fixes the problem in -mm4.  I don't even have a serial 
> mouse/keyboard, but do have a serial PCI card onboard.  The box has a 
> USB connection to a Belkin KVM instead of directly attached input devices.
> 
> I also note that it is occurring on kernel-smp-2.6.11-1.1219_FC4 - so 
> it is probably a problem in mainline as well as -mm.

Can you please confirm that the above fix is present in 2.6.12-rc5 and that
2.6.12-rc5 is working OK?


> 
> Now I'm crashing a bit further through the shutdown, here's the stacktrace:

Is this still occurring in either 2.6.12-rc5 or 2.6.12-rc5-mm1?

> INIT: Sending processes the TERM signal
> Stopping yum:  Disabling nightly yum update: [  OK  ]
> [  OK  ]
> Stopping cups-config-daemon: [  OK  ]
> Stopping HAL daemon: [  OK  ]
> Stopping system message bus: [  OK  ]
> Stopping atd: [  OK  ]
> Stopping cups: [  OK  ]
> Shutting down xfs: [  OK  ]
> [  OK  ] down console mouse services: [  OK  ]
> Shutting down NFS mountd: [  OK  ]
> Shutting down NFS daemon: nfsd: last server has exited
> nfsd: unexporting all filesystems
> RPC: error 5 connecting to server localhost
> RPC: failed to contact portmap (errno -5).
> Unable to handle kernel paging request at virtual address f2826d2c
>   printing eip:
> c01337a9
> *pde = 00000000
> Oops: 0000 [#1]
> SMP DEBUG_PAGEALLOC
> Modules linked in: nfsd exportfs md5 ipv6 lp snd_usb_audio 
> snd_usb_lib pwc video
> dev usb_storage autofs4 eeprom lm85 i2c_sensor rfcomm l2cap bluetooth nfs lockd
> sunrpc dm_mod video button battery ac ohci1394 ieee1394 uhci_hcd 
> ehci_hcd parpor
> t_serial parport_pc parport hw_random i2c_i801 i2c_core emu10k1_gp 
> gameport snd_
> emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss 
> snd_mixer_oss snd_
> pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore 
> e100 mii flopp
> y ext3 jbd ata_piix libata sd_mod scsi_mod
> CPU:    0
> EIP:    0060:[<c01337a9>]    Not tainted VLI
> EFLAGS: 00010087   (2.6.12-rc1-mm4)
> EIP is at worker_thread+0x149/0x230
> eax: 00000001   ebx: 00000212   ecx: f7eb4018   edx: f2826d20
> esi: f2826d24   edi: f7eb4000   ebp: 00000000   esp: f7e83f7c
> ds: 007b   es: 007b   ss: 0068
> Process events/0 (pid: 8, threadinfo=f7e83000 task=f7fefad0)
> Stack: f7eb4028 f7eb4010 f7eb4018 f7e83000 f2826d20 c014f4b0 00000001 00000000
>         000f41fa 00010000 00000000 00000000 f7fefad0 c011ea50 00100100 00200200
>         ffffffff ffffffff fffffffc f7e46f54 f7eb4000 c0133660 c0137694 ffffffff
> Call Trace:
>   [<c014f4b0>] cache_reap+0x0/0x240
>   [<c011ea50>] default_wake_function+0x0/0x10
>   [<c0133660>] worker_thread+0x0/0x230
>   [<c0137694>] kthread+0x94/0xa0
>   [<c0137600>] kthread+0x0/0xa0
>   [<c01023f5>] kernel_thread_helper+0x5/0x10
> Code: 00 00 89 f8 e8 19 e3 1e 00 89 c3 8b 47 40 40 89 47 40 83 f8 03 
> 0f 8f bd 00
>   00 00 8b 77 10 3b 74 24 04 74 71 8d 56 fc 89 54 24 10 <8b> 42 0c 89 
> 44 24 14 8b
>   6a 10 8b 46 04 8b 16 89 10 89 36 89 42
>   [  OK  ]
> Shutting down NFS quotas: [FAILED]
> Shutting down NFS services:  [  OK  ]
> Stopping sshd: [  OK  ]
> Stopping postfix:  Shutting down postfix: <3>BUG: soft lockup 
> detected on CPU#0!
> 
> Pid: 3413, comm:          rpc.rquotad
> EIP: 0060:[<c0321ac0>] CPU: 0
> EIP is at _spin_lock_irqsave+0x20/0x50
>   EFLAGS: 00000286    Not tainted  (2.6.12-rc1-mm4)
> EAX: f7eb4000 EBX: 00000246 ECX: f7eb4000 EDX: c22021a0
> ESI: f7eb4000 EDI: c22021a0 EBP: c01335b0 DS: 007b ES: 007b
> CR0: 8005003b CR2: 800147fc CR3: 37256d20 CR4: 000006e0
>   [<c013350c>] __queue_work+0xc/0x50
>   [<c012cc17>] run_timer_softirq+0xd7/0x1c0
>   [<c0128950>] __do_softirq+0x80/0x100
>   [<c0106adb>] do_softirq+0x4b/0x50
>   =======================
>   [<c010511c>] apic_timer_interrupt+0x1c/0x30
>   [<c02b7ed8>] kfree_skbmem+0x8/0x20
>   [<c02b007b>] cpufreq_governor+0x3b/0x50
>   [<c014eed2>] kfree+0x62/0x90
>   [<c02b7ed8>] kfree_skbmem+0x8/0x20
>   [<c02b7fcc>] __kfree_skb+0xdc/0x1a0
>   [<c02d2501>] netlink_recvmsg+0xf1/0x230
>   [<c02b422a>] sock_recvmsg+0xfa/0x120
>   [<c02b40d2>] sock_sendmsg+0xe2/0x110
>   [<c0137b20>] autoremove_wake_function+0x0/0x30
>   [<c0149d32>] __alloc_pages+0x122/0x440
>   [<c01d94a2>] copy_from_user+0x42/0x80
>   [<c02b5ba9>] sys_recvmsg+0x109/0x1e0
>   [<c01d94a2>] copy_from_user+0x42/0x80
>   [<c02b553e>] sys_sendto+0xfe/0x140
>   [<c011a863>] do_page_fault+0x253/0x6a1
>   [<c017c6a1>] d_alloc+0x141/0x1a0
>   [<c01648d1>] fd_install+0x21/0x50
>   [<c02b3e57>] sock_map_fd+0xf7/0x130
>   [<c032068d>] schedule+0x97d/0xc10
>   [<c02b5e67>] sys_socketcall+0x1e7/0x200
>   [<c0103fbb>] sysenter_past_esp+0x54/0x79
> 
> System is an up to date FC4- devel box with a 2.8 Ghz SMP Intel processor.
> 
> reuben
> 
