Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbSLFVgW>; Fri, 6 Dec 2002 16:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbSLFVgW>; Fri, 6 Dec 2002 16:36:22 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:2820
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267597AbSLFVgS>; Fri, 6 Dec 2002 16:36:18 -0500
Date: Fri, 6 Dec 2002 16:47:05 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM/BUG][2.5.50][PnP]: Issue with SBAWE32 Gameport and Serial
 port & IDE controller conflict
Message-ID: <Pine.LNX.4.44.0212061642250.806-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[This was sent to Adam Belay <ambx1@neo.rr.com>, older info]
cc: Linux Kernel Mailing List

There are problems with the new PnP interface.

Of notice:

Observation #1:
===============

display of /proc/iports in particular PCI slots:

ec00-ecff : ATI Technologies Inc 3D Rage I/II 215GT [
ef80-ef9f : Intel Corp. 82371SB PIIX3 USB [N
ffa0-ffaf : Intel Corp. 82371SB PIIX3 IDE [N

the string is cut off (trivial to fix). This appears to be only affecting PCI
device strings.

/sys/devices/pci0/00:00.0:
Intel Corp. 430HX - 82439HX TXC...
/sys/devices/pci0/00:07.0:
Intel Corp. 82371SB PIIX3 ISA [N....

So there is common code that is truncating the string, I could make  a patch
to fix this easily.

Observation #2:
===============

Not all devices in sysfs show resources when they should.

case in point:

/proc/ioports:

ffa0-ffaf : Intel Corp. 82371SB PIIX3 IDE [N
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

Intel Corp. 82371SB PIIX3 IDE [N atoma/Triton II] (cut off portion)

Resources file is empty but should show: ffa0-ffaf

/sys/devices/pci0/00:07.1/ide0 has no resources file so it's resources are
 not shown anywhere.

but if there was a resource file it might show: ffa0-ffa7 for ide0.

Observation #3:
===============

When enabling PNP BIOS on BIOS: This bios seems to turn on an extra COM port
(This might be resolved by disabling the COM port being autodetected in
BIOS).

from /proc/iports:

02f8-02ff : serial
03e8-03ef : serial
03f8-03ff : serial

The problem is:

ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe

The Sound Blaster IDE controller wants to use this port range (but it is not
the first pick from PnP).

/sys/devices/pnp1/01:01/er:
Generic ESDI/IDE/ATA compatible hard disk controller (from SB IDE
 Controller).

Possible locations found:

Dependent: 01 - Priority preferred
   port 0x168-0x168, align 0x0, size 0x8, 16-bit address decoding
   port 0x36e-0x36e, align 0x0, size 0x2, 16-bit address decoding
   irq 10 High-Edge

*THIS* should be selected by PnP but is not for some reason ^^^^^^^^^^^^^

Dependent: 02 - Priority acceptable
   port 0x1e8-0x1e8, align 0x0, size 0x8, 16-bit address decoding
   port 0x3ee-0x3ee, align 0x0, size 0x2, 16-bit address decoding
   irq 11 High-Edge

* This is not available due to 0x3ee being used by the serial port.

-----------------------------------------------------------------------------
----- Dependent: 03 - Priority acceptable
   port 0x100-0x1f8, align 0x7, size 0x8, 16-bit address decoding
   port 0x300-0x3fe, align 0x1, size 0x2, 16-bit address decoding
   irq 10,11,12,15 High-Edge

***: when manually enabling this device PnP has chosen:

io 0x100-0x107
io 0x300-0x301
irq 12

-----------------------------------------------------------------------------
----- Dependent: 04 - Priority functional
   port 0x170-0x170, align 0x0, size 0x8, 16-bit address decoding
   port 0x376-0x376, align 0x0, size 0x1, 16-bit address decoding
   irq 15 High-Edge

Observation #4:
===============

The Game-port on this Sound Blaster AWE32 seems to only use port 0x200-0x200.


>From our code:

Also, here are my findings from debugging:

pnp: the driver 'ns558' has been registered
pnp: pnp: match found with the PnP device '01:01.03' and the driver 'ns558'
pnp: the driver 'ns558' has been registered

ns558: BEFORE LOOP: u = ff, v = ff, io = 200
ns558: u = ff, v = ff, io = 200
ns558: Any bits to change?

Code we're dying at:


/*
 * We must not be able to write arbitrary values to the port.
 * The lower two axis bits must be 1 after a write.
 */

        c = inb(io);
        outb(~c & ~3, io);
        if (~(u = v = inb(io)) & 3) {
                outb(c, io);
                return;
        }
/*
 * After a trigger, there must be at least some bits changing.
 */

                printk (KERN_INFO "ns558: BEFORE LOOP: u = %x, v = %x, io
=
%x\n", u, v, io);
        for (i = 0; i < 1000; i++) v &= inb(io);

                printk (KERN_INFO "ns558: u = %x, v = %x, io = %x\n", u,
v,
io);
        if (u == v) {           <================================ We die
Here.
                outb(c, io);
                printk (KERN_INFO "ns558: Any bits to change?\n");
                return;
        }
        wait_ms(3);


We never get to finish the function because in this case, u and v both
equal
ff which exits function without setting any lists.

Something is definately going odd here.

Shawn.

On December 6, 2002 10:39 am, Shawn Starr wrote:
> Looking at a 2.4 /proc/iports I see this:
>
> Our error:
> ide2: I/O resource 0x3EE-0x3EE not free.
>
> Region in use:
> 03e8-03ef : serial(auto)
>
> If im not mistaken 0x3ee inside that range of 0x3e8 to 0x3ef.
>
> why Is the serial port conflicting? and oddly why is ISAPNP not choosing
> the best possibility (which is #1 not #2 which conflicts with the serial
> port).
>
> Hmm...
>
> Shawn.


