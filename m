Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTEGTqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTEGTqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:46:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53957 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264321AbTEGTqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:46:14 -0400
Date: Wed, 7 May 2003 21:58:12 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030507175033.GR823@suse.de>
Message-ID: <Pine.SOL.4.30.0305072119530.27561-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003, Jens Axboe wrote:

> On Wed, May 07 2003, Linus Torvalds wrote:
> >
> > On Wed, 7 May 2003, Jens Axboe wrote:
> > > >
> > > > And testing. In particular, you might want to test whether a device
> > > > properly supports 48-bit addressing, either from the kernel or from user
> > > > programs.
> > >
> > > For that, a forced 48-bit hwif->addressing inherited by drives will
> > > suffice. And I agree, we should have that.
> >
> > No no no.
> >
> > You definitely do NOT want to set "hwif->addressing" to 1 before you've
> > tested whether it even _works_.
>
> Well duh, of course not. Whether a given request is executed in 48-bit
> or not is a check that _includes_ drive capabilities too of course.

Yeah, we test drive capabilities properly in idedisk_setup(),
but Linus is right speaking about _hwif_ capabilities.
Jens you your patch sets hwif->rqsize to 65535 in setup-pci.c for all
PCI hwifs which is simply wrong as not all of them supports LBA48.
You should check for hwif->addressing and if true set rqsize to 65536
(not 65535) and not in IDE PCI code but in ide_init_queue() in ide-probe.c.
I also think that max request size should be printed for all drives,
not only 48-bit capable.

> > Imagine something like "hdparm" - other things are already in progress,
> > the system is up, and IDE commands are potentially executing concurrently.
> > What something like that wants to do is to send one request out to check
> > whether 48-bit addressing works, but it absolutely does NOT want to set
> > some interface-global flag that affects other commands.
>
> Then it just puts a taskfile request on the request queue and lets it
> reach the drive, nicely syncronized with the other requests. There's no
> need to toggle any special bits for that.

Yes, but patch subtly breakes taskfile :-).

Taskfile ioctl uses do_rw_taskfile() or flagged_taskfile().
Patch replaces drive->adrressing checks by task->addressing,
but ide_taskfile_ioctl() doesn't know about it so task->addressing
will be always equal 0.

You should add checking for 48-bit commands and setting task->addressing
to 1 if neccessary to ide_taskfile_ioctl().

Also changes for pdc202xx_old.c are wrong, we should check for
task->addressing not rq_lba48(rq) as taskfile requests also use this
codepath.

Patch also misses updates for many uses of drive->addressing
(in ide.c, ide-io.c, icside.c, ide-tcq.c and even in ide-taskfile.c).

> > Only after it has verified that 48-bit addressing does work should it set
> > the global flag.
>
> Sounds fine.

Jens, I like the general idea of the patch, but it needs some more work.
Linus, please don't apply for now.

--
Bartlomiej

> --
> Jens Axboe



