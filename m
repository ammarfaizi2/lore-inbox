Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRA2PKs>; Mon, 29 Jan 2001 10:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRA2PKi>; Mon, 29 Jan 2001 10:10:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27012 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131063AbRA2PKX>; Mon, 29 Jan 2001 10:10:23 -0500
Date: Mon, 29 Jan 2001 10:09:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <20010128233425.E1300@bug.ucw.cz>
Message-ID: <Pine.LNX.3.95.1010129095018.31344A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Pavel Machek wrote:

> Hi!
> 
> > > Ok. I've thought about it some more, but I don't care enough about
> > > this issue to do the painstaking legwork: I don't have one of those
> > > POST-code indicators on port 0x80.
> > > 
> > > I've made the "pause" in outb_p just a few (*) ns slower, because it
> > > now loads a variable before outputting the value to port 0x80. As the
> > > whole idea about this is "pausing", making it a bit slower shouldn't
> > > matter too much.  I've tested it: It compiles, it boots.
> > > 
> > > I'm not too familar with the syntax of the "asm" statement. So I may
> > > illegally be modifying the AX register. I don't care enough about this
> > > to figure it out right now.
> > > 
> > 
> > It is; you'd have to specify "eax" as a clobber value, and that is
> > undesirable.
> > 
> > And you're still overwriting the POST value written by the BIOS.
> 
> So save value from bios at initial boot ;-).
> 								Pavel
> -- 

This is getting all too "strange". Somebody stated that they didn't
want the MFG port being overwritten so I posted a patch that would
use another port.

Instead of testing their machines with the patch, I get tons of
messages like this! I even explained what the purpose of the
delay was, just in case somebody really wanted to know. I suggest
that those who want their POST codes untouched test the patch, those
who don't care, ignore it. Those who are interested in backwards
compatibility should try the patch, those who are not interested
should ignore it also.

The all too often linux-kernel idea; "It doesn't have to be better,
only different..." is getting a bit stale. There are not any extra
hardware ports just laying around. The DMA scratch register, which
I proposed as an alternate to the MFG port, does not affect DMA
operations in any way. It's just one of the few read/write registers
available.

Pavel's idea of "saving" the value in the MFG port ignores the
fact that there is no specification making it readable. A board
manufacturer can save a few gates in his ASIC and leave it write-only.
Further, saving eax, reading the port, writing the port, then restoring
eax is at least twice the delay required.

If you insist upon using the MFG port (port 0x80), just read it.

	pushl	%eax
	inb	$0x80,al
	popl	%eax

Reads and writes take the same time. The extra overhead is the 
save/restore of register EAX. FYI, I would not trust gcc with a
"clobber" value of EAX. Many versions assume that EAX is usable
all the while (like in a called procedure). Just do the push/pop
yourself.

If you decide to do this, you also have to take care of the
code in floppy.h as well as io.h.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
