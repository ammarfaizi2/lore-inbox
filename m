Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSIIPP2>; Mon, 9 Sep 2002 11:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSIIPP1>; Mon, 9 Sep 2002 11:15:27 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:64665 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317365AbSIIPP0>;
	Mon, 9 Sep 2002 11:15:26 -0400
Date: Mon, 9 Sep 2002 17:20:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.33/drivers/input/keyboard/atkbd.c allow SETLEDS to fail
Message-ID: <20020909172004.A2631@ucw.cz>
References: <200209091504.IAA01726@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209091504.IAA01726@baldur.yggdrasil.com>; from adam@yggdrasil.com on Mon, Sep 09, 2002 at 08:04:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 08:04:11AM -0700, Adam J. Richter wrote:
> On Mon, 9 Sep 2002 at 16:07:23 +0200, Vojtech Pavlik wrote:
> >On Mon, Sep 09, 2002 at 06:51:11AM -0700, Adam J. Richter wrote:
> 
> >> 	I have a computer with an Iwill VD133 motherboard doing
> >> USB-to-PS/2 keyboard emulation (built into the chipset somewhere)
> >> for a BTC 7932M USB keyboard.  Under this configuration, the
> >> SETLEDS command in atkbd_probe fails (the first atkbd_sendbyte
> >> in atkbd_command fails), but the keyboard otherwise works if
> >> that failure is ignored.
> [...]
> 
> >I cannot do that, since then the keyboard identification will give too
> >many positives.
> 
> 	What real problem does that cause?  There are other tests that
> the keyboard still has to pass. 

There are not. If SETLEDS fails, then there is the GETID command, which
is also allowed to fail (fails on AT (non-PS/2) keyboards, which are
still common), and it most likely also fails on your keyboard. That's
all.

If you kill the SETLEDS command, then even without a keyboard, the
keyboard will be detected, and sent commands, which will have to time
out every time.

> Does this change even cause a false
> positive in any real case?  As I understand it, this is how it was
> prior to 2.5.32.

Yes. The keyboard was assumed to be always present.

> >I assume you have an USB keyboard, and the BIOS emulates a PS/2 keyboard
> >for non-USB capable OSes.
> 
> >Well, fix Linux irq router code, instead of damaging the keyboard code.
> 
> 	How is the Linux IRQ routing code broken?  As far as I know,
> it only reads the information given to it and cannot reprogram the
> hardware.

It can.

> 	My understanding is that the BIOS is responsible for setting
> up the IRQ routes of each device and writing them into each device's
> PCI configuration register dword 15 byte 0 (INTERRUPT_LINE), which is
> normally just 8 bits of RAM.

Yes, but because the BIOS often writes nonsense to these config
registers, Linux knows several southbridges and can fix the routing by
hand.

> The mechanism for *making* those routes
> is vendor specific and handled by the BIOS at boot time.  In the
> particular case of my VD133, it apparently uses a Via VT82C598 PCI
> bridge ("Apollo MVP3 AGP"), which I think is the component that would
> have the secret bits for setting up routing from the main PCI bus to
> the interrupt controllers.

Most likely the interrupt routing is controlled by the southbridge (the
ISA bridge device). See arch/i386/pci/irq.c. Maybe it's as easy as an
entry for your southbridge is missing.

> And those bits do appear to be secret.

Not really. Most of them are actually documented. Namely for built-in
devices like USB controllers, because those cannot be wired differently
by different board manufacturers.

> While I have found programming information for a number of Via chips
> on my VD133 motherboard, I have only been able to find technical
> marketing information on the VT82C598, and the form for requesting
> additional information from the Via web site says they normally only
> give more detailed documentation to high-volume partners under
> non-disclosure agreements.

Try the southbridge instead of the northbridge. I have several of the
documents, and can send it to you if you tell me the right chip number.

> 	By the way, there is a note in drivers/pci/quirks.c that
> mentioned that a different Via chipset did IRQ configuration for the
> USB device by having the write to the INTERRUPT_LINE register actually
> do the configuration. I tried it ("setpci -v -s 00:01.0 INTERRUPT_LINE=7"),
> but that didn't update the kernel's idea of the IRQ routing (although
> I could read it back from hardware with "lspci -H 1 -vv -s 00:01.0").
> 
> 	However, even if some further development of this kludge works
> (I would welcome that), I suspect that the bug that I am reporting is
> common to many USB emulated keyboards, and that my fix does not cause
> a real problem, and applications that do not need USB for any other
> purpose to avoid including or configuring Linux USB.

Well, the emulated keyboard is a very very ugly kludge. It uses SMM and
SMI to handle the keyboard, and then pushes keystrokes into the keyboard
controller. It disables any extra keys on the keyboard, and the keyboard
LEDs. The Linux USB stack isn't too big to enable the keyboard the sane
way on those systems.

> 	On the other hand, if there is real hardware is broken by my
> change (and kernels prior to 2.5.32 I assume), that would change things,
> and I'd be interested in knowing what that hardware is and how it breaks.

Any machine with an USB keyboard enabled in the normal way will try to
set the LEDs on a non-existing PS/2 keyboard. Which will take time.

-- 
Vojtech Pavlik
SuSE Labs
