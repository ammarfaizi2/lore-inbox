Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135669AbRDSNou>; Thu, 19 Apr 2001 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135670AbRDSNok>; Thu, 19 Apr 2001 09:44:40 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:21495 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S135669AbRDSNob>; Thu, 19 Apr 2001 09:44:31 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-pm-devel@lists.sourceforge.net>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI power management
Date: Thu, 19 Apr 2001 15:43:33 +0200
Message-Id: <20010419134333.31606@mailhost.mipsys.com>
In-Reply-To: <E14qEYX-0007Cl-00@the-village.bc.nu>
In-Reply-To: <E14qEYX-0007Cl-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>null = 'do absolutely nothing'
>generic = 'do D3 as per the specification'
>
>The idea being the PM layer would go around calling
>
>	dev->power_off(dev);
>
>as a default notifier for PCI devices.

Ok, I see. I didn't understand that the functions you were talking about
would be defaults to put directly in the pci_dev structure.

>And in the case of the cards like that you would need a custom mask. So you'd
>do
>	pci_set_power_handler(dev, atyfb_power_on, atyfb_power_off)
>
>to get a custom function. For most authors however they can call the power
>handler setup just using prerolled functions that do the right thing and know
>about any architecture horrors they dont.

Right. However, rare are the drivers that don't need at least to know
that a power management sequence is going on. All bus mastering drivers,
at least, must stop bus mastering (and clearing the bit in the command
register is not enough on a bunch of them). Most drivers have to cleanly
stop ongoing operations, refuse (or block) requests while the driver is
sleeping, etc... and finally configure things back once waking up. I
don't see much cases where a simple "default" function would work. 

My current scheme on powerbook don't do half of that... it still sorta
works since I manage to stop all scheduling and shut things down in the
proper order, but it's neither a clean nor a safe way to do things.

>I'd rather
>
>	pci_dev->powerstate
>
>or similar as a set of flags in the device.

Ok, agree with that one.

I sill consider, however, that the current suspend/resume callbacks in
the pci_dev structure are not the best way to do things. I would have
really prefered that each pci_dev embed a pm notifier structure. In some
cases, we want to pass more than simple suspend/resume messages (suspend
request, suspend now, suspend cancel, and resume are the 4 messages I use
on powerbooks). 

Also, this can be generalized to other type of drivers (USB, IEEE1394,
..), eventually passing bus-specific messages

Ben.



