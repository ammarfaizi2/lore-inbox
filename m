Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbTGKUkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbTGKUkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:40:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266309AbTGKUka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:40:30 -0400
Date: Fri, 11 Jul 2003 13:48:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net,
       pavel@suse.cz
Subject: Re: [2.5.75] S3 and S4
Message-Id: <20030711134833.1adeceb1.akpm@osdl.org>
In-Reply-To: <20030711200053.GA402@elf.ucw.cz>
References: <20030711193611.GA824@dreamland.darkstar.lan>
	<20030711200053.GA402@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> > Suspending devices
> > Badness in local_bh_enable at kernel/softirq.c:113
> > Call Trace:
> >  [<c0130078>] local_bh_enable+0x88/0x90
> >  [<f0a44fa4>] e100_do_wol+0x14/0x60 [e100]
> >  [<f0a461ee>] e100_suspend+0x3e/0xa0 [e100]
> >  [<f0a461b0>] e100_suspend+0x0/0xa0 [e100]
> >  [<c0212577>] pci_device_suspend+0x47/0x70
> >  [<c029bc99>] device_suspend+0xd9/0x100
> >  [<c023e047>] acpi_system_save_state+0x42/0x8c
> >  [<c023e153>] acpi_suspend+0x5e/0xb3
> >  [<c023e394>] acpi_system_write_sleep+0xe3/0x132
> >  [<c0177de0>] filp_open+0x60/0x70
> >  [<c017952d>] vfs_write+0xad/0x120
> >  [<c017963f>] sys_write+0x3f/0x60
> >  [<c010b10f>] syscall_call+0x7/0xb
> > 
> 
> If e100. You have the hardware...

No, it's acpi_system_save_state() illegally calling device_suspend() under
local_irq_disable().


> > S4  suspends fine,  but  it seems  that it  doesn't  like preemption  on
> > resume:
> > 
> > ......[lots of dots]......[nosave c041c000]Enabling SEP on CPU 0
> > Freeing prev allocated pagedir
> > bad: scheduling while atomic!
> > Call Trace:
> >  [<c012419e>] schedule+0x6ce/0x6e0
> >  [<c02ded7b>] pci_read+0x3b/0x40
> >  [<c01358e8>] schedule_timeout+0x88/0xe0
> >  [<c02dedbc>] pci_write+0x3c/0x40
> >  [<c0135850>] process_timeout+0x0/0x10
> >  [<c020f9e4>] pci_set_power_state+0xe4/0x190
> >  [<f0a46278>] e100_resume+0x28/0x70 [e100]
> >  [<c02125cd>] pci_device_resume+0x2d/0x30
> >  [<c029bd76>] device_resume+0xb6/0xd0
> >  [<c014e60c>] drivers_resume+0x8c/0xa0
> >  [<c014ea15>] do_magic_resume_2+0xc5/0x170
> >  [<c011d410>] restore_processor_state+0x70/0x90
> >  [<c011ff5f>] do_magic+0x11f/0x140
> >  [<c014ef1d>] do_software_suspend+0x6d/0xa0
> >  [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
> >  [<c0177de0>] filp_open+0x60/0x70
> >  [<c017952d>] vfs_write+0xad/0x120
> >  [<c017963f>] sys_write+0x3f/0x60
> >  [<c010b10f>] syscall_call+0x7/0xb
> 
> That's e100 driver, again. Fix it.

No, e100_resume() looks OK to me.  Something seems to have corrupted
preempt_count().


> > Fixing swap signatures... <3>bad: scheduling while atomic!
> > Call Trace:
> >  [<c012419e>] schedule+0x6ce/0x6e0
> >  [<c02a219d>] generic_make_request+0x17d/0x210
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c012641e>] io_schedule+0xe/0x20
> >  [<c0150522>] wait_on_page_bit+0xa2/0xd0
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c017194b>] swap_readpage+0x5b/0x80
> >  [<c0171a2a>] rw_swap_page_sync+0xba/0x110
> >  [<c014d8be>] mark_swapfiles+0x7e/0x1b0
> >  [<c014ea35>] do_magic_resume_2+0xe5/0x170
> >  [<c011d410>] restore_processor_state+0x70/0x90
> >  [<c011ff5f>] do_magic+0x11f/0x140
> >  [<c014ef1d>] do_software_suspend+0x6d/0xa0
> >  [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
> >  [<c0177de0>] filp_open+0x60/0x70
> >  [<c017952d>] vfs_write+0xad/0x120
> >  [<c017963f>] sys_write+0x3f/0x60
> >  [<c010b10f>] syscall_call+0x7/0xb
> 
> Ahha, this looks like generic problem. I'll probably take a look...

This will have the same cause as the earlier "scheduling while atomic"
problem.


