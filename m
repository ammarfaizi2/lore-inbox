Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316764AbSFDUyc>; Tue, 4 Jun 2002 16:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316783AbSFDUyb>; Tue, 4 Jun 2002 16:54:31 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:48348 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316764AbSFDUyb>; Tue, 4 Jun 2002 16:54:31 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Date: Tue, 4 Jun 2002 20:26:14 +0200
Message-Id: <20020604182614.4451@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0206041128020.654-100000@geena.pdx.osdl.net>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm not going to try and force you to use a device_initcall. But, it 
>appears that it will work, and it fits the nomenclature. 

Well, one problem I have with PCI probing beeing done that late
on PPC is that I need pcibios_init() to setup a few things, like
conversion tables between bus numbers, that has to be done before
devices are inited, and that need the bus to be probed as the
bus numbers can be reassigned at that point.

There are also other issues related to some of the "combo" ASICs
we have on pmac (and maybe other embedded platforms). Those aren't
currently probed using the PCI probe code, but rather (on pmac
at least), using the firmware device-tree so we can probe for
individual cells in these ASICs regardless of the actual PCI
device embedding the cells we care about.

However, this leads to a few issues: If we request resources for
these cells, the PCI bus must have been probed first or the resources
won't be properly be assigned as child of the correct ASIC pci_dev.
Also, some cells need to get to the pci_dev of their parent ASIC for
other reasons, and that also require the pci bus to have been probed
before those devices are inited.

Finally, add to that mix that some of the devices in those ASICs
are critical for the kernel early (like the PIC, timers used for
calibration or power management unit), so they must be probed
early. pffff...

So currently, device_initcall may work for pcibios_init on PPC
only because Makefile magic will cause arch/ppc/* stuff to be
called before other drivers. But that's not something I like ;)

I have plans to convert most of these drivers to something saner
for 2.5 around your new device model, probably some kind of
macio_device shell (for a device within a mac-io ASIC), the ASIC
itself acting like a PCI<->mac-io bridge.
I'll have to keep a few special cases for things like the PIC, but
there's nothing much we can do about that.

That's among the things we need to discuss at Ottawa ;)

Ben.

