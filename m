Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRDGV6j>; Sat, 7 Apr 2001 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbRDGV63>; Sat, 7 Apr 2001 17:58:29 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30134 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131988AbRDGV6V>;
	Sat, 7 Apr 2001 17:58:21 -0400
Message-ID: <3ACF8D7C.608B48D2@mandrakesoft.com>
Date: Sat, 07 Apr 2001 17:58:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: reinelt@eunet.at, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <200104072134.OAA11307@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It only means that you should probably approach it as being a special
> "invisible PCI bridge", and basically have a specific driver for that
> chip that acts as a _bridge_ driver.
> 
> Writing a bridge driver is not that hard: your init routine will
> instantiate the devices behind the bridge (ie you would allocate two
> "struct pci_device" structures and you would add them to behind the
> "bridge", and you would make _those_ look like real serial and parallell
> devices.
> 
> See for example drivers/pcmcia/cardbus.c: cb_alloc() for how to create a
> new "pci_dev" (see the "for i = 0; i < fn ; i++)" loop: it creates the
> devices for each subfunction found behind the cardbus bridge.  It really
> boils down to "dev = kmalloc(); initialize_dev(dev); pci_insert_dev(dev,
> bus);").

Cool :)  Creative and interesting solution.

IMHO that's a slippery slope...  If you do this as a solution for
multifunction devices, you also have to consider even more stupid
hardware which exports one PCI function, but multiple BARs for different
purposes...

Another problem, which I have yet to think much about, is doing a
reverse mapping after what you just describe:  how does one figure out
that a bridge+devices is really a single hardware device?  Answering
that question is interesting for NICs as well, because 4-port NICs often
appear as four devices behind a bridge.  Some operations, such as
sharing an EEPROM across four ports, or setting a special flag if you
are quad-port hardware, require that knowledge.  [ugly hacks exist now
to get around our lack of such knowledge]

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
