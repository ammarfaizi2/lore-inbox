Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262225AbRERACw>; Thu, 17 May 2001 20:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262221AbRERACn>; Thu, 17 May 2001 20:02:43 -0400
Received: from www.inreko.ee ([195.222.18.2]:22402 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S262220AbRERAC0>;
	Thu, 17 May 2001 20:02:26 -0400
Date: Fri, 18 May 2001 02:04:25 +0200
From: Marko Kreen <marko@l-t.ee>
To: linux-kernel@vger.kernel.org
Subject: rfc: devfs2 idea
Message-ID: <20010518020425.A27187@l-t.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have seen now several runs of devfs / hot-pluggable /
device-identification discussions and they mainly consist of
some people giving parameters for device identification and
others giving examples of devices not fitting into them.

My main conclusions are:

* Different devices (even under one subsystem) give
  very different amount of info about themselves.

* there are devices for which it is impossible to get any
  specific info.

* major:minor is not good

* current devfs is also not good enough

* Policy does not belong to kernel.  Also 'There cant be any
  fixed rules'.

* There cant be 100% Right solution, as interfacing with devices
  has too much this 'Real World' in it.

* Also there cant be 100% accepted solution as people too
  have quite a lot of this 'Real World' with them...

* and backwards compatibility.

So I guess I cant make situation worse by submitting my idea of
devfs2.  I am aiming it at near 90% ;)


Now.  devfs2 is not intended to be mounted to /dev
Rather it should live in /devfs or /proc/sys/devices
or /devices.

So /devices/ should like /proc consist of numbered directories.
Main idea is that one dir will describe one 'device node'.  And
only one.  I call the dir num 'devid'.  It will be unique for
one session (boot-shutdown).  It will be given out in ascending
order.  Devices detected later get bigger devid.  If device goes
away and comes back it will get new devid.  Lets say devid is
64bit int starting from 0 so I need not worry about wrapping.

Now files.  And I want to emphasize that this is only sketch,
I want to express general idea, not say that this is only way.

  /name
	short name.  [ urandom, null, zero - devfsd2 can simply
	use that name and drop it into /dev, or under
	/dev/$(parent)/ ]

  /parent
	The parent devid.  Not mandatory but most of devices
	can be said to be 'under' something.

  /info
	this is consist of 'key: value\n' pairs.  All relevant
	info the kernel has about this device.  Most
	common/typical values (all?) can be separated into
	separate files (as I have done with 'parent' and 'name').
	
	Possible keys: type, desc, driver, irq, dma,
	dma2, map, serial, uuid, (topology, location),
	bus, ...

	Note that I have categorized them as 'info'.  Later
	the devfsd2 _can_ but does not need to use them.

	example1:
		name: aix7xxx
		type: scsi-host
		desc: Adaptec AIC-7881U (rev 1)
		irq: 11

	example2:
		name: colormap
		type: fb-colormap
		desc: Color map for framebuffer 0
		[ parent is the main fb0 ]


  /ioctls
	Is a '\n' separated list of ioctl strings the
	node supports.  (And there could be dir
	/proc/sys/ioctls/STRING describing it...)

  /aliases (rw)
	Initially empty, but writing into it strings
	in format 'major:minor' makes kernel to redirect
	requests into this device.


[ Actually, the next item should not be needed. I am only
  keeping it, so I can say it really does not belong here... ]

  /node
	The node itself where open/read/write/ioctl can be done.
	This should be 'ordinary' file not char/block dev as
	it is virtual enough.


Now the devfsd2 part:

devfsd can operate 2 ways:

  1) Tell devid to react to specific major:minor numbers
     /dev can be then on disk, containing old-style major:minor
     nodes.

  2) Do a new-style mknod(2) (pathname, devid), after that
     set perms.  /dev should be managed by current devfs1 or
     can be on ramfs...  It should _not_ get into disk as
     devid's can be different on next boot.

devfsd2 flowchart:

  * start, read all current devices, attach to listening events,
    read config.

  * match devices, put them somewhere.  Really unknown devices,
    with even 'type' unknown should simply syslogged so admin
    can give some rules for them.

Here will be the heuristic for device manipulation.

  1) new-style: load config, try to match devices by whatever
     rules are specified there.   Eg.  disk by this serial here,
     mouse with that usb-location there...  All stuff under
     a framebuffer N goes to dir /dev/fbN/'name' where 'name'
     is taken from /info ...

     If not matched, then put to some default location for
     that kinda device.  Eg. unknown USB-mouse, put to next
     free /dev/usbmouseX.  Unknown ide1 slave disk, put as hdd.

  2) devfs1-style: by current devfs1 rules.

  3) old-skool (default?): tell device needed major:minor
     from MAKEDEV database.

I guess initially some minimal implementation (the 3/MAKEDEV)
should be in kernel, when init/devfsd2 are more spread, then
it can be dropped from kernel.

All details like layout, filenames, keys, value formats
should be specified centrally, by some imortant person
(hpa/LANANA...)

Various notes:

* /devices/0 should be 'root', where all other can be attached.

* embedded devices: in-kernel defvsd can be dropped, as hardware
  is fixed and known, init can run minimal program that does the
  needed initialization, then exits.

* various other parts of kernel can refer to devid if needed.
  eg. ioctl 'on what device this file resides'

* in-kernel code can open devices by devid, user only through
  mknodded entries.

* devfsd2 config should be flexible enough to specify eg
  'ide0 master partitions should named as hdaX'.  So it
  must be possible to match not only current devid info
  but also parents'.

* permissions-should-be-on-disk: well, they are: in devfsd2
  config file.  Ofcourse the major:minor variant can be used.
  If the major:minor size get increased, the devfsd2 should be
  able to do fixed-dynamic allocation so admin can fill the /dev
  with nodes and tell devfsd2 to give them out to specific types
  of devices.

* eg. when fb0 is a device (not dir) in /dev then Linux VFS
  allow use of sub-devices in form /dev/fb0/xxx.  I personally
  does not like it, but it is allowed in devfs2 too - the
  available sub-devices can be described under devid in separate
  entry.

  Ofcourse, when they are some form of parameters for device
  they they probably cannot be described so easily.

* Note that the devid numbering follows the detection order.
  So if you have two same type devices, and no specific info 
  what to do with them, devfsd2 can be backwards-compatible
  by assigning them in that order.

* As I said there are different info available for different
  devices.  So driver/subsystem maintainers with LANANA and
  devfs2 maintainer should decide what info to put into /info
  and also create needed devfsd2 config rules for both old-style
  and new-style configurations.

* booting/mounting: I cant imagine this as impossible.  kernel
  mounts root, runs init, that mount devfs into /devices, ramfs
  into /dev, runs devfsd /devices /dev.


So.  Comments?  How much of this is sane?



-- 
marko

