Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264969AbUELEzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbUELEzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 00:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUELEzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 00:55:24 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:63398 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S264972AbUELEzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 00:55:15 -0400
Date: Tue, 11 May 2004 21:55:08 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>,
       <madan@cs.Stanford.EDU>, "David L. Dill" <dill@cs.Stanford.EDU>
Subject: Re: [CHECKER] e2fsck writes out blocks out of order, causing root
 dir to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34)
In-Reply-To: <20040512033110.GC4245@thunk.org>
Message-ID: <Pine.GSO.4.44.0405112118400.8807-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure how this is really a [CHECKER] issue per se, since it
> isn't a kernel issue and you didn't really find this via using the a
> hacked-up gcc compiler, did you?

Yeah this is a bug in e2fsprogs not in kernel.  The kernel journal_recover
flushes out the blocks using sync_dev_no_super, so it's fine.

We caught this warning by a new FS checking tool.  It is based on a C
Model Checker developed by Madan and a few Stanford people (Descritions of
CMC can be found at
http://chicory.stanford.edu/thesis/madan-thesis-abs.html).  You can think
of the tool as a whole machine simulator.  Althought the disk is virtual
in memory, both the kernel and e2fsck will believe they are talking to a
real block device.  The strength of the tool is that it can systematically
enumerate all the possible failures and check for errors.  We aim at
catching deep consistency errors in both the kernel fs code and the fs
utilities code.

> I assume you did this by setting a breakpoint somewhere inside e2fsck?
> Where, specifically?  I want to make sure I can replicate this test
> case exactly as you did, at least under gdb control.  Later I'll think

We got the warning using our tool, which can stop fsck after each block
write and run it again.  To repeat it with gdb, try to stop fsck when the
journal is closed (after replaying is done) and the journal super block is
flushed out by flush_cached_blocks.  If you use the image I provide, the
journal super block should be block 268.

> Assuming I can automate this for a regression test suite, may I have
> permission to include a compressed version of this crashed disk image
> in e2fsprogs?

sure, my pleasure :)

> BTW, it looks like you didn't realize that there was a simpler way of
> instrumenting e2fsck's I/O.  You could have simple built e2fsck with
> configure --enable-testio-debug, and then set the environment variable
> TEST_IO_FLAGS=0x0F to log all reads, writes, set_blksize, and flush
> operations.  See lib/ext2fs/test_io.c for more information.  There are
> also environment variables that can be used to direct the log
> information to a file, as well as ask the test_io layer to dump out
> the contents of a specific block whenver it is read or written.
> E2fsprogs has a very civilized debugging environment.  :-)

Thanks for the information :)  I used debuge2fs utility last night when
diagnosing this warning.  It is really nice.  Without it I wouldn't be
able to pin down the warning.  Thanks!

>
>
> In any case, I believe the following patch (versus the latest
> e2fsprogs tree in Bitkeeper; it looks like probably won't apply
> cleanly to e2fpsrogs 1.34, but it shouldn't be that hard to fix up for
> 1.34) should address this issue, but I'd like to repeat your test case
> exactly as you performed it before pronouncing it fixed.  The fix
> doesn't cause any problems for the existing regression test suite, so
> at the very least I'm confident the fix is safe.

I'll apply the patch and re-run our tool. I'll let know you if this will
fix it or not.

Thanks for the quick reply and the patch!

-Junfeng

