Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbSIXWaf>; Tue, 24 Sep 2002 18:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSIXWaf>; Tue, 24 Sep 2002 18:30:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3716 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261808AbSIXWae>;
	Tue, 24 Sep 2002 18:30:34 -0400
Date: Tue, 24 Sep 2002 15:37:23 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
In-Reply-To: <20020924192956.GA25963@kroah.com>
Message-ID: <Pine.LNX.4.44.0209241516470.966-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Sep 2002, Greg KH wrote:

> On Tue, Sep 24, 2002 at 11:55:00AM -0700, Linus Torvalds wrote:
> > 
> > So I'd suggest you just export a text-file that describes the thing. 
> > Something like
> > 
> >  - legacy name (the kernel knows about these anyway, see /proc/mounts and 
> >    friends)
> 
> I would like to see all of the /proc/mounts and friends info that
> "knows" about the legacy name, to disappear if possible.  Yes, I know
> the root filesystem logic will have to stay, but I don't want to see
> this be used like the devfs name is used throughout the kernel.  That
> info should not be in the kernel, it's up to the user what to name their
> "USB mouse, connected to the EHCI host controller's 3 hub port".

I agree. We can create a file in userspace that the hotplug agent can 
query for what to name the device. It's gonna have to do this anyway, for 
user-defined policy. Putting the legacy name in that puts all names in 
one place. 

> >  - major number, minor number) and char vs block
> 
> Yes, this info is needed, and if presented in a file, that would be
> fine.  It was just that the device node was a nice compact version of
> this :)

Exactly. If we go with a text file, and we enforce our own 1 value/file 
semantics, we end up with a file for each:

- major
- minor
- type (char vs. block)
- legacy name

If we punt the legacy name to userspace, a device node becomes ideal for 
expressing the data. 

> But I can see how the device node would be abused, and it's fine with me
> if it isn't present in driverfs.

I didn't even want it in the first place. ;) But, it's a lot easier to 
express the data /sbin/hotplug needs than three separate files. 

Also note that there may be multiple 'node' files (or equivalent) for 
devices that support multiple interfaces. E.g. mice in the input layer 
have an general event device and a mouse event device. The patch I posted 
wouldn't work, since the name is hardcoded to 'node'. But, it would be 
trival to append or prepend the name of the interface to 'node'. 

We could do that for each of the text files, but that would unnecessarily 
clutter the device's directory.

As far as abuse, we could force the permissions to 000, which would still 
allow us to stat the device. We appear to still do a request_module() on 
open(), but read() and write() should fail..


	-pat

