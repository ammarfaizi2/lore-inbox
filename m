Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVAYOgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVAYOgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVAYOgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:36:35 -0500
Received: from fsmlabs.com ([168.103.115.128]:31635 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261957AbVAYOgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:36:33 -0500
Date: Tue, 25 Jan 2005 07:36:57 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.11-rc2-mm1 kernel BUG at kernel/workqueue.c:104
In-Reply-To: <20050125001424.481a9a19.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501250736330.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501242144120.3010@montezuma.fsmlabs.com>
 <20050124214356.6bed35ac.akpm@osdl.org> <Pine.LNX.4.61.0501250020320.3010@montezuma.fsmlabs.com>
 <20050125001424.481a9a19.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, Andrew Morton wrote:

> OK, thanks.  I get what appears to be a use-after-free error. 
> CONFIG_DEBUG_PAGEALLOC is set:
> 
> Program received signal SIGEMT, Emulation trap.
> 0xc0272bc2 in kbd_keycode (keycode=57, down=1, hw_raw=0, regs=0xc0673f9c)
>     at drivers/char/keyboard.c:1035
> 1035            if (tty && (!tty->driver_data)) {
> (gdb) p tty
> $1 = (struct tty_struct *) 0xce3c4000
> (gdb) p *tty
> Cannot access memory at address 0xce3c4000
> (gdb) bt
> #0  0xc0272bc2 in kbd_keycode (keycode=57, down=1, hw_raw=0, regs=0xc0673f9c)
>     at drivers/char/keyboard.c:1035
> #1  0xc0272ee4 in kbd_event (handle=0xcf150674, event_type=1, event_code=57, 
>     value=1) at drivers/char/keyboard.c:1162
> #2  0xc03081d8 in input_event (dev=0xcf19b090, type=1, code=57, value=1)
>     at drivers/input/input.c:188
> #3  0xc030a71a in atkbd_report_key (dev=0xcf19b090, regs=0xc1235000, code=57, 
>     value=0) at drivers/input/keyboard/atkbd.c:239
> #4  0xc030ab8b in atkbd_interrupt (serio=0xcf771df8, data=57 '9', flags=0, 
>     regs=0xc0673f9c) at drivers/input/keyboard/atkbd.c:392
> #5  0xc0279dd9 in serio_interrupt (serio=0xcf771df8, data=57 '9', dfl=0, 
>     regs=0xc1235000) at drivers/input/serio/serio.c:681
> #6  0xc027a96f in i8042_interrupt (irq=1, dev_id=0xc06cb3a0, regs=0xc1235000)
>     at drivers/input/serio/i8042.c:481
> #7  0xc013b7e5 in handle_IRQ_event (irq=1, regs=0xc0673f9c, action=0xcf0ee85c)
>     at kernel/irq/handle.c:90
> #8  0xc013b913 in __do_IRQ (irq=1, regs=0xc0673f9c) at kernel/irq/handle.c:177
> #9  0xc0104eee in do_IRQ (regs=0x0) at arch/i386/kernel/irq.c:105
> #10 0xc010375a in common_interrupt () at arch/i386/kernel/semaphore.c:177
> 
> Roman, binary searching indicates that the bug was introduced by
> merge-vt_struct-into-vc_data.patch.  The latest version.

Thanks for narrowing it down Andrew.

