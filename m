Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSFTSwm>; Thu, 20 Jun 2002 14:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSFTSwl>; Thu, 20 Jun 2002 14:52:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52241 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315374AbSFTSwi>; Thu, 20 Jun 2002 14:52:38 -0400
Date: Thu, 20 Jun 2002 11:53:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020620183209.GF28800@gum01m.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.44.0206201137060.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Kurt Garloff wrote:
>
> Actually, with the important exception of IDE disks, most devices are SCSI
> in some way

Don't be silly.

You appear to have a very disk-centric world view, and you seem to ignore
that even in disks, the large majority is IDE, and with SCSI prices not
coming down, that's going to be only more and more true.

Also, most disk devices are using SCSI _command_sets_. But that does not
translate to "using the SCSI mid-layer".

> So our consolidated driver structure will IMHO look like this

The way it seems to be going right now is:

 - stage 1: minor/major -> "queue + index" mapping
   (only done at "open()" time, the internal kernel is trying to get rid
   of most of the major/minor stuff)

 - stage 2: ll_rw_block.c, ioctl.c: insert command on queue.

   Yes, this layer builds up SCSI commands, but it doesn't actually have
   anything to do with the SCSI midlayer.

 - stage 3: driver takes it off the queue and executes the thing.

In short, what is happening is that the SCSI mid-layer to some degree
becomes _less_ relevant, exactly because the SCSI _command_ structure has
gotten so universal that that part is moved up one layer into the generic
part.

Which means that things like ide-scsi etc just don't make any sense any
more. Your assumption that SCSI-cd would take over the IDE layer is just
_wrong_. It's going the other way. There shouldn't be any real difference
between "disk" and "cdrom", you just send commands down the queue.

> Now, userspace should really not care what sort of device is hiding behind a
> "disk" device, except that we
> (1) want to be able to identify and find back a device
>    (a) by a path to it                  and/or
>    (b) by a unique hardware identifier  and/or
>    (c) by its content (a label on it)

Absolutely.

> (2) may want to be able to send low-level (SCSI mostly) commands for
>     configuration  to inquire speical information, or to do things where no
>     kernel driver support exists, such as scanning or writing CDs.
>     For SCSI-like devices, we always want to use sg for this, IMHO,
>     as open() on a sg device is without side-effects and works reliably.

I think we should get _away_ from those silly "sg" devices. The whole
notion that there are "sg" vs "sr" vs "sd" devices is a total bogosity,
and should just go away. What's the point of having those things? It only
confuses people.

We should open a disk device, and access it. Nothing else. The fact that
SCSI got the notion that sd/sr/sg are somehow different is just one of the
_problems_ in the SCSI layer. It's just a queue to send commands to
together with the data and the result, that's all it ever was.

(In other words, I kind of agree with your characterization that "we
should always use 'sg'" because clearly that's the closest of the SCSI
devices to the notion of a command queue. However, I think you've stared
at SCSI so long that you think that that split-up makes sense, when it
really doesn't).

> > I will bet you that there are more IDE CD-RW's out there than there are
> > SCSI devices. The fact that people use ide-scsi to write to them is a
> > hopefully very temporary situation, and the command interface is going
> > to move to a higher layer.
>
> They use SCSI commands, so you will want to offer an interface for
> applications to send SCSI commands, unless you want somebody to write a
> kernel driver to support CD writing.

SCSI commands != "SCSI midlayer".

The IDE driver is already moving into the direction that it just accepts a
command off the request queue.

That does _not_ mean that it has anything to do with the SCSI layer, quite
the reverse. It means that we're going _away_ from the SCSI layer, and
that ide-scsi becomes nothing but an embarrassing remnant of history.

		Linus

