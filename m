Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129820AbQKHIbV>; Wed, 8 Nov 2000 03:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbQKHIbL>; Wed, 8 Nov 2000 03:31:11 -0500
Received: from pivsbh1.ms.com ([199.89.64.103]:4008 "EHLO pivsbh1.ms.com")
	by vger.kernel.org with ESMTP id <S129512AbQKHIaz>;
	Wed, 8 Nov 2000 03:30:55 -0500
Message-ID: <3A090F20.D4B42BDE@msdw.com>
Date: Wed, 08 Nov 2000 08:30:25 +0000
From: Richard Polton <Richard.Polton@msdw.com>
Reply-To: Richard.Polton@msdw.com
Organization: Morgan Stanley Dean Witter & Co.
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD   (WinNT; U)
X-Accept-Language: en,ja
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: 2.4.0-test10 problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(usb people, issue 1 is partly relevant and issue 3 is definitely USB.)

I have been testing my test10 installation and have come up with
a few old problems, all of which have been reported before.

1. Warm reboot fails to restart, i.e. hangs after displaying 'Restarting

    system'. In this particular scenario, the power switch is disabled
    too and the only way in which the machine responds is by switching
    off at the wall and pulling the battery. Note that this scenario has
been
    observed only if I boot, get the login prompt (optionally log in)
and then
    ctrl-alt-del. A similar scenario occurs after an amount of time
using the
    machine and then rebooting. In this case, the machine restarts
successfully
    but hangs when it tries to initialise (right word?) the UHCI
controller.

    Here is the exchange Randy Dunlap and I had about this some
(internet) time ago:



> Not absolutely sure about the numbers, but I think that the
> UHCI controller
>
> is Intel 82371AB USB Host Controller (PIIX4) (rev. 0x01).
>
> The uhci hcd is built into the kernel. There are not any usb
> modules loaded
>
> on reboot. When I say 'locks up ...' I do indeed mean that shutdown
> succeeds
> as does some portion up until the HCD initialises of startup.
>
> Thanks,
>
> Richard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Richard,

I have that same USB host controller in my PC (not laptop).

I have built usb-uhci and uhci-alt (which Richard is not using
BTW) into the kernel (2 separate kernels of course) and
rebooted with both of them successfully.

Can you provide a kernel log up to the point of the failure?

Maybe there's something other than USB that's locking up,
but it appears that it's the USB UHCI HCD that's the problem
because that's the latest info on the console.
Or does usb-uhci actively complain about a problem?

My experiments didn't work, so I'll try just thinking
about it... The usb Makefile and module inits did change
recently.  Maybe that has something to do with it.
I'll keep thinking/checking on it.

~Randy

> "Dunlap, Randy" wrote:
>
> > > I am running 2.4.0-test8 on my laptop with a UHCI controller. When

> > > performing a
> > > warm reboot the machine locks up on initialisation of the
> controller.
> > > This did not occur under 2.4.0-test5. Any thoughts?
> >
> > Need more info, such as:
> >
> > Which uhci host controller driver (HCD)?
> > Is the uhci HCD built as a module or in-kernel?
> >
> > If module:
> > Is the uhci HCD loaded when you do the warm reboot?
> >
> > What other USB drivers are loaded when you do the reboot?
> >
> > And you say: "locks up on initialisation of the controller".
> > Does this mean that the shutdown succeeds and some portion
> > of the following init succeeds, up until the HCD is trying
> > to initialize?
> >
> > ~Randy


    I thought that it had been fixed, but I was wrong.


2. Parallel port cdrom fails to mount disks:
    modprobe friq
    modprobe pcd
    mount /dev/pcd0 /mnt/cdrom    fails with a return code of 32.
    Additionally, lsmod after the aborted mount shows that the following
modules
    have been unexpectedly loaded: nls_iso8859-1, nls_cp437, vfat and
fat. Note
    that the cd is an iso9660 formatted disk.

    Here is the relevant section of my log file:

Nov  7 20:21:52 turbocharged kernel: paride: version 1.05 installed
Nov  7 20:21:52 turbocharged kernel: paride: friq registered as protocol
0
Nov  7 20:22:07 turbocharged kernel: pcd: pcd version 1.07, major 46,
nice 0
Nov  7 20:22:07 turbocharged kernel: pcd0: friq 1.01, Freecom IQ ASIC-2
adapter at 0x378, mode 0 (4-bit), delay 1
Nov  7 20:22:09 turbocharged kernel: pcd0: Master: R/RW 2x2x24
Nov  7 20:22:09 turbocharged kernel: pcd0: mode sense capabilities
completion: alt=0x53 stat=0x51 err=0x60 loop=0 phase=3
Nov  7 20:22:09 turbocharged kernel: pcd0: mode sense capabilities:
Sense key: 6, ASC: 29, ASQ: 0
Nov  7 20:22:09 turbocharged kernel: Uniform CD-ROM driver Revision:
3.11
Nov  7 20:22:57 turbocharged kernel: cdrom: open failed.
Nov  7 20:22:57 turbocharged kernel: VFS: Disk change detected on device
pcd(46,0)
Nov  7 20:23:17 turbocharged kernel: cdrom: open failed.
Nov  7 20:23:17 turbocharged kernel: VFS: Disk change detected on device
pcd(46,0)
Nov  7 20:23:25 turbocharged kernel: cdrom: open failed.
Nov  7 20:23:25 turbocharged kernel: VFS: Disk change detected on device
pcd(46,0)


3. usb-storage: I am using a LaCie USB hard disk which generally behaves
perfectly well.
    In one situation, though, I have problems. I unmounted all the
partitions on the USB
    device manually and then issued the 'halt' command. During shutdown,
towards the end
    where usb-storage is removed (or something similar - I forgot to
bring that bit of the log file )-8   )
    I see reams of

    usb-storage: *** thread sleeping

    messages which, in fact, never stop. The only recourse is the power
switch.

Thanks for listening,

Richard

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
