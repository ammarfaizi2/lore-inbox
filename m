Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262972AbTCWIjA>; Sun, 23 Mar 2003 03:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTCWIjA>; Sun, 23 Mar 2003 03:39:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:23308 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262972AbTCWIi6>; Sun, 23 Mar 2003 03:38:58 -0500
Date: Sun, 23 Mar 2003 08:50:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] alternative dev patch
Message-ID: <20030323085000.B6788@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Roman Zippel <zippel@linux-m68k.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	akpm@digeo.com
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030321012455.GB10298@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030321012455.GB10298@kroah.com>; from greg@kroah.com on Thu, Mar 20, 2003 at 05:24:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 05:24:55PM -0800, Greg KH wrote:
> On Fri, Mar 21, 2003 at 12:03:57AM +0100, Roman Zippel wrote:
> > I'm unsure how your code will scale. It depends on how that code will be 
> > used. If drivers register a lot of devices, your lookup function has to 
> > scan a possibly very long list of minor devices and that function is 
> > difficult to optimize.
> 
> And then we grab the BKL :(

You're thinking the wrnog way around.  Locking reduction / splitting is
trivial, getting the algorithms right is the hard part.  Getting rid
of BKL in chardev open is a matter of simple search and replace and I expect
it to happen before 2.6.

> There are a number of char drivers that have "regions".  The tty layer
> support them, and the usb core supports them as two examples.  I'm sure
> there are others.  Personally, I like the symmetry with the block device
> function the way Andries did it.

No, Andries did not do it symmetric to the block devices.

> > Even for block devices blk_register_region() is not the preferred 
> > interface, you should use alloc_disk/add_disk instead. This will make it 
> > easier to assign dynamic device numbers later.
> 
> True, but dynamic device numbers can be built on top of the *_region()
> calls as it is today.  Anyway, dynamic numbers are for 2.7 :)

Dynamic numbers are there today and have been for ages.

> No, I don't see /proc/misc going away due to the driver model,

I do see it going away.  Dito for /proc/devices.  They already are
inaccurate for those midlevel drivers that partition their major number
themselves and having the ranges properly exported like it's already
done for block devices is the proper replacement.  Yes, this breaks
userspace and we'll have to live with it.

