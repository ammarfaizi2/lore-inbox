Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUFWXM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUFWXM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUFWXM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:12:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:15787 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263540AbUFWXMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:12:54 -0400
Date: Wed, 23 Jun 2004 15:03:03 -0700
From: Greg KH <greg@kroah.com>
To: Jeremy Katz <jeremy.katz@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, katzj@redhat.com
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Message-ID: <20040623220303.GD6548@kroah.com>
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org> <cb5afee1040620125272ab9f06@mail.gmail.com> <20040621060435.GA28384@kroah.com> <cb5afee10406210914451dc6@mail.gmail.com> <cb5afee10406231415293e90c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5afee10406231415293e90c0@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 05:15:54PM -0400, Jeremy Katz wrote:
> For example, /sys/bus/ide/devices/* and then symlinks forever... lots
> of readdir, readlink, etc makes probing far slower and more complex
> than the simple /proc/ide/ide?/*/ that could be used before.

Yes, ide never got completly moved over to sysfs like scsi did.  We
never had the time to do this work, sorry.

But now your parsing should be easier with the one-value to one-file
rule, right?  And libsysfs should help out here with all of the symlinks
and readdir, etc calls.

> > > Also, things in sysfs aren't exactly stable enough to count on as a
> > > dependable interface, but that's something the kernel has never
> > > reliably exported to userspace.
> >
> > Why isn't sysfs stable enough?  You can find any driver instantly.  And
> > any device bound to that driver in a stable and repeatable manner.
> 
> Again, not sysfs itself.  How information is exported via sysfs.  I'm
> not saying that things exported via /proc are always the picture of
> stability here (cf the recent change from /proc/scsi/usb-storage-$host
> to /proc/scsi/usb-storage/$host), but at the same time, things in
> /proc have tended to settle down in the general case.  This just isn't
> true yet with sysfs and is only the sort of thing that can happen with
> time.
> 
> There are also other things; I guess consistency is a better word. 
> People like to say use /sys/block to show block devices, but that
> shows a lot of "useless" block devices from the point of view of
> trying to show disks.

But all of those devices are block devices.  You want a hardware
picture, right?  sysfs never said it would show you just that, but it
makes it easier to determine.

For this specific instance, just look for block devices that have a
device symlink that points to a real device.

> > So, give me specific examples, or stop ranting for no reason.
> 
> And to be more constructive (after a discussion with Jeff this
> afternoon which is when I realized the reply didn't go out), what
> would be _very_ useful to have from a "probing disks" perspective
> would be a way to enumerate easily and simply from within sysfs the
> disks that are associated with a specific controller.

Hm, I think libsysfs can give you this, if you ask for the block devices
that are associated with each individual device associated with a
driver.

The whole "what driver controls what devices" is not a simple one to one
mapping all the time, with drivers that work on multiple types of
busses, and drivers that control devices that contain multiple class
devices, etc.  It's not a simple thing to solve, sorry.

But what you can use is the MODULE_DEVICE_TABLE() information in the
modules to try to help you out here.  That details a mapping of what
kind of devices that specific driver supports.

> Note: this should not mean that we then go and remove currently
> existing stuff in /proc.  Deprecate it and then it can go away in time
> as people switch.  Having to have a flag day is very painful.  It's
> far easier to deprecate in one stable series with a new interface
> available and then start removing the old ones as things start to
> switch over.  If it really is an improvement, then getting people to
> change won't be difficult.

I agree, I don't think that many things have disappeared from /proc just
yet, right?  You should just have more information than what you
previously did, right?  Or did scsi drop their /proc support fully?

thanks,

greg k-h
