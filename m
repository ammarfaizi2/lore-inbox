Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVEaTI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVEaTI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVEaTI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:08:27 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:21400 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261263AbVEaTGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:06:38 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Date: Tue, 31 May 2005 11:53:24 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net> <20050531084852.GJ25536@sunbeam.de.gnumonks.org>
In-Reply-To: <20050531084852.GJ25536@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311153.24747.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 1:48 am, Harald Welte wrote:
> On Mon, May 30, 2005 at 03:55:39PM -0700, David Brownell wrote:
> 
> > The logic closing an open usbfs file -- which is done before any task
> > exits with such an open file -- is supposed to block till all its URBs
> > complete.  So the pointer to the task "should" be valid for as long as
> > any URB it's submitted is active.
> 
> unfortunately it doesn't seem to cover the fork() case, see below.

OK, so it seems this is a moderately deep broken assumption in usbfs.


> > Not that it helps at all, but I've never really trusted the usbfs async
> > I/O code.  "Real AIO" could be a lot more obviously correct.  And smaller.
> 
> mh, but nobody has written AIO-enabled usbfs2  yet ;)

I'm still hoping that one of the folk who want make an interesting and
useful contribution to Linux will take the hint.  It goes slowly. :)


Right now I think a "usbfs 1.5" would be the simplest way to deliver
it ... an ioctl that returns a new per-endpoint file descriptor.  It'd
need to support the AIO calls and a bit more ... and that could be the
guts of a "usbfs2".  The "gadgetfs" code shows how small that part
could be ... and later, some libfs based code could do all the fun
stuff, creating a real "usbfs2" that exports normal per-endpoint files
and so on.  Then we could deprecate the current AIO stuff...


> meanwhile, the current usbfs aio handling is the only way how to deal
> with delivery of interrupt pipe URB's to userspace drivers.

Other than tying up the file descriptor with a blocking read, that is.


> However, __exit_files() only calls close_files() if files->count goes
> down to zero. What if the process fork()ed before, and the other half of
> the fork still has a refcount?  -> boom.
> 
> It seems to me that the whole usbdevio async handling doesn't really
> cope with a lot of the unix semantics, such as fork() or file descriptor
> passing.

*cough* usbfs2 aio *cough*


> Wouldn't it help to associate the URB with the file (instaed of the
> task), and then send the signal to any task that still has opened the
> file?  I'm willing to hack up a patch, if this is considered a sane fix.

Sounds reasonable, except that not all such tasks will want the signal.
Though I guess the infrastructure to filter the signal out already exists,
so the main missing piece is that urb-to-file binding.

- Dave

