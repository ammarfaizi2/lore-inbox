Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130334AbRBPMNQ>; Fri, 16 Feb 2001 07:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130385AbRBPMNH>; Fri, 16 Feb 2001 07:13:07 -0500
Received: from web3802.mail.yahoo.com ([204.71.203.173]:8969 "HELO
	web3802.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130334AbRBPMM4>; Fri, 16 Feb 2001 07:12:56 -0500
Message-ID: <20010216121255.22971.qmail@web3802.mail.yahoo.com>
Date: Fri, 16 Feb 2001 04:12:55 -0800 (PST)
From: "Mike S." <mikes1987@yahoo.com>
Subject: isapnp , 2.2.14 vs. 2.4.1 and awe_wave
To: linux-kernel@vger.kernel.org, isapnp@roestock.demon.co.uk, tiwai@suse.de,
        mr.shonk@dial.pipex.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings kernel, awe_wave and isapnptools developers:
  
  
I recently upgraded the Linux kernel on my K6-2 PC from 2.2.14 to
2.4.1.
I like the new kernel and think that the kernel developers have done
a great job- thank you!

However, I have become aware of an issue (not necessarily a bug) with
2.4.1 which should possibly be documented in a/the readme. It is an
interesting little mystery to me.

The only problem I had with 2.4.1 was that the awe_wave module would
not recognize my AWE64 SoundBlaster. Everything worked great with my
2.2.14 "emergency backup" kernel. Since I use isapnptools and did
not compile in any kernel pnp support, I was almost sure that I had
found a bug in the new 2.4.1 awe_wave. I think that most folks that 
encounter this will become convinced that they are looking at a 
real live awe_wave bug. 

Probing around with test code in awe_wave.c, it become clear to me
that the card was not being initialized properly by my isapnptools. 
Even more alarming was the fact that pnpdump would not see the SB card 
at all under 2.4.1, unless I used the -r option, but would show it 
just fine under 2.2.14.

The specs on my little system are:
Amptron PM8900 motherboard (Intel VX chipset), 
K6-2 366MHZ (via PowerLeap adapter and motherboard hacks), 64MB RAM,
Award PNP BIOS V4.51 (1997), I won't mention the PCI cards, 
but there are two ISA cards:
1. An ISA AWE64 SoundBlaster
2. An ISA 5634BTS (Powercom) hardware modem (This is one excellent
modem
   BTW) using COM2- the motherboard COM2 has been shut down in the
BIOS. 

The serial drivers I always build into the kernel, all sound and 
parport related drivers are built as modules.

Software specs:
RedHat 6.0 (upgraded)   gcc: 2.96   glibc: 2.2.1   gmake: 3.79
binutils: 2.9.5   util-linux: 2.10p   modutils: 2.4.1
isapnptools: 1.18

Here is my isapnp.conf, sharp eyes will see a problem (discussed
below):
******** BEGIN isapnp.conf ****************
# $Id: pnpdump.c,v 1.18 1999/02/14 22:47:18 fox Exp $
# Trying port address 0203
# Board 1 has serial identifier 05 0e 8f 5c ee e4 00 8c 0e
# Board 2 has serial identifier cb 46 46 46 46 12 20 68 04

# (DEBUG)
#(VERIFYLD N)
(READPORT 0x0203)
(ISOLATE PRESERVE)
#(ISOLATE CLEAR)
(IDENTIFY *)
(VERBOSITY 3)
(CONFLICT (IO WARNING)(IRQ WARNING)(DMA WARNING)(MEM WARNING))
# warning needed because isapnp will think that the modem
# IO port conflicts with itself. I like isolate preserve to try to 
# keep what my BIOS already did- the only reason I need
# isapnp is to activate those AWE ports at 0x620,0xA20,0xE20
# that Creative Inc. didn't put in the card's PNP ROM- boneheads.
# The serial driver doesn't seem to mind any shake-ups. 
# 
# Card 1: (serial identifier 05 0e 8f 5c ee e4 00 8c 0e)
# Vendor Id CTL00e4, Serial Number 244276462, checksum 0x05.
# Version 1.0, Vendor version 1.0
# ANSI string -->Creative SB AWE64  PnP<--
# Vendor defined tag:  73 02 45 20
#

(CONFIGURE CTL00e4/244276462 (LD 0
# ANSI string -->Audio<--

(INT 0 (IRQ 5 (MODE +E)))
(DMA 0 (CHANNEL 1))
(DMA 1 (CHANNEL 5))
(IO 0 (SIZE 16) (BASE 0x0220))
(IO 1 (SIZE 2) (BASE 0x0330))
(IO 2 (SIZE 4) (BASE 0x0388))

(NAME "CTL00e4/244276462[0]{Audio               }")
(ACT Y)))


# Logical device id CTL7002
(CONFIGURE CTL00e4/244276462 (LD 1
#     Compatible device id PNPb02f
#     ANSI string -->Game<--

(IO 0 (SIZE 8) (BASE 0x0200))

(NAME "CTL00e4/244276462[1]{Game                }")
(ACT Y)))


# Logical device id CTL0022
(CONFIGURE CTL00e4/244276462 (LD 2
#     ANSI string -->WaveTable<--

(IO 0 (SIZE 4) (BASE 0x0620))
(IO 1 (SIZE 4) (BASE 0x0A20))
(IO 2 (SIZE 4) (BASE 0x0E20))

#     Vendor defined tag:  75 01 69 46 35 55
(NAME "CTL00e4/244276462[2]{WaveTable           }")
(ACT Y)))

# End tag... Checksum 0x00 (OK)


# Card 2: (serial identifier cb 46 46 46 46 12 20 68 04)
# Vendor Id ACH2012, Serial Number 1179010630, checksum 0xCB.
#     Version 1.0, Vendor version 0.0
#     ANSI string -->5634BTS 56K Video Ready Modem<--
#
(CONFIGURE ACH2012/1179010630 (LD 0

(IO 0 (SIZE 8) (BASE 0x02f8))
(INT 0 (IRQ 3 (MODE +E)))

(NAME "ACH2012/1179010630[0]{5634BTS 56K Video Ready Modem}")
(ACT Y)))
# End tag... Checksum 0x00 (OK)


(WAITFORKEY)
******* END isapnp.conf *****************




Versions prior to 1.19 of pnpdump will default to using 0x0203
as a read port. This is problematic as the game port of most sound
cards uses 8 addresses starting at 0x0200. V1.19 and later of
pnpdump uses 0x0273 as the default readport and this causes far
fewer problems.

Under kernel 2.2.14 the above isapnp.conf works great, under
2.4.1, the SoundBlaster will not be found by isapnp at all!

Of course, if I change the readport to 0x0273 everything works
great.

The $10,000 question to me is: What is the 2.4.1 kernel doing
that is touching my sound card in such a way that it is no longer 
recognized? In all cases, I have no PNP support in the kernel and all
sound related drivers are in modules- the loading of which I turned
off. I even tried a kernel without joystick support! Still,
pnpdump V1.18 will not see the SoundBlaster under 2.4.1 unless I
force the readport to 0x0273!

V1.22 of pnpdump does see the SoundBlaster. However, it is not
enough for users to upgrade isapnptools as they must also edit the
isapnp.conf so that the readport is 0x0273 (or whatever pnpdump V1.19+
finds above 0x0207).



On an unrelated note, _must_ the linux-x.y.z.tar tar balls 
all unpack as "linux"? Every time I forget this and 
overwrite a prior source tree. I then feel as if I were the
victim of a joke. In the very least, warn us about this
in the ftp server readme.

Also, when I tried to compile a 2.2.14 kernel with gcc 2.96,
I got an error "badly puncuated #define" in
linux/arch/i386/lib/checksum.S. 
The error occurs on lines 231 and 237 of checksum.S.
Removing the -traditional flag from linux/arch/i386/lib/Makefile
will fix the problem.



 
  I hope all this helps somebody out,
 
  Michael Shell
  mikes1987@yahoo.com
     


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
