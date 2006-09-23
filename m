Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWIWWQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWIWWQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWIWWQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:16:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:20164 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750807AbWIWWQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:16:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
Date: Sun, 24 Sep 2006 00:18:46 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609202120.58082.rjw@sisk.pl> <200609221328.58504.rjw@sisk.pl> <1158963526.5106.42.camel@nigel.suspend2.net>
In-Reply-To: <1158963526.5106.42.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609240018.47017.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 23 September 2006 00:18, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2006-09-22 at 13:28 +0200, Rafael J. Wysocki wrote:
> > On Friday, 22 September 2006 07:23, Pavel Machek wrote:
> > > On Fri 2006-09-22 11:01:53, Nigel Cunningham wrote:
> > > > Hi.
> > > > 
> > > > On Wed, 2006-09-20 at 21:20 +0200, Rafael J. Wysocki wrote:
> > > > > Hi,
> > > > > 
> > > > > The following series of patches makes swsusp support swap files.
> > > > > 
> > > > > For now, it is only possible to suspend to a swap file using the in-kernel
> > > > > swsusp and the resume cannot be initiated from an initrd.
> > > > 
> > > > I'm trying to understand 'resume cannot be initiated from an initrd'.
> > > > Does that mean if you want to use this functionality, you have to have
> > > > everything needed compiled in to the kernel, and it's not compatible
> > > > with LVM and so on?
> > > 
> > > Not in this version of patch; for resume from initrd, ioctl()
> > > interface needs to be added (*).
> > 
> > Yup.  This is not technically impossible, but the patches don't add an
> > interface needed for this purpose.
> > 
> > Initially I thought of a sysfs-based one, but it didn't seem to be a good
> > solution.  I'm going to add an ioctl() to /dev/snapshot that will allow us
> > to set the "resume offset" from an application.
> > problem I not
> > > 									Pavel
> > > (*) Actually.. of course resume from file from initrd is possible
> > > *now*, probably without this patch series, but that would be bmap and
> > > doing it by hand from userland.
> > 
> > Well, not from a swap file.  To use a swap file for suspending we need a
> > kernel to tell us which page "slots" are available to us (otherwise we could
> > overwrite some swapped-out pages).
> > 
> > We could use a regular (non-swap) file like this but that would require us to
> > use some dangerous code (ie. one that writes directly to blocks belonging to
> > certain file bypassing the filesystem).  IMHO this isn't worth it, provided
> > the kernel's swap-handling code can do this for us and is known to work. ;-)
> 
> It's not that dangerous once you debug it.

Certainly.  Still, let me repeat: if there is some code that does pretty much
the same and has _already_ been debugged, I prefer using it to writing some
new code, debugging it etc.

> This is what Suspend2 does - 
> all I/O is done using bmapping and bios with direct sector numbers,
> regardless of where you're reading from/writing to. The main difficulty
> I saw was with XFS, where the device block size and filesystem block
> size can differ, but even then, it's just a matter of making sure you
> get the right one in the right place.
> 
> I would encourage you in this direction because it also adds way more
> flexibility. If swap is a thing of the past, the only reason for people
> to have swap space now is to suspend to disk. If you can write to a swap
> file, they don't need a swap partition and more.

Obviously.  That's what the patches are for. :-)

> If you can write to an 
> ordinary file, they can know that even if they are in a low memory
> situation and swap is being used, there's no race condition between
> freeing up memory to meet the conditions for suspending to disk, and
> allocating storage for writing the actual image.

Well, I wouldn't call that a race condition.

By using an ordinary file to save the suspend image, you effectively divide
the whole storage needed for suspending in two independent parts.  Still
the sum of these two parts has to be sufficient to save the total amount of
data that cannot be discarded residing in memory before the suspend.  IMO
it doesn't really matter if this storage is divided or not, because to total
size of it has to be sufficient regardless.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
