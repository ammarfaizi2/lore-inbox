Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270218AbTHGRXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270316AbTHGRXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:23:51 -0400
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:34288 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S270218AbTHGRXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:23:46 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.0-test2 vs 2.2.12 -- Some observations
Date: Thu, 7 Aug 2003 13:23:44 -0400
User-Agent: KMail/1.5.3
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet> <20030807142624.GA29208@lst.de>
In-Reply-To: <20030807142624.GA29208@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071323.44884.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	So now that 2.6.0-test2 runs on a 386EX/25 with 8MB of memory, and the CF 
disk is working properly, I have a few observations regarding the change in 
kernels, and the impact that I see.

	These are not (necessarily) judgements, and the comparison may not be 100% on 
equal footing, but nonetheless, they're what I see.  If you have suggestions, 
I'll be happy to try them.  So, with abestos suite in standby mode:

	Both kernels are very limited in what's compiled in.  Basically, it's 386 
optioned, with math emulation enabled, IDE for hard disk only, PPP with 
compression, ethernet (but no drivers, just enough so that PPP works), 
SYSVIPC, ext2 support, /proc support, serial console (serial.h has been 
modified for 6 serial ports, 2 16450s (the 386EX native ports), and 2 
external 16C752's (each channel on a dedicated interrupt).

	The 2.2.12 version is compiled with GCC 2.91.66, the 2.6.0-test2 version with 
GCC 2.96.

	Kernel 2.2.12 is a BlueCat variation, which has some minor tweaks to reduce 
the footprint, modifications to remove real-time clock support, and the 
CLOCK_TICK_RATE changed from 1193180 to 1000000.  The 2.6.0-test2 kernel has 
similiar modifications, implemented as much as possible in the mach- 
directories.  2.2.12 also has support for an AT1700 ethernet controller 
(whose hardware is not present in the system, currently).  2.6.0-test2 is 
build without this.

	2.2.12 compiles out at 755712 bytes, which is uncompressed (we don't compress 
the kernel because a 386EX/25 takes too long to uncompress).  The values 
reported by the kernel as it comes up are: 6884k/8192k availale (596k kernel 
code, 416k reserved, 272k data, 24k init).

	2.6.0-tests compiles out at 1163392 bytes (again, uncompressed, for the same 
reason).  The values reported by the kernel are: 6296k/8132k available (932k 
kernel code, 1424k reserved, 239k data, 68k init, 0k highmem).  The 
CONFIG_EMBEDDED is set (admittedly, I haven't grepped the code to see what 
all this variable impacts).

	I'm sure the reserved value is something I'm failing to tune myself that's 
been tweaked into the BlueCat distro.  That's something I need to look into.  
But 300K of code growth (33%!) for the same basic functionality strikes me 
as... not good.  Any thoughts on this issue?

	For reasons unknown, whereas 2.2.12 picked up the values for how much memory 
we have stuffed into a fake BIOS block, 2.6.0-test2 does not (nor did 
2.5.69).  I have to set a mem=7744k into the boot params.  Anything more, and 
I get kernel paging faults at startup.  I'm unclear why this is, but since it 
can be worked around at the moment, I can let it lay.

	2.2.12 reports 3.49 Bogomips, 2.6.0-test2 reports varying values, depending 
on what HZ is set to (more on this shortly).  4.14 for HZ=100, 8.19 for 
HZ=1000.  I realize that Bogomips are meaningless, and didn't at some point 
the method for determining them change?  I do find it odd that that the 
rating should change by changing the HZ value, however.

	Interactive performance is an atrocity with 2.6.0-test2.  Something as simple 
as backspacing though a command line can cause overrun errors.  Whereas 
before zmodeming a file down was not an issue with 2.2.12 (this, in fact, is 
how software is applied to the CF card), it fails completely under 
2.6.0-test2.  In addition, I started getting 'serial8250: too much work for 
irq4'.  Granted, the console port is a 16450, which has no FIFO.  But to go 
to a newer kernel and get this error doesn't seem right.  Perhaps there's 
some performance tuning I'm missing, but I do know that it was not required 
under 2.2.12, so I'm not sure why I would need to do that under 2.6.0-test2.

	I have not run hdparm on the drives, but e2fsck coming up on a dirty 
partition is amazingly slow on 2.6.0-test2.  On a 32MB CF card with 25% usage 
(about 300 files), it takes less than 10 seconds under 2.2.12.  On 
2.6.0-test2, I'm seeing on the order of 40+ seconds.  Long enough, in fact, 
that the watchdog that makes sure the system has booted into the application 
is timing out and punting the system.

	Any thoughts or things to look for would be greatly appreciated.  I realize 
that many people doing embedded work on small processors are using the older 
kernels.  I'd like to use a newer one, since the device driver interface is 
so much cleaner, and I'd like to use a CF+WiFi card, which is not supported 
in the older kernels.  

	I've posted the .config files, along with the System.map and kernel images to 
http://tinymicros.com/linux.  The final images are run through "objcopy -O 
binary -R .note -R .comment -R .stab -R .stabstr vmlinux vmlinuz" to produce 
the image that goes into the FLASH parts.

	--John

