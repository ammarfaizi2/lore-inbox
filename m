Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUBKTTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUBKTTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:19:44 -0500
Received: from h-66-166-159-6.STTNWAHO.covad.net ([66.166.159.6]:43480 "EHLO
	pooka.dleonard.net") by vger.kernel.org with ESMTP id S266150AbUBKTTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:19:37 -0500
Date: Wed, 11 Feb 2004 11:19:29 -0800 (PST)
From: dleonard@dleonard.net
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
cc: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: devfs vs udev, thoughts from a devfs user
In-Reply-To: <20040211123352.GA32657@ti19.telemetry-investments.com>
Message-ID: <Pine.LNX.4.44.0402111114270.3555-100000@pooka.dleonard.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For mount 2.12 /etc/mtab doesn't get updated correctly but umount is at least smart (or dumb) enough not to do the wrong thing.

r:dryad:/tmp# mkdir /tmp/a /tmp/b
r:dryad:/tmp# mount -t ramfs none /tmp/a
r:dryad:/tmp# touch /tmp/a/foo
r:dryad:/tmp# mount --move /tmp/a /tmp/b
r:dryad:/tmp# ls /tmp/b
foo

r:dryad:/tmp# cat /etc/mtab
/dev/hda2 / ext3 rw,errors=remount-ro 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
/dev/hda5 /usr ext3 rw 0 0
/dev/hda6 /home ext3 rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
none /tmp/a ramfs rw 0 0
/tmp/a /tmp/b none rw 0 0

r:dryad:/tmp# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda5 /usr ext3 rw 0 0
/dev/hda6 /home ext3 rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
none /tmp/b ramfs rw 0 0

r:dryad:/tmp# umount /tmp/a
umount: none: not found
umount: /tmp/a: not mounted
umount: none: not found
umount: /tmp/a: not mounted
r:dryad:/tmp# ls /tmp/b
foo

This problem *does* occur exactly as Greg says with mount 2.11n (debian) though.

-- 

<Douglas Leonard>
<dleonard@dleonard.net>

On Wed, 11 Feb 2004, Bill Rugolsky Jr. wrote:

> On Wed, Feb 11, 2004 at 07:50:49AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Tue, Feb 10, 2004 at 05:16:00PM -0800, Greg KH wrote:
> > > Doesn't work for what we want here:
> > >
> > > 	$ mkdir /tmp/a /tmp/b
> > > 	$ mount -t ramfs none /tmp/a
> > > 	$ touch /tmp/a/foo
> > > 	$ mount --move /tmp/a /tmp/b
> > > 	$ ls /tmp/b
> > > 	foo
> > > 	$ umount /tmp/a
> > > 	$ ls /tmp/b
> > > 	$
> > >
> > > Hm, not nice :(
> >
> > Huh?  Is that a bug report or just your guess at what would happen if you
> > tried the above?
> >
> > If it _does_ happen - we have a problem and I'd like to know which versions
> > have such bug.
>
> Ugh, /etc/mtab really ought to die.
>
> Anyway, with traditional /etc/mtab, mount --move produces:
>
>    none on /tmp/a type ramfs (rw)
>    /tmp/a on /tmp/b type none (rw)
>
> ln -sf /proc/self/mounts /etc/mtab and retry, it works fine:
>
>    none on /tmp/b type ramfs (rw)
>
> I'll have a look at mount later today, if nobody else gets there first.
>
> 	-Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

