Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263429AbTCNSOv>; Fri, 14 Mar 2003 13:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbTCNSOv>; Fri, 14 Mar 2003 13:14:51 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:44691
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S263429AbTCNSOs>; Fri, 14 Mar 2003 13:14:48 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2003 10:25:21 -0800
MIME-Version: 1.0
Subject: Re: VESA FBconsole driver?
Message-ID: <3E71AE11.850.4B46BB7@localhost>
In-reply-to: <3E71ABC7.90500@aitel.hist.no>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:

>  > Why is it ugly? IMHO it is very much needed, as it would provide a
>  > mechanism for the kernel to be able to properly restore the screen
>  > if a user land program goes astray.
> 
> First - the bios isn't always able to fix the screen - the program may
> have programmed the video hardware in odd ways the bios don't know 
> about.  Bioses aren't a magic fix.

Exactly what facts do you base the above statement on? Have you seen this 
in practice? 

I can tell you from my own personal experience that the BIOS on the 
graphics card can nearly always restore the screen no matter what state 
you have put the graphics hardware into. I have done development in DOS 
for years writing the UniVBE and SciTech Display Doctor products, and we 
have always used the BIOS to restore the screen when one of our graphics 
drivers crashed during development.

> Second, the proper way to do this is for the video driver to fix
> it up, using more efficient code that runs under linux without
> special consideration because it was written for that case. 

Great, assuming you *have* a video driver for the card in question! There 
are lots of cards that can run on the  VESA fbconsole driver that uses a 
mode set by the real mode boot loader and can never be changed once the 
system is up and running. For those particular devices using the BIOS is 
the *perfect* solution IMHO (if the driver was so easy to write it would 
already exist).

> > More tricks like what? All we need is the ability to call the BIOS and 
> > have it execute the necessary real mode code, just like we do on ia32 
> > machines in user land.
> 
> Ability to call the bios in real mode is no simple feat. And the
> bios may screw up.  That doesn't matter for a user program, it just
> crashes and don't damage anything else.  You don't want the kernel
> to crash - ever.  A broken bios is _no_ excuse here. 

We are talking about using the BIOS to do the most basic and simple thing 
that it does - set a display mode. Sure BIOS'es are buggy, but even the 
crappiest BIOS on the planet can properly set the display mode without 
crashing! They have to, or their Windows 9x drivers would never have 
worked.

Anyway this is a moot point because I do believe that if we implement the 
VESAFBD style daemon that Aki was working on we can avoid the need for 
the vm86() calls to be made from the kernel anyway, and have them run in 
the protected space of a userland daemon. Then if the BIOS does crash 
(unlikely IMHO), it won't crash the kernel.

> Bioses are generally too limited.  They make a lot of stupid
> assumptions, thinking it is ok to use legacy vga registers and
> things like that. Consider a machine with two or more video cards.
> Linux handles that fine, but a bios? Or really two bioses, one for
> each card? 

What about it? How do you think Linux brings up the secondary graphics 
card for dual head operations? It uses the *BIOS*! I know that because I 
resurrected the x86emu project that is used to warmboot the secondary 
graphics cards. You can in fact do it on x86 Linux without needing the 
BIOS emulator at all, just using the vm86() services and some nify copy 
on write features of the Linux kenerl. As far as legacy I/O port access 
goes, the BIOS will nearly always do that, but if you only run the BIOS 
on one card at a time, this is no problem. The PCI spec allows you to 
selectively enable and disable the I/O port access on any graphics card 
on the bus as you see fit. So you simply disable the primary card, enable 
the secondary card and let the BIOS have at it.

This does work, because it is how secondary controllers are done on Linux 
today.

> Imagine a dual processor where one one processor executes one bios
> and the other processor another bios , each trying to set up one
> card. Somehow I think this won't work too well. 

No, it wouldn't and you would need to ensure mutually exclusive access to 
the graphics cards. Simple problem really and since XFree86 is not 
threaded is not a problem in the existing code anyway, but if it is that 
is pretty a simple multu-processor programming problem.

> As for userspace tricks - userspace can do all sorts of nifty
> things like actually open a file and read it.  For example a file
> with the latest list of bios oddities to work around. 

Definately. I have no argument there.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

