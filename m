Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbTILHQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 03:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTILHQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 03:16:14 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:56471 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S261170AbTILHQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 03:16:10 -0400
Subject: Re: Panic when finishing raidreconf on 2.6.0-test4 with preempt
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030909204206.GA11626@unthought.net>
References: <1062883950.1341.26.camel@clubneon.clubneon.com>
	 <20030909181131.GB9079@unthought.net>
	 <1063135290.1119.32.camel@clubneon.priv.hereintown.net>
	 <20030909204206.GA11626@unthought.net>
Content-Type: text/plain
Message-Id: <1063350969.698.1.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 03:16:09 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19xiA5-00047a-R6*52lYPFjQHvo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Kernel version corrected in the subject line.]
[Plus forgot to include l-k.]

On Tue, 2003-09-09 at 16:42, Jakob Oestergaard wrote: 
> On Tue, Sep 09, 2003 at 03:21:31PM -0400, Chris Meadors wrote:
> 
> Eh, ok, I'm not really sure what you did...
> 
> You ran raidreconf once, and after the entire reconfiguration had run,
> the kernel barfed.

That's what I figured...

> Then what?  You re-ran the reconfiguration?  Same as before?

...after I ran it the second time.

The problem was, it takes a while for the reconf to run.  So I went to
watch a movie or something.  I got back and my screen was blanked, key
presses wouldn't clear it.  Even Alt+SysRq wouldn't respond.  So, I hit
the reset button.  That is when I saw that the kernel wouldn't recognize
the drive that should have been part of the array as being part of the
array.

I figured the kernel panicked, and went to reproduce it.  As the reconf
was running the second time, I started thinking to myself, that maybe it
wasn't a good idea.  That I could have probably recovered data if I had
run fsck on the initial result. 

> If so, then I can pretty much guarantee you that your data are lost. You
> may get Ibas (ibas.no) to scrape off the upper layers of your disk
> platters, run some pattern analysis on whats left, and possibly then
> retrieve some of your old data, but that's about the only chance I can
> see you having.
> 
> If you only ran raidreconf once, then there might still be a good chance
> to get your data back.  To me it doesn't sound like this is the case,
> but if it is, please let me know.

Nope, as I said, I ran it twice.  Since my machine was hung solid, and
the screen was blank, I didn't know exactly what had happened, and then
my fingers worked faster than my brain.

> Sorry about your loss (but running an experimental raid reconfiguration
> tool on an experimental kernel without backups, well...  ;)

Exactly, the raidreconf HOWTO also plainly says, "unless you don't
consider the data important, you should make a backup of your current
RAID array now."  I don't know if it it is worth adding to the
documentation, to not rerun raidreconf, if it fails for what ever
reason, until the array has been recovered to a fully consistent state.

> Ok. It would be interesting to see if the oops goes away when preempt is
> disabled.

Okay, it took some time, but here is what I've tested, all on
2.6.0-test5 now:

First, by mistake, raidreconf on a started array, gets all the way
through, but when it discovers at the end that md0 already has disks, it
exits gracefully, no oops.

Second, raidreconf still triggers the oops in -test5 when expanding a 4
disk RAID5 to 5 disks.

Third, mkraid completes without any trouble when building a new 4 disk
array.

Last, even in a kernel built without preempt support (I don't know why I
thought that was the problem initially, I must have misread something),
raidreconf still oops the machine when attempting to write the new
superblocks.

The here is some of the the output from the oops, copied by hand, as it
hangs the machine solid, and I don't have anything else to capture it
with:

EIP is at blk_read_rq_sectors+0x50/0xd0

Process md0_raid5

Stack trace:

__end_that_request_first+0x127/0x230
scsi_end_request+0x3f/0xf0
scsi_io_completion+0x1bb/0x470
sym_xpt_done+0x3b/0x50
sd_rw_intr+0x5a/0x1d0
scsi_finish_command+0x76/0xc0
run_timer_softirq+0x10a/0x1b0
scsi_softirq+0x99/0xa0
do_IRQ+0xfe/0x130
common_interupt+0x18/0x20
xor_p5_mmx_5+0x6b/0x180
xor_block+0x5b/0xc0
compute_parity+0x15d/0x340
default_wake_function+0x0/0x30
handle_stripe+0x95f/0xcc0
__wake_up_common+0x31/0x60
raid5d+07d/0x140
default_wake_function+0x0/0x30
md_thread+0x0/0x190
kernel_thread_helper+0x5/0x10


If you need anything else, I can reproduce this at will.  It just takes
about 30 minutes to reconf to 5 9GB drives.

-- 
Chris

