Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbTEMUtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTEMUtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:49:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17632 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261275AbTEMUs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:48:57 -0400
Date: Tue, 13 May 2003 14:02:04 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Mike Anderson <andmike@us.ibm.com>
Subject: Re: [RFC] support for sysfs string based properties for SCSI (1/3)
In-Reply-To: <1051989565.2036.14.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0305131326050.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 May 2003, James Bottomley wrote:

> On Sat, 2003-05-03 at 14:11, James Bottomley wrote:
> > 
> > This first patch is of general interest (the other two are going to the
> > SCSI list only).
> > 
> > The problem this seeks to solve is that we have a bunch of properties in
> > SCSI that we'd like to expose through the sysfs interface.  The
> > mid-layer can get their values, but setting them requires co-operation
> > from the host drivers, thus we'd like to expose a show/store interface
> > to all the SCSI drivers.
> > 
> > The current one call back per sysfs file is a bit unwieldy for
> > encapsulating in an interface like this.  what this patch does is to
> > allow a fallback show/store method of the bus type (if the device type
> > doesn't exist).  However, the bus_type show/store passes in the
> > attribute so a comparison may be done against the name of the attribute.

I'm not very fond of your implementation. I like the concept, and it 
works, but there's a much better way, despite requiring some changes to 
the kobject core. 

Ideally, what you'd like to do, instead of adding more conditionals to
normal call chain down to the lowest-level sysfs show()/store() methods,
you'd like to bypass them and define your own methods higher up; e.g. to
replace dev_attr_{show,store} in this case.

But you can't, because in order to define attributes for a device object, 
you must use the device_attribute infrastructure, which means using the 
call chain I've mandated. :)

We could modify the lowest-level methods, but that requires changing every 
attribute definition, and we'll still end up with the macro hell we 
already see to export many attributes that all just a little different. 

So, what I propose is killing struct kobj_type. We can move ->release() 
into struct kset, adding a small amount of overhead to ksets of an 
identical type (trivial). We can move ->sysfs_ops and ->default_attrs into 
say struct attribute_group and allow subsystems to register arbitrary 
groups of attributes of attributes for kobjects. 

This will allow us to keep identical behavior everywhere, with a little 
glue, but will also solve your problem nicely. You will do something like:


struct attribute my_attrs[] = {
	foo,
	bar,
	baz,
	NULL,
};

struct attribute_group my_group {
	.ops	= {
		my_attr_show,
		my_attr_store,
	},
	.attrs	= my_attrs,
};

int my_register()
{
	...
	if ((error = device_register(&mydev.dev)))
		goto Err;
	if ((error = attr_grp_register(&mydev.dev.kobj,&my_group)))
		goto Unregister;
	...
}

my_show() and my_store() will get pointers to the kobjects, which you'll
have to convert into the proper type, and pointer to the attributes, so
you'll be able to tell which attribute is requested from a much higher
level. 

We can still keep device_attribute arround, but in general I don't think
it's that useful to route every attribute request through the core. Using
them is fine, and easy. But attributes travel in herds, and appear when an
object is registered with a subsystem, or some extension of a subsystem.

It's easier to define one set of callbacks + lookup mechanism for 
attribute by name, than it is to macro-ize the hell out of your code, 
provided your dealing with a fair number of attributes per object.


	-pat

