Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbTCJKrm>; Mon, 10 Mar 2003 05:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbTCJKrm>; Mon, 10 Mar 2003 05:47:42 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:58897 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261282AbTCJKrl>; Mon, 10 Mar 2003 05:47:41 -0500
Date: Mon, 10 Mar 2003 11:58:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries Brouwer <aebr@win.tue.nl>
cc: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
In-Reply-To: <20030309230824.GA3842@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0303101100250.5042-100000@serv>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl>
 <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org>
 <20030309203144.GA3814@win.tue.nl> <Pine.LNX.4.44.0303092310470.32518-100000@serv>
 <20030309230824.GA3842@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Mar 2003, Andries Brouwer wrote:

> > My main question here is whether that code hurts in any way? Does it 
> > prevent other cleanups? Sure this code needs more work to be really 
> > useful, but as long as it only wastes a bit of space, I'd prefer to keep 
> > it.
> 
> Yes, dead code always hurts.

It's not really dead code, it's not yet used code and if it stays there as 
a reminder to actually do something about it, it's good that it hurts.

>  
> -       error = register_chrdev(driver->major, driver->name, &tty_fops);
> +       error = register_chrdev_region(driver->major, driver->minor_start,
> +                                      driver->num, driver->name, &tty_fops);

Are that much parameters really needed?
When I look through the character device list, I basically see two usages.
1. A character device is mapped to n device numbers (where n is <= 8). In 
this case it should be enough to register a really available character 
device with a single device number. More can be configured e.g. through a 
sysfs interface. Currently we have here misc devices users, which is 
running out of number space and the other users which are often wasting a 
complete major number for a few devices.
2. A large number of dynamic virtual devices (e.g. terminals), these want 
a complete major anyway and currently they have to register multiple of 
them.
These are the two cases a new character device core should be able to 
handle. On top of this we can still think about a small compatibility 
layer.

bye, Roman


