Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbRENBr5>; Sun, 13 May 2001 21:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbRENBrr>; Sun, 13 May 2001 21:47:47 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:7834 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262065AbRENBrf>; Sun, 13 May 2001 21:47:35 -0400
Message-ID: <3AFF384B.7382B436@uow.edu.au>
Date: Mon, 14 May 2001 11:43:39 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: "David S. Miller" <davem@redhat.COM>, linux-kernel@vger.kernel.org
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
In-Reply-To: <15091.23655.488243.650394@pizda.ninka.net> from "David S. Miller" at May 5, 1 06:15:00 am <200105131819.WAA27939@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> BTW what did happen with Andrew's netdev registration patch?
> By some strange reason I believed it is already applied... Grrr.

Alan had it applied in his tree for a while.  It was a damn huge
patch though, and Jeff came up with a simpler version which is
now present in both 2.4 streams.

Jeff has introduced `alloc_etherdev()' which allocates storage
for a netdev but doesn't register it.  The one quirk with this
approach (and why it's vastly simpler than my thing) is that
the name of the interface is not known during probe, so the
drivers need to take care that the identifier which they emit
in their detection messages make sense.

Old code:

xxx_probe()
{
	dev = init_etherdev();
	< initialise stuff >
	printk("%s", dev->name);
	/*
	 * If we sleep here, we drop BKL and other tasks/CPUs
 	 * can open an unready device.  dev_probe_lock() plugs
	 * this for PCI/Cardbus devices only
	 */
	if (failed) {
		unregister_netdev(dev);
		return -EWHATEVER;
	}
	return 0;
}

New code:

xxx_probe(struct pci_dev *pdev, ...)
{
	dev = alloc_etherdev();
	<initialise stuff>
	/*
	 * Note that dev->name doesn't make sense at this time.
	 * So we use PCI locations.  Drivers which support
	 * EISA as well as PCI (eg 3c59x) will have a NULL
	 * pdev here and need to make something up.
	 */
	printk("%s", pdev->slot_name);
	/*
	 * If we sleep here, we're fine: the device isn't
	 * registered in the namespace yet
	 */
	...
	if (failed) {
		kfree(dev);
		return -EBUMMER;
	}
	return register_netdev(dev);
}

Not many drivers have been converted to the new interface yet.

The situation with old-style drivers which use net_device.init()
is a bit foggy.  ISTR that the init() method was inherently
immune to this race.  

-
