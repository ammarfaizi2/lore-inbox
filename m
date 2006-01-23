Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWAWVHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWAWVHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWAWVHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:07:06 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:51161 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030187AbWAWVHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:07:05 -0500
Date: Mon, 23 Jan 2006 16:07:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: remove unneeded klist methods
In-Reply-To: <1137947405.4058.10.camel@mulgrave>
Message-ID: <Pine.LNX.4.44L0.0601231557160.4874-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006, James Bottomley wrote:

> Sorry ... forgot to mention that part ... the change from _del to
> _remove ties us up with a wait for the list to actually remove.  This is
> potentially dangerous because you're waiting on events you don't
> control.

I forgot to mention in my earlier reply...

If you don't do something like klist_remove, then you have a dangerous
race: removing a device while a driver is being added.  It's possible that
the driver_attach routine could iterate up to the device and then bind it
to the driver after the device had been unregistered.  The device 
structure would be deallocated when the iterator moved on, without ever 
getting unbound from the driver.

This problem could be avoided if driver_probe_device had some way to
recognize that the driver under consideration had been unregistered, but
right now there is no way for it to tell.  The driver_is_registered inline
routine merely tests the embedded klist_node to see if it is still on the
bus's klist -- which it would be, because removal from that klist is
precisely what you are trying to avoid waiting for.

Alan Stern

