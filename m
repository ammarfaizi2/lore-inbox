Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWJPKzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWJPKzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJPKzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:55:39 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:48052 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751500AbWJPKzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:55:38 -0400
Date: Mon, 16 Oct 2006 12:56:13 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Greg K-H <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
Message-ID: <20061016125613.16c9f667@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <200610161113.31007.duncan.sands@math.u-psud.fr>
References: <20061016104411.1fb2bc57@gondolin.boeblingen.de.ibm.com>
	<200610161113.31007.duncan.sands@math.u-psud.fr>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 11:13:30 +0200,
Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> There may have been a similar problem with
> USB locking, since there too probe was expecting a lock to be held that might
> not be held when called from the kthread:
> 
> 	 * This function must be called with @dev->sem held.  When called for a
> 	 * USB interface, @dev->parent->sem must be held as well.
> 	 */
> 	int driver_probe_device(struct device_driver * drv, struct device * dev)

But as we don't know we're probing an usb interface, we have no chance
of ensuring that dev->parent->sem is taken in the multithreaded case
(meaning we couldn't do multithreaded probe for usb). (Any idea why the
parent's sem must be taken for usb interfaces?)

> Also, what about device removal racing with probe?  Is it possible for someone to
> attempt to remove a device in the gap between the call to device_attach and the
> kthread actually running and doing the probe?  That would result in remove and
> probe being called in the wrong order...

->probe won't be called if the device is already being removed, but
that still results in bus->remove being called without a prior ->probe
(but not drv->probe since dev->driver is not set at that time).
