Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292702AbSCMIKQ>; Wed, 13 Mar 2002 03:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292705AbSCMIKG>; Wed, 13 Mar 2002 03:10:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5127 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292702AbSCMIJz>;
	Wed, 13 Mar 2002 03:09:55 -0500
Date: Wed, 13 Mar 2002 09:09:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Karsten Weiss <knweiss@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020313080946.GC15877@suse.de>
In-Reply-To: <20020312134631.GE1473@suse.de> <Pine.LNX.4.21.0203121558300.3462-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0203121558300.3462-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12 2002, Marcelo Tosatti wrote:
> So, Jens, could you please explain the problem in the interrupt handlers
> in detail ?

Ok... It affects all the pio handlers in ide-taskfile.c,
multi-write/read as well. The address for pio transfers is calculated
like so:

va = rq->buffer + (rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE;

which is wrong for two reasons. First of all, rq->buffer cannot be
indexed for the entire nr_sectors range -- it's per definition only the
first segment in the request, and can as such only be indexed within the
first current_nr_sectors number of sectors. The above can be grossly out
of range... Second, nr_sectors and current_nr_sectors are indexing two
different things -- the former indexes the entire request (all segments)
while the latter indexes only the first segments. So

	foo = rq->nr_sectors - rq->current_nr_sectors;

makes no sense _at all_ and can only be wrong.

So why does 2.4.19-pre3 work for pio at all? For the same reason that
Andre never found this problem in 2.5 either: the taskfile interrupt
handlers are _never_ used in pio mode. In 2.5 it was by accident, and
when the merge happened they did indeed get used. It ate disks, very
quickly. Take a look at drivers/ide/ide-disk.c, line 64:

#ifdef CONFIG_IDE_TASKFILE_IO
#  undef __TASKFILE__IO /* define __TASKFILE__IO */
#else /* CONFIG_IDE_TASKFILE_IO */
#  undef __TASKFILE__IO
#endif /* CONFIG_IDE_TASKFILE_IO */

It's a mess... This really should have been fixed prior to 2.4
inclusion. Oh well.

-- 
Jens Axboe

