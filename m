Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262749AbTCUBNn>; Thu, 20 Mar 2003 20:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262757AbTCUBNn>; Thu, 20 Mar 2003 20:13:43 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19718 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262749AbTCUBNl>;
	Thu, 20 Mar 2003 20:13:41 -0500
Date: Thu, 20 Mar 2003 17:24:55 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] alternative dev patch
Message-ID: <20030321012455.GB10298@kroah.com>
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202314210.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303202314210.5042-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 12:03:57AM +0100, Roman Zippel wrote:
> I'm unsure how your code will scale. It depends on how that code will be 
> used. If drivers register a lot of devices, your lookup function has to 
> scan a possibly very long list of minor devices and that function is 
> difficult to optimize.

And then we grab the BKL :(

Hint, optimizing the open() path for char devices is not anything we
will probably be doing in 2.6, due to the BKL usage there.  It's also
not anything anyone has seen on any known benchmarks as a point of
contention, so I would not really worry about this for now.

For 2.7, when we want to drop the BKL, then we can worry about this.

> char devices don't have partitions, so you hardly need regions. The 
> problem with the tty layer is that the console and the serial devices 
> should have different majors.

There are a number of char drivers that have "regions".  The tty layer
support them, and the usb core supports them as two examples.  I'm sure
there are others.  Personally, I like the symmetry with the block device
function the way Andries did it.

> Even for block devices blk_register_region() is not the preferred 
> interface, you should use alloc_disk/add_disk instead. This will make it 
> easier to assign dynamic device numbers later.

True, but dynamic device numbers can be built on top of the *_region()
calls as it is today.  Anyway, dynamic numbers are for 2.7 :)

> > I am not sure I understand. Where are these huge tables?
> > And how did you remove them?
> 
> See the misc device example. It doesn't have a table, but the list is now 
> only needed to generate /proc/misc. As soon as character devices are 
> better integrated into the driver model, even this list is not needed 
> anymore. This means for simple character devices, we can easily add a 
> alloc_chardev/add_chardev interface similiar to block devices.

No, I don't see /proc/misc going away due to the driver model, I imagine
there are too many users of it to disappear.  Also, the driver model
doesn't care a thing about major/minor numbers so I don't understand how
you think it can help in this situation.

thanks,

greg k-h





> 
> bye, Roman
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
