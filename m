Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSK0IMg>; Wed, 27 Nov 2002 03:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSK0IMg>; Wed, 27 Nov 2002 03:12:36 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:34268 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S261644AbSK0IMf>; Wed, 27 Nov 2002 03:12:35 -0500
Date: Tue, 26 Nov 2002 22:25:11 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Module alias and table support
To: "Adam J. Richter" <adam@freya.yggdrasil.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Message-id: <3DE46547.4080908@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>> = adam
 >>  = greg
 >   = adam

 > [...]
 >>> If we're going to use strings for device ID matching,
 >>> then we can consolidate all of the xxx_device_id types into one:

This is going to end up rewriting every MODULE_DEVICE_TABLE in the
kernel, as well as hotplug and that depmod functionality, before
hotplugging handles module loading again, isn't it?  Somehow I'd
rather not see us change so many things while we're "stabilizing".
("We had to destroy the village in order to save it.")


If you're really talking "strings", with arbitrary whitespace,
I rather like the idea of letting a bunch of key=value lines be
used as an ID.  Easy to pass through hotplug, and it'd be lots
easier to work with from userland than the "numbers and spaces"
syntax of the 2.4 "modules.*map" files.

But the first string I'd like to see would be one composed of
several lines in current "modules.*map" format ... that'd be
good stuff to put back in 2.5.50 and its modutils even on a
temporary basis.


 >>> - No need for user level programs to query devices to generate
 >>> hotplug information (goodbye pcimodules, usbmodules,
 >>> isapnpmodules),
 >
 >>I think these can almost already go away now, with the info we have in
 >>sysfs.

The latest (cvs) hotplug scripts won't try to any of use
those on 2.5 systems, it expects /sys/bus/$type/devices/*/*
to expose all the necessary information (for coldplug, and
for per-interface hotplug).

PCI doesn't, USB does, I don't know about the rest.  Getting
rid of 'usbmodules' was a good thing, mostly because of issues
related to usbfs, but the "coldplug" support does need to get
rewritten now.  (Workaround:  unplug/replug.  After those work
at the sysfs and modutils level, that is.)


 > static int try_every_driver_and_modprobe(struct device *dev, const char *id,
 > 	    				  void *arg)
 > {
 > 	...
 > 		request_module(id); /* or call hotplug or whatever */
 > 	}
 > 	BUG();	/* NOTREACHED */
 > 	return -1;
 > }

Why a BUG?

Hotplug is about more than just loading modules, and I'm not sure
that "try every driver and hotplug" would make sense.

- Dave



