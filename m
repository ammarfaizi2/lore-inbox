Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTJ0Qbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTJ0Qbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:31:47 -0500
Received: from ida.rowland.org ([192.131.102.52]:28676 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263280AbTJ0Qbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:31:46 -0500
Date: Mon, 27 Oct 2003 11:31:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Missing kobject release methods?
Message-ID: <Pine.LNX.4.44L0.0310271121350.679-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

For a long time, I've been getting debug warnings about missing release()  
methods in various kobjects.  They come up because your usb-2.5 tree has
DEBUG defined in a number of driver-model source files.

It's not easy to track down exactly what the objects in question are; the
driver-model/kobject system is a pretty tangled web of pointers and
subobjects.  I suspect the objects in question are actually embedded as
sub-structures of other things that do get released correctly, so these
messages may be completely safe to ignore.  But it would be better if they
weren't generated in the first place, because they fill up my system logs
and debugging screens with stack dumps.

The kobjects and subroutines that provoke these messages are:

	usb		in usb_major_cleanup()
	usb_host	in usb_host_cleanup()
	drivers		in bus_unregister()
	devices		in bus_unregister()
	usb		in usb_exit()
	class_obj	in usb_host_release()

To see for yourself, try rmmod'ing a USB device driver module and the 
usbcore module.

It oculd be that fixing this will be as simple as initializing a .release
method with a pointer to a function that does nothing in some place like 
lib/kobject.c:kset_init().  But I don't pretend to understand the details 
of kobjects and such well enough to really track this down.  Maybe you 
can.

Alan Stern

