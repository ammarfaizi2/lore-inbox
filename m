Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSLWPSl>; Mon, 23 Dec 2002 10:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSLWPSl>; Mon, 23 Dec 2002 10:18:41 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:13316 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266520AbSLWPSk>; Mon, 23 Dec 2002 10:18:40 -0500
Date: Mon, 23 Dec 2002 18:26:24 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021223182624.A728@jurassic.park.msu.ru>
References: <m17ke3m3gl.fsf@frodo.biederman.org> <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com> <15877.26255.524564.576439@argo.ozlabs.ibm.com> <1040569382.1966.11.camel@zion> <20021222222106.B30070@localhost.park.msu.ru> <15878.22747.913279.67149@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15878.22747.913279.67149@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Dec 23, 2002 at 11:29:15AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 11:29:15AM +1100, Paul Mackerras wrote:
> We could relocate the ASIC if we could find the ioremaps and fix them
> up, or if we could get to all the drivers and have them re-do their
> ioremaps.  There is no way to do that at the moment, though.
> Typically the ASIC will have a couple of IDE interfaces, audio,
> serial, i2c, interrupt controller, wireless ethernet, timer, and PMU
> (power management unit) interfaces in it, so there are several drivers
> involved.

I see, thanks. I always had an impression that pci_init is called
way too late in the boot sequence, at least on the PCI-centric systems.
This makes all that PCI surgery really painful. Ideally, the init
order should be defined per architecture. This applies to the
generic device model as well: currently we have legacy, isa-pnp
and other stuff initialized and probed *before* PCI, though typically
these are hanging of the PCI bus. And it's a real problem on machines
with multiple PCI buses. Oh, well...

> In fact we don't really need to probe the BARs of the ASIC at all,
> because the device tree that we get from Open Firmware tells us the
> size and location of the resources it is using (along with all the
> other PCI devices in the system).  If we could have a
> platform-specific hook so that we could provide an alternative method
> for probing the BARs of certain PCI devices, that would let us avoid
> the whole problem.

It can be trivially done using Linus' idea of probing in 2 phases.
The pass 1 can be made 100% non-destructive: we can initialize
device structures, read in device/vendor IDs, class codes and
build the bus trees. Basically, everything that we do currently
minus pci_read_bases(), so the resource fields are blank. Then we
can call arch- and device-specific routines, where along with other
fixups the device BARs could be probed in arch-specific way and written
down in the pci_dev structure.
In the pass 2 (generic BAR probing), we can check the resource flags
for non-zero value and skip the probe of respective BAR.
This would make the code a LOT more flexible.

Ivan.
