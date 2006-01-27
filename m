Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWA0S7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWA0S7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWA0S7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:59:01 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11236
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932218AbWA0S7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:59:00 -0500
Date: Fri, 27 Jan 2006 10:58:32 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Vasil Kolev <vasil@ludost.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com,
       linux-ide@vger.kernel.org
Subject: Re: kobject_register failed for Promise_Old_IDE (-17)
Message-ID: <20060127185832.GB31555@kroah.com>
References: <1138093728.5828.8.camel@lyra.home.ludost.net> <20060124223527.GA26337@kroah.com> <58cb370e0601241458y6cdf702ey9caa261702a7948a@mail.gmail.com> <1138175680.5857.4.camel@lyra.home.ludost.net> <20060126230152.GP3668@stusta.de> <20060126232140.GA15742@kroah.com> <20060126234830.GQ3668@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126234830.GQ3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 12:48:30AM +0100, Adrian Bunk wrote:
> On Thu, Jan 26, 2006 at 03:21:40PM -0800, Greg KH wrote:
> > On Fri, Jan 27, 2006 at 12:01:52AM +0100, Adrian Bunk wrote:
> > > On Wed, Jan 25, 2006 at 09:54:40AM +0200, Vasil Kolev wrote:
> > > > ?? ????, 2006-01-24 ?? 23:58 +0100, Bartlomiej Zolnierkiewicz ????????????:
> > > > > On 1/24/06, Greg KH <greg@kroah.com> wrote:
> > > > > > On Tue, Jan 24, 2006 at 11:08:47AM +0200, Vasil Kolev wrote:
> > > > > > > Hello,
> > > > > > > I have a machine that's currently running 2.4.28 with the promise_old
> > > > > > > driver, which runs ok. I tried upgrading it last night to 2.6.15, and
> > > > > > > the following error occured, and no drives were detected/made available:
> > > > > > >
> > > > > > >  [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
> > > > > > >  [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
> > > > > > >  [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x40
> > > > > > >  [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
> > > > > > >  [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
> > > > > > >  [17179598.940000]  [__pci_register_driver+125/132] __pci_register_driver+0x7d/0x84
> > > > > > >  [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_register_driver+0x13/0x35
> > > > > > >  [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12/0x16 [pdc202xx_old]
> > > > > > >  [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x1ae
> > > > > > >  [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb
> > > > > >
> > > > > > This means that some other driver tried to register with the same exact
> > > > > > name for the same bus.  As it looks like this is the ide bus, I suggest
> > > > > > asking on the linux ide mailing list.
> > > > > 
> > > > 
> > > > Well, now I remember that in /sys in the proper place there were two
> > > > directories called Promise_Old_IDE, maybe the driver tried to register
> > > > twice?
> > > >...
> > > 
> > > Greg, IIRC, weren't there plans to turn this case into a BUG()?
> > 
> > No, we dump the stack trace so that people can see what is happening,
> > but if the caller has done their error handling correctly, the kernel
> > will not crash.
> > 
> > I don't like adding BUG() calls for stuff that it should not be needed
> > for (like this.)
> 
> 
> Yes, this was my thinko (-17 is -EEXIST).
> 
> 
> The interesting question is why he sees two directories although the 
> second register failed.
> 
> 
> I'm not sure whether I understand the problem and the code correctly, 
> but perhaps the problem is something like the following:
> 
> 
> In fs/sysfs/dir.c:create_dir(), sysfs_make_dirent() was already called 
> when sysfs_create() fails.
> 
> In the (error == -EEXIST) case, we therefore need to call 
> sysfs_remove_dir().

Hm, yeah, by using my little test module for these things, I can create
two directories in sysfs without the core complaining:
 $ ls /sys/class/gregkh/ -li
 total 0
 4371756 drwxr-xr-x 2 root root 0 Jan 27 10:56 greg1
 4371756 drwxr-xr-x 2 root root 0 Jan 27 10:56 greg1
 4371758 drwxr-xr-x 5 root root 0 Jan 27 10:56 greg2
 4371760 drwxr-xr-x 2 root root 0 Jan 27 10:56 greg3

I'll work on this.  Thanks for pointing it out.

greg k-h
