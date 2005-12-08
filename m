Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVLHKwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVLHKwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 05:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVLHKwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 05:52:38 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:42946 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932070AbVLHKwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 05:52:37 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [discuss] Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Date: Thu, 8 Dec 2005 11:53:50 +0100
User-Agent: KMail/1.9
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org, "Discuss x86-64" <discuss@x86-64.org>
References: <20051204232153.258cd554.akpm@osdl.org> <200512080015.01444.rjw@sisk.pl> <43980058.76F0.0078.0@novell.com>
In-Reply-To: <43980058.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512081153.51397.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 8 December 2005 09:43, Jan Beulich wrote:
> I don't know how resume normally handles the re-syncing of the wall
> clock, but the problem here is obvious: do_timer runs a loop to
> increment jiffies, which may require significant amounts of time
> (depending how long the system was sleeping).
> 
> Whatever mechanism was previously used to adjust the wall clock during
> resume, this (a) has to happen before enabling interrupts and (b) has to
> communicate to the timer interrupt handler to adjust its last time stamp
> taken (to compare against in the next run). Clearly, the code was broken
> already before, as it doesn't handle the resume case (where the HPET
> value read is entirely unrelated to the one read during the last timer
> interrupt before suspend) at all, and even in the TSC timer case it
> simply checks whether the TSC delta is negative (which is not a valid
> condition, as, between the booting of the system and the OS resume there
> may elapse more time than the system was running altogether prior to
> suspend).

Well, I'm not an expert, but I think I understand your argumentation.
However, the problem is that resume _works_ without the patch
and doesn't work with it, which is a regression.  (BTW, without
the patch the wall clock is evidently correct after resume.)

Frankly I don't know who should fix the broken code, but my
understanding has always been that if someone's patch
introduces a regression, he/she ough to change the patch
so that it does not happen.

Greetings,
Rafael


> >>> "Rafael J. Wysocki" <rjw@sisk.pl> 08.12.05 00:15:01 >>>
> Update:
> 
> On Wednesday, 7 December 2005 01:46, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Monday, 5 December 2005 08:21, Andrew Morton wrote:
> > > 
> > >
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> 
> > 
> > }-- snip --{
> > > +x86_64-hpet-overflow.patch
> > 
> > This patch breaks resume from disk badly.  The box hangs solid as
> soon as interrupts
> > are reenabled during resume (right after the image has been read).
> 
> I've just managed to get a call trace from it, which is appended.
> 
> Greetings,
> Rafael
> 
> 
> swsusp: Reading resume file was successful
> PM: Preparing devices for restore.
> Suspending device 1.0
> Suspending device ide1
> Suspending device 0.1
> Suspending device ide0
> Suspending device serial8250
> Suspending device serio4
> Suspending device serio3
> Suspending device serio2
> Suspending device serio1
> Suspending device serio0
> Suspending device i8042
> Suspending device vesafb.0
> Suspending device 0000:01:00.0
> Suspending device 0000:02:02.0
> Suspending device 0000:02:01.4
> Suspending device 0000:02:01.3
> Suspending device 0000:02:01.2
> Suspending device 0000:02:01.1
> Suspending device 0000:02:01.0
> Suspending device 0000:02:00.0
> Suspending device 0000:00:18.3
> Suspending device 0000:00:18.2
> Suspending device 0000:00:18.1
> Suspending device 0000:00:18.0
> Suspending device 0000:00:0b.0
> Suspending device 0000:00:0a.0
> Suspending device 0000:00:08.0
> Suspending device 0000:00:06.0
> Suspending device 0000:00:02.2
> Suspending device 0000:00:02.1
> Suspending device 0000:00:02.0
> Suspending device 0000:00:01.1
> Suspending device 0000:00:01.0
> Suspending device 0000:00:00.0
> Suspending device pci0000:00
> Suspending device platform
> PM: Restoring saved image.
> NMI Watchdog detected LOCKUP on CPU 0
> CPU 0
> Modules linked in: usbserial thermal processor fan button battery ac
> snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_
> pcm snd_timer snd soundcore snd_page_alloc af_packet pcmcia
> firmware_class yenta_socket rsrc_nonstatic pcmcia_core evdev joydev sg
> usbhid st
>  sr_mod ehci_hcd ohci_hcd sk98lin sd_mod scsi_mod ide_cd cdrom dm_mod
> parport_pc lp parport
> Pid: 3304, comm: bash Not tainted 2.6.15-rc5-mm1 #1
> RIP: 0010:[<ffffffff8013c87d>] <ffffffff8013c87d>{do_timer+77}
> RSP: 0018:ffffffff80481eb8  EFLAGS: 00000002
> RAX: 000000001d0f8788 RBX: 00000255e7679aa8 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 00000000003d09fa RDI: 0000000000000000
> RBP: ffffffff80481ed8 R08: 0000000000000040 R09: 00000000ffffffff
> R10: 0000000094fc4b38 R11: 00000000c0010008 R12: 000002560cbc37bc
> R13: ffff81002bd63d38 R14: ffff81002bd63d38 R15: 0000000000000000
> FS:  00002aaaab28fe80(0000) GS:ffffffff8050f000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002aaaaaac2000 CR3: 000000002ad20000 CR4: 00000000000006e0
> Process bash (pid: 3304, threadinfo ffff81002bd62000, task
> ffff810001fdb790)
> Stack: 0000000000000fed 00000000000002b7 0000000000000b18
> 000002560cbc37bb
>        ffffffff80481f08 ffffffff80112dd1 ffffffff803d39c0
> 0000000000000000
>        ffff81002bd63d38 0000000000000000
> Call Trace: <IRQ> <ffffffff80112dd1>{timer_interrupt+689}
> <ffffffff8015ae83>{handle_IRQ_event+51}
>        <ffffffff8015af72>{__do_IRQ+162} <ffffffff80111097>{do_IRQ+55}
>        <ffffffff8010f0b0>{ret_from_intr+0}  <EOI>
> <ffffffff8011ae3d>{enable_lapic_nmi_watchdog+29}
>        <ffffffff8011ae63>{lapic_nmi_resume+19}
> <ffffffff8015296d>{swsusp_suspend+93}
>        <ffffffff8015296a>{swsusp_suspend+90}
> <ffffffff801537b8>{pm_suspend_disk+88}
>        <ffffffff80151266>{enter_state+118}
> <ffffffff801514a7>{state_store+119}
>        <ffffffff801c09a4>{subsys_attr_store+36}
> <ffffffff801c0e2a>{sysfs_write_file+202}
>        <ffffffff80180549>{vfs_write+233}
> <ffffffff801806f0>{sys_write+80}
>        <ffffffff8010eb0e>{system_call+126}
> 
> Code: 48 ff cb 48 85 c9 48 89 ce 74 25 8b 05 de 38 2a 00 48 63 d0
> console shuts up ...
>  <7>APIC error on CPU0: 00(00)
> Kernel panic - not syncing: Aiee, killing interrupt handler!
> 
> 

-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
