Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSEZNld>; Sun, 26 May 2002 09:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316086AbSEZNlc>; Sun, 26 May 2002 09:41:32 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:49904 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316080AbSEZNlc>; Sun, 26 May 2002 09:41:32 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <acm1vp$2ak$1@penguin.transmeta.com> 
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 May 2002 14:41:30 +0100
Message-ID: <28429.1022420490@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
> > Is there a clean way to detect the "card ejected before anything
> > calls pci_dev->remove()" case?  I don't really like the idea of
> > wrapping code around every PCI register access to detect such cases.

> You don't have much choice with CardBus, I'm afraid.

You get an interrupt _before_ the card goes away, because the pins are of
different lengths. 

As long as your driver API has some kind of abort() call to tell it that the
device is no longer present, and you manage to call that within the few
milliseconds between the card detect pin contact breaking and the rest of
the pins breaking, you should be fine.

If you're sharing interrupts and have high interrupt latency, there may be a
problem -- perhaps it would be better if in that case you could ensure that
the socket IRQ handler gets run _before_ the device IRQ handler. 

>  Also, it's generally a good idea to "just say no" to endless loops in
> drivers. Hardware bugs _do_ happen, and it's a lot more pleasant to
> have the driver do a
> 	printk("Device does not respond\n");
> than for the kernel to hang.

Too late. On some hardware, if you try to talk to the device once it's 
gone, you're already dead. Not all the world is a PeeCee.

--
dwmw2


