Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265113AbSJWSLj>; Wed, 23 Oct 2002 14:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSJWSLj>; Wed, 23 Oct 2002 14:11:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4790 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265113AbSJWSLh>;
	Wed, 23 Oct 2002 14:11:37 -0400
Date: Wed, 23 Oct 2002 20:17:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][CFT] dma audio and raw burning
Message-ID: <20021023181731.GK1107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've extended the sgio patches to allow dma for writing cd's in a format
that is not a multiple of 512 bytes. Previously, Linux has never been
able to use dma for writing eg audio and raw cd's on ATAPI drives. Now
we can. The operation is of course also zero-copy, like mode2 writing
was in the previous patch. So all in all, cd writing should be both much
faster than before and also a much smother experience. Find the patch
against 2.5.44 here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-14b.diff.bz2

And the modified cdrecord in rpm and tar.gz + diff here:

*.kernel.org/pub/linux/kernel/people/axboe/tools/

For testing, forget about ide-scsi. Just make sure that ide-cd is
loaded. And then give the device name to cdrecord, -scanbus does not
work for now:

	# cdrecord -dev=/dev/hdc ...

That should be it. I would much appreciate testing from people with fast
ATAPI burners. If you are able to compare writing cd's without (using
ide-scsi) and with the patch (remove ide-scsi) and compare, do let me
know.

There are also a bunch of other changes in the patch. Some are necessary
for bio_map_user(), others are necessary for ide-cd to be able to
operate in bytes and not sectors (basically I've relaxed the dma
alignment to 4 bytes instead of 512b sectors), others are just plain bug
fixes:

o blk_put_request() in scsi_ioctl.c was just plain racy, elv_add_request
  was too. Make proper put, get, and insert locking and lockless
  variants.

o Fix the whole elv_add_request,_elv_add_request_core() etc mess. Now we
  have

	elv_add_request(queue, request, plug, at_end);
	__elv_add_request(), lockless variant of above
	__elv_add_request_pos(), lockless, specify position

o Inspecting request after io completion is racy, since the request
  could be used again right away. This was a bug in scsi_ioctl.c, since
  it needs to check residual count in the request. It's also a bug in
  ide.c code for many years, for ide_do_drive_cmd() with ide_wait
  action. Add simple ref counts for requests to make this work properly.

o Clean q->last_merge clearing, it was a bit all over the place before.
  We need to clear in elv_next_request(), and in elv_remove_request().

o Make the request adding and deletion check for proper operation, by
  using list_del_init() and doing sanity checks on insert and removal.

o Make blk_dump_rq_flags() be a bit more useful.

o Make sure get_request() clears some standard fields.

o Add end_that_request_chunk(). Like end_that_request_first(), but
  operate on bytes instead of sectors. __end_that_request_first() also
  contains Suparna's patch to only call bio_endio() when we really have
  to. We need partial completions for some devices, but there's no point
  in partially completing xx chunks when they finish at the same time
  anyways (as is the case with ide dma, and scsi, for instance. well
  most drivers, really).

Below are the changes I made to Linus' initial code, which (frankly) was
pretty horrible and cleary hacked into existance...

o Add bio_map_user(). It maps a range of user memory to a bio. This also
  needed some changes to the queue merge_bvec_fn() to make it return
  number of bytes we can accept at a given location instead of a bool.
  These changes aren't finalized yet, I need to look at this in the next
  few days...

o Make SCSI work. A bit more work than Linus had out lined, but not too
  bad. Note that SCSI will do data copies if the data and length isn't
  sector aligned.

o Make ide-cd really work... I've cleaned this a *lot*. The
  transformations were broken before, they work now. Only pio was
  supported before, now we do dma for just about everything. The new
  worker is cdrom_newpc_intr() which is a newly written interrupt
  handler that handles all REQ_BLOCK_PC requests and operates in
  granularities of bytes instead of sectors. This will be used to
  replace the three interrupt handlers ide-cd has now (cdrom_read_intr,
  cdrom_write_intr, cdrom_pc_intr). 

That's about it, I think. Again, testers are more than welcome!

-- 
Jens Axboe

