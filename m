Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262769AbTCVMvN>; Sat, 22 Mar 2003 07:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262770AbTCVMvN>; Sat, 22 Mar 2003 07:51:13 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:22797 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262769AbTCVMvL>; Sat, 22 Mar 2003 07:51:11 -0500
Date: Sat, 22 Mar 2003 14:02:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>, <akpm@digeo.com>
Subject: Re: [PATCH] alternative dev patch
In-Reply-To: <20030322013800.GD18835@kroah.com>
Message-ID: <Pine.LNX.4.44.0303221306350.5042-100000@serv>
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030321012455.GB10298@kroah.com>
 <Pine.LNX.4.44.0303210936590.5042-100000@serv> <20030322013800.GD18835@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Mar 2003, Greg KH wrote:

> > The BKL also shouldn't be a reason to make it unnecessary expensive? I 
> > don't understand your argument.
> 
> I was trying to point out that pre-mature optimiziation of this code
> should not be done before we get rid of the most expensive portion, the
> bkl.  That's all.

Can we at least note, that my patch has a performance advantage?
We can still deal with the BKL later.
I hope we can agree, that we should avoid adding premature new 
interfaces, which can be expensive later?

> So only tty drivers currently do this.  But that might just be because
> it's pretty hard to get a range of minors right now, as the api hasn't
> been present.  Once we expand the range, I bet it will get quite common
> (most character drivers only want from 1-16 minors normally.)

There are a few options:
1. Drivers can implement that themselves:
a) The driver allocates the major itself and opens the real minor device 
in its open function, (e.g. see the misc driver example). Especially tape 
drivers have to do this anyway, because they encoded the open mode in 
higher bits, so regions won't help you here at all.
b) The driver allocates the major itself and installs the file_operations 
directly in the char_device, e.g. that is something you might want to do 
in the usb driver:

register_usb_device(...)
{
	...
	cdev = cdget(dev);
	down(&cdev->sem);
	if (cdev->fops)
		...;
	cdev->fops = fops;
	up(&cdev->sem);
}
(see the misc driver again for a detailed example.)

2. If it should be really needed, we can add simple region support by 
adding a minor_shift argument to the major device, so get_chrfops() would 
first try (major, minor & ((1 << shift) - 1)), before it tries directly 
(major, 0).

So I really don't see why we should support arbitrary regions, since 
currently nobody needs it and if someone should need it in the future, he 
can easily do it himself.

> > /proc/devices, /proc/misc, /proc/tty/drivers, ... is currently mostly 
> > needed to generate device nodes for dynamic device numbers. This badly 
> > needs a more generic mechanism.
> 
> I agree.  But again, 2.7.  Remember our feature freeze?

I agree too and nowhere in my patch did I change something about this.

bye, Roman

