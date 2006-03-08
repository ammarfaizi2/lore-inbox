Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWCHBdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWCHBdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWCHBdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:33:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:36265
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751503AbWCHBdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:33:19 -0500
Date: Tue, 7 Mar 2006 17:33:04 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Dave Peterson <dsp@llnl.gov>, Al Viro <viro@ftp.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, dthompson@lnxi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060308013304.GC24739@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603070847.44417.dsp@llnl.gov> <20060307170401.GA6989@kroah.com> <200603072003.42327.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603072003.42327.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 08:03:41PM -0500, Dmitry Torokhov wrote:
> On Tuesday 07 March 2006 12:04, Greg KH wrote:
> > On Tue, Mar 07, 2006 at 08:47:44AM -0800, Dave Peterson wrote:
> > > Ok, how does this sound:
> > > 
> > >     - Modify EDAC so it uses kmalloc() to create the kobject.
> > >     - Eliminate edac_memctrl_master_release().  Instead, use kfree() as
> > >       the release method for the kobject.  Here, it's important to use a
> > >       function -outside- of EDAC as the release method since the core
> > >       EDAC module may have been unloaded by the time the release method
> > >       is called.
> > 
> > No, if this happens then you are using the kobject incorrectly.  How
> > could it be held if your module is unloaded?  Don't you have the module
> > reference counting logic correct?
> > 
> 
> It is pretty hard to implement kobject handling correctly. Consider the
> following:
> 
> 	rmmod device_driver < /sys/devices/pci0000:00/...../power/state
> 
> for a driver that creates/destroys device objects.

I agree, that's one reason I really hate the "default" attributes :(

To do this "right" we need to make the attributes dynamically created
and the owner set to the proper module.  I did that for the module core
code and it's on my todo list for the driver core too.

> Opening 'state' attribute will pin device structure into memory but will
> not increase _your_ module's refcount. It is nice if you have a subsystem
> core split from drivers code - then you can keep core module reference
> until device objects are gone and allow individual drivers be unloaded
> freely. But for single-module system it is pretty hard, that's why
> platform devices are popular.

They are popular for when you don't have a "bus", and rightfully so.

thanks,

greg k-h
