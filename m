Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVAYFod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVAYFod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 00:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVAYFod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 00:44:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:34258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261822AbVAYFoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 00:44:30 -0500
Date: Mon, 24 Jan 2005 21:43:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.11-rc2-mm1 kernel BUG at kernel/workqueue.c:104
Message-Id: <20050124214356.6bed35ac.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501242144120.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501242144120.3010@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> I pressed a key on a VT during boot and got the following;
> 
>  usb-storage: device scan complete
>  ------------[ cut here ]------------
>  kernel BUG at kernel/workqueue.c:104!
>  invalid operand: 0000 [#1]
>  PREEMPT SMP DEBUG_PAGEALLOC
>  Modules linked in:
>  CPU:    0
>  EIP:    0060:[<c01314af>]    Not tainted VLI
>  EFLAGS: 00010017   (2.6.11-rc2-mm1)
>  EIP is at queue_work+0x8f/0xa0
>  eax: f5ebe0e4   ebx: f5ebe0e0   ecx: 00000001   edx: 00000000
>  esi: c19adef8   edi: 00000000   ebp: f5e4fe14   esp: f5e4fe08
>  ds: 007b   es: 007b   ss: 0068
>  Process udev.hotplug (pid: 1351, threadinfo=f5e4e000 task=f5817ac0)
>  Stack: c1815000 0000001c 00000001 f5e4fe20 c0388d3d c1815000 f5e4fe2c c03890c1
>         00000002 f5e4fe64 c0389be1 f5e4ffc4 c011a7b8 00000000 00000002 00000086
>         00000001 00000020 c1815000 f5e4ffc4 00000001 f7b09674 0000001c f5e4fe80
>  Call Trace:
>   [<c010403a>] show_stack+0x7a/0x90
>   [<c01041c6>] show_registers+0x156/0x1c0
>   [<c01043e0>] die+0x100/0x190
>   [<c0104819>] do_invalid_op+0xa9/0xc0
>   [<c0103cc7>] error_code+0x2b/0x30
>   [<c0388d3d>] fn_enter+0x1d/0x60
>   [<c03890c1>] k_spec+0x31/0x50
>   [<c0389be1>] kbd_keycode+0x1a1/0x300
>   [<c0389dd3>] kbd_event+0x93/0xf0
>   [<c04d2963>] input_event+0xd3/0x3b0
>   [<c04d74cf>] atkbd_report_key+0x2f/0x70
>   [<c04d76fe>] atkbd_interrupt+0x1ee/0x510
>   [<c03abbf3>] serio_interrupt+0x43/0x74
>   [<c03ac84d>] i8042_interrupt+0x17d/0x270
>   [<c0141e8a>] handle_IRQ_event+0x2a/0x60

I can't reproduce it from a quick test here.  I'd assume that the keystroke
came in before the vt's workqueue is initialised.  fn_enter() calls
put_queue() calls con_schedule_flip() calls schedule_work() which goes BUG:

		BUG_ON(!list_empty(&work->entry));

I bet the list_head pointers are null.

Roman might have a theory?
