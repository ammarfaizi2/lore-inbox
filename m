Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUJQAMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUJQAMp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUJQAMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:12:45 -0400
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:46984 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S268966AbUJQAMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:12:34 -0400
Date: Sat, 16 Oct 2004 20:12:16 -0400
From: Jim Paris <jim@jtan.com>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PCI IRQ problems: "nobody cared!"
Message-ID: <20041017001216.GA29461@jim.sh>
References: <20041015083722.GA3315@jim.sh> <1097906133.14149.37.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097906133.14149.37.camel@d845pe>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

Thanks for the tips.  I tried your suggestions (a bit out of order).
Here are the results.

> Before doing anything else, please verify that you're running the latest
> BIOS for this box.

The BIOS and EC are both the latest version available.

> You might find that using "noirqdebug" gets you through the boot
> sequence and that after the drivers are loaded the system runs
> normally. This may be preferable to the irqpoll workaround.
> Of course both are workarounds and neither actually help us
> identify the root cause.

"noirqdebug" results in a freeze where it would previously have given
the "irq 9: nobody cared!" error.

> Note that PNPBIOS shouldn't run on an ACPI-enabled system -- probably no
> harm, but use a CONFIG_PNPBIOS=n kernel to verify there is no change in
> your ACPI enabled result.

That was on the Debian kernel.  On my own 2.6.8.1 build, I have
CONFIG_PNP=n, and the result (without irqpoll) is the same.
My full config:
  https://jim.sh/svn/jim/devl/toughbook/log/current.config

> The failure in the acpioff case is a clue I think.  Several devices
> get enabled on IRQ9 with no issues, but the system dies when yenta
> gets enabled, so perhaps the devices behind that bridge are at
> fault.

It doesn't seem specific to a particular device.

With my 2.6.8.1 and acpi=off, it dies when uhci_hcd is loaded, before yenta. 
  https://jim.sh/svn/jim/devl/toughbook/log/uhcidie.txt
(fyi, I've also added some ram since the last logs I posted)

In order to get Debian installed with their kernel, I needed to have
IDE working, as well as one of either wireless net, wired net, or usb.
I tried a ton of configurations, until I finally found that the only
thing that worked was using acpi=off, and then only loading modules
8139too for net, and generic for IDE.  If I used piix for IDE, it
would cause the same irq9 problem on load and break the other devices
(but the IDE would still work).

[ I should have mentioned and tested PIIX earlier.  See the end of
this mail for what I found out. ]

> It would be interesting to look at your
> BIOS setup to see if there are some parameters you can use to allow the
> BIOS to give us more freedom.
..
> As a start, go to your BIOS SETUP
> and disable all devices that it allows you to disable.

BIOS lets me enable or disable the following:
  serial ports, touch screen, parallel port,
  touch pad, LAN, modem, wireless LAN.
For the devices on the first line, I can also choose their port/IRQ
manually, but the BIOS (Phoenix) doesn't give me any more control than
that.  The motherboard has six DIP switches, but they are undocumented.

Setting all of them to "disable" doesn't change anything for acpi=on
or acpi=off.

> Also, it would be a good idea to identify the device at the root cause.
> Looks like you have a couple of NICs behind a cardbus bridge.
> If they are physically removable, then take them out.

I physically removed both the NIC/modem combo and the wireless card.
Both the acpi=on and acpi=off cases failed the same way as when the
cards are present:
  https://jim.sh/svn/jim/devl/toughbook/log/removed.txt
  https://jim.sh/svn/jim/devl/toughbook/log/removed-acpioff.txt

> If you supply the output from lspci -vv
> and acpidmp, then we can find out exactly
> what devices are attached to which interrupt link
> and that will probably tell us which device is being bad.

Sure.  With acpi and irqpoll:
  https://jim.sh/svn/jim/devl/toughbook/log/lspcivv.txt
  https://jim.sh/svn/jim/devl/toughbook/log/acpidmp.txt

> One thing that might help is if you try Bjorn's patch
> to delay enabling the PCI Interrupt Links until the
> actual drivers request that their interrupt be enabled:
> http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/remove-unconditional-pci-acpi-irq-routing.patch

First, 2.6.9-final has the same problems:
  https://jim.sh/svn/jim/devl/toughbook/log/269.txt

2.6.9-final-routeirq (with Bjorne's patches) breaks at IDE initialization:
  https://jim.sh/svn/jim/devl/toughbook/log/269bjorn.txt

But!  2.6.9-final-routeirq, _without_ CONFIG_BLK_DEV_PIIX (just
CONFIG_BLK_DEV_GENERIC), works!
  https://jim.sh/svn/jim/devl/toughbook/log/nopiix.txt

And 2.6.9-final-routeirq with neither ACPI nor PIIX also works:
  https://jim.sh/svn/jim/devl/toughbook/log/noacpi-nopiix.txt

For completeness, 2.6.9-final-routeirq with pci=routeirq and no PIIX breaks:
  https://jim.sh/svn/jim/devl/toughbook/log/routeirq-nopiix.txt

So it appears that the problem is very much related to the IDE
controller.  That's a little bit surprising, because IDE was the only
thing that consistently worked when everything else broke.

-jim
