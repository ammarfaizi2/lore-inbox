Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTE0T4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbTE0T4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:56:25 -0400
Received: from 216-42-72-155.ppp.netsville.net ([216.42.72.155]:25484 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264087AbTE0T4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:56:20 -0400
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com>
	 <200305271952.34843.m.c.p@wolk-project.de>
	 <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
	 <200305272004.02376.m.c.p@wolk-project.de>
	 <20030527182547.GG3767@dualathlon.random>
	 <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
Content-Type: text/plain
Organization: 
Message-Id: <1054066135.32363.73.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 27 May 2003 16:08:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 14:33, Marcelo Tosatti wrote:

> Andrea,
> 
> It seems your "fix-pausing" patch is fixing a potential wakeup
> miss, right? (I looked quickly throught it). Could you explain me the
> problem its trying to fix and how?
> 
> Its too late to fix that in 2.4.21 (rc5 is going out in hours).

The bug report seems to be on ext2, and on a box with 3.5GB of ram and
4G of dirty data.  So, I don't think he is hitting the fix-pausing bug,
which needs just the right set of conditions to miss unplugs:  

1) bdflush can't be awake, so the percentage of dirty buffers has to be
somewhat low.  Otherwise bdflush will trigger unplugs.

2) kupdate needs to be stuck waiting on the super lock, otherwise
kupdate would be triggering unplugs

2a) Some process needs to be calling wait_on_buffer() with the super
lock held.  This makes it pretty much impossible to trigger on ext2
without using O_SYNC mode.

3) You've got to race in __wait_on_buffer (cut n' paste from an old mail
from Andrea)

       CPU0                    CPU1 
       -----------------       ------------------------ 
       reiserfs_writepage 
       lock_buffer() 
                               fsync_buffers_list() under lock_super() 
                               wait_on_buffer() 
                               run_task_queue(&tq_disk) -> noop 
                               schedule() <- hang with lock_super acquired 
       submit_bh() 
       /* don't unplug here */ 


With ext3, you can trigger with two procs, it gets much easier if you
toss a schedule() into submit_bh(), right before generic_make_request. 
reiserfs + the data logging patches is easier to trigger and produces
longer pauses.

For ext3:
A: while(1) sync
B: while(1) write(fd, 8k); fsync(fd); ftruncate(fd, 0);

The idea behind proc B is to increase the chances the
sync and the fsync are trying to write and wait on the same buffer. 

ext3 is hung on a metadata block, while it tries to get write access to
the block before logging it.  This ends up calling wait_on_buffer with
the super held while in proc B, while proc A is in sync flushing the
metadata block.  

I  trigged the hang in ext3 during block allocation, so the ftruncate
makes sure ext3 is constantly allocating blocks (and always dirtying the
same bitmap/direct block).

It isn't a perfect reproduction of the hang, because in ext3 kjournald
wakes up every once and a while (~30 seconds or more) and kicks the
transaction.  But, with more procs running, someone could be waiting
with the journal lock held, which would keep kjournald from fixing
things.



