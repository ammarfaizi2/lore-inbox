Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316877AbSFQJ6M>; Mon, 17 Jun 2002 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSFQJ6K>; Mon, 17 Jun 2002 05:58:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58633 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316877AbSFQJ6K>;
	Mon, 17 Jun 2002 05:58:10 -0400
Message-ID: <3D0DB3A7.C32CCAE9@zip.com.au>
Date: Mon, 17 Jun 2002 03:02:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: "laptop mode" for floppies too?
References: <E17JssS-0006aL-00@alf.amelek.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Michalkiewicz wrote:
> 
> Hi,
> 
> I've just read (in Kernel Traffic - don't have enough time to follow
> linux-kernel directly...) about your proposed "laptop mode" patch
> (basically writing all dirty blocks to disk after it spins up - looks
> like a good idea to me).  Similar problem exists with floppies (also
> in desktop PCs) - it takes a while to spin up, so I think it would
> make sense to write all dirty blocks just before spinning down, so
> that the drive is less likely to spin up again soon.

I kinda lost interest in `laptop mode'.  The proposed simple, specific
implementation seemed to be deemed insufficient by many people, and
I believe that a fully-blown per-queue implementation would add an
unjustifiable amount of complexity.  So I guess I'll submit the patch
which allows ext3 commit intervals to be tuned and leave it at that.

The key idea of writing back all dirty data when the disk is spun up
for a read can be implemented by a userspace daemon which polls /proc/stat
anyway.

> So it would be nice to have more general support for this feature in
> the block device layer (not limited to IDE devices).  Is anyone working
> on something like that (for 2.5)?

Nobody is working on that.

You could get this effect by setting the `kupdate' interval short and
by setting the "maximum age of dirty data" small.  So in 2.4 terms,
set the fifth parameter in /proc/sys/vm/bdflush to 100 (one second)
and set the sixth parameter to 200.

That will penalise the hard disk rather nastily, however.

A proper solution is not feasible with the 2.4 data structures.
In 2.5, making the "maximum age of dirty data" be a per-queue
tunable is in fact pretty simple.  The trickiest part would be
exposing the per-queue tunables to userspace, actually.

I do need to revisit this stuff - we need a way of being able
to incorporate the nominal write bandwidth of the backing device
into the memory balancing decisions.  I'll take a look at your
idea when I get onto that.

-
