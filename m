Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269791AbRHDEjq>; Sat, 4 Aug 2001 00:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269793AbRHDEjh>; Sat, 4 Aug 2001 00:39:37 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:6489 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269791AbRHDEjZ>; Sat, 4 Aug 2001 00:39:25 -0400
Date: Sat, 4 Aug 2001 00:39:27 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032116130.25779-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108040026490.14842-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Linus Torvalds wrote:

> That implies that we are trying to flush way too few buffers at a time and
> do not get any overlapping IO.

It started out at full throughput, but eventually became jerky and
chaotic.  After I sent the message I noticed it was at 0% idle with
kswapd, kreclaimd, kflushd and kupdated all eating cycles in addition to
dd.

> Btw, how did you test this? Do you have a patch for inode_fsync() already?

Nah, didn't do that patch yet.  The test was the same old dd </dev/zero
of=/tmp/foo bs=1024k with vmstat running and executing commands on another
shell (gotta automate that).  Note that the other approach of leaving the
throttling in and limited to 2MB queues resulted in fairly consistent
60MB/s throughput with no chaotic breakdown.

Using the number of queued sectors in the io queues is, imo, the right way
to throttle io.  The high/low water marks give us decent batching as well
as the delays that we need for throttling writers.  If we remove that,
we'll need another way to wait for io to complete.  Waiting on pages
simply does not work as the page chosen may not be in the "right place" in
the queue.  So, what's the plan?

		-ben

