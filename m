Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRC3S4B>; Fri, 30 Mar 2001 13:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRC3Szu>; Fri, 30 Mar 2001 13:55:50 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:17935 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129084AbRC3Szg>; Fri, 30 Mar 2001 13:55:36 -0500
Date: Fri, 30 Mar 2001 10:54:41 -0800
To: linux-kernel@vger.kernel.org
Subject: Issue with console on non-sequential BIOS serial port
Message-ID: <20010330105441.A5542@ferret.phonewave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There appears to be a device naming inconsistancy with the BIOS-handled
serial ports. I'm not enough of a C coder to narrow it down, but in
terms of observed behaviour, it appears that there is a hard-coded
mapping between the four BIOS serial ports and four device nodes
(ttyS0[0-3]), which does not appear to be followed by devfs.

My hardware:

TMC dual socket 7 board, PIIX3 controller. The two onboard ports are set
to BIOS [com1:] and [com3:]. I also have a two-port ISA serial card set
to non-BIOS IO ports. The onboard port hardware does allow interrupt
sharing.

The onboard ports are assigned to /dev/tts/0 and /dev/tts/1, and I have
the other two mapped with setserial to /dev/tts/2 and /dev/tts/3.

Now I put a serial console on the second port. I put a getty on
/dev/tts/1 in inittab, but at this point I discover that I have to pass
console=ttyS2,<speed> to the kernel.

Seems to work okay, until setserial opens the serial device nodes, and
the serial console is overwritten with a single repeating
character. This happens until the getty is spawned, and the serial
console appears to go back to normal: I start to see console messages on
it again.

My question is, what is the best way to resolve this inconsistancy? I
really can't change the serial port configuration, since I don't have
any free interrupts left to unshare the serial port (well, there IS irq
6, but I can't put anything on that). I also can't use serial port 0
because of cable limitations.

Could the serial code be changed to sequentially enumerate the BIOS
ports, instead of hard-mapping them?

Or, (I think this might be a better solution) specify the serial console
port directly by IO address and IRQ, then switch it to the correct
device node once serial ports are initialised?

-- Ferret (who just has to do the weirdest things to his hardware)
