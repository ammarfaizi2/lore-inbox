Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbTGKTtp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbTGKTs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:48:27 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:18400 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265285AbTGKTqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:46:34 -0400
Date: Fri, 11 Jul 2003 22:00:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net,
       pavel@suse.cz
Subject: Re: [2.5.75] S3 and S4
Message-ID: <20030711200053.GA402@elf.ucw.cz>
References: <20030711193611.GA824@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711193611.GA824@dreamland.darkstar.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've been playing with ACPI and software suspend.
> 
> I have an AthlonXP on a KT333 motherboard. Kernel UP with preemption.
> 
> S3 doesn't work with FB (well, I  can suspend the machine but the screen
> isn't restored on resume. I can blindly  login and reboot) but I read on
> fbdev that this is a WIP.  Without FB the system goes to sleep with some
> warnings (we call local_bh_enable with interrupts disabled):
> 

[Please, people, edit out those dmesg-s (unless something went wrong
with refrigerator). I'm not at all interested in your process list,
even if "pickup" process sounds funny. ]

> Stopping tasks: klogd entered refrigerator
> =init entered refrigerator
...
> =unlinkd entered refrigerator
> =master entered refrigerator
> =pickup entered refrigerator

You have "interesting" processes on your machine ;).

> Suspending devices
> Badness in local_bh_enable at kernel/softirq.c:113
> Call Trace:
>  [<c0130078>] local_bh_enable+0x88/0x90
>  [<f0a44fa4>] e100_do_wol+0x14/0x60 [e100]
>  [<f0a461ee>] e100_suspend+0x3e/0xa0 [e100]
>  [<f0a461b0>] e100_suspend+0x0/0xa0 [e100]
>  [<c0212577>] pci_device_suspend+0x47/0x70
>  [<c029bc99>] device_suspend+0xd9/0x100
>  [<c023e047>] acpi_system_save_state+0x42/0x8c
>  [<c023e153>] acpi_suspend+0x5e/0xb3
>  [<c023e394>] acpi_system_write_sleep+0xe3/0x132
>  [<c0177de0>] filp_open+0x60/0x70
>  [<c017952d>] vfs_write+0xad/0x120
>  [<c017963f>] sys_write+0x3f/0x60
>  [<c010b10f>] syscall_call+0x7/0xb
> 

If e100. You have the hardware...

> And then the resume:
>  
> Enabling SEP on CPU 0
> Back to C!

[This reminds me I need to clean up those messages].

> Devices Resumed
> hda: Wakeup request inited, waiting for !BSY...
> hda: start_power_step(step: 1000)
...
> sleep left refrigerator
> e100: eth0 NIC Link is Up 10 Mbps Half duplex
> MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Bank 0: d46ee00000007fee
> MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Bank 1: f713eeedb75ae7fd
> MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Bank 2: f60000000000feff
> MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Bank 3: fc0000000000ffef
> 
> I'm a bit  worried about these MCEs, but the  machine seems stable after
> resume (btw,  I remeber that Alan  once posted a MCE  decoder, but can't
> find it - any clue?).

Not sure what it is. MCEs should be hardware fault, always...

> S4  suspends fine,  but  it seems  that it  doesn't  like preemption  on
> resume:
> 
> ......[lots of dots]......[nosave c041c000]Enabling SEP on CPU 0
> Freeing prev allocated pagedir
> bad: scheduling while atomic!
> Call Trace:
>  [<c012419e>] schedule+0x6ce/0x6e0
>  [<c02ded7b>] pci_read+0x3b/0x40
>  [<c01358e8>] schedule_timeout+0x88/0xe0
>  [<c02dedbc>] pci_write+0x3c/0x40
>  [<c0135850>] process_timeout+0x0/0x10
>  [<c020f9e4>] pci_set_power_state+0xe4/0x190
>  [<f0a46278>] e100_resume+0x28/0x70 [e100]
>  [<c02125cd>] pci_device_resume+0x2d/0x30
>  [<c029bd76>] device_resume+0xb6/0xd0
>  [<c014e60c>] drivers_resume+0x8c/0xa0
>  [<c014ea15>] do_magic_resume_2+0xc5/0x170
>  [<c011d410>] restore_processor_state+0x70/0x90
>  [<c011ff5f>] do_magic+0x11f/0x140
>  [<c014ef1d>] do_software_suspend+0x6d/0xa0
>  [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
>  [<c0177de0>] filp_open+0x60/0x70
>  [<c017952d>] vfs_write+0xad/0x120
>  [<c017963f>] sys_write+0x3f/0x60
>  [<c010b10f>] syscall_call+0x7/0xb

That's e100 driver, again. Fix it.

> Fixing swap signatures... <3>bad: scheduling while atomic!
> Call Trace:
>  [<c012419e>] schedule+0x6ce/0x6e0
>  [<c02a219d>] generic_make_request+0x17d/0x210
>  [<c01272d0>] autoremove_wake_function+0x0/0x50
>  [<c012641e>] io_schedule+0xe/0x20
>  [<c0150522>] wait_on_page_bit+0xa2/0xd0
>  [<c01272d0>] autoremove_wake_function+0x0/0x50
>  [<c01272d0>] autoremove_wake_function+0x0/0x50
>  [<c017194b>] swap_readpage+0x5b/0x80
>  [<c0171a2a>] rw_swap_page_sync+0xba/0x110
>  [<c014d8be>] mark_swapfiles+0x7e/0x1b0
>  [<c014ea35>] do_magic_resume_2+0xe5/0x170
>  [<c011d410>] restore_processor_state+0x70/0x90
>  [<c011ff5f>] do_magic+0x11f/0x140
>  [<c014ef1d>] do_software_suspend+0x6d/0xa0
>  [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
>  [<c0177de0>] filp_open+0x60/0x70
>  [<c017952d>] vfs_write+0xad/0x120
>  [<c017963f>] sys_write+0x3f/0x60
>  [<c010b10f>] syscall_call+0x7/0xb

Ahha, this looks like generic problem. I'll probably take a look...

> Unable to handle kernel paging request at virtual address 40107114
>  printing eip:
> 40107114
> *pde = 2dbf6067
> *pte = 00000000
> Oops: 0004 [#1]
> CPU:    0
> EIP:    0073:[<40107114>]    Not tainted
> EFLAGS: 00010202
> EIP is at 0x40107114
> eax: ffffffea   ebx: 00000001   ecx: 080d440c   edx: 00000002
> esi: 00000002   edi: 080d440c   ebp: bffffae8   esp: bffffab8
> ds: 007b   es: 007b   ss: 007b
> Process bash (pid: 484, threadinfo=ed776000 task=ef1e40c0)
>  <6>note: bash[484] exited with preempt_count 1
> pdflush left refrigerator
> e100: eth0 NIC Link is Up 10 Mbps Half duplex
> 
> 
> ksymoops says:
> 
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> 
> >>EIP; 40107114 Before first symbol   <=====
> 
> >>eax; ffffffea <__kernel_rt_sigreturn+1baa/????>

That's bad. Error outside of kernel. Not sure what is wrong.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
