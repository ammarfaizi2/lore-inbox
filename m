Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbTEEXxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTEEXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:53:32 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:8455 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262226AbTEEXx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:53:29 -0400
Subject: Re: [RFC] support for sysfs string based properties for SCSI (1/3)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <20030505171745.GA1477@kroah.com>
References: <1051989099.2036.7.camel@mulgrave>
	<1051989565.2036.14.camel@mulgrave> <20030505170202.GA1296@kroah.com>
	<1052154516.1888.33.camel@mulgrave>  <20030505171745.GA1477@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 May 2003 19:05:52 -0500
Message-Id: <1052179553.1888.461.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 12:17, Greg KH wrote:
> On Mon, May 05, 2003 at 12:08:35PM -0500, James Bottomley wrote:
> > Nothing prevents users from doing it the callback way.  However,
> > callbacks aren't a scaleable interface for properties that have to be
> > shared and overridden.
> 
> I don't understand the "shared and overridden" aspect.  Do you mean a
> default attribute for all types of SCSI devices, with the ability for an
> individual device to override the attribute with it's own values if it
> wants to?  That still seems doable within the driver model today,
> without having to rely on bus specific functions.

Yes, but the problem is how to communicate the override between the HBA
driver and SCSI. The override is required because changing some
properties may require changes at many levels.  The queue_depth in the
example I gave is the obvious one:

- the device needs to make sure it has internal resources for the
revised queue depth.  It also has to implement the change.
- the mid-layer needs to do the adjustment
- As does the block layer (I didn't implement this one in my patch).

The interface obviously belongs in the SCSI API, but one API entry per
property causes the interface to explode and also makes it quite
difficult to add new ones, so we need a generic get/set property
interface; however, then we need to know what property, hence the
strings.

> Hm, this is _really_ calling for what Pat calls "attributes".  Take a
> look at the ones in the class model, and let me know if those would work
> for you for devices.  If so, I'll be glad to add them, which should help
> you out here.

Well, I analysed the class interface.  It currently won't do what we
need, but it might be able to if it supported an inheritance, so there
would be a device class which could then be extended by the drivers to
override the properties they need.  However, isn't this type of
inheritance going to be a real pain using function pointers, and if we
only support overrides of show/store, it's probably simpler just to
support the strings based interface.

James


