Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVAGGf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVAGGf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 01:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVAGGf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 01:35:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:21662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261260AbVAGGfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 01:35:17 -0500
Date: Thu, 6 Jan 2005 22:35:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <20050107034145.GI9636@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0501062222500.2272@ppc970.osdl.org>
References: <200501070313.j073DCaQ009641@hera.kernel.org>
 <20050107034145.GI9636@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jan 2005, William Lee Irwin III wrote:

> On Fri, Jan 07, 2005 at 12:29:13AM +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2229.1.1, 2005/01/06 16:29:13-08:00, torvalds@ppc970.osdl.org
> > 	Make pipe data structure be a circular list of pages, rather than
> > 	a circular list of one page.
> > 	This improves pipe throughput, and allows us to (eventually)
> > 	use these lists of page buffers for moving data around efficiently.
> 
> Interesting; how big a gain did you see?

On my ppc970 (which Alan correctly points out is not necessarily the best 
platform to test), lmbench throughput looks like this:

	*Local* Communication bandwidths in MB/s - bigger is better
	-----------------------------------------------------------
	Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   
	Mem                          UNIX      reread reread (libc) (hand) read write
	--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
before:
	ppc970.os  Linux 2.6.10 753. 1305 550. 1110.3 2051.3  932.3  926.4 2043 1291.
	ppc970.os  Linux 2.6.10 738. 1596 558. 1099.4 2038.8  936.6  925.0 2033 1288.
	ppc970.os  Linux 2.6.10 752. 1535 557. 1107.2 2043.5  937.9  932.1 2037 1292.
	ppc970.os  Linux 2.6.10 750. 1524 556. 1107.5 2046.0  937.2  930.4 2037 1289.
after:
	ppc970.os  Linux 2.6.10 976. 1594 561. 1110.6 2045.8  934.9  923.6 2039 1288.
	ppc970.os  Linux 2.6.10 1195 1595 549. 1102.0 2049.0  909.5  930.5 2044 1292.
	ppc970.os  Linux 2.6.10 1669 1418 507. 1122.9 2051.3  943.4  916.4 2035 1280.
	ppc970.os  Linux 2.6.10 1472 1612 557. 1092.4 2032.9  932.1  935.1 2030 1281.


ie that's a clear improvement (30-90% higher bandwidth). That's from
having <n> (currently 16) pages of buffers in flight instead of just one.

Of course, the full 16 you'll seldom see in real life - stdio etc tends to
buffer up at 8kB or similar, but it does mean that such a 8kB write won't
need to block for the reader to empty the pipe.

I worried a bit about latency, but my test-run of four before/after was in 
the noise. It's bound to be worse because of the extra allocation, but 
it's not clearly visible.

However, I've got a long-term cunning plan, which was the _real_ reason
for the pipe changes. I'm finally going to implement Larry McVoy's
"splice()"  operation, and it turns out that a pipe (with the new
organization) ends up being the exact conduit between two files that you
need to "splice" an input an an output together - without any copying (the
new pipe buffering is just pointers to pages and byte ranges within those
pages).

Together with a "tee()" system call (duplicate it in two), you can
basically generate pipelines and forks of data, and you'll only need to
update a reference count (and pupulate a new "struct pipe_buffer" thing).

But making sure that every step along the way is an improvement is part of 
the philosophy.

			Linus
