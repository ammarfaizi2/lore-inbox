Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUJXNSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUJXNSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUJXNSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:18:31 -0400
Received: from verein.lst.de ([213.95.11.210]:6054 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261468AbUJXNO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:14:59 -0400
Date: Sun, 24 Oct 2004 15:14:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] parport: kill dead code and exports
Message-ID: <20041024131446.GA19658@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there's lots of exports in parport that aren't used by any drivers.
Behind many of them there's actually dead code.


--- 1.7/drivers/parport/daisy.c	2004-03-29 15:44:20 +02:00
+++ edited/drivers/parport/daisy.c	2004-10-23 14:52:26 +02:00
@@ -207,8 +207,7 @@
  *
  *	This function is similar to parport_register_device(), except
  *	that it locates a device by its number rather than by the port
- *	it is attached to.  See parport_find_device() and
- *	parport_find_class().
+ *	it is attached to.
  *
  *	All parameters except for @devnum are the same as for
  *	parport_register_device().  The return value is the same as
@@ -305,53 +304,6 @@
 	return res;
 }
 
-/**
- *	parport_device_coords - convert canonical device number
- *	@devnum: device number
- *	@parport: pointer to storage for parallel port number
- *	@mux: pointer to storage for multiplexor port number
- *	@daisy: pointer to storage for daisy chain address
- *
- *	This function converts a device number into its coordinates in
- *	terms of which parallel port in the system it is attached to,
- *	which multiplexor port it is attached to if there is a
- *	multiplexor on that port, and which daisy chain address it has
- *	if it is in a daisy chain.
- *
- *	The caller must allocate storage for @parport, @mux, and
- *	@daisy.
- *
- *	If there is no device with the specified device number, -ENXIO
- *	is returned.  Otherwise, the values pointed to by @parport,
- *	@mux, and @daisy are set to the coordinates of the device,
- *	with -1 for coordinates with no value.
- *
- *	This function is not actually very useful, but this interface
- *	was suggested by IEEE 1284.3.
- **/
-
-int parport_device_coords (int devnum, int *parport, int *mux, int *daisy)
-{
-	struct daisydev *dev;
-
-	spin_lock(&topology_lock);
-
-	dev = topology;
-	while (dev && dev->devnum != devnum)
-		dev = dev->next;
-
-	if (!dev) {
-		spin_unlock(&topology_lock);
-		return -ENXIO;
-	}
-
-	if (parport) *parport = dev->port->portnum;
-	if (mux) *mux = dev->port->muxport;
-	if (daisy) *daisy = dev->daisy;
-	spin_unlock(&topology_lock);
-	return 0;
-}
-
 /* Send a daisy-chain-style CPP command packet. */
 static int cpp_daisy (struct parport *port, int cmd)
 {
@@ -558,108 +510,3 @@
 	kfree (deviceid);
 	return detected;
 }
-
-/* Find a device with a particular manufacturer and model string,
-   starting from a given device number.  Like the PCI equivalent,
-   'from' itself is skipped. */
-
-/**
- *	parport_find_device - find a specific device
- *	@mfg: required manufacturer string
- *	@mdl: required model string
- *	@from: previous device number found in search, or %NULL for
- *	       new search
- *
- *	This walks through the list of parallel port devices looking
- *	for a device whose 'MFG' string matches @mfg and whose 'MDL'
- *	string matches @mdl in their IEEE 1284 Device ID.
- *
- *	When a device is found matching those requirements, its device
- *	number is returned; if there is no matching device, a negative
- *	value is returned.
- *
- *	A new search it initiated by passing %NULL as the @from
- *	argument.  If @from is not %NULL, the search continues from
- *	that device.
- **/
-
-int parport_find_device (const char *mfg, const char *mdl, int from)
-{
-	struct daisydev *d;
-	int res = -1;
-
-	/* Find where to start. */
-
-	spin_lock(&topology_lock);
-	d = topology; /* sorted by devnum */
-	while (d && d->devnum <= from)
-		d = d->next;
-
-	/* Search. */
-	while (d) {
-		struct parport_device_info *info;
-		info = &d->port->probe_info[1 + d->daisy];
-		if ((!mfg || !strcmp (mfg, info->mfr)) &&
-		    (!mdl || !strcmp (mdl, info->model)))
-			break;
-
-		d = d->next;
-	}
-
-	if (d)
-		res = d->devnum;
-
-	spin_unlock(&topology_lock);
-	return res;
-}
-
-/**
- *	parport_find_class - find a device in a specified class
- *	@cls: required class
- *	@from: previous device number found in search, or %NULL for
- *	       new search
- *
- *	This walks through the list of parallel port devices looking
- *	for a device whose 'CLS' string matches @cls in their IEEE
- *	1284 Device ID.
- *
- *	When a device is found matching those requirements, its device
- *	number is returned; if there is no matching device, a negative
- *	value is returned.
- *
- *	A new search it initiated by passing %NULL as the @from
- *	argument.  If @from is not %NULL, the search continues from
- *	that device.
- **/
-
-int parport_find_class (parport_device_class cls, int from)
-{
-	struct daisydev *d;
-	int res = -1;
-
-	spin_lock(&topology_lock);
-	d = topology; /* sorted by devnum */
-	/* Find where to start. */
-	while (d && d->devnum <= from)
-		d = d->next;
-
-	/* Search. */
-	while (d && d->port->probe_info[1 + d->daisy].class != cls)
-		d = d->next;
-
-	if (d)
-		res = d->devnum;
-
-	spin_unlock(&topology_lock);
-	return res;
-}
-
-EXPORT_SYMBOL(parport_open);
-EXPORT_SYMBOL(parport_close);
-EXPORT_SYMBOL(parport_device_num);
-EXPORT_SYMBOL(parport_device_coords);
-EXPORT_SYMBOL(parport_daisy_deselect_all);
-EXPORT_SYMBOL(parport_daisy_select);
-EXPORT_SYMBOL(parport_daisy_init);
-EXPORT_SYMBOL(parport_find_device);
-EXPORT_SYMBOL(parport_find_class);
===== drivers/parport/ieee1284.c 1.7 vs edited =====
--- 1.7/drivers/parport/ieee1284.c	2004-03-03 13:45:15 +01:00
+++ edited/drivers/parport/ieee1284.c	2004-10-23 14:52:54 +02:00
@@ -40,7 +40,7 @@
 
 /* Make parport_wait_peripheral wake up.
  * It will be useful to call this from an interrupt handler. */
-void parport_ieee1284_wakeup (struct parport *port)
+static void parport_ieee1284_wakeup (struct parport *port)
 {
 	up (&port->physport->ieee1284.irq);
 }
@@ -813,9 +813,7 @@
 EXPORT_SYMBOL(parport_negotiate);
 EXPORT_SYMBOL(parport_write);
 EXPORT_SYMBOL(parport_read);
-EXPORT_SYMBOL(parport_ieee1284_wakeup);
 EXPORT_SYMBOL(parport_wait_peripheral);
-EXPORT_SYMBOL(parport_poll_peripheral);
 EXPORT_SYMBOL(parport_wait_event);
 EXPORT_SYMBOL(parport_set_timeout);
 EXPORT_SYMBOL(parport_ieee1284_interrupt);
===== drivers/parport/probe.c 1.5 vs edited =====
--- 1.5/drivers/parport/probe.c	2004-03-03 13:45:15 +01:00
+++ edited/drivers/parport/probe.c	2004-10-23 14:48:21 +02:00
@@ -213,4 +213,3 @@
 	parport_close (dev);
 	return retval;
 }
-EXPORT_SYMBOL(parport_device_id);
===== drivers/parport/procfs.c 1.8 vs edited =====
--- 1.8/drivers/parport/procfs.c	2004-08-08 08:43:40 +02:00
+++ edited/drivers/parport/procfs.c	2004-10-23 14:49:10 +02:00
@@ -529,8 +529,5 @@
 }
 #endif
 
-EXPORT_SYMBOL(parport_device_proc_register);
-EXPORT_SYMBOL(parport_device_proc_unregister);
-
 module_init(parport_default_proc_register)
 module_exit(parport_default_proc_unregister)
===== drivers/parport/share.c 1.22 vs edited =====
--- 1.22/drivers/parport/share.c	2004-05-10 13:25:43 +02:00
+++ edited/drivers/parport/share.c	2004-10-23 14:51:21 +02:00
@@ -1007,7 +1007,6 @@
 EXPORT_SYMBOL(parport_unregister_driver);
 EXPORT_SYMBOL(parport_register_device);
 EXPORT_SYMBOL(parport_unregister_device);
-EXPORT_SYMBOL(parport_get_port);
 EXPORT_SYMBOL(parport_put_port);
 EXPORT_SYMBOL(parport_find_number);
 EXPORT_SYMBOL(parport_find_base);
===== drivers/scsi/initio.c 1.28 vs edited =====
