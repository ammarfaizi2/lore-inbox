Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313554AbSDLLrr>; Fri, 12 Apr 2002 07:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313555AbSDLLrq>; Fri, 12 Apr 2002 07:47:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35336 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313554AbSDLLrp>;
	Fri, 12 Apr 2002 07:47:45 -0400
Date: Fri, 12 Apr 2002 13:47:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>
Subject: [PATCH][CFT] IDE TCQ #3 for 2.5.8-pre3
Message-ID: <20020412114745.GE5285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The third version is ready, lots of changes since last version.

General IDE changes (not directly related to TCQ)

- ata_request_t -> struct ata_request (was actually done before Martin
  posted his first merge, better conform to current ide style)

- add ide_init_commandlist() and keep ide_build_commandlist() for when
  command depth changes. also do proper locking here.

- remove a bit of debugging info here and there

- split ide_do_request into something readable:
	ide_choose_drive() find a suitable drive, if any
	ide_do_request() does usuall setup stuff
	ide_queue_commands() starts queuing commands to a drive, usually
 	  just a single one (non tcq)

- have ide_intr() call only ide_queue_commands for when an isr returns
  ide_released.

- introduce ide_pending_commands(drive)
	returns number of pending commands for a drive

- introduce ide_can_queue(drive)
	returns 1 if drive can queue a new command

- Correctly set hwgroup->rq on queued commands, simplifies some of the
  IDE_CUR_AR() etc stuff.

Both ide_pending_commands and ide_can_queue are called from the queueing
loop where we know the state of a non-tcq drive, so the non-tcq case if
simply a define.

TCQ changes:

- Fix race when starting dma before having set an interrupt handler in
  ide_dma_queued_start. Oops! This could hit under high interrupt rates
  here (> 10000 interrupts/sec).

- Introduce config option to control queueing behaviour. Basically we
  can always try and honor the SERVICE bit when a command completes, or
  we can choose not to. If we always honor the service bit, then the
  drive queue has a tendency to fluctuate wildly when the drive is busy.
  This happens when we queue lots of commands before any of them can
  complete, then as each of them completes the drive signals SERVICE to
  start transfer on the next queued command. This will 'slowly' deplete
  the internal queue. If CONFIG_BLK_DEV_IDE_TCQ_FULL is set, then we
  will instead try and queue a new command as one completes and rely on
  the queueing loop to check pending service once we can't queue more.
  This is just an experiement, I don't know if this is a win yet. And it
  does complicate the code somewhat, so I may kill it. Pending further
  analysis/testing.

- Fix some problems with changing queueing depth on a busy drive:
	- make sure that we don't try and start a non-queuable command
	  when the drive has stuff queued, this is a violation of the
	  protocol
	- fix using_tcq and queue_depth usage
	- going from dma to queueing required setting a depth larger
	  than 1, this is now ok too.

- Add option to wait for 'data phase' before starting dma in
  queued_start and read/write_queued. Seems to work without it... If it
  doesn't work for you, try and change the IDE_TCQ_WAIT_DATAPHASE at the
  start of ide-tcq.c

- Try and service drive in irq timeout path before giving up completely.

- Proper error dumping in various places.

- kill ide_tcq_end()

- Fix compile error when CONFIG_BLK_DEV_IDE_TCQ_DEFAULT wasn't set.

- Use IDE_INACTIVE_TAG instead of -1

- Change default queueing depth to 8

I've done a bit of experimenting with performance in this release, some
interesting results came up. Queuing too many commands slows stuff down
considerably, even things like streamed reads (which don't benefit from
queueing in the first place...). I think this part is a driver problem,
but I haven't been able to profile it just yet. Streamed writes and
random writes are about the same performance regardless of depth, this
is most likely due to the write caching being done.

Random reads benefit nicely from queueing, as expected. tiotest shows as
much as ~0.9mb/sec (for udma, or tcq with depth 1) to ~1.7mb/sec
increase (with 32 commands). 8 still gives a nice ~1.5mb/sec, so that's
why it's the current default. This is with the _FULL queueing option,
disabling that seems to require higher queue depths to achieve the same
performance. Please try for yourself. Again, you can do:

echo "using_tcq:XX" > /proc/ide/hdY/settings

to change queueing depth at any time. This is even safe to do while the
drive is busy now, it will scale the depth instantly.

Next on the agenda is making sure tcq plays nicely when there is more
than one drive on a channel. So don't try this yet, even with this
release. When the next 2.5.8-pre comes out, I'll merge with what Martin
has adopted so far.

ftp.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.8-pre3/ata-tcq-258p3-3.gz

-- 
Jens Axboe

