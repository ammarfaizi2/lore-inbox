Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbRFPV3Q>; Sat, 16 Jun 2001 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264667AbRFPV3E>; Sat, 16 Jun 2001 17:29:04 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62937 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264666AbRFPV2z>;
	Sat, 16 Jun 2001 17:28:55 -0400
Message-ID: <3B2BCF79.9BCC40E0@mandrakesoft.com>
Date: Sat, 16 Jun 2001 17:28:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: pci_disable_device() vs. arch
In-Reply-To: <3B2BC57F.408A9B18@mandrakesoft.com> <20010616211449.2117@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> >
> >Its not clutter -- what you are doing is hiding pieces of the driver
> >from the driver maintainer.  pcibios_enable_device should not be
> >cluttered up with such mess, too.
> 
> Well... pcibios_enable_device() has to at least make sure the device
> gets powered up as it's powered down after PCI probe. Except if we
> end up calling pci_set_power_state() to power it up early in the
> sungem driver.

huh?  pci_enable_device calls pci_set_power_state.  sungem calls
pci_enable_device.

pcibios_enable_device shouldn't have to worry about power stuff.  If it
does, you need a pcibios_set_power_state, called from
pci_set_power_state, instead.


> >I point out that I recently fixed a bug where Via interrupts were being
> >assigned incorrectly.  If I had not done a global grep for Via
> >irq-related code, I would have missed the spot where the PPC code was
> >doing a kludge for one of the four on-board Via devices, hardcoding the
> >USB irq number to 11.
> 
> Hrm... interrupt routing on some PPC-based motherboard is quite a
> mess, fortunately that's not the case on pmacs. The IRQ assignement
> has to be part of the arch AFAIK, only the arch knows on which
> interrupt line of the controller a given chip is wired and how
> interrupt controllers are cascaded.

Via is an exception


> What I suggest if for pci_bus to have an optional set_power_state
> function that is called when a device on that bus calls
> pci_set_power_state(). This function would then be able to implement
> those cases where power control is possible, while not done
> via PCI PM caps.

> A pci_bus structure exist for both "root" busses and busses under
> PCI<->PCI bridges, so effectively, there's a pci_bus structure per
> bridge (beeing host or PCI<->PCI). I beleive it makes sense for
> the bridge to have a way to handle the child power state.

Ok, agreed.  There are always gonna be special case bridges, including
(for my interest) multi-port NICs whose interfaces are presented as PCI
devices downstream from a PCI-PCI bridge.  Controlling power for these
nics is sometimes done by messing around with the PM bits on the bridge,
not on the downstream devices.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
