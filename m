Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262146AbSIZCjQ>; Wed, 25 Sep 2002 22:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbSIZCjQ>; Wed, 25 Sep 2002 22:39:16 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:30901 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262146AbSIZCjP>; Wed, 25 Sep 2002 22:39:15 -0400
Date: Wed, 25 Sep 2002 19:44:47 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and
 usb
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D92749F.9050504@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020925212955.GA32487@kroah.com> <3D9250CD.7090409@pacbell.net>
 <20020926002554.GB518@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I also found the unload USB module problem.  The driver core was calling
> hotplug after the device was already removed.  Made it a bit difficult
> to be able to describe the device that way :)

On the other hand, since there's no internal "this is an ex-device"
state, that's also insurance that nothing could use "usbfs" to try
to re-activate the device.  I seem to recall oopses going away by
reporting the hotplug "remove" events after the usbfs path could
no longer be used.  Not that I ever liked that consequence, but
a fix adding such a "zombie" state would have taken a bit of time.

The real "module unload problem" has a lot to do with not having any
way to track how many devices a module is bound to ... that aren't
necessarily opened at the moment.  (Does Rusty's patch set touch
any of that?)

Without having a way to answer that question, today's un-helpful
"driver is in active use" refcount would encourage rmmodding drivers
that users will expect to still be available.  Plug in two devices,
look at one, decide to use the other, unplug the first ... and just
because you hadn't yet opened the second device, its driver module
vanishes.  As you start to use it ... huge frustration quotient! :)

- Dave




