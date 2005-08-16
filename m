Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVHPDd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVHPDd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVHPDd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:33:58 -0400
Received: from kent.litech.org ([72.9.242.215]:22536 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S965087AbVHPDd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:33:57 -0400
Date: Mon, 15 Aug 2005 23:33:53 -0400
From: Nathan Lutchansky <lutchann@litech.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/5] add i2c_probe_device and i2c_remove_device
Message-ID: <20050816033353.GI24959@litech.org>
References: <20050815175106.GA24959@litech.org> <20050815175438.GE24959@litech.org> <20050816001413.50b9c6be.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816001413.50b9c6be.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 12:14:13AM +0200, Jean Delvare wrote:
> > These functions can be used for special-purpose adapters, such as
> > those on TV tuner cards, where we generally know in advance what
> > devices are attached.  This is important in cases where the adapter
> > does not support probing or when probing is potentially dangerous to
> > the connected devices.
> 
> Do you know of any adapter actually not supporting the SMBus Quick
> command (which we use for probing)?

I do, in fact, which is the reason I submitted these patches in the
first place.  :-)

The WIS GO7007, which is the MPEG1/2/4 video encoder used in the Plextor
ConvertX, has an on-board i2c interface that supports nothing but 8-bit
and 16-bit register reads and writes.  Worse, it does not correctly
report i2c errors.  Even if it did support probing, though, I wouldn't
want to use it because the i2c adapter generally lives on the other end
of a USB and requires a minimum of 15 USB round trips per i2c
transaction, so probing 124 i2c addresses would take a while.

> > +	if (kind < 0 && !i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
> > +		return -EINVAL;
> 
> Coding style please: one space after the comma. 
> 
> > +
> > +	down(&core_lists);
> > +	list_for_each(item,&drivers) {
> 
> Ditto.

Yeah, I copied those lines from other parts of i2c-core.c.  But I'll fix
them.

> > +		driver = list_entry(item, struct i2c_driver, list);
> > +		if (driver->id == driver_id)
> > +			break;
> > +	}
> > +	up(&core_lists);
> > +	if (!item)
> > +		return -ENOENT;
> > +
> > +	/* Already in use? */
> > +	if (i2c_check_addr(adapter, addr))
> > +		return -EBUSY;
> > +
> > +	/* Make sure there is something at this address, unless forced */
> > +	if (kind < 0) {
> > +		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> > +				   I2C_SMBUS_QUICK, NULL) < 0)
> > +			return -ENODEV;
> > +
> > +		/* prevent 24RF08 corruption */
> > +		if ((addr & ~0x0f) == 0x50)
> > +			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
> > +				       I2C_SMBUS_QUICK, NULL);
> > +	}
> > +
> > +	return driver->detect_client(adapter, addr, kind);
> > +}
> 
> You are duplicating a part of i2c_probe_address() here. Why don't you
> simply call it?

I could, I guess.  Is there a reason i2c_probe_address is limited to
7-bit addresses?  Clients with 10-bit addresses (I've never seen one,
but I guess they exist?) should be able to be instantiated though the
known-device list.

I think the way to go about this would be to rework and resubmit the
first 3 patches once we decide how to handle the no-probe adapter flag,
and later I will send a separate patch set for review with the
known-device list implementation.

Thank you for all your help!  -Nathan
