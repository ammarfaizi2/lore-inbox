Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265214AbRF0CnB>; Tue, 26 Jun 2001 22:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265218AbRF0Cmv>; Tue, 26 Jun 2001 22:42:51 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:51212 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S265214AbRF0Cmk>; Tue, 26 Jun 2001 22:42:40 -0400
Date: Tue, 26 Jun 2001 22:42:37 -0400 (EDT)
From: David T Eger <eger@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
cc: eger@cc.gatech.edu
Subject: PCI Power Management / Interrupt Context
Message-ID: <Pine.SOL.4.21.0106262208240.3824-100000@oscar.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So I'm writing some code for a PCI card that is a framebuffer device, and
happily filling in the functions for the probe() and remove() functions
when I read documentation (Documentation/pci.txt) which mentions that
remove() can be called from interrupt context.

Now in order to properly tear down some things in the system, there are
some standard unregister() interfaces.  For instance,
unregister_framebuffer() and unregister_netdev().  After which, drivers
believe all is safe and go on about releasing ioremap()'d regions and
such.

One of the first things that unregister_netdev() does is to down() the
rtnl semaphore.  *cough* *cough*  This is a blocking operation, I believe,
which, umm - you can't do that from an interrupt, correct?

Reading code in my sister frame buffer devices, I see that
unregister_framebuffer() can fail.  I can easily see a nice happy console
or user app diddling away on the framebuffer writing to the memory on the
device, and then poof! someone yanks the card, processor takes an
interrupt, and then... and then?  what to do? 

In fact, here's an interesting snippet from cyber2000fb.c:

static void __devexit cyberpro_remove(struct pci_dev *dev)
{
	struct cfb_info *cfb = (struct cfb_info *)dev->driver_data;

	if (cfb) {
	/*
	* If unregister_framebuffer fails, then
	* we will be leaving hooks that could cause
	* oopsen laying around.
	*/
	if (unregister_framebuffer(&cfb->fb))
		printk(KERN_WARNING "%s: danger Will Robinson, "
			"danger danger!  Oopsen imminent!\n",
	cfb->fb.fix.id);
	cyberpro_unmap_smem(cfb);
	cyberpro_unmap_mmio(cfb);
	cyberpro_free_fb_info(cfb);

	/*
	* Ensure that the driver data is no longer
	* valid.
	*/
	dev->driver_data = NULL;
	if (cfb == int_cfb_info)
	int_cfb_info = NULL;
	}
}

So, umm, is there a consensus on what to do if someone currently expects
to be writing to memory that doesn't exist any more?  Leave the mappings
there?  Take them out and laugh as our users' machine suddenly oopses to a
halt? Pray? Laugh? Cry?
					
-David Thomas Eger (eger@cc.gatech.edu)


