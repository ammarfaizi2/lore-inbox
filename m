Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262173AbTCHTuv>; Sat, 8 Mar 2003 14:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262174AbTCHTuv>; Sat, 8 Mar 2003 14:50:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35598 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262173AbTCHTuu>;
	Sat, 8 Mar 2003 14:50:50 -0500
Date: Sat, 8 Mar 2003 11:51:18 -0800
From: Greg KH <greg@kroah.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030308195117.GE26374@kroah.com>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308191237.GA26374@kroah.com> <20030308194714.GA7340@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308194714.GA7340@vana.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 08:47:14PM +0100, Petr Vandrovec wrote:
> On Sat, Mar 08, 2003 at 11:12:37AM -0800, Greg KH wrote:
> > On Sat, Mar 08, 2003 at 10:47:49AM +0000, Russell King wrote:
> > > Hi,
> > > 
> > > What prevents the following scenario from happening?  It's purely
> > > theoretical - I haven't seen this occuring.
> > > 
> > > - Load PCI driver.
> > > 
> > > - PCI driver registers using pci_module_init(), and adds itself to sysfs.
> > > 
> > > - Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
> > >   driver, and calls the PCI drivers probe function.
> > 
> > Ugh, yes you are correct, I can't believe I missed this before.
> > 
> > How does this patch look?
> 
> Bad...
> 
> What are you trying to solve?

The case where while probe() is called, the module is unloaded.
Same thing for remove().

That's all.

> After driver calls pci_unregister_driver,
> it is sure that there are no other users of this pci driver.

Sure, but that's not the case of what we are protecting here.  We want
pci_unregister_driver() (which is usually called from the module_exit()
function), to not be called if we are in the middle of calling either
probe() or release().

Do you have a way of protecting the race that is described by Russell
here that differs from my patch?

thanks,

greg k-h
