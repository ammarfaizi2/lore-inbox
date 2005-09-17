Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVIQAst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVIQAst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVIQAst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:48:49 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:28619 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750793AbVIQAss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:48:48 -0400
Date: Sat, 17 Sep 2005 01:48:27 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Greg KH <gregkh@suse.de>
Cc: dtor_core@ameritech.net, Vojtech Pavlik <vojtech@suse.cz>,
       Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
In-Reply-To: <20050916215054.GC13920@suse.de>
Message-ID: <Pine.LNX.4.58.0509170146170.18018@skynet>
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org>
 <200509152023.44003.dtor_core@ameritech.net> <20050916080237.GD10007@midnight.suse.cz>
 <d120d50005091608447d816585@mail.gmail.com> <20050916215054.GC13920@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nah, that's a mess.  I think the proposal I had would work for both
> input and block with a minimum of disruption.  Still don't know about
> video though, David said he would take some time this weekend to get me
> some feedback, which is good, as I have to get on a 14 hour plane ride
> soon...
>

Okay from my hazy memories at KS and previous attempts at implementing
this (Patrick might be able to find the piece of paper with the pretty
pictures :-):

For video we need to be able to bind a number of sub-drivers to a toplevel
driver but have them participate in the whole driver architecture
correctly.

I think we need to end up with something like:
	/sys/class/video_adapter
		- /radeon0
			/radeondrm0
			/radeonfb0
			/radeonsomethingIhaventthoughtabout0
		- /radeon1
			/radeondrm1
			/radeonfb1
			/radeonsomethingIhaven'tthoughtabout1
		- /mga0
			/mgadrm0
			/mgafb0
			/mgasomethingIhaventthoughtabout0

The lowlevel driver will be responsible for PCI handling for the card and
will have the list of PCI IDs to bind to, the higher level drivers need to
be dynamically inserted/removed and should be able to have instances of
themselves appear/disappear with hotplugging of the adapters.

My previous attempts at this led me to try to use a bus driver at the
radeon0 level and have my subdrivers appear on the "radeon" bus, also some
work done by Alan Cox on a vga class driver went the same direction, but
this got very unwieldly when I started to actually try and get it working.

To get the above scheme, something like a) start machine with one radeon
adapter, insert radeon_lowlevel module, it brings up
/sys/class/video_adapter/radeon0, insert radeondrm and radeonfb module
above it and you get the radeondrm0 and radeonfb0 subdrivers.
b) hotplug a second radeon, radeon1 appears with drm and fb drivers bound
to it as
well.
c) hotplug mga card, load the subdrivers and have it appear.

Hopefully there is enough info here to figure out if we can fit into your
propsed scheme, there may be an extra level in the sysfs hierarchy above
I'm not really sure, I'm not sure if it would end up as
/sys/class/video_adapter/video0/radeon0/radeondrm0 or
/sys/class/video_adapter/radeon/radeon0/radeondrm0

This is quite different that /sys/class/graphics stuff, it is more for the
lowlevel card drivers than the highlevel interfaces.

Regards,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

