Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTFKQsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFKQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:48:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263205AbTFKQsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:48:04 -0400
Date: Wed, 11 Jun 2003 10:03:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Matthew Wilcox <willy@debian.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: pci_domain_nr vs. /sys/devices
In-Reply-To: <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0306110949280.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >   /sys/devices/pci-domainN/pciN/*
> > 
> > So we can pave the way for when we'll stop play bus number tricks and
> > actually have overlapping PCI bus numbers between domains. (I don't plan
> > to do that immediately because that would break userland & /proc/bus/pci
> > backward compatiblity)
> > 
> > What do you think ?
> 
> I don't think sysfs works like that (please correct me if I've
> misunderstood, mochel..)

We can do that, in two different ways. As PCI domains are discovered, 
devices or kobjects can be registered that represent their existence. 
Depending on what their parent is, they can be added anywhere into the 
hierarchy. 

It might be good to do this anyway, since it will give us the ability to 
keep a list of all PCI domains in the system, assuming that's desired. :)

> Look in /sys/bus/pci/devices/  There you have all the PCI devices
> lumped together in one place, and we obviously need the domain number
> in the name.  I don't know where the 0 on the end of /sys/devices/pci0/
> comes from, but if we could, I wouldn't say no to:
> 
> /sys/devices/pciDDDD/DDDD:BB:SS.F
> or
> /sys/devices/pciDDDD:BB/DDDD:BB:SS.F
> (Domain,Bus,Slot,Func)


We could do that (as well as what is described above). However, it's 
important to note that this exposes a limitation of the driver model. We 
have a flat name space in /sys/bus/<bus>/devices/, which is very handy, 
and nearly free, since each bus maintains a list of all devices anyway. 
However, since it's a flat listing, the names must be unique across all 
instances of that bus. 

Fine, but the names are currently taken directly from dev->bus_id, meaning 
that the local directories for the devices must also be unique across the 
entire bus namespace. This is certainly not true, and something that Linus 
has complained about before. The names in the local directories only need 
to be unique in the local namespace. 

Unfortunately, the symlinks are created in the core, and the core doesn't
know about bus/device organization. A possilbe solution would be to 
represent bus instances in the core, and have the symlink names created 
from a concatenation of the bus name (e.g. DD:BB) and the local device ID 
(SS.F). This would reduce pressure on bus_id size, and make things easier 
to read..


	-pat

