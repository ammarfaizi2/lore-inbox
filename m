Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266698AbUFWVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266698AbUFWVWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUFWVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:20:43 -0400
Received: from mproxy.gmail.com ([216.239.56.241]:39394 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266684AbUFWVQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:16:11 -0400
Message-ID: <cb5afee10406231415293e90c0@mail.gmail.com>
Date: Wed, 23 Jun 2004 17:15:54 -0400
From: Jeremy Katz <jeremy.katz@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       katzj@redhat.com
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
In-Reply-To: <cb5afee10406210914451dc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org> <cb5afee1040620125272ab9f06@mail.gmail.com> <20040621060435.GA28384@kroah.com> <cb5afee10406210914451dc6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I can't use gmail and sent this just to Greg originally...  Greg
-- I've added a little bit more from my original mail

On Sun, 20 Jun 2004 23:04:35 -0700, Greg KH <greg@kroah.com> wrote:
> On Sun, Jun 20, 2004 at 03:52:33PM -0400, Jeremy wrote:
> > > Agreed.  And the old viodasd reason was rejected exactly because it was
> > > such a f***ing mess.
> >
> > The argument could be made that sysfs is similarly a f***ing mess and
> > that instead of solving problems, it creates more.
>
> It does?  Have you brought this up to the sysfs / kobject / driver model
> authors?  I think they would be open to any critiques of the current
> code, especially if such critique contains patches.

My argument isn't around the code... I haven't looked at it enough to
say one way or another.  Although it does seem to duplicate plenty of
things that were available before and then drivers start to drop
random bits that other people depended on being in /proc with the
"well, it should be in sysfs now" argument.  Unfortunately, it wasn't
a clean break and instead it's a very meandering migration.  Which
makes things a bit more difficult to deal with.

> > The mess of symlinks present there is a disaster and disgusting for
> > anyone who wants to actually write clean probing code.
>
> What do you mean by this.  Any examples?

For example, /sys/bus/ide/devices/* and then symlinks forever... lots
of readdir, readlink, etc makes probing far slower and more complex
than the simple /proc/ide/ide?/*/ that could be used before.

> > Also, things in sysfs aren't exactly stable enough to count on as a
> > dependable interface, but that's something the kernel has never
> > reliably exported to userspace.
>
> Why isn't sysfs stable enough?  You can find any driver instantly.  And
> any device bound to that driver in a stable and repeatable manner.

Again, not sysfs itself.  How information is exported via sysfs.  I'm
not saying that things exported via /proc are always the picture of
stability here (cf the recent change from /proc/scsi/usb-storage-$host
to /proc/scsi/usb-storage/$host), but at the same time, things in
/proc have tended to settle down in the general case.  This just isn't
true yet with sysfs and is only the sort of thing that can happen with
time.

There are also other things; I guess consistency is a better word. 
People like to say use /sys/block to show block devices, but that
shows a lot of "useless" block devices from the point of view of
trying to show disks.  Block devices also ends up including things
like loop devs (which are all always there), ramdisks, nbd and
probably other things I'm not thinking of.  There's also some
variation in what drivers show -- eg, iseries!vda vs carmel_0 for
device names...  the directory separator used being different points
at how there's a bit of ad-hocness to it.

> So, give me specific examples, or stop ranting for no reason.

And to be more constructive (after a discussion with Jeff this
afternoon which is when I realized the reply didn't go out), what
would be _very_ useful to have from a "probing disks" perspective
would be a way to enumerate easily and simply from within sysfs the
disks that are associated with a specific controller.  Not entirely
sure where under sysfs this would go, but to be able to easily see
that for block device type foo, I have disks disk0, disk1 and disk2. 
The vio sysfs stuff actually works kind of nicely like this, but it
would be more useful as a generic thing rather than not being able to
depend on it.

Note: this should not mean that we then go and remove currently
existing stuff in /proc.  Deprecate it and then it can go away in time
as people switch.  Having to have a flag day is very painful.  It's
far easier to deprecate in one stable series with a new interface
available and then start removing the old ones as things start to
switch over.  If it really is an improvement, then getting people to
change won't be difficult.

Jeremy
