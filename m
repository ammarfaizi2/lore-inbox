Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269322AbRHGTEi>; Tue, 7 Aug 2001 15:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269312AbRHGTE0>; Tue, 7 Aug 2001 15:04:26 -0400
Received: from imladris.infradead.org ([194.205.184.45]:48132 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269313AbRHGTEJ>;
	Tue, 7 Aug 2001 15:04:09 -0400
Date: Tue, 7 Aug 2001 20:04:09 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <200108071049.MAA07138@sunrise.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0108071925040.27407-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre.

 >>>>>>  Q> alias eth0 ne
 >>>>>>  Q> options eth0 io=0x340
 >>>>>>  Q> alias eth1 ne
 >>>>>>  Q> options eth1 io=0x320
 >>>>>>  Q> alias eth2 ne
 >>>>>>  Q> options eth2 io=0x2c0
 >>>>>>  Q> alias eth3 ne2k-pci
 >>>>>>  Q> alias eth4 ne2k-pci
 >>>>>>  Q> alias eth5 tulip

 >>>> However, if the cards are controlled by different drivers, you
 >>>> can influence the order they are detected in by your choice of
 >>>> entries in modules.conf - in the example above, the ISA cards
 >>>> are always eth0, eth1 and eth2, the NE2k-pci cards are always
 >>>      ^^^^^^

 >>>> eth3 and eth4, and the tulip card is always eth5, simply because
 >>>> that's what the said file says.

 >>> Not always. You are wrong here, I'm afraid:

 >>> Lets assume that eth0-eth3 are not initialized at boot time and
 >>> your init scripts attempt to initialize eth4 ...

I gather that I misunderstood what you were saying above, so let me
clarify what I now understand by your comments:

 1. You are assuming a broken set of init scripts. Specifically,
    they load the individual modules manually by the name of the
    module, rather than stating that you wish to initialise a
    particular interface and letting kmod sort out the correct
    module.

    If this is your assumption, then you've created an artificial
    situation that by its very nature is broken and unreliable.

 2. Alternatively, you are saying that in your setup, the module
    referred to by the `alias eth0` line in modules.conf was not
    compiled as part of the kernel.

    If this is your claim, then you have created a deliberately
    broken setup.

 3. Alternatively, you are saying that in your setup, the module
    referred to by the `alias eth0` line in modules.conf is the
    wrong module for that particular interface.

    If this is your claim, then you have again produced a broken
    setup.

 4. Alternatively, in your setup, there are interfaces controlled
    by the same driver that are separated by interfaces controlled
    by one or more other drivers.

    If this is your claim, then you will get the scenario that you
    describe, but this is simply because they are separated, and
    is corrected by renumbering them so that all interfaces that
    are controlled by the same driver are contiguously numbered
    for all drivers.

As I see things, if you're referring to a situation covered by any of
the situations above, then my only interest is in advising you how to
correct the situation to get rid of the broken setup.

 >> Then I get an entry for eth4 in the `ifconfig` output, with NO
 >> entries for `eth0` through `eth3`, exactly as expected.

 > Did you ever try ?

Not with any of the broken scenarios described above, no.

 > I think no. I've got the problem a few times while
 > (re)configuring multi-ethernet machines.

 > ne2k-pci is the first module loaded...

If it is, then the setup falls into one of the scenarios above. The
CORRECT scenario (the only non-broken one) has ifconfig trying to
initialise the interfaces in the sequence eth0 - eth1 - ... - ethN
with kmod loading the appropriate driver for each one based on the
contents of the modules.conf file. ANY other scenario is broken by
design.

 > ...and it finds two interfaces. As there is no interfaces
 > registered at the moment, they are named eth0 and eth1 (sic!)

 > The interface names from modules.conf mean nothing here, they
 > are ignored.

Then the init scripts are broken as stated above.

 > I see tho ways to get the proper interface names:

 > 1. Force loading all modules in the appropriate sequence (ne before
 >    ne2k-pci) either manually or via pre-install command

 > 2. Renaming interfaces after they are initialized (yes,
 >    interface names can be changed, but it is ugly)

The first is not only the correct one, but also what just about every
system other than yours does by default.

 >> Note that the `ifconfig` command refers to the interfaces by
 >> name, and it's the settings in modules.conf that decide what
 >> type of interface that name refers to. That mapping can't be
 >> changed by any interface configuration or initialisation
 >> command, and the names used are those as given.

 > ifconfig does not assign interface names. The kernel driver
 > (module) does. And the driver has no option passed (even I thing
 > it is impossiblke to pass any) to define new interface naming
 > scheme.

Here's what is supposed to happen:

 1. ifconfig tries to initialise interface eth0.

 2. The kernel sees that interface eth0 doesn't exist as a module
    so asks the kmod driver to load it.

 3. The kmod driver refers to the modules.conf file to determine
    the true name for the eth0 interface. On my system, it sees
    the line `alias eth0 ne` telling it that eth0 is controlled by
    the module ne.

 4. The kmod driver checks whether the ne driver is loaded, and
    loads it if not.

 5. The kmod driver advises the kernel that the eth0 module has
    beel loaded at whatever address the ne driver was loaded at.

 6. The kernel then uses that module to refer to the eth0 driver.

Note that the kernel assigns interface names BASED ON WHAT IFCONFIG
DOES. If ifconfig tries to initialise eth1 before eth0 then the kernel
will get out of step with everything else, and correctly so. That's a
bug in the init scripts, not in the kernel.

 >>> To avoid such problems one probably should add a lot of
 >>> pre-install parameters in modules.conf.

 >> What problems?

 > Described above.

What KERNEL problems then? I don't see any yet.

Best wishes from Riley.

