Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVL3Ws3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVL3Ws3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVL3WsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:48:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:53960 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964929AbVL3Wrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:47:45 -0500
Date: Fri, 30 Dec 2005 00:12:18 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 11 of 20] ipath - core driver, part 4 of 4
Message-ID: <20051230081218.GB7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 04:31:30PM -0800, Bryan O'Sullivan wrote:
> Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>
> 
> diff -r c37b118ef806 -r e8af3873b0d9 drivers/infiniband/hw/ipath/ipath_driver.c
> --- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
> +++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:43 2005 -0800
> @@ -5408,3 +5408,1709 @@

Clever use of 4 patches to just add onto the same file.  This has grown
into a huge file, can't you split it up into smaller pieces?

> +int __init infinipath_init(void)
> +{
> +	int r = 0, i;
> +
> +	_IPATH_DBG(KERN_INFO DRIVER_LOAD_MSG "%s", ipath_core_version);
> +
> +	ipath_init_picotime();	/* init cycles -> pico conversion */
> +
> +	/*
> +	 * initialize the statusp to temporary storage so we can use it
> +	 * everywhere without first checking.  When we "really" assign it,
> +	 * we copy from _ipath_status
> +	 */
> +	for (i = 0; i < infinipath_max; i++)
> +		devdata[i].ipath_statusp = &devdata[i]._ipath_status;
> +
> +	/*
> +	 * init these early, in case we take an interrupt as soon as the irq
> +	 * is setup.  Saw a spinlock panic once that appeared to be due to that
> +	 * problem, when they were initted later on.
> +	 */
> +	spin_lock_init(&ipath_pioavail_lock);
> +	spin_lock_init(&ipath_sma_lock);
> +
> +	pci_register_driver(&infinipath_driver);
> +
> +	driver_create_file(&(infinipath_driver.driver), &driver_attr_version);
> +
> +	if ((r = register_chrdev(ipath_major, MODNAME, &ipath_fops)))
> +		_IPATH_ERROR("Unable to register %s device\n", MODNAME);

Why even save off the return value if you don't do anything with it?

And please don't put assignments in the middle of if statements, that's
just messy and harder to read (the fact that gcc made you put an extra
() should be a hint that you were doing something wrong...)

And does your driver work with udev?  I didn't see where you were
exporting the major:minor number of your devices to sysfs, but I might
have missed it.

> +	/*
> +	 * never return an error, since we could have stuff registered,
> +	 * resources used, etc., even if no hardware found.  This way we
> +	 * can clean up through unload.
> +	 */
> +	return 0;
> +}

Are you sure that's a good idea?  Please do the proper thing and tear
down your infrastructure if something fails, that's the correct thing to
do.  That way you can actually recover if something that you call in
this function fails (like driver_create_file(), or
pci_register_driver().) Functions don't return error values just so you
can ignore them :)

> +/*
> + * note: if for some reason the unload fails after this routine, and leaves
> + * the driver enterable by user code, we'll almost certainly crash and burn...
> + */

See, you admit that what you are doing isn't the wisest thing, which
should tell you something...

> +static void __exit infinipath_cleanup(void)
> +{
> +	int r, m, port;
> +
> +	driver_remove_file(&(infinipath_driver.driver), &driver_attr_version);
> +	if ((r = unregister_chrdev(ipath_major, MODNAME)))
> +		_IPATH_DBG("unregister of device failed: %d\n", r);
> +
> +
> +	/*
> +	 * turn off rcv, send, and interrupts for all ports, all drivers
> +	 * should also hard reset the chip here?
> +	 * free up port 0 (kernel) rcvhdr, egr bufs, and eventually tid bufs
> +	 * for all versions of the driver, if they were allocated
> +	 */
> +	for (m = 0; m < infinipath_max; m++) {
> +		uint64_t val;
> +		struct ipath_devdata *dd = &devdata[m];
> +		if (dd->ipath_kregbase) {
> +			/* in case unload fails, be consistent */
> +			dd->ipath_rcvctrl = 0U;
> +			ipath_kput_kreg(m, kr_rcvctrl, dd->ipath_rcvctrl);
> +
> +			/*
> +			 * gracefully stop all sends allowing any in
> +			 * progress to trickle out first.
> +			 */
> +			ipath_kput_kreg(m, kr_sendctrl, 0ULL);
> +			val = ipath_kget_kreg64(m, kr_scratch);	/* flush it */
> +			/*
> +			 * enough for anything that's going to trickle
> +			 * out to have actually done so.
> +			 */
> +			udelay(5);
> +
> +			/*
> +			 * abort any armed or launched PIO buffers that
> +			 * didn't go. (self clearing).	Will cause any
> +			 * packet currently being transmitted to go out
> +			 * with an EBP, and may also cause a short packet
> +			 * error on the receiver.
> +			 */
> +			ipath_kput_kreg(m, kr_sendctrl, INFINIPATH_S_ABORT);
> +
> +			/* mask interrupts, but not errors */
> +			ipath_kput_kreg(m, kr_intmask, 0ULL);
> +			ipath_shutdown_link(m);
> +
> +			/*
> +			 * clear all interrupts and errors.  Next time
> +			 * driver is loaded, we know that whatever is
> +			 * set happened while we were unloaded
> +			 */
> +			ipath_kput_kreg(m, kr_hwerrclear, -1LL);
> +			ipath_kput_kreg(m, kr_errorclear, -1LL);
> +			ipath_kput_kreg(m, kr_intclear, -1LL);
> +			if (dd->__ipath_pioavailregs_base) {
> +				kfree((void *)dd->__ipath_pioavailregs_base);
> +				dd->__ipath_pioavailregs_base = NULL;
> +				dd->ipath_pioavailregs_dma = NULL;
> +			}
> +
> +			if (dd->ipath_pageshadow) {
> +				struct page **tmpp = dd->ipath_pageshadow;
> +				int i, cnt = 0;
> +
> +				_IPATH_VDBG
> +				    ("Unlocking any expTID pages still locked\n");
> +				for (port = 0; port < dd->ipath_cfgports;
> +				     port++) {
> +					int port_tidbase =
> +					    port * dd->ipath_rcvtidcnt;
> +					int maxtid =
> +					    port_tidbase + dd->ipath_rcvtidcnt;
> +					for (i = port_tidbase; i < maxtid; i++) {
> +						if (tmpp[i]) {
> +							ipath_putpages(1,
> +								      &tmpp[i]);
> +							tmpp[i] = NULL;
> +							cnt++;
> +						}
> +					}
> +				}
> +				if (cnt) {
> +					ipath_stats.sps_pageunlocks += cnt;
> +					_IPATH_VDBG
> +					    ("There were still %u expTID entries locked\n",
> +					     cnt);
> +				}
> +				if (ipath_stats.sps_pagelocks
> +				    || ipath_stats.sps_pageunlocks)
> +					_IPATH_VDBG
> +					    ("%llu pages locked, %llu unlocked via ipath_m{un}lock\n",
> +					     ipath_stats.sps_pagelocks,
> +					     ipath_stats.sps_pageunlocks);
> +
> +				_IPATH_VDBG
> +				    ("Free shadow page tid array at %p\n",
> +				     dd->ipath_pageshadow);
> +				vfree(dd->ipath_pageshadow);
> +				dd->ipath_pageshadow = NULL;
> +			}
> +
> +			/*
> +			 * free any resources still in use (usually just
> +			 * kernel ports) at unload
> +			 */
> +			for (port = 0; port < dd->ipath_cfgports; port++)
> +				ipath_free_pddata(dd, port, 1);
> +			kfree(dd->ipath_pd);
> +			/*
> +			 * debuggability, in case some cleanup path
> +			 * tries to use it after this
> +			 */
> +			dd->ipath_pd = NULL;
> +		}
> +
> +		if (dd->pcidev) {
> +			if (dd->pcidev->irq) {
> +				_IPATH_VDBG("unit %u free_irq of irq %x\n", m,
> +					    dd->pcidev->irq);
> +				free_irq(dd->pcidev->irq, dd);
> +			} else
> +				_IPATH_DBG
> +				    ("irq is 0, not doing free_irq for unit %u\n",
> +				     m);
> +			dd->pcidev = NULL;
> +		}
> +		if (dd->pci_registered) {
> +			_IPATH_VDBG
> +			    ("Unregistering pci infrastructure unit %u\n", m);
> +			pci_unregister_driver(&infinipath_driver);

This is the call that should have cleaned up all of the memory and other
stuff that you do above.  If not, then your driver will not work in any
hotplug pci systems, which would not be a good thing.  Please do like
Roland says and put your resources and stuff in the device specific
structures, like the rest of the kernel drivers do.  You know, we do
things like this for a reason, not just because we like to be difficult
:)

> +			dd->pci_registered = 0;
> +		} else
> +			_IPATH_VDBG
> +			    ("unit %u: no pci unreg, wasn't registered\n", m);
> +		ipath_chip_cleanup(dd);	/* clean up any per-chip chip-specific stuff */
> +	}
> +	/*
> +	 * clean up any chip-specific stuff for now, only one type of chip
> +	 * for any given driver
> +	 */
> +	ipath_chip_done();
> +
> +	/* cleanup all our locked pages private data structures */
> +	ipath_upages_cleanup(NULL);
> +}
> +
> +/* This is a generic function here, so it can return device-specific
> + * info.  This allows keeping in sync with the version that supports
> + * multiple chip types.
> +*/
> +void ipath_get_boardname(const ipath_type t, char *name, size_t namelen)
> +{
> +	ipath_ht_get_boardname(t, name, namelen);
> +}

Why not just export ipath_ht_get_boardname instead?

> +module_init(infinipath_init);
> +module_exit(infinipath_cleanup);
> +
> +EXPORT_SYMBOL(infinipath_debug);
> +EXPORT_SYMBOL(ipath_get_boardname);

EXPORT_SYMBOL_GPL() ?
And put them next to the functions themselves, it's easier to notice
that way.

thanks,

greg k-h
