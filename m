Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbUKJHNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbUKJHNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 02:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUKJHNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 02:13:39 -0500
Received: from [211.58.254.17] ([211.58.254.17]:63719 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261249AbUKJHNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 02:13:25 -0500
Date: Wed, 10 Nov 2004 16:13:15 +0900
From: Tejun Heo <tj@home-tj.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Message-ID: <20041110071315.GA17026@home-tj.org>
References: <20041104185826.GA17756@kroah.com> <d120d50004110508333c183cc1@mail.gmail.com> <20041109012722.GA20689@home-tj.org> <200411082043.21818.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411082043.21818.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Dmitry.

On Mon, Nov 08, 2004 at 08:43:21PM -0500, Dmitry Torokhov wrote:
> On Monday 08 November 2004 08:27 pm, Tejun Heo wrote:
> >  Are you suggesting splitting every bus implementation into two
> > separate modules?  Otherwise, we will have to move kobj field of every
> > bus-specific device structure to the head (to use the common release
> > function).  Either way, it can be done, but it just seems another
> > twist added to the already twisted refcounting.  Moreoever, not only
> > the devices are problematic, refcounting in class devices and block
> > device hierarchy seems broken too.
> >
> 
> It is already defacto implementation standard - every subsystem has a core
> modules (pci, usbcore, serio) plus modules (drivers) actually talking to
> hardware and registering devices (ports, whatever) with the corresponding
> core. It is just a matter of splitting cleanup functions into core and
> device-specific parts.

 AFAIK, PCI isn't compiled as modules and USB has ohci/uhci/ehci stuff
and serio has ports stuff.  But still, I cannot agree with you.

 1. It's too twisted.
	a. to prevent premature unload, we depend on
	   - attr -> kobj -> module_ref to bus core module.  By doing
	   this, we're making a chain of two different types of
	   reference counts.  IMHO, it's just a bit too subtle.
	b. to enable bus module unload, we depend on
	   - device creation/detach operations are done in a separate
	     module than device release.

 2. too restrictive.
	a. any bus implementation must be implemented as two separate
	   modules just to enable peaceful module unloading
	b. all other places which make use of kobject and any type of
	   generic attr must use only the release routine proper to
	   the core module.  No callbacks, no data dereferences....
	   (for example, scsi_host class uses scsi_host_template
	    structure which contain class device specific callbacks
	    when releaseing scsi_host class device.  This is
	    currently broken and won't be fixed by your method.)

 3. not intutive.  Maybe this is the most important.
	a. it's natural to expect the release code has access to
	   codes & data of whatever it's releasing.
	b. children bypassing dependency hierarchy and depending
	   directly on indirect ancestor is just difficult to
           track, memorize and do correctly.
    IMO, above a and b are the primary reasons for why kobject/attr
    refcountings are currently done incorrectly in many places.

> >  But all attrs will be deflated and it just seems the right thing to
> > do(tm).
> > 
> 
> I think there are much more kobjects than attrs.

 Yes, there are.  But many objects which contain kobjs keep separate
owner field anyway, which can be removed after kobj can handle module
refcounting, and even without that, I think 4 or 8 bytes addition to
struct kobject is worth it if we can get the refcounting straight.

 Thanks.

-- 
tejun

