Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUAGDm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 22:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUAGDm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 22:42:29 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:56974 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266129AbUAGDmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 22:42:24 -0500
Date: Tue, 6 Jan 2004 22:29:59 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@colin2.muc.de>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040106222959.GA3188@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@colin2.muc.de>,
	Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	"Grover, Andrew" <andrew.grover@intel.com>
References: <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401060744240.2653@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 07:48:37AM -0800, Linus Torvalds wrote:
>
>
> On Tue, 6 Jan 2004, Andi Kleen wrote:
> >
> > Anyways, I already implemented reservation for the aperture for the K8
> > driver some time ago. And it's in your tree. But it doesn't help for
> > finding IO holes because there could be other unmarked hardware lurking
> > there ... Or worse there is just no free space below 4GB.
>
> The "unmarked hardware" is why we have PCI quirks. Look at
> drivers/pci/quirks.c, and notice how many of the quirks are all about
> quirk_io_region().  Exactly because there isn't any way for the BIOS to
> tell us about these things on the IO side.
>
> (Actually, there is: PnP-BIOS calls are supposed to give us that
> information. However, not only are the BIOSes buggy and don't give a
> complete list _anyway_, anybody who uses the PnP-BIOS is much more likely
> to just get a kernel oops when the BIOS is buggy and assumes that only
> Windows will call it. So I strongly suggest you not _ever_ use pnp unless
> you absolutely have to).

For those with legacy systems, the isapnp protocol, a component of pnp, is
unaffected by this problem.  Most systems that support ISA addin cards,
have correctly implemented PnPBIOSes.

>
> The same quirks could be done on the MMIO side for northbridges.
>
> 			Linus

For the past few weeks I've been doing research on the PnPBIOS general
protection faults, and I've come up with a few observations and a proposed
solution.  Any comments would be appreciated.

1.) There probably isn't anything wrong with the way we're calling the PnPBIOS.

After searching through various mailing lists I discovered that several other
open source operating systems, although having many variations on the PnPBIOS
code, are having identical problems (including that the same type of calls
trigger the faults).  A while back I added a change that was similar to some
of apm's buggy bios handling code.  It appears to fix the problems with getting
dynamic resource information on many buggy systems.  I later decided (see
pnp-fix-1 in -mm) to get static resource information (the resources set at boot
time) because the specifications suggest using that call when enumerating
devices for the first time.  To my surprise, many have reported problems with
the PnPBIOS driver found in -mm.  In addition, there are some, but
significantly fewer, BIOSes that are completely broken and don't work with
either call type.

The recent escd fix I have made corrects a thinko in the PnPBIOS code and it
turns out that faults from calling /proc/pnp/bus/escd were probably not caused
by BIOS bugs.  I've attached this fix to the end of the email.  This leaves
only the get node calls.

2.) Windows works with buggy BIOSes because of the way it calls them.

I looked into how Windows handles the PnPBIOS and may have discovered why it
works on buggy BIOS.  It turns out that exclusively realmode calls are used.
See www.missl.cs.umd.edu/Projects/sebos/winint/index2.html#pnpbios.  My
knowledge is limited in this area of the x86 architecture but it is my
impression that it would not be possible, or perhaps worth it, to implement
realmode calls for the Linux PnPBIOS driver because of the time it is
initialized.

3.) BIOS bugs appear to affect mostly laptops.

The Oops seems to generally occur when getting information about the mouse
controller.  Because of touchpads and external mouses, the BIOS code may be
a little different from desktop systems.  Nonetheless my laptop, as well as
all my other test systems, do not have any PnPBIOS problems.

4.) PnPBIOS support may not be fully implemented on a few rare systems with
ACPI.

The PnPBIOS standard has been obsoleted by ACPI.  Only in systems made before
ACPI or systems with blacklisted ACPI support (there are many), is the PnPBIOS
necessary.  Unfortunantly resource management in the Linux ACPI driver isn't
fully supported relative to resource management in the Linux PnPBIOS driver.
It is concievable that some PnPBIOSes only implement a minimal set of calls
properly.


A proposed solution...

For 2.6...

1.) only get dynamic resource information
2.) blacklist any BIOSes that fail on dynamic resource calls.  We might get
lucky and there will be few enough that it is possible to create a blacklist.
Also look into them to see if they work with static instead.
3.) attach a warning, by printk and/or kconfig help, to the /proc/bus/pnp
interface as it is able to make any PnPBIOS call. (done in -mm)
4.) As a last resort disable PnPBIOS support if ACPI is successful.  Although
the two can currently coexist, this would prevent the buggy BIOSes found in
more modern x86 systems from being used.  Of course this would be useless if
the user decides to not include the ACPI driver.
5.) Look into other ways of finding out if the PnPBIOS might be buggy,
currently we only have DMI.

Any others?

For the next development kernel...

I am working on a new resource management infustructure, tied more closely to
the driver model and sysfs, and some ACPI patches.  They should make it easier
for us to take advantage of ACPI resource management.  Although one of my
biggest focuses is ACPI, I'd like to maintain compatibility with older
protocols such as PnPBIOS.  Also it is a major goal to make it usable for all
architectures (like the existing resource management code), but perhaps even
for Open Firmware when it is further implemented.

>From there we can phase out PnPBIOS support where ACPI provides an alternative.

It's worth noting that PnPBIOS support is useful on the majority of systems that
support it.  In later kernels it can serve as an alternative when ACPI is buggy
or unsupported.

Thanks,
Adam



--- a/drivers/pnp/pnpbios/bioscalls.c	2003-11-26 20:44:47.000000000 +0000
+++ b/drivers/pnp/pnpbios/bioscalls.c	2003-12-02 21:17:42.000000000 +0000
@@ -493,7 +493,7 @@
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, (void *)nvram_base, 65536);
+			       data, 65536, __va((void *)nvram_base), 65536);
 	return status;
 }

@@ -516,7 +516,7 @@
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, nvram_base, 65536);
+			       data, 65536, __va((void *)nvram_base), 65536);
 	return status;
 }
 #endif
