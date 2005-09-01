Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVIASJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVIASJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVIASJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:09:23 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:64672 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030275AbVIASJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:09:23 -0400
Date: Thu, 1 Sep 2005 14:09:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>
cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Whither klists?
Message-ID: <Pine.LNX.4.44L0.0509011351400.5533-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick and Greg:

To put it baldly: Should klists be replaced with regular lists, each 
protected by an rwsem (or even a mutex)?

The advantage of klists is that threads can remove or add nodes while 
other threads iterate through the list.  With an rwsem, only one thread 
would be able to add or remove a node at a time, and only when no other 
thread was using the list.  Considering that klists are currently used 
to hold:

	the set of all devices on a bus,

	the set of all drivers for a bus, and

	the set of all children of a device,

	(not counting the set of all devices bound to a driver, since
	there's already a patch to replace that with a mutex-protected
	regular list)

this limitation on adding or removing doesn't seem significant.  There
aren't many places where these lists are iterated over or altered.  We
could remove most of the overhead associated with klists and get rid of an
extra API for people to learn.

Note that this would be very different from the old bus subsystem rwsem.  
That protected too much -- everything associated with the bus subsystem -- 
making it a pronounced chokepoint.  My suggestion involves a separate 
rwsem for each of these lists, so that none of them would be subject to 
much contention.

Alan Stern

