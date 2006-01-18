Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWARVyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWARVyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWARVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:54:07 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42374 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161023AbWARVyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:54:05 -0500
Date: Wed, 18 Jan 2006 16:54:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] ehci calling put_device from irq handler
In-Reply-To: <20060118212901.GA8923@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0601181648010.4974-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Greg KH wrote:

> We can not call put_device() from irq context :(
> 
> I added a "might_sleep()" to the driver core and get the following from
> the ehci driver.  Any thoughts?

In principle the put_device and corresponding get_device calls aren't
needed.  We don't release a usb_device structure until after disabling all
its endpoints, and disabling an endpoint will wait until all the URBs for
that endpoint have completed.  So there's no reason to keep a reference to
the device structure for each URB.

I see that uhci-hcd is guilty of the same thing (reference acquired for 
each QH, released while holding a spinlock).  Probably each of the 
host controller drivers is.

Alan Stern

