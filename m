Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265542AbSJXQmD>; Thu, 24 Oct 2002 12:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265544AbSJXQmC>; Thu, 24 Oct 2002 12:42:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54406 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265542AbSJXQlZ>;
	Thu, 24 Oct 2002 12:41:25 -0400
Date: Thu, 24 Oct 2002 09:51:00 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Steven Dake <sdake@mvista.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <alan@lxorquk.ukuu.org.uk>
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel
 2.5.44
In-Reply-To: <3DB73E2A.5090001@mvista.com>
Message-ID: <Pine.LNX.4.44.0210240940050.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Any reason you can't use driverfs for the 2.5 code?
> >
> >  
> >
> I'm not sure how driverfs would be used by this particular patch.  Could 
> you be more specific in stating how this could be used?

I haven't looked extensively at the code, but I'll give you these hints: 
Each scsi device gets a directory in the driverfes hierarchy. If you can 
obtain a pointer to that device during initialization, you can create 
attribute files to handle read/write in that directory. 

You need to declare a struct device attribute, which looks like: 

(from include/linux/device.h)

struct device_attribute {
        struct attribute        attr;
        ssize_t (*show)(struct device * dev, char * buf, size_t count, loff_t off);
        ssize_t (*store)(struct device * dev, const char * buf, size_t count, loff_t off);
};

for each file you want to export.


There is a macro to help, which will fill in the embedded attr structure 
for you: 

DEVICE_ATTR(name,mode,show,store);

which is equivalent to declaring. 

struct device_attribute dev_attr_<name> = { ... };

(You can do it manually, too, if you feel really manly). 


I assume that the ability to hotswap drives in a feature supported by a 
subset of SCSI drives. I don't know how you handle checking each device, 
and it's not really relevant. Whenever you find a device that supports 
hotswap, then do something like:

{
	Scsi_Device * scsi_dev;
	...
	device_create_file(&scsi_dev->sdev_driverfs_dev,&hotswap_attr); 
	...
}

The attribute descriptor will be reused for each device that exports it. 
On read() and write(), your show() and store() callbacks will be called, 
with a pointer to the device for which it was called as the first 
argument. 

I hope this all makes sense... If you have any questions, please feel free
to ask.


	-pat

