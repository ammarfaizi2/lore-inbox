Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292055AbSBOJDH>; Fri, 15 Feb 2002 04:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292043AbSBOJCs>; Fri, 15 Feb 2002 04:02:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292041AbSBOJCh>;
	Fri, 15 Feb 2002 04:02:37 -0500
Date: Fri, 15 Feb 2002 10:02:24 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support
Message-ID: <20020215090224.GB2727@suse.de>
In-Reply-To: <200202131826.g1DIQCT02506@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202131826.g1DIQCT02506@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13 2002, James Bottomley wrote:
> axboe@suse.de said:
> > ChangeSet@1.297, 2002-02-13 13:42:39+01:00, axboe@burns.home.kernel.dk
> >   Add support for SCSI drivers to indicate support for ordered tags
> >   http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/
> > torvalds-2002020517305 \ 6-16047-c1d11a41ed024864/cset@1.133.114.4?nav=
> > index.html|ChangeSet@-1h
> 
> > ChangeSet@1.298, 2002-02-13 13:43:04+01:00, axboe@burns.home.kernel.dk
> >   Add ordered tag support to the aic7xxx scsi driver
> 
> The rest of the aic7xxx code uses MSG_ORDERED_TASK rather than 
> MSG_ORDERED_Q_TAG.  You have to scan through the headers to see that
> these are #defined the same.

Ah, the MSG_ORDERED_TASK did probably not exist when I originally did
the patch (a year or so ago, iirc). I'll change the define to follow the
rest of the code.

> A problem (that is probably only an issue for older drives) is that
> while technically the standard requires all 3 types of TAG to be
> supported if tag queueing is, some drives really only have simple tag
> support in their firmware, so you may need to add a blacklist for
> ordered tags on certain drives.

Yes you are right.

> A further issue is that you haven't added anything to the error
> recovery code for this.  If error recovery is activated for the device
> at the reset level, all tags will be discarded by the device.  The eh
> will retry the failing command and then the other tagged commands will
> be re-issued from the scsi_bottom_half_handler (assuming the low level
> device driver immediately fails them with DID_RESET) in the order in
> which the low level driver failed them.  Thus you have potentially
> completely messed up the ordering when the commands all get retried.

I already have this fixed locally by just maintaining a fifo list of
queued commands so we can retry them in the correct order. For 2.5
there's a busy and free list (so no more scanning for a free command
either), I would imagine that the easiest for 2.4 is to just maintain a
busy list in addition to the current array of pending/free commands.

-- 
Jens Axboe

