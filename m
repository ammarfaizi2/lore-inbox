Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318165AbSG3BNm>; Mon, 29 Jul 2002 21:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318175AbSG3BNm>; Mon, 29 Jul 2002 21:13:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:9376 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318165AbSG3BNk>;
	Mon, 29 Jul 2002 21:13:40 -0400
Date: Tue, 30 Jul 2002 11:12:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial core problems on embedded PPC
Message-ID: <20020730011203.GL2351@zax>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729100009.A23843@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 10:00:10AM +0100, Russell King wrote:
> On Mon, Jul 29, 2002 at 02:08:24PM +1000, David Gibson wrote:
> > I've been trying to get the new serial core stuff working on a PPC 4xx
> > machine (an EP405 board, specifically).  This is proving more
> > difficult than I expected.
> 
> It's vital that you mention the kernel version you're using; some of
> these problems sound like 2.5.28.

Sorry.  I'm working off the linuxppc-2.5 BK tree, which is currently
at 2.5.29.

> > In 8250.c, it appears that in order for a port to be used for the
> > serial console it must be defined "old style" with SERIAL_PORT_DFNS,
> > rather than being registered with register_serial() (because
> > serial8250_console_setup() indexs into the serial8250_ports array)).
> > This presents a small problem for 4xx, since it's serial ports are
> > memory mapped and the new old_serial_port structure can't represent
> > these.
> 
> There is no easy solution for this.  Alan said we must not drop support
> for serial console initialisation early on in the kernel setup, which
> means before the memory subsystems are initialised.
> 
> > I added support for these into 8250.c, but ran into further troubles.
> 
> I suspect a 2.5.28 kernel; please confirm and we'll that it from there.

2.5.29 based BK, actually.

> > The current plethora of similar-but-not-the-same structures describing
> > serial ports (serial_state, serial_struct, uart_port, old_serial_port)
> > is also rather confusing.  I'm guessing some of these are deprecated
> > and remain only as an aid to transition, but I'm not sure which.
> 
> I don't see there being an easy way to kill this off:
> 
> 1. serial_struct is a userspace API.

Ok.

> 2. old_serial_port glues asm/serial.h into 8250.c; asm/serial.h can't be
>    changed because (mainly) ppc uses it elsewhere.  Other architectures
>    seem to do the same sort of thing.

I think PPC's use of asm/serial.h in the bootloader needs to go away
anyway.  Could old_serial_port at least change base_baud to baud_base
to match serial_struct and serial_state.  That way a designated
initializer will work in either context.

> Unless ppc and others are willing to put up with major breakage when I
> change asm/serial.h, I don't see this getting cleaned up.  Comments on
> this area welcome.

Well, the machines I'm working on are totally broken now, so...

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
