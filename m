Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131997AbQLIQN0>; Sat, 9 Dec 2000 11:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbQLIQNQ>; Sat, 9 Dec 2000 11:13:16 -0500
Received: from front4.grolier.fr ([194.158.96.54]:55228 "EHLO
	front4.grolier.fr") by vger.kernel.org with ESMTP
	id <S131997AbQLIQNE> convert rfc822-to-8bit; Sat, 9 Dec 2000 11:13:04 -0500
Date: Sat, 9 Dec 2000 15:26:43 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: davej@suse.de, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <E144jVc-0005Lk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012091500230.1058-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Alan Cox wrote:

> > If/When x86 (or all?) architectures use this, will it make sense to
> > remove the PCI space cache line setting from drivers ?
> > Or is there borked hardware out there that require drivers to say
> > "This cacheline size must be xxx bytes, anything else will break" ?
> 
> If there is surely the driver can override it again before enabling the
> master bit or talking to the device ?

Configuring PCI cacheline size with a value that is a multiple of the
right value should not break. MWIs will still write whole cache lines and
MRL and MRM may prefetch more data but this should be harmless.

But, configuring a device for a value lower that the right value of the
cache line size will break if the hardware actually invalidate cache-lines
on MWI. Bridges that alias MWI to MW will obviously not be harmed by such
a misconfiguration.

As a result, in my opinion:

- A device that requires some non zero cache line size value lower than
the right value for a given system and that actually use MWIs must not be
supported on that system, unless we know that the bridge does alias MWI to
MW. (If such a device can be configured for not using MWI, any value for 
the PCI cache line size will not break).

- A driver that blindly shoe-horns some value for the cache-line size must
be fixed. Basically, it should not change the value if it is not zero and,
at least, warn user if it has changed the value because it was zero.

What are the strong reasons that let some POST softwares not fill properly
the cache line size of PCI devices ?

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
