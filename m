Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318077AbSG2WSO>; Mon, 29 Jul 2002 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSG2WSO>; Mon, 29 Jul 2002 18:18:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59533 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318077AbSG2WSH>;
	Mon, 29 Jul 2002 18:18:07 -0400
Date: Mon, 29 Jul 2002 15:21:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Adam Belay <ambx1@netscape.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
In-Reply-To: <3D4571B7.1000709@netscape.net>
Message-ID: <Pine.LNX.4.44.0207291431381.22697-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Not a chance. I refuse to apply any devfs interface layers to the device 
> >model core, or any devfs-specific members to the device model data 
> >structures. And, that's just on principle. 
> >
> This patch merely adds one new list to the device struct.  The 
> information it provides is not devfs specific and it only extracts data 
> from the devfs structures that already exist.

Look at what you named it: 

+    struct list_head devfs_handles;   /* stores devfs entries */

If that's not devfs specific, why does it carry such a name?

> >As for technical reasons, why on earth would you want to do this in the 
> >first place? 
> >
> Actually doing this is extremely useful.  Without such an interface it's 
> impossible to tell which device interface in the driver model 
> corresponds to which dev entry both with and without the use of devfs. 

I agree that such information can be useful, but you're going about it the
wrong way (for several reasons now that I look a little closer at the 
patch). 

1) devfs imposes a default naming policy. That is bad, wrong and unjust.
There shalt not be a default naming policy in the kernel. Period.

2) You're not exploiting the interface; you're abusing the infrastructure.  
You want to modify every driver to call this wrapper function that resides
in the device model core, just so you can get one extra file in the 
device's driverfs directory? 

devfs was already implemented in the wrong way in the first place. Instead
of requiring modification to every driver, the devfs registration should
have taken place in the subsystem for which the driver belongs to. In most
cases (I won't say all), the driver already registers the devices it
attaches to with _something_. The proper thing to do is not to create a 
parallel API, but one the subsystems can use. The subsystems already know 
most of the information about the device, they should use it. 

If you want this information exposed, the really unintrusive thing to do 
would be to just call device_create_file in the drivers you want to expose 
this information. Or, in the subsystems the driver registers with. Which 
brings me to my next point:

3) You're munging three values in the driverfs file. 

Thou shalt not have more than one value per file. 

Exceptions are available, but only in extreme cases (like arrays of 
information; we're still not quite sure what to do with that). 

4) You're doing this:

+struct dev_handle {
+    devfs_handle_t handle;
+    struct list_head device_list;   /* node in device's list */
+};
+
+typedef struct dev_handle * ldm_devfs_t;

Thou shalt not use typedef. 

5) You're adding a function with _9_ parameters, two of which are void *. 

6) You're adding infrastructure in the core for an interface that is 
optional and rarely used. 

>  Imagine a user trying to configure a serial port through the driverfs. 
>  Without this interface how can the user determine which serial port he 
> is configuring.  With my patch it is possible to determine the !major! 
> and !minor! number of the device as well as a path to devfs in the event 
> that it is used.  It provides information so that the user can determine 
> which device the driver model is talking about.  With the floppy driver 
> that I converted it is especially nice because it lists for the user all 
> the many devices that correspond with that particular floppy drive. 

With device classes, you will have a directory like this: 

	/devices/class/floppy/

With symlinks back to the device's directory in the physical hierarchy 
layout. The user can see what devices of what type they have, and have 
access to their configuration items. 

It is that mapping (from logical to physical) that is really useful, not 
the other way around. Users probably aren't going to be poking around 
in the physical layout as much as they will be in the logical layout (but 
we keep all the attributes in one place with symlinks between them). 

>  Many user level scripts and programs "will" need this kind of 
> information when the driver model is complete.

That's not an argument. You, nor I, nor anyone else can accurately say 
exactly what user level scripts will need when it is done. Furthermore, 
the point of the device model is not, has never been, nor ever will be, to 
satisfy the mythical requirements of userspace. It is meant to consolidate 
and centralize internal interfaces. The fact that they're exported to 
userspace is because we can easily. 

> >We've collectively decided that enforcing device naming policy in the
> >kernel is the Wrong Thing To Do. devfs does this; and your patch
> >furthers the pain.
> >
>  My patch does not enforce any policies, it merely extracts information 
> from the already existing devfs.  The major and minor numbers provided 
> are useful to even those who don't use devfs.

So why call include the devfs information at all? The SCSI people have 
been doing something similar for a couple of versions now. They export a 
driverfs file with the kdev_t value in it. Granted, they export it as one 
value, which is bad, but it's only the kdev_t number.

If you want the path to the device node, write a script that looks it up 
(in userspace). 

>  Please have a more open mind about this.  It may need a bit of 
> adaptation but is still very useful.  If you have any questions or 
> comments feel free to contact me.

I do have an open mind. This is not a rash decision. I began looking at 
this a year ago. After many long days of meditation, chant, and heavy 
drug use, I came to the conclusion that devfs does not have Buddha in it. 
And, if it doesn't have Buddha, I can't hang with it. Therefore, I will 
refuse any patch that does anything but remove devfs-isms. 

	-pat

