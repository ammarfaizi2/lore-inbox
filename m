Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbRBCU3z>; Sat, 3 Feb 2001 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbRBCU3p>; Sat, 3 Feb 2001 15:29:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129693AbRBCU3n>; Sat, 3 Feb 2001 15:29:43 -0500
Date: Sat, 3 Feb 2001 12:28:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010201220744.K11607@redhat.com>
Message-ID: <Pine.LNX.4.10.10102031224210.8867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> 
> On Thu, Feb 01, 2001 at 09:33:27PM +0100, Christoph Hellwig wrote:
> 
> > I think you want the whole kio concept only for disk-like IO.  
> 
> No.  I want something good for zero-copy IO in general, but a lot of
> that concerns the problem of interacting with the user, and the basic
> center of that interaction in 99% of the interesting cases is either a
> user VM buffer or the page cache --- all of which are page-aligned.  
> 
> If you look at the sorts of models being proposed (even by Linus) for
> splice, you get
> 
> 	len = prepare_read();
> 	prepare_write();
> 	pull_fd();
> 	commit_write();
> 
> in which the read is being pulled into a known location in the page
> cache -- it's page-aligned, again.

Wrong.

Neither the read nor the write are page-aligned. I don't know where you
got that idea. It's obviously not true even in the common case: it depends
_entirely_ on what the file offsets are, and expecting the offset to be
zero is just being stupid. It's often _not_ zero. With networking it is in
fact seldom zero, because the network packets are seldom aligned either in
size or in location.

Also, there are many reasons why "page" may have different meaning. We
will eventually have a page-cache where the pagecace granularity is not
the same as the user-level visible one. User-level may do mmap at 4kB
boundaries, even if the page cache itself uses 8kB or 16kB pages.

THERE IS NO PAGE-ALIGNMENT. And anything that even _mentions_ the word
page-aligned is going into my trash-can faster than you can say "bug".

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
