Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbSLaB6F>; Mon, 30 Dec 2002 20:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbSLaB6F>; Mon, 30 Dec 2002 20:58:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40066
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267120AbSLaB6E>; Mon, 30 Dec 2002 20:58:04 -0500
Subject: Re: [PATCH] pnp & pci structure cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Jaroslav Kysela <perex@suse.cz>,
       Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20021231014729.GB28152@gtf.org>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz>
	<20021230221212.GE32324@kroah.com>
	<1041289960.13684.180.camel@irongate.swansea.linux.org.uk>
	<20021230225012.GA19633@gtf.org> <20021230225134.GD814@kroah.com>
	<20021230231436.GA20810@gtf.org>
	<1041299426.13956.191.camel@irongate.swansea.linux.org.uk> 
	<20021231014729.GB28152@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Dec 2002 02:47:01 +0000
Message-Id: <1041302821.13956.202.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-31 at 01:47, Jeff Garzik wrote:
> There will definitely be cases where people will want to black out
> existing entries too.
> Or would that open up to too much potential vendor abuse?  

I'm not sure. At the point this occurs the end user has either directly
chosen to replace a driver, or indirectly installed software they want
which does so. It probably should log that an alternative driver setup
has been configured so the user can figure out wtf is going on when
debugging weirdness.

Its providing the same facilities as rm /lib/modules/... at a finer
granularity - if I want to force e100 not eepro100 for a given card for
example.

> > I think it also means we need to be able to go pci table -> owner ?
> 
> I don't really see why.  If you wanted to be terribly correct have
> these things as refcounting kobjects or similar...  But really, with all
> those other wonderfully unlocked PCI lists in the core, why starting
> doing it The Right Way now?  ;-)

PCI list locking is easy to fix.

1. Take a list walking semaphore before scanning internally
2. Refcount up the pci device before calling the device inserted method
   Refcount down the pci device before calling the device removed method
3. Add pci_lock/unlock functions, and pci_get/put functions
4. Add pci_device_present(vendor, device). Swap the ab-users of pci_ 
   for this to it
5. Clean up drivers as we go along

Almost all the hotplug horrors are zapped at the point #1 and #2 are
done. Its also easy to assert the lock must be taken in pci_find_* when
debugging to squish the rest

Alan
--
It ain't over until the vax server pings..

