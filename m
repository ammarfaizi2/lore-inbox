Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270722AbTG0Kcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270724AbTG0Kct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:32:49 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:38923 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270722AbTG0KcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:32:15 -0400
Date: Sun, 27 Jul 2003 12:47:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: i8042 problem
Message-ID: <20030727104726.GA1313@win.tue.nl>
References: <20030726093619.GA973@win.tue.nl> <20030726212513.A0BD.CHRIS@heathens.co.nz> <20030727020621.A11637@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727020621.A11637@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 02:06:21AM -0400, Pete Zaitcev wrote:
> > Date: Sat, 26 Jul 2003 21:41:32 -0400
> > From: Chris Heath <chris@heathens.co.nz>
> 
> > > > drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [40] 
> > > > drivers/input/serio/i8042.c: 60 -> i8042 (command) [50] 
> > > > drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [50] 
> > > > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [51] 
> > > > serio: i8042 KBD port at 0x60,0x64 irq 1 
> > > > <------------- This is it, keyboard is dead. 
> > > 
> > > Writing 44 to the command byte disables IRQ1. 
> > 
> > It looks like a timeout problem.  The ack (fa) arrived 11 ticks after
> > the byte (00) was sent, but it looks like the timeout is only 10 ticks.
> > 
> > Try playing with the timeout in atkbd_sendbyte (line 217 of
> > drivers/input/keyboard/atkbd.c).
> 
> Playing with timeout does not help, but on second thought
> I suspect that atkbd fails to open the port for some reason,
> that's why interrupts stay disabled.

Well, Chris is right, of course.

As I said, writing 44 to the command byte disables IRQ1.
So, the question is, who does that. Read the code:

We do i8042_init, detect a PS/2 keyboard/mouse controller, and call
i8042_port_register() first for mouse, then for keyboard.
This i8042_port_register() does
	serio_register_port(port);
and then happily reports
	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n"

This serio_register_port(port) probes connected devices.
It calls atkbd_connect(), which calls atkbd_probe(), and
the latter fails.
Now atkbd_connect() does serio_close() which does
i8042_close() and we see
	i8042_ctr &= ~values->irqen;
	i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR);
that the IRQ is disabled.

So the culprit is the failing of atkbd_probe().
It does a ATKBD_CMD_GETID, but gets no answer, then a
ATKBD_CMD_SETLEDS, and that command fails.
It sends the 0xed, gets an ACK, sends the 0x00 and times out.

And it times out because atkbd_sendbyte has a timeout of 10 msec
while the reply came after 11 msec.

So, apart from other things you might try, it seems to me that
changing the timeout in atkbd_sendbyte from the 10000 that is
there to the 100000 that the comment implies, should help.

Andries


-         int timeout = 10000; /* 100 msec */
+         int timeout = 100000; /* 100 msec */

