Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276973AbRJQQpj>; Wed, 17 Oct 2001 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276977AbRJQQp3>; Wed, 17 Oct 2001 12:45:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24327 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276973AbRJQQpL>; Wed, 17 Oct 2001 12:45:11 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
Date: Wed, 17 Oct 2001 16:44:49 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9qkci1$h9g$1@penguin.transmeta.com>
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au>
X-Trace: palladium.transmeta.com 1003337127 30189 127.0.0.1 (17 Oct 2001 16:45:27 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Oct 2001 16:45:27 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BCD8269.B4E003E5@anu.edu.au>,
Robert Cohen  <robert.cohen@anu.edu.au> wrote:
>
>Factor 3: the performance problems only happens for I/O that is due to
>network traffic, not I/O that was generated locally. I realise this is
>extremely strange and I have no idea how it knows that I/O is die to
>network traffic let alone why it cares. But I can assure you that it
>does make a difference.

I'll bet you $5 AUD that this happens because you don't block your
output into nicely aligned chunks. 

When you have an existing file, and you write 1500 bytes to the middle
of it, performance will degrade _horribly_ compared to the case of
writing a full block, or writing to a position that hasn't been written
yet. 

Your benchmark probably just does the equivalent of

	for (;;) {
		int bytes = read(in, buf, BUFSIZE);
		if (bytes <= 0)
			break;
		write(out, buf, bytes);
	}

am I right? The above is obvious code, but it happens to be bad code. 

Now, when you read from the network, you will NOT get reads that are a
nice multiple of BUFSIZE, you'll get reads that are a multiple of the
packet data load (~1460 bytes on TCP over ethernet), and you'll end up
doing unaligned writes that require a read-modify-wrtie cycle and thus
end up doing twice as much IO. 

And not only does it do twice as much IO (and potentially more with
read-ahead), the read will obviously be _synchronous_, so the slowdown
is more than twice as much. 

In contrast, when the source is a local file (or a pipe that ends up
chunking stuff up in 4kB chunks instead of 1500-byte packets), you'll
have nice write patterns that fill the whole buffer and make the read
unnecessary. Which gets you nice streaming writes to disk.

With most fast disks, this is not unlikely to be performance difference
on the order of a magnitude.

And there is _nothing_ the kernel can do about it. Your benchmark is
bad, and has different behaviour depending on the source.

In short, fix your program. Change the loop to be something like

	unsigned int so_far = 0;
	for (;;) {
		int bytes = read(in, buf+so_far, BUFSIZE-so_far);
		if (bytes <= 0)
			break;
		so_far += bytes;
		if (so_far < BUFSIZE)
			continue;
		write(out, buf, BUFSIZE);
		so_far = 0;
	}
	if (so_far)
		write(out, buf, so_far);

which will act the same for partial and full reads, and I bet you'll see
the same difference for local and networking I/O (modulo the speed
difference in the _source_, of course).

Oh, and I bet you that once you do something like the above, you won't
see much difference between a 8kB buffer and a 256kB buffer.  The
smaller buffer will generate more system calls, but it won't much matter
(and sometimes the smaller buffer performs better due to better data
cache locality and better overlapping IO - system calls under Linux
aren't slow, other factors can easily dominate). 

		Linus
