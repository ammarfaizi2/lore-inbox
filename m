Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVBDTkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVBDTkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbVBDTkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:40:36 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:63483 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S266558AbVBDTjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:39:25 -0500
Message-ID: <4203D303.1BCB6EB1@gte.net>
Date: Fri, 04 Feb 2005 11:54:43 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jaco Kroon <jaco@kroon.co.za>, sebekpi@poczta.onet.pl,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za>
		 <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <41F9545A.4080803@kroon.co.za>
		 <Pine.LNX.4.58.0501271314070.2362@ppc970.osdl.org> <41F96743.9060903@kroon.co.za> <Pine.LNX.4.58.0501271426420.2362@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [66.199.68.159] at Fri, 4 Feb 2005 13:39:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

> On Fri, 28 Jan 2005, Jaco Kroon wrote:
> > >>
> > >>ok, how would I try this?  Where can I find an example to code it from?
> > >>  Sorry, I should probably be grepping ...
> > > If the udelay() didn't work, then this one isn't worth worryign about
> > > either. Back to the drawing board.
> > Yea.  But for interrests sake, what do you mean with a serializing IO
> > instruction?
>
> If you use "outb_p()" instead of an "outb()", the regular IO instruction
> will be followed by another out to another port on the motherboard: that
> will not only cause a delay, it should also force at least the host bridge
> to have no outstanding posted writes (the host bridge shouldn't post IO
> port writes anyway, but hey, it won't hurt to try to make even more sure
> of that).
>
> > I also tried increasing the total timeout value to about 5 seconds
> > (versus the default half second), still no success, so the device is
> > simply not sending back the requested values.
>
> If it was the other way around (that it works with ACPI _on_), I'd assume
> that ACPI just disables some broken BIOS SMM emulation code. But I just
> don't see ACPI _enabling_ SMM emulation. That would be just too strange,
> and against the whole point of the legacy keyboard emulation stuff - you
> want to do legacy keyboard emulation if the OS is old, not if it's new.
>
> It may be that ACPI ends up enabling some silly power control SMM sequence
> that wakes up on keyboard accesses, and screws up the emulation. That
> sounds pretty strange too, I have to say - even if SMM/ACPI would like to
> trap keyboard command sequences, I'd have expected it to just pass them
> through after looking at them.
>
> One option may be that SMM/ACPI traps the _received_ characters, and
> incorrectly eats the reply, because it thinks it's some special key
> sequence (and should cause SMM/ACPI to make the screen brighter or
> something silly like that).
>
> Does anybody know/remember what the keycode 0xA5 means?

So far , the only place I can find a 0xA5 is  under the PS/2 Keyboard numbers and scan codes.
KeyNumber   Set 1 Make/Break     Set 2 Make/Break   Set 3 Make/Break   Base Case   Uppercase
38                  25/A5                        42/F0 42                 42/F0 42                 k                  K

I am not familiar with how PS/2 uses it scan code. Unlike the AT it only have one Scan code to a Key Number.

>
>
> > I still stand with the theory that it is sending back the value we want
> > for the first request on the second one (managed to get this one by
> > explicitly turning i8042_debug on and off in the code):
> >
> > i8042_init()
> > ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
> > ACPI: PS/2 Mouse Controller [MSE0] at irq 12
> > i8042_controller_init()
> > i8042_flush()
> > drivers/input/serio/i8042.c: 20 -> i8042 (command) [4]
> > drivers/input/serio/i8042.c: 47 <- i8042 (return) [4]
> > drivers/input/serio/i8042.c: 60 -> i8042 (command) [5]
> > drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [5]
> > i8042_check_aux()
> > drivers/input/serio/i8042.c: Interrupt 12, without any data [9]
> > i8042_flush()
> > drivers/input/serio/i8042.c: d3 -> i8042 (command) [13]
> > drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [13]
> > drivers/input/serio/i8042.c:      -- i8042 (timeout) [875]
> > i8042_check_aux: param_in=0x5a, command=AUX_LOOP, param_out=5a <= -1
> > drivers/input/serio/i8042.c: a9 -> i8042 (command) [879]
> > drivers/input/serio/i8042.c: a5 <- i8042 (return) [879]
> > i8042_check_aux: param_in=??, command=AUX_TEST, param_out=a5 <= 0
> >
> > I've rebooted a couple of times and that interrupt is in exactly the
> > same place every time.  And int 12 is indeed the AUX device, could this
> > be a clue?
>
> Does it change if you change the initial value of "param" (0x5a) to
> something else?
>
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
