Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318552AbSIBXD5>; Mon, 2 Sep 2002 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSIBXD5>; Mon, 2 Sep 2002 19:03:57 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:1417 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318538AbSIBXDy>;
	Mon, 2 Sep 2002 19:03:54 -0400
Date: Tue, 3 Sep 2002 01:08:24 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Message-ID: <20020902230824.GB9359@win.tue.nl>
References: <UTC200209022141.g82LfMV21308.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0209021459030.1401-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209021459030.1401-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 03:00:27PM -0700, Linus Torvalds wrote:

> > No, my suggested changes would not break a single Linux installation
> > in the world.
> 
> .. by making your suggested behaviour not be used. Yes.

Not so pessimistic. We go by small steps.

I think it important to get rid of partition table reading in the kernel.

It (pt reading) is wrong in principle, as we agree already.
But there are also all kinds of practical reasons.

 One argument is that our traditional DOS-type partition table will soon
 be at the end of its useful life. Yes, maybe it survives a few more years
 but our own stability requires slow changes, so we must start thinking a
 long time in advance.
 Another argument is that it sometimes takes a *long* time, like several
 minutes, especially when this reading triggers hardware bugs.
 Another argument is that nobody knows whether there is a partition table.
 In the case of ZIP drives there sometimes is a jumper or special SCSI command
 to switch between the "large floppy" and "removable disk" statuses, and
 the kernel doesnt know.
 Another argument is that tricky things happen in the presence of disk managers.

So stage one is a kernel boot parameter "nopt" or so, that stops parsing
of partition tables other than the root partition. Some people need it
because of special problems, others just want to experiment. That is good,
and we'll get some feedback on partx and family.

Stage two happens a year later, when we have a working initrd. Seen from the
outside the new (kernel + initrd) plays the role of the old kernel.
Ha. That means that we can move the pt reading to initrd, and nobody notices.

Stage three happens when initrd and kernel no longer are so tightly coupled.
Initrd is just early userspace, tools exist to populate it, distributions make
their own. Now the kernel does not need any partition reading code and
nobody ever noticed. And the setup has become much more powerful.

-----

> But if that is the case, then we _still_ need to fix the media change and 
> partition read issue. Right? Which brings back _all_ my points for why it 
> should be done at open time, and by the generic routine. Agreed?

The above was mainly about the partition reading at boot time.
There are two other situations: partition reading at insmod time,
and partition reading at media change time.

But these are easier situations. There is a functioning userspace already.
As I said, in view of the desired direction, I would not mind at all if
a media change did not trigger partition reading today.
(In fact, for me, under 2.5.33, it doesn't. But blockdev --rereadpt helps.)


Andries
