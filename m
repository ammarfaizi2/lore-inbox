Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWCHBDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWCHBDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWCHBDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:03:45 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:56463 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751952AbWCHBDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:03:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Tue, 7 Mar 2006 20:03:41 -0500
User-Agent: KMail/1.9.1
Cc: Dave Peterson <dsp@llnl.gov>, Al Viro <viro@ftp.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, dthompson@lnxi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603070847.44417.dsp@llnl.gov> <20060307170401.GA6989@kroah.com>
In-Reply-To: <20060307170401.GA6989@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072003.42327.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 12:04, Greg KH wrote:
> On Tue, Mar 07, 2006 at 08:47:44AM -0800, Dave Peterson wrote:
> > Ok, how does this sound:
> > 
> >     - Modify EDAC so it uses kmalloc() to create the kobject.
> >     - Eliminate edac_memctrl_master_release().  Instead, use kfree() as
> >       the release method for the kobject.  Here, it's important to use a
> >       function -outside- of EDAC as the release method since the core
> >       EDAC module may have been unloaded by the time the release method
> >       is called.
> 
> No, if this happens then you are using the kobject incorrectly.  How
> could it be held if your module is unloaded?  Don't you have the module
> reference counting logic correct?
> 

It is pretty hard to implement kobject handling correctly. Consider the
following:

	rmmod device_driver < /sys/devices/pci0000:00/...../power/state

for a driver that creates/destroys device objects.
 
Opening 'state' attribute will pin device structure into memory but will
not increase _your_ module's refcount. It is nice if you have a subsystem
core split from drivers code - then you can keep core module reference
until device objects are gone and allow individual drivers be unloaded
freely. But for single-module system it is pretty hard, that's why
platform devices are popular.

-- 
Dmitry
