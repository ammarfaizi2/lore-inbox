Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264025AbRFPXYj>; Sat, 16 Jun 2001 19:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264062AbRFPXY3>; Sat, 16 Jun 2001 19:24:29 -0400
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:41096 "EHLO
	bassia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264025AbRFPXYQ>; Sat, 16 Jun 2001 19:24:16 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: pci_disable_device() vs. arch
Date: Sun, 17 Jun 2001 01:23:58 +0200
Message-Id: <20010616232358.22354@smtp.wanadoo.fr>
In-Reply-To: <3B2BCF79.9BCC40E0@mandrakesoft.com>
In-Reply-To: <3B2BCF79.9BCC40E0@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>huh?  pci_enable_device calls pci_set_power_state.  sungem calls
>pci_enable_device.
>
>pcibios_enable_device shouldn't have to worry about power stuff.  If it
>does, you need a pcibios_set_power_state, called from
>pci_set_power_state, instead.

Right, having a hook in pci_set_power_state() handles it all. Now,
there need to be some thinking about how to actually implement it
(when to call pcibios_set_power_state inside pci_set_power_state
and what result should it returns).

I see several options:

 - Use it when the device has no PM capabilities
 - Call it first, and depending on the result code, do the normal
   PM or not, or eventually just fail.
 - Call it last/first depending if entering a low power state or
   exiting.

In my case, the device don't have PM caps, so I don't really care,
and it's the same for the other devices I have in mind that would
need it.

I still like the idea of implementing this as a function pointer
inside the pci_bus. In fact, the current implementation could be
done by filling this pointer with a default value, thus allowing
the arch to do any variation it may like by overriding this
pointer.

I keep having embedded in mind, where we have all sort of weird
designs (usually to save a few wires on a PLD) and flexibility is
fine when it doesn't add bloat. In this case, I beleive having
this notion of "pci_bus ops" for PM makes sense and is not bloat.

>Via is an exception

Yes, unless it's cascaded on a master interrupt controller. But
I agree the hard coding wasn't good, PPC is just so many different
boxes, they don't all have a nice device-tree or useable BIOS
residual datas :(

>Ok, agreed.  There are always gonna be special case bridges, including
>(for my interest) multi-port NICs whose interfaces are presented as PCI
>devices downstream from a PCI-PCI bridge.  Controlling power for these
>nics is sometimes done by messing around with the PM bits on the bridge,
>not on the downstream devices.

Ah, nice you see you agree ;)

Ben.


