Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWAZXse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWAZXse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWAZXse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:48:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45831 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750924AbWAZXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:48:33 -0500
Date: Fri, 27 Jan 2006 00:48:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: Vasil Kolev <vasil@ludost.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com,
       linux-ide@vger.kernel.org
Subject: Re: kobject_register failed for Promise_Old_IDE (-17)
Message-ID: <20060126234830.GQ3668@stusta.de>
References: <1138093728.5828.8.camel@lyra.home.ludost.net> <20060124223527.GA26337@kroah.com> <58cb370e0601241458y6cdf702ey9caa261702a7948a@mail.gmail.com> <1138175680.5857.4.camel@lyra.home.ludost.net> <20060126230152.GP3668@stusta.de> <20060126232140.GA15742@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126232140.GA15742@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 03:21:40PM -0800, Greg KH wrote:
> On Fri, Jan 27, 2006 at 12:01:52AM +0100, Adrian Bunk wrote:
> > On Wed, Jan 25, 2006 at 09:54:40AM +0200, Vasil Kolev wrote:
> > > ?? ????, 2006-01-24 ?? 23:58 +0100, Bartlomiej Zolnierkiewicz ????????????:
> > > > On 1/24/06, Greg KH <greg@kroah.com> wrote:
> > > > > On Tue, Jan 24, 2006 at 11:08:47AM +0200, Vasil Kolev wrote:
> > > > > > Hello,
> > > > > > I have a machine that's currently running 2.4.28 with the promise_old
> > > > > > driver, which runs ok. I tried upgrading it last night to 2.6.15, and
> > > > > > the following error occured, and no drives were detected/made available:
> > > > > >
> > > > > >  [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
> > > > > >  [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
> > > > > >  [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x40
> > > > > >  [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
> > > > > >  [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
> > > > > >  [17179598.940000]  [__pci_register_driver+125/132] __pci_register_driver+0x7d/0x84
> > > > > >  [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_register_driver+0x13/0x35
> > > > > >  [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12/0x16 [pdc202xx_old]
> > > > > >  [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x1ae
> > > > > >  [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb
> > > > >
> > > > > This means that some other driver tried to register with the same exact
> > > > > name for the same bus.  As it looks like this is the ide bus, I suggest
> > > > > asking on the linux ide mailing list.
> > > > 
> > > 
> > > Well, now I remember that in /sys in the proper place there were two
> > > directories called Promise_Old_IDE, maybe the driver tried to register
> > > twice?
> > >...
> > 
> > Greg, IIRC, weren't there plans to turn this case into a BUG()?
> 
> No, we dump the stack trace so that people can see what is happening,
> but if the caller has done their error handling correctly, the kernel
> will not crash.
> 
> I don't like adding BUG() calls for stuff that it should not be needed
> for (like this.)


Yes, this was my thinko (-17 is -EEXIST).


The interesting question is why he sees two directories although the 
second register failed.


I'm not sure whether I understand the problem and the code correctly, 
but perhaps the problem is something like the following:


In fs/sysfs/dir.c:create_dir(), sysfs_make_dirent() was already called 
when sysfs_create() fails.

In the (error == -EEXIST) case, we therefore need to call 
sysfs_remove_dir().


> thanks,
> 
> greg k-h


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

