Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280779AbRKOI3k>; Thu, 15 Nov 2001 03:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280782AbRKOI3a>; Thu, 15 Nov 2001 03:29:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13 "EHLO vasquez.zip.com.au")
	by vger.kernel.org with ESMTP id <S280781AbRKOI3X>;
	Thu, 15 Nov 2001 03:29:23 -0500
Message-ID: <3BF37CA6.92CA12E7@zip.com.au>
Date: Thu, 15 Nov 2001 00:28:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] races in access to pci_devices
In-Reply-To: <Pine.GSO.4.21.0111142257510.1095-100000@weyl.math.psu.edu> <3BF37508.6EA78A85@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> I haven't looked at it in over a year, but from a quick look, all the
> list access look like they can be protected by a simple spinlock.

I don't think so?   We do things like calling driver probe methods
in the middle of a driver list walk.

An rwsem _may_ be suitable, but I'm not sure that we don't do
a nested walk in some circumstances, and AFAIK our rwsems
still are not safe for the same thread to do a down_read() twice.

Then there's the bus list, and the order of its lock wrt the device
list.

One approach would be to use a spinlock and a per-device refcount.
So something like:

	spin_lock(&pci_dev_lock);
        dev = pci_dev_g(pci_devices.next);
	while (dev != pci_dev_g(&pci_devices)) {
		struct pci_dev *next;

		pci_dev_get(dev);
		spin_unlock(&pci_dev_lock);
		diddle(dev);
		spin_lock(&pci_dev_lock);
		next = pci_dev_g(dev->global_list.next);
		pci_dev_put(dev);
		dev = next;
        }
	spin_unlock(&pci_dev_lock);

pci_dev_get(struct pci_dev *dev)
{
#ifdef CONFIG_SMP
	if (!spin_is_locked(&pci_dev_lock))
		BUG();
#endif
	dev->refcount++;
}

pci_dev_put(struct pci_dev *dev)
{
#ifdef CONFIG_SMP
	if (!spin_is_locked(&pci_dev_lock))
		BUG();
#endif
	dev->refcount--;
	if (dev->refcount == 0)
		kfree(dev);
}

I _think_ all this list traversal happens in process context now.
Not sure about the PCI hotplug driver though.

It's really sticky.  Which is why it isn't fixed :(

Sigh.  Maybe go for an rwsem in 2.5, backport when it stops
deadlocking?


-
