Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVA2TK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVA2TK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVA2TJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:09:40 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:63182 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261535AbVA2TIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:12 -0500
Date: Fri, 28 Jan 2005 19:39:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jaco Kroon <jaco@kroon.co.za>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       sebekpi@poczta.onet.pl, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050128183955.GA2640@ucw.cz>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <20050127202947.GD6010@pclin040.win.tue.nl> <20050128131728.GA11723@ucw.cz> <41FA4A4A.4040308@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA4A4A.4040308@kroon.co.za>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 04:20:58PM +0200, Jaco Kroon wrote:
> Vojtech Pavlik wrote:
> >On Thu, Jan 27, 2005 at 09:29:47PM +0100, Andries Brouwer wrote:
> >
> >
> >>>So what _might_ happen is that we write the command, and then 
> >>>i8042_wait_write() thinks that there is space to write the data 
> >>>immediately, and writes the data, but now the data got lost because the 
> >>>buffer was busy.
> >>
> >>Hmm - I just answered the same post and concluded that I didnt understand,
> >>so you have progressed further. I considered the same possibility,
> >>but the data was not lost since we read it again later.
> >>Only the ready flag was lost.
> >
> > 
> >What I believe is happening is that we're talking to SMM emulation of
> >the i8042, which doesn't have a clue about these commands, while the
> >underlying real hardware implementation does. And because of that they
> >disagree on what should happen when the command is issued, and since the
> >SMM emulation lazily synchronizes with the real HW, we only get the data
> >back with the next command.
> >
> >I still don't have an explanation why both 'usb-handoff' and 'acpi=off'
> >help, I'd expect only the first to, but it might be related to the SCI
> >interrupt routing which isn't done when 'acpi=off'. Just a wild guess.
> >
> 
> Ok, I'm not too clued up with recent hardware and the BIOS programming 
> that goes with it (being a system admin/application programmer), what 
> exactly is usb-handoff?

usb-handoff is a kernel option that enables a PCI quirk routine that
takes the USB controller out of BIOS's hands. Until that is done (the
linux USB drivers also do it, only later), the BIOS owns the USB
controller and tries to emulate a PS/2 mouse and keyboard for systems
which can't handle USB.

>  acpi=off obviously just turns all acpi support 
> in the kernel off. 

Indeed.

> SCI is also a new abbreviation I haven't seen 
> before.

System Configuration Interrupt. In addition to SMI (System Management
Interrupt), these are two interrupts the BIOS uses to do its job behind
the operating system's back.

>  Whilst I've seen SMM before, I'm not sure what it stands for (I 

SMM is System Management Mode. It's a special mode of the CPU, which is
entered when a SMI is triggered by some event, like an port write trap
in the case of the emulated PS/2 mouse. 

Using SMM the BIOS can emulate any device it wishes to, and the OS will
think it's real. It's an even more privileged mode than what the OS runs
in.

> assume it's something to do with simulation of legacy devices for older 
> operating systems)?

It also does thermal monitoring, often is used for turning the backlight
off on notebooks, and handling various magic Fn- key combinations.

> From the kernel-parameters documentation:
> 
> usb-handoff [HW] Enably early USB BIOS -> OS handoff
> 
> I guess this means the OS takes over control of the USB devices at an 
> earlier stage than usual - possibly before ACPI gets initialised? 

Before the i8042 keyboard driver gets initialized. That's the important
part, because the handoff stops the BIOS from emulating a PS/2 mouse,
and thus blocking access to the real PS/2 mouse controller.

> I'm 
> unable to determine much from looking at drivers/pci/quirks.c (which is 
> where the usb-handoff parameter is defined).
> 
> usb-handoff=1 does however also fix the problem.  Ok.  This makes it 
> even more confusing (and probably more complicated).  The appropriate 
> section from dmesg that shows that it is working correctly:
> 
> i8042_init()
> ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
> ACPI: PS/2 Mouse Controller [MSE0] at irq 12
> i8042_controller_init()
> i8042_flush()
> drivers/input/serio/i8042.c: 20 -> i8042 (command) [4]
> drivers/input/serio/i8042.c: 47 <- i8042 (return) [4]
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [4]
> drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [4]
> i8042_check_aux()
> drivers/input/serio/i8042.c: Interrupt 12, without any data [8]
> i8042_flush()
> drivers/input/serio/i8042.c: d3 -> i8042 (command) [13]
> drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [13]
> drivers/input/serio/i8042.c: a5 <- i8042 (return) [13]
> i8042_check_aux:  passed

I don't like the interrupt message, I'll check why it's enabled so
early. It may have a good reason to, as well. Other than that, it looks
very much OK.

> So as with acpi=off, we get a correct return.  Now that usb is 
> mentioned, I think either myself or Sebastian has mentioned that the 
> keyboard does not work unless USB1.1 support is compiled in.  Another 
> clue possibly?

Compiling USB 1.1 support does the very same thing as specifying
usb-handoff on the command like - tells the BIOS to keep its hands off
the USB _and_ PS/2 controllers.

> Another question - would it be usefull at all to see what happens if the 
> AUX_LOOP test is never performed but only AUX_TEST?  Or does AUX_TEST 
> rely on the fact that AUX_LOOP must first fail/timeout somehow?

No. You can use AUX_TEST event before AUX_LOOP. But I expect it to fail
similarly when BIOS is active.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
