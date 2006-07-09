Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWGIQX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWGIQX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 12:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWGIQX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 12:23:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:36244 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751311AbWGIQX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 12:23:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XbnA7rEUkVeaOS9XJYE27NWiLiKg59OEFuwNw9zRlnp4JAtoDx/qWZhdaaGV1tCEJIjk8mMFpgBYQ0eP0FUSfTG2l97REFmzLzqyXjLFsscMZETJqEdiOhvMAtijmElhxv0/VoDkSsiUprimeKwZAFuML8y/Nf0tpyMT07f9HFk=
Message-ID: <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
Date: Sun, 9 Jul 2006 12:23:25 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Opinions on removing /proc/tty?
Cc: "Greg KH" <greg@kroah.com>, rmk+lkml@arm.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, efault@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/9/06, Albert Cahalan <acahalan@gmail.com> wrote:
> > Jon Smirl writes:
> > > On 7/8/06, Mike Galbraith <efault@gmx.de> wrote:
> > >> On Fri, 2006-07-07 at 22:56 -0400, Jon Smirl wrote:

> > >>> Does anyone have a problem with deleting /proc/tty if
> > >>> ldisc enum support is added to sysfs?
> > >>
> > >> ps uses /proc/tty/drivers, so some coordination would be needed.
> > >
> > > Greg, I just looked at the source for ps and it has a bunch
> > > of fixed code for turning major/minor into /dev/name.  Isn't
> > > that something udevinfo should be doing? But looking at the
> > > help for udevinfo I don't see any way to turn a major/minor
> > > into /dev/name. The altermative seems to be search /dev
> > > looking for the right device node.
> >
> > By far, the best thing for procps (ps, top, etc.) would
> > be /proc/*/tty links. Code that, give everybody a year
> > to upgrade, and then... maybe.
> >
> > There is no way I'm going to have the procps run a "udevinfo"
> > program, and I very much dislike relying on oddball libraries.
> > Reliability and performance matter; this isn't some GNOME/KDE
> > thing that can break just because 1 of 200 libraries changed.
> >
> > In order, the procps code tries:
> >
> > 1. /proc/*/tty symlink (effectively commented out)
> Doesn't existing the the current kernel.

Sure. It was planned, and there once was a half-written patch.
Right now, procps looks for Linux 2.7.0 before even trying.
(at the time, it was looking like the feature wouldn't make it
into the 2.6.xx series and that 2.7.xx would exist)

> > 2. /proc/tty/drivers
> This info can be wrong due to udev renames.  For example tty1 vs tty/1
> The info in /proc/tty/drivers describes hardware not processes, it
> belongs in sysfs, not /proc.

The only cost is a wasted stat() call to verify the name.
IMHO, using non-standard names is stupid anyway. The people
who do this are probably quite rare. As long as you stick to
the standard device names or devfs, this method is very fast.

(all of these methods will stat() the file to verify it)

> > 3. /proc/*/fd/2 symlink
> Working in the current kernel
>
> > 4. hard-coded guess
> This will be wrong because of udev renames. For example tty1 vs tty/1

That would be fucked up. You need a /dev/tty device.
You need that device even on non-Linux systems.
Also, your abbreviated tty names would start with "/", making
many tools interpret them as absolute paths.

See? Lots of badness happens if you mess with device names.

> > 5. /proc/*/fd/255 symlink
> Working in the current kernel
>
> > 6. "?"
> Always good
>
> > Long ago, procps would search /dev for the mapping. This was
> > too slow to be done directly when ps ran, so a binary file in
> > /etc was used to cache the data. Keeping that file updated
> > was a major problem.
>
> This is what udev does, it maintains the mapping between devices and
> names. Udevinfo is how you query the database. /etc/udev is where you
> control how the device numbers are mapped into names.

You'd just better not choose screwball names.

> Now we have a good example of the impact of pushing something (udev)
> into user space and not shipping the binary as part of the kernel
> tree. What is the API for converting a device node number to a name?

I suggest using devfs.  :-)  The /proc/tty/drivers names
are correct on devfs systems.

We have a Documentation/devices.txt file in the kernel source.
Nearly all of the time, this alone should do the job.

Note that procps needs to handle a tty that udev doesn't
know about, even on a system running udev. It's best to
have everything in /dev with devices.txt names, but somebody
might create a chroot environment somewhere else.
Only the symlinks in /proc can provide this.

In any case, I'm NOT running a udevinfo program or linking
to a screwball library. Random failures are not OK.
