Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130341AbRBAKdB>; Thu, 1 Feb 2001 05:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130314AbRBAKcv>; Thu, 1 Feb 2001 05:32:51 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:1548 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130341AbRBAKcj>; Thu, 1 Feb 2001 05:32:39 -0500
Message-ID: <3A793B0E.E327293D@idb.hist.no>
Date: Thu, 01 Feb 2001 11:31:42 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: William Knop <w_knop@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
In-Reply-To: <F148MamEWkeMEwuwi7N000015ef@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Knop wrote:
> 
> I decided recently to go bleeding-edge on one of my Linux boxes and
> discovered I had a problem with module loading while using DevFS.

> Correct me if I'm wrong, but DevFS only makes /dev entries when a device is
> present, and the device is not present until the module is loaded. So if I
> want to access /dev/hda and the IDE module has not been loaded yet, I will
> get a message telling me the device doesn't exist or some such instead of
> autoloading the module and being happy. Same goes for hotswap devices,

You can have the device autoloaded and be happy, even when using devfs.
All you need is to set up the devfsd daemon right.

I have my sound driver as modules - so /dev/dsp don't exist when it
isn't loaded.  I can still have my sound using programs autoload 
the driver.  I'll show this as an example, as I don't use USB myself.

My /etc/devfsd.conf contains the following, among other things:

LOOKUP          dsp             MODLOAD
LOOKUP          sound           MODLOAD
This is a neat one.  Whenever someone tries to lookup "/dev/dsp"
devfsd will do a "modprobe /dev/dsp" if the device isn't there.
Appropriate aliases in /etc/modules.conf then ensures the
correct module is loaded.

REGISTER        sound/.*        MKOLDCOMPAT
UNREGISTER      sound/.*        RMOLDCOMPAT

This ensures old fashioned names like /dev/dsp works, by creating
links to /dev/sound/dsp.  Few programs ask directly 
for /dev/sound/dsp yet.

My modules.conf contains this, among other things:
alias /dev/dsp sound-service-0-3

This maps the "/dev/dsp" probe to the sound driver.
Further aliases for sound-service-0-3 follows, but thats
just stuff necessary to load ALSA so I won't detail it here.


This happens when a program tries to open the (non-existing) /dev/dsp:
* app tells kernel to open "/dev/dsp"
* devfs realize it isn't there, and pass the request to devfsd
* devfsd does a "modprobe /dev/dsp" because its configuration says so.
* modprobe looks up the real driver in modules.conf, using my aliases.
  The sound driver modules are loaded.
* The sound modules create /dev/sound/dsp among others
* devfs notice this, and notifiex devfsd which creates the /dev/dsp 
  symlink as devfsd.conf says so.
* devfsd returns to devfs that lets the sound driver continue its
  initialization.  The sound driver finishes and modprobe returns
  and the first invocation of devfsd finishes.
* devfs continue looking up /dev/dsp.  It exists now, so the kernel
  return a file descriptor to the app in the usual way.

This may seem like a lot - fortunately it is simpler when the driver
is in memory.

> I realize modularizing the entire IDE subsystem is not really good anyway,
> because every time it reloads it will rescan the bus... But what about USB?
> Suppose I don't have any IDE or USB devices, but want support so I can use
> them later. Especially in the case of USB, plugability is a must for desktop
> "home" systems.

Setting up a LOOKUP in devfsd will do the trick.  You can run devfsd in
debug mode if you want to know exactly what the kernel tries to look up.

As for what to modularize - I believe the idea is to create modules
for anything that sits unused for long periods of time, and
compile in anything that is used most of the time.  So I
compile in network adapters and drivers for disks that is mounted
all the time.  Sound, isdn, floppy and cdrom is used occationally, and
goes in modules.  Your case might be different.
 
> I also have enabled the "module autoload" feature of DevFS, which
> conveniently autoloads my 3c59x driver. :)
> 
> Does the kernel only autoload modules through userspace request, or can a
> hardware request cause loading? For instance, inserting a USB peripheral
> would cause the USB chipset to signal the OS. So therefore the OS can update
> its device tables and unload the module again when it becomes inactive. This
> goes for all hot-swap devices, IMHO.
> 
I believe it is software requests only.  The hw can notify the os,
_if_ the os has a driver catching the notification.  So you'll probably
need some part of USB loaded or compiled in to catch the notification.
The various devices may the be loaded as the kernel or some userspace
daemon parses the request and ask for the module. 

Or you can skip this and load the device when a program want to open it,
instead of when it is plugged in.  You'll simply get an error
if the device isn't there.


Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
