Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270195AbRHGMCj>; Tue, 7 Aug 2001 08:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270196AbRHGMC2>; Tue, 7 Aug 2001 08:02:28 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:39655 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270195AbRHGMCT>; Tue, 7 Aug 2001 08:02:19 -0400
Message-Id: <5.1.0.14.2.20010807123805.027f19a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 Aug 2001 13:02:27 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] using writepage to start io
Cc: Daniel Phillips <phillips@bonn-fries.net>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20010807120234.D4036@redhat.com>
In-Reply-To: <01080623182601.01864@starship>
 <755760000.997128720@tiny>
 <01080623182601.01864@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 12:02 07/08/01, Stephen C. Tweedie wrote:
>On Mon, Aug 06, 2001 at 11:18:26PM +0200, Daniel Phillips wrote:
>FWIW, we've seen big performance degradations in the past when testing
>different ext3 checkpointing modes.  You can't reuse a disk block in
>the journal without making sure that the data in it has been flushed
>to disk, so ext3 does regular checkpointing to flush journaled blocks
>out.  That can interact very badly with normal VM writeback if you're
>not careful: having two threads doing the same thing at the same time
>can just thrash the disk.
>
>Parallel sync() calls from multiple processes has shown up the same
>behaviour on ext2 in the past.  I'd definitely like to see at most one
>thread of writeback per disk to avoid that.

Why not have a facility with which each fs can register their own writeback 
functions with a time interval? The daemon would be doing the writing to 
the device and would be invoking the fs registered writers every <time 
interval> seconds. That would avoid the problem of having two fs trying to 
write in parallel but that ignores the problem of having two parallel 
writers on separate partitions of the same disk but that could be solved at 
the fs writeback function level.

At least for NTFS TNG I was thinking of having a daemon running every 5 
seconds and committing dirty data to disk but it would be iterating over 
all mounted ntfs volumes in sequence and flushing all dirty data for each, 
thus avoiding concurrent writing to the same disk, which I had thought 
might cause a problem and you just confirmed it...[1]

Just a thought,

Anton

[1] I am aware this probably doesn't scale too well but considering a 
volume can span several disk partitions on the same disk or across several 
disks I don't see how to parallelize at the fs level.


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

