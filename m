Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292840AbSCMJBw>; Wed, 13 Mar 2002 04:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292847AbSCMJBl>; Wed, 13 Mar 2002 04:01:41 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47113
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292840AbSCMJBb>; Wed, 13 Mar 2002 04:01:31 -0500
Date: Wed, 13 Mar 2002 01:00:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Karsten Weiss <knweiss@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <20020313080946.GC15877@suse.de>
Message-ID: <Pine.LNX.4.10.10203130056210.18254-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

Please try again because that is not the real problem.
All you have shown is that we disagree on the method of page walking
between BLOCK v/s IOCTL.  This is very minor and I agreed that it is
reasonable to map the IOCTL buffer in to BH or BIO so this is a net zero
of negative point.

How about attempting to describe the differences between the atomic and
what is violated by who and where.  I will help you later if you get
stuck.

Regards,

Andre Hedrick

On Wed, 13 Mar 2002, Jens Axboe wrote:

> On Tue, Mar 12 2002, Marcelo Tosatti wrote:
> > So, Jens, could you please explain the problem in the interrupt handlers
> > in detail ?
> 
> Ok... It affects all the pio handlers in ide-taskfile.c,
> multi-write/read as well. The address for pio transfers is calculated
> like so:
> 
> va = rq->buffer + (rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE;
> 
> which is wrong for two reasons. First of all, rq->buffer cannot be
> indexed for the entire nr_sectors range -- it's per definition only the
> first segment in the request, and can as such only be indexed within the
> first current_nr_sectors number of sectors. The above can be grossly out
> of range... Second, nr_sectors and current_nr_sectors are indexing two
> different things -- the former indexes the entire request (all segments)
> while the latter indexes only the first segments. So
> 
> 	foo = rq->nr_sectors - rq->current_nr_sectors;
> 
> makes no sense _at all_ and can only be wrong.
> 
> So why does 2.4.19-pre3 work for pio at all? For the same reason that
> Andre never found this problem in 2.5 either: the taskfile interrupt
> handlers are _never_ used in pio mode. In 2.5 it was by accident, and
> when the merge happened they did indeed get used. It ate disks, very
> quickly. Take a look at drivers/ide/ide-disk.c, line 64:
> 
> #ifdef CONFIG_IDE_TASKFILE_IO
> #  undef __TASKFILE__IO /* define __TASKFILE__IO */
> #else /* CONFIG_IDE_TASKFILE_IO */
> #  undef __TASKFILE__IO
> #endif /* CONFIG_IDE_TASKFILE_IO */
> 
> It's a mess... This really should have been fixed prior to 2.4
> inclusion. Oh well.
> 
> -- 
> Jens Axboe
> 

