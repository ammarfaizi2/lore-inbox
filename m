Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263547AbTCUI56>; Fri, 21 Mar 2003 03:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263556AbTCUI56>; Fri, 21 Mar 2003 03:57:58 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:35602 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263547AbTCUI55>; Fri, 21 Mar 2003 03:57:57 -0500
Date: Fri, 21 Mar 2003 10:08:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>, <akpm@digeo.com>
Subject: Re: [PATCH] alternative dev patch
In-Reply-To: <20030321012455.GB10298@kroah.com>
Message-ID: <Pine.LNX.4.44.0303210936590.5042-100000@serv>
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030321012455.GB10298@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Mar 2003, Greg KH wrote:

> On Fri, Mar 21, 2003 at 12:03:57AM +0100, Roman Zippel wrote:
> > I'm unsure how your code will scale. It depends on how that code will be 
> > used. If drivers register a lot of devices, your lookup function has to 
> > scan a possibly very long list of minor devices and that function is 
> > difficult to optimize.
> 
> And then we grab the BKL :(

This is currently required for either implementation and needs to be moved 
to the driver.

> Hint, optimizing the open() path for char devices is not anything we
> will probably be doing in 2.6, due to the BKL usage there.  It's also
> not anything anyone has seen on any known benchmarks as a point of
> contention, so I would not really worry about this for now.

The BKL also shouldn't be a reason to make it unnecessary expensive? I 
don't understand your argument.

> > char devices don't have partitions, so you hardly need regions. The 
> > problem with the tty layer is that the console and the serial devices 
> > should have different majors.
> 
> There are a number of char drivers that have "regions".  The tty layer
> support them, and the usb core supports them as two examples.  I'm sure
> there are others.  Personally, I like the symmetry with the block device
> function the way Andries did it.

Every single call to usb_register_dev in 2.5.65 uses exactly 1 minor 
number. Block device drivers need regions because they have partitions 
and we need to find out which device a partition belongs to. Where have 
character devices such requirements?

> > See the misc device example. It doesn't have a table, but the list is now 
> > only needed to generate /proc/misc. As soon as character devices are 
> > better integrated into the driver model, even this list is not needed 
> > anymore. This means for simple character devices, we can easily add a 
> > alloc_chardev/add_chardev interface similiar to block devices.
> 
> No, I don't see /proc/misc going away due to the driver model, I imagine
> there are too many users of it to disappear.  Also, the driver model
> doesn't care a thing about major/minor numbers so I don't understand how
> you think it can help in this situation.

I didn't mean that /proc/misc goes away, I meant the misc_list in misc.c. 
They could be other ways to generate /proc/misc.
/proc/devices, /proc/misc, /proc/tty/drivers, ... is currently mostly 
needed to generate device nodes for dynamic device numbers. This badly 
needs a more generic mechanism.

bye, Roman

