Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVCUVom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVCUVom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVCUVnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:43:14 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:39566 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261959AbVCUVhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:37:08 -0500
Subject: Re: Suspend-to-disk woes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Stefan Seyfried <seife@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mgarrett@chiark.greenend.org.uk
In-Reply-To: <423E94FF.9000603@suse.de>
References: <423B01A3.8090501@gmail.com>
	 <20050319132612.GA1504@openzaurus.ucw.cz>
	 <200503191220.35207.rmiller@duskglow.com>
	 <20050319212922.GA1835@elf.ucw.cz> <20050319212922.GA1835@elf.ucw.cz>
	 <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
	 <E1DDAcH-0002n5-00@chiark.greenend.org.uk>
	 <1111384766.9720.144.camel@desktop.cunningham.myip.net.au>
	 <423E94FF.9000603@suse.de>
Content-Type: text/plain
Message-Id: <1111441138.14853.26.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 22 Mar 2005 08:38:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-03-21 at 20:33, Stefan Seyfried wrote:
> Hi,
> 
> Nigel Cunningham wrote:
> 
> > On Mon, 2005-03-21 at 11:17, Matthew Garrett wrote:
> 
> >> It's trivial to do this in userspace - just have an app in initramfs
> 
> > It's not that trivial.
> 
> > - Your image might not be stored in a swap partition. For Suspend2, it
> > can potentially in a swap file or (soon) an ordinary file;
> > - Finding which partition to look in for the signature might be non
> > trivial (labels in fstab). You'd want to hard code it or (perferably)
> > copy a config file from the root (or other) partition;
> > - Having addressed the above issues, you still need to add code to read
> > the swap header, parse it to find the header, read the header from the
> > image, parse it and obtain the kernel version of the saved image.
> 
> Well, and you want to compile all this into the kernel? Just to hold the
> hands of users who have not read the fine manual?

Most of it is in there anyway - the kernel code needs to check the image
exists and read the header irrespective of whether it does sanity
checking. In Suspend2, this code is also used for other error conditions
that can stop you being able to resume (failure to load the right
modules in an initrd, failure at accessing the device where the image
should be found etc).

> And you'd need to compile this into all kernels, especially those that
> _don't_ support suspend to disk. Or you are back at the place where the
> thread started.

Yes. The real solution is for all kernels on a system to either support
suspend to disk or not support it. Half measures are what cause the
problem.

> > If your image is not stored in a swap partition, you probably can't
> > mount the fs the image is stored on, because doing so will replay the
> > image and make resuming unsafe, so this approach is less trivial without
> > knowing exactly which disk blocks and device IDs to use (and using dd to
> > access them).
> 
> GRUB reads kernel and initramfs from a dirty reiserfs partition on
> resume (although this is a bad idea if you want a fast resume, but
> that's another problem). It is possible.

Mmm. I know it's all possible, but I'm pointing out the issues that make
it not "trivial", which was the original claim.

> > On top of these, we have two implementations, so you'll want to check
> > for the signatures of both.
> 
> This is the final argument for doing it in userspace :-).

How so? You then have to maintain two codebases for doing all this
reading and parsing.

> > That said, I am considering making something like what you're saying:
> > exposing methods of testing whether an image exists and an entry through
> > which you can get Suspend to erase an image via a proc (eventually
> > sysfs) entry. This will allow something like what you're saying to be
> > controlled from userspace.
> 
> It does not help if the next kernel i boot is not suspend2 patched. This
> work should rather go into a library that exports this functions to
> userspace programs, for all known suspend implementations.

So don't use kernels that aren't suspend2 patched :>

If someone said "I want to boot a kernel that doesn't have support for
ext3 but my rootfs is ext3", would we say "Well then, write a userspace
ext3 driver"? Not exactly the same, I know, but I think the point
stands. We'd say "Don't be silly. Put in the support you need."

The real solution to this mess is to get distros compiling in support
for suspend-to-disk by default. I realise that hasn't been attractive.
Hopefully it will change real-soon-now.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

