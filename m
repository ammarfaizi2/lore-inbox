Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSJ3PmJ>; Wed, 30 Oct 2002 10:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSJ3PmJ>; Wed, 30 Oct 2002 10:42:09 -0500
Received: from [217.167.51.129] ([217.167.51.129]:46808 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S264714AbSJ3PmH>;
	Wed, 30 Oct 2002 10:42:07 -0500
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp from eating disks
Date: Wed, 30 Oct 2002 16:48:36 +0100
Message-Id: <20021030154836.14201@192.168.4.1>
In-Reply-To: <1035991224.5141.70.camel@irongate.swansea.linux.org.uk>
References: <1035991224.5141.70.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why aren't those fields initialized explicitly in the static declaration
>> of idedisk_driver? And what are the do_idedisk_suspend/do_idedisk_resume
>> functions, that _are_ initialized explicitly?
>> 
>> I want to understand the madness, not add to it.
>
>The IDE devices are already beginning to use the pci suspend/resume
>callbacks so I would prefer that we have a very clear model of WTF is
>going on here.

The way it should be done is as follow (propagation of suspend/resume):

arch->pci_bus->...->pci_driver->ide_subdriver

The details as I see them (and that would match my needs on ppc) are
that the suspend request originates from the bus binding of the
controller, as any other device. (non PCI hosts will need specific
arch tweaks here or whatever parent bus they have in the news model
will deal with sending them the suspend call).

The driver (interface driver) is then acting like a bus. So it's
it's responsiblity to forward the request to it's sub-drivers
(typically ide-disk, ide-cd, whatever is attached to that
physical interface). Once the subdrivers are done, the interface
driver can proceed to shutting down the actual HW.

However, that leads to some problems regarding the existing bits
of code I see in there.

One of them is that the do_idedisk_suspend & friends don't take
the proper "level" parameter defined by the device model, which
makes it difficult to implement the various suspend/resume steps
as defined by the new driver model.

Another is that I feel (and I know Pavel doesn't agree here) that
the disk driver should also block further incoming requests (that
is leave them in the queue) instead of panic'ing. That is the
driver should not rely on not beeing fed any more request, but
rather make sure it will leave them in the queue and deal with
them when resumed.

I hope I'll finally find enough time to tackle porting of all
of the Pmac stuff to the new model, that will give me a chance
to implement our power management scheme based on the new
semantics and thus validate them (FYI, we've had fairly well
working power management on pmac for a couple of years now,
based on an arch specific mecanism & driver hooks, and I hope
I discussed enough with Patrick & Greg to make sure our experience
in this domain ended up in the design of the new model).

Ben.


