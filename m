Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSFOUCX>; Sat, 15 Jun 2002 16:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSFOUCW>; Sat, 15 Jun 2002 16:02:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35853 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315503AbSFOUCU>;
	Sat, 15 Jun 2002 16:02:20 -0400
Message-ID: <3D0B9C6B.8050601@mandrakesoft.com>
Date: Sat, 15 Jun 2002 15:58:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206151411410.7247-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> I still think it's probably a good idea to replace pci_enable_device()
> by a more fine-grained API, which allows a driver author to specify 
> which exact resources he needs.

To repeat, pci_enable_device is not _just_ resource assignment.

It also provides:
1) power state management (wakes up the device)
2) an entry point which guarantees the bus layer that the driver is not 
interested in the hardware at all before that point.  Or IOW, 
pci_enable_device is a bus layer hook for whatever "device 
wakeup/appearing" needs that bus has.  Sure, we are talking about moving 
some of that functionality to other functions (pci_request_<foo>), but 
that doesn't mean we should ditch the hook altogether.

Remember, we have a matching pair here:  pci_enable_device, 
pci_disable_device.  Update the code that goes on between those two 
calls, sure.  But leave the calls there.


> So a complete API would be
> 
> 	pci_request_{irq,io,mmio}
> 	pci_release_{irq,io,mmio}
> 	pci_enable_{irq,io,mmio}
> 	pci_assign_{irq,io,mmio}
> 
> but normally a driver would just use pci_request/release_*() + maybe
> pci_assign_irq(), which will take care of the appropriate assign/enable
> internally.


That seems like a decent enough API, pending a bit of driver conversion 
to see how well it works out in practice.  So I'm ok with it (with the 
pci_enable_device proviso, above)

	Jeff



