Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267909AbTAHV00>; Wed, 8 Jan 2003 16:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267919AbTAHV00>; Wed, 8 Jan 2003 16:26:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13186 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267909AbTAHVZ3>; Wed, 8 Jan 2003 16:25:29 -0500
Date: Wed, 8 Jan 2003 16:37:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
In-Reply-To: <3E1C8CD2.4070402@zytor.com>
Message-ID: <Pine.LNX.3.95.1030108161352.626A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, H. Peter Anvin wrote:

> Nakajima, Jun wrote:
> >
> > Normally all accesses should be long (0xcf8/0xcfc) but x86 is byte addresseable and some chipsets do support byte accesses. 
> > We do not encourage use of byte accesses as it will not be supported in future platforms.
> > 
> 
> The PCI standard is quite explicit: byte accesses are permitted to the
> data window (0xCFC) and not permitted to the address window (0xCF8).
> Accepting byte accesses to the address window, or not supporting byte
> accesses to the data window, *will* result in breakage (I can attest to
> this fact quite well.)
> 
> 	-hpa
> 

After power-on reset, or a hardware reset if provided (not SW
reset), you do a byte-write to CSE (Configuration Space Enable).
CSE is at 0xCF8. The 8-bit field is:
00000000B
   |  ||_________ SCE (special cycle enable)
   |  |__________ <1,3> Target function number
   |_____________ non-zero = enable configuration

This is done by the BIOS because once the enable configuration bits
are set, all accesses are supposed to be 32 bits.

There is also another byte-port at 0xCFA this is called the
forward register and it must be set before enabling configuration
transactions. This register identifies one of 256 possible
PCI buses.

None of the 8-bit registers are supposed to be touched (they
are not accessible) after configuration transactions are
enabled. All of the configuration registers are specified
as numbered doubleword registers, from 0 to 15. Attempting to
read or write less than a doubleword can stop the bus interface
state-machine, locking up everything. This is because many of
the physical lines are shared (see IDSEL, muxed to address lines).
If the exact step-by-step bus activity for which it was designed,
does not occur, all bets are off!

This was hinted by "Nakajima, Jun" <jun.nakajima@intel.com>. 


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


