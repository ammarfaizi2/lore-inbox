Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVALPSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVALPSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVALPSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:18:40 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:42397 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261218AbVALPRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:17:43 -0500
Subject: Re: [PATCH] Add attribute container to the generic device model
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <greg@kroah.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112070802.GB2085@kroah.com>
References: <1105506370.10378.26.camel@mulgrave>
	 <20050112070802.GB2085@kroah.com>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 09:17:22 -0600
Message-Id: <1105543042.5577.9.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 23:08 -0800, Greg KH wrote:
> But classes could always have an arbitrary number of attributes, right?

Per class, yes.  The SCSI transport classes evolved such that they
simply don't display attributes that are irrelevant to the underlying
device.  Also, not all devices are fully capable, so attributes that are
ro on one HBA are rw on another.  This means that we need the attributes
per class device rather than per class.

> > This will be used as the basis for a generic transport class, but I did
> > it like this in case anyone found the abstraction useful.
> 
> Hm, I like the idea, but we already allow devices belonging to arbitrary
> number of classes (through class_device) today.  What makes this
> different?

The idea is simply to be an attribute container for classes that can't
use the per-class one (because of the needs listed above).

> And how does this change, if at all, sysfs representations of devices
> that use this?
> 
> Some minor comments about the code:
> 
> > +EXPORT_SYMBOL(attribute_container_classdev_to_container);
> 
> Can these all be EXPORT_SYMBOL_GPL?  It's your choice, as you wrote the
> code, but we're trying to keep the driver model stuff all GPL explicit,
> as there's no way someone can say it's a "derived work" from long ago
> that's using these new functions.

Well ... I can, certainly, but that would be window dressing it a bit.
The ultimate end consumer will be SCSI (and other bus) HBA's, not all of
which are GPL available.  However, as long as the HBA APIs exported by
the transport class are non-GPL available, this should all work (and
certainly none of the attribute container APIs are used by HBAs).

> > +/**
> > + * attribute_container_add_device - see if any container is interested in dev
> > + *
> > + * @dev: device to add attributes to
> > + * @fn:	 function to trigger addition of class device.
> > + *
> > + * If no fn is provided, the code will simply register the class
> > + * device via class_device_add.
> 
> You mean the class_device of the "container", right?

Yes, this function actually allocates the container (which contains the
classdev) then calls fn on it (or just does a class_device_add if no
fn).  I'll update the doc.

> The code looks sane, if not a bit confusing as there's no user of it :)

There is now ... you didn't wait long enough ...

James


