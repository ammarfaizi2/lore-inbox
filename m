Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbRFPVP7>; Sat, 16 Jun 2001 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264660AbRFPVPt>; Sat, 16 Jun 2001 17:15:49 -0400
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:4008 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264659AbRFPVPn>; Sat, 16 Jun 2001 17:15:43 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: pci_disable_device() vs. arch
Date: Sat, 16 Jun 2001 23:14:49 +0200
Message-Id: <20010616211449.2117@smtp.wanadoo.fr>
In-Reply-To: <3B2BC57F.408A9B18@mandrakesoft.com>
In-Reply-To: <3B2BC57F.408A9B18@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Its not clutter -- what you are doing is hiding pieces of the driver
>from the driver maintainer.  pcibios_enable_device should not be
>cluttered up with such mess, too.

Well... pcibios_enable_device() has to at least make sure the device
gets powered up as it's powered down after PCI probe. Except if we
end up calling pci_set_power_state() to power it up early in the
sungem driver.

>I point out that I recently fixed a bug where Via interrupts were being
>assigned incorrectly.  If I had not done a global grep for Via
>irq-related code, I would have missed the spot where the PPC code was
>doing a kludge for one of the four on-board Via devices, hardcoding the
>USB irq number to 11.

Hrm... interrupt routing on some PPC-based motherboard is quite a
mess, fortunately that's not the case on pmacs. The IRQ assignement
has to be part of the arch AFAIK, only the arch knows on which
interrupt line of the controller a given chip is wired and how
interrupt controllers are cascaded.

>Correct.  If your driver uses the API correctly, then when/if we want to
>mess around with hotplug resource assignment, we can un-assign resources
>as we like.  Since there aren't too many users of pci_disable_device so
>far, I want to make sure early adopters get it right.

Well... at least with sungem, there's no such risk as the entire bus
(up to the host bridge) where it lives is internal to the UniNorth
ASIC.

>Can you give a -specific- example of arch code that is -not- sungem
>related, but needs to occur when one powers-down a sungem MAC?
>
>If the PM code is related to sungem, it belongs in sungem.
>So far I don't see a need for arch-specific hooks anywhere...

Hrm... let me try again...

Powering down individual devices can be controlled by the PCI PM
capabilities, or in some cases (at least 2 cases here on UniNorth
based pmacs) by other bits in the host bridge.

What I suggest if for pci_bus to have an optional set_power_state
function that is called when a device on that bus calls
pci_set_power_state(). This function would then be able to implement
those cases where power control is possible, while not done
via PCI PM caps.

A pci_bus structure exist for both "root" busses and busses under
PCI<->PCI bridges, so effectively, there's a pci_bus structure per
bridge (beeing host or PCI<->PCI). I beleive it makes sense for
the bridge to have a way to handle the child power state. 

Ben


