Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSILRzx>; Thu, 12 Sep 2002 13:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSILRzx>; Thu, 12 Sep 2002 13:55:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25482 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316695AbSILRzv>;
	Thu, 12 Sep 2002 13:55:51 -0400
Date: Thu, 12 Sep 2002 11:00:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Matt_Domsch@Dell.com
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1E7FF@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0209121022250.1057-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Sep 2002 Matt_Domsch@Dell.com wrote:

> > The next logical extension would be to make a symlink 'disk' in each
> > directory that points at the PCI 
> > bus:dev.fn/scsiX/a:b:c:d:disk file for the
> > appropriate disk.  However, I'm in a quandry...  There's no 
> > simple way to do this.
> 
> Or is there? :-)
> 
> Patrick, in drivers/base/core.c, there's this concept of platform_notify()
> and platform_notify_remove().  Could I exploit this to get callbacks to the
> EDD code to create a symlink at that point?  These aren't exported to
> modules ATM, and I could see how multiple things may want to use this hook -
> so instead, how about notifier lists (ala reboot notifiers) that the EDD
> code could register with, instead of a single entry?  As a list, modules
> could add/remove themselves easily.

You definitely want something like platform_notify(), but the nature of 
the call implies you can only have one firmware driver that can be 
notified of device discovery. In the ia32 world, having only one firmware 
with device knowledge is rare.

This is a perfect opportunity to unleash the concept of device extensions
on the world. Extensions are (usually conditional) augmentations of a
subsystem that apply to or operate on every device as it is discovered by
or registered with the subsystem.

Extensions get a simple structure:

struct device_extension {
        char                    * name;
        struct list_head        node;
        dev_add_t               add_device;
        dev_remove_t            remove_device;
};


...and can be registered with any bus or class or with the driver model 
core (but not more than one):

extern int dev_ext_register(struct device_extension *);
extern void dev_ext_unregister(struct device_extension *);

extern int bus_ext_register(struct bus_type *, struct device_extension *);
extern void bus_ext_unregister(struct bus_type *, struct device_extension *);

extern int class_ext_register(struct device_class *, struct device_extension *);
extern void class_ext_unregister(struct device_class *, struct device_extension *);


The list of extensions at any level is iterated over after the device is 
registered with the subsystem. 


procfs or driverfs files are perfect examples of extensions. In PCI, a 
handful of files are created for every device. Instead of having a call 
wrapped in #ifdef to create the files, the extension can be registered on 
startup, and happen implicitly. 

Registering the device with firmware drivers is another good usage of 
them. Instead of conditional calls, the firmware driver can register an 
extension with the core and be notified when the device is discovered. 
You'd get a pointer to the device, from which you could ascertain the path 
and create a symlink..

If that's useful, and no one complains horribly about it, I'll submit a
patch to Linus.

> Then, one more request - giving back the ability to make a symlink given the
> device, not just a name.

Yes, it's coming. :)

	-pat

