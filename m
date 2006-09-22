Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWIVWSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWIVWSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWIVWSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:18:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:28571 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965231AbWIVWSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:18:50 -0400
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200609221328.58504.rjw@sisk.pl>
References: <200609202120.58082.rjw@sisk.pl>
	 <1158886913.15894.31.camel@nigel.suspend2.net>
	 <20060922052324.GG2357@elf.ucw.cz>  <200609221328.58504.rjw@sisk.pl>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 08:18:46 +1000
Message-Id: <1158963526.5106.42.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2006-09-22 at 13:28 +0200, Rafael J. Wysocki wrote:
> On Friday, 22 September 2006 07:23, Pavel Machek wrote:
> > On Fri 2006-09-22 11:01:53, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Wed, 2006-09-20 at 21:20 +0200, Rafael J. Wysocki wrote:
> > > > Hi,
> > > > 
> > > > The following series of patches makes swsusp support swap files.
> > > > 
> > > > For now, it is only possible to suspend to a swap file using the in-kernel
> > > > swsusp and the resume cannot be initiated from an initrd.
> > > 
> > > I'm trying to understand 'resume cannot be initiated from an initrd'.
> > > Does that mean if you want to use this functionality, you have to have
> > > everything needed compiled in to the kernel, and it's not compatible
> > > with LVM and so on?
> > 
> > Not in this version of patch; for resume from initrd, ioctl()
> > interface needs to be added (*).
> 
> Yup.  This is not technically impossible, but the patches don't add an
> interface needed for this purpose.
> 
> Initially I thought of a sysfs-based one, but it didn't seem to be a good
> solution.  I'm going to add an ioctl() to /dev/snapshot that will allow us
> to set the "resume offset" from an application.
> problem I not
> > 									Pavel
> > (*) Actually.. of course resume from file from initrd is possible
> > *now*, probably without this patch series, but that would be bmap and
> > doing it by hand from userland.
> 
> Well, not from a swap file.  To use a swap file for suspending we need a
> kernel to tell us which page "slots" are available to us (otherwise we could
> overwrite some swapped-out pages).
> 
> We could use a regular (non-swap) file like this but that would require us to
> use some dangerous code (ie. one that writes directly to blocks belonging to
> certain file bypassing the filesystem).  IMHO this isn't worth it, provided
> the kernel's swap-handling code can do this for us and is known to work. ;-)

It's not that dangerous once you debug it. This is what Suspend2 does -
all I/O is done using bmapping and bios with direct sector numbers,
regardless of where you're reading from/writing to. The main difficulty
I saw was with XFS, where the device block size and filesystem block
size can differ, but even then, it's just a matter of making sure you
get the right one in the right place.

I would encourage you in this direction because it also adds way more
flexibility. If swap is a thing of the past, the only reason for people
to have swap space now is to suspend to disk. If you can write to a swap
file, they don't need a swap partition and more. If you can write to an
ordinary file, they can know that even if they are in a low memory
situation and swap is being used, there's no race condition between
freeing up memory to meet the conditions for suspending to disk, and
allocating storage for writing the actual image.

Regards,

Nigel

