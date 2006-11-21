Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030594AbWKUAta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030594AbWKUAta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWKUAta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:49:30 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:55676 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP
	id S1030594AbWKUAta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:49:30 -0500
Date: Mon, 20 Nov 2006 19:49:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe
 ohci1394"
In-Reply-To: <tkrat.c6b0c0fdc1b83378@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.44L0.0611201942270.30952-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Stefan Richter wrote:

> On 20 Nov, Alan Stern wrote:
> >> > Is the problem caused by the fact that some of these struct device's 
> >> > aren't bound to a driver?  Remember, bus_rescan_devices() will skip over 
> >> > anything that already has a driver.  Could you solve your problem by 
> >> > adding a do_nothing driver that would bind to these otherwise unused 
> >> > devices?
> 
> There are three minor problems with this approach:
>  - some ballast in system memory for the dummy driver struct
>  - the dummy driver is visible in sysfs
>  - the (root) user can unbind the driver which will recreate the
>    preconditions for the deadlock

I agree with all these objections.

The real issue here is the way ieee1394 sets up children of devices with
no driver.  On the face of it that is quite illogical: If a device has no
driver, then who can interrogate it to find out about its children?

USB faces a similar situation.  In a USB device, all the real work is 
actually done by "interfaces".  So we set up a device structure for the 
USB device itself, plus device structures for each of its interfaces.  The 
parent structure is bound to a (more or less) dummy driver, which insures 
that the child structures are deleted whenever it gets unbound.

Still, maybe some compromise can be reached.  Perhaps Dmitry's idea, or 
something like it, can be adopted.

Alan Stern

