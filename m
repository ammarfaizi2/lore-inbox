Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbTHZTD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbTHZTDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:03:25 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:25261 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S262821AbTHZTDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:03:23 -0400
Date: Tue, 26 Aug 2003 21:02:52 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] kernel BUG at arch/i386/mm/highmem.c:14!
Message-ID: <20030826190252.GA3642@k3.hellgate.ch>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20030826173337.GA3993@k3.hellgate.ch> <20030826180146.GF862@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826180146.GF862@suse.de>
X-Operating-System: Linux 2.6.0-test4 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003 20:01:46 +0200, Jens Axboe wrote:
> Possibly some artifact of using read/write multiple on IDE, does it work
> if you disable that with -m0 on the device? I'm guessing the error is
> 100% reproducible?

I'm guessing you're right (small sample size, though).

I made one (successful) attempt at reproducing the BUG (copy some 300 MB of
data to a partition, then disable DMA on the target disk).

I made two further attempts but with all kernel output on the serial
console, one with -m16 and one with -m0. Both resulted in a flood of "bad:
scheduling while atomic!", but no BUG. The -m0 version looked like a flood
in slow motion (line by line).

I suppose the first BUG had the scheduling messages, too, but I didn't see
them because they had scrolled past by the time I got to the console. I did
see those "bad: scheduling while atomic!" messages, tough, when I
reproduced the BUG.

Call traces would look like this:
----------------------------------------------------------------------------
hda: DMA disabled
bad: scheduling while atomic!
Call Trace:
 [<c011ce00>] schedule+0x510/0x520
 [<c022a820>] blk_run_queues+0x120/0x300
 [<c0147e50>] find_get_page+0x70/0x140
 [<c011ed6e>] io_schedule+0xe/0x20
 [<c0171f7f>] __wait_on_buffer+0xcf/0xe0
 [<c011fa80>] autoremove_wake_function+0x0/0x50
 [<c011fa80>] autoremove_wake_function+0x0/0x50
 [<c01de17a>] flush_commit_list+0x31a/0x440
 [<c01e28fb>] do_journal_end+0x5fb/0xc00
 [<c01e1b79>] flush_old_commits+0x139/0x1d0
 [<c01cf940>] reiserfs_write_super+0x30/0x40
 [<c01791bf>] sync_supers+0x1ef/0x280
 [<c014e143>] wb_kupdate+0x63/0x160
 [<c011cae2>] schedule+0x1f2/0x520
 [<c014eb0c>] __pdflush+0x21c/0x5f0
 [<c014eee0>] pdflush+0x0/0x20
 [<c014eef1>] pdflush+0x11/0x20
 [<c014e0e0>] wb_kupdate+0x0/0x160
 [<c0107259>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011ce00>] schedule+0x510/0x520
[...]
----------------------------------------------------------------------------

Or this:

----------------------------------------------------------------------------
hda: DMA disabled
bad: scheduling while atomic!
Call Trace:
 [<c011ce00>] schedule+0x510/0x520
 [<c014ea26>] __pdflush+0x136/0x5f0
 [<c014eee0>] pdflush+0x0/0x20
 [<c014eef1>] pdflush+0x11/0x20
 [<c0107259>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011ce00>] schedule+0x510/0x520
 [<c010babb>] handle_IRQ_event+0x3b/0x70
 [<c012d7cc>] schedule_timeout+0x8c/0xe0
 [<c012d730>] process_timeout+0x0/0x10
 [<c011ed91>] io_schedule_timeout+0x11/0x20
 [<c022bb1b>] blk_congestion_wait+0x8b/0xa0
 [<c011fa80>] autoremove_wake_function+0x0/0x50
 [<c011fa80>] autoremove_wake_function+0x0/0x50
 [<c019cee1>] writeback_inodes+0x1/0x420
 [<c014e1e4>] wb_kupdate+0x104/0x160
 [<c014eb0c>] __pdflush+0x21c/0x5f0
 [<c014eee0>] pdflush+0x0/0x20
 [<c014eef1>] pdflush+0x11/0x20
 [<c014e0e0>] wb_kupdate+0x0/0x160
 [<c0107259>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
[...]
----------------------------------------------------------------------------
