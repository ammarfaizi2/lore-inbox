Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVIQAUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVIQAUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVIQAUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:20:36 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:15212 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750782AbVIQAUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:20:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WdZLs3lSWYsFWLenY8ShpVmH6Ss7MemB6sPr+JqJdWX5exZy2uEwx/mdzv/4hE4o/bDH/yvNtL5Be9D6suwlyfZgesJR+wbR6I0M37BhRueP81NO0/mEAdfWfnL6pA+1mYY45NOdk1LCK+XLGQnHVc8elGh01PuryboDj3mnBOk=
Message-ID: <432B614A.4000705@gmail.com>
Date: Sat, 17 Sep 2005 08:20:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
References: <20050916002036.GA6149@suse.de>
In-Reply-To: <20050916002036.GA6149@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> 
> But, what about video devices?  David and Pat, we talked about this at
> OLS, but Pat kept the paper we drew on, and the beer we were drinking at
> the time has made my memory a bit fuzzy as to all of your requirements
> for the video subsystem.  I remember things about frame buffers and
> monitors and other things like that, but nothing specific, sorry.  Could
> you outline your needs and I'll see if this proposed structure would
> solve your issues?
> 

I'm still not very familiar with sysfs, but this is a possible simplistic
view for the graphics class:

	/sys/class/graphics/
	|-- fb0
	|   |-- framebuffer0
	|   `-- display0
	|-- fb1
	|   |-- framebuffer1
	|   |-- display1
	|   '-- display2
	|-- fb2
	|   |-- framebuffer2 
 	|   '-- display3
	'-- fb3
	    |-- framebuffer3
	    '-- display3 

graphics is the class
fb0, fb1, etc is the class_device
framebuffer and display are subclasses?

- fb0 is a simple device, one framebuffer attached to one display
- fb1 is one framebuffer with 2 displays (mirrored)
- perhaps, fb2 and fb3 are multi-head, different framebuffers, different displays
  but same device

display does not have a driver as they are created by the framebuffer themselves,
is that okay?

How about backlight/lcd drivers? They can stand on their own, but if a framebuffer
driver is loaded, a backlight/lcd driver can be bound to fb.

How about i2c?  Under display?

Offtopic:

Main limitation of sysfs concerning video devices is that the one value,
one attribute may not be appropriate. For example, setting xres and yres also
necessitates simultaneous changes in other attributes of the display (pixelclock,
margins, etc). Jon Smirl somewhat made it work by making mode attribute a string
and accept only modes that are present in the driver's private mode database.
Custom timings are not accepted unless the user updates the private mode database
of the driver (has to use an ioctl to do that).

Similarly, pixelformats are problematic.  Again, Jon Smirl made this work somehow
by accepting strings. Custom pixelformats are again problematic, and one has
to use the ioctl to set that.

Tony
