Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277612AbRJREyc>; Thu, 18 Oct 2001 00:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277605AbRJREyW>; Thu, 18 Oct 2001 00:54:22 -0400
Received: from mail.anu.edu.au ([150.203.2.7]:57782 "EHLO mail.anu.edu.au")
	by vger.kernel.org with ESMTP id <S277598AbRJREyM>;
	Thu, 18 Oct 2001 00:54:12 -0400
Message-ID: <3BCE5FC0.F2D3E95B@anu.edu.au>
Date: Thu, 18 Oct 2001 14:51:12 +1000
From: Robert Cohen <robert.cohen@anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au> <200110171644.f9HGinZ17717@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3BCD8269.B4E003E5@anu.edu.au>,
> Robert Cohen  <robert.cohen@anu.edu.au> wrote:
> >
> >Factor 3: the performance problems only happens for I/O that is due to
> >network traffic, not I/O that was generated locally. I realise this is
> >extremely strange and I have no idea how it knows that I/O is die to
> >network traffic let alone why it cares. But I can assure you that it
> >does make a difference.
> 
> I'll bet you $5 AUD that this happens because you don't block your
> output into nicely aligned chunks.
> 
> When you have an existing file, and you write 1500 bytes to the middle
> of it, performance will degrade _horribly_ compared to the case of
> writing a full block, or writing to a position that hasn't been written
> yet.
> 
>
> Now, when you read from the network, you will NOT get reads that are a
> nice multiple of BUFSIZE, you'll get reads that are a multiple of the
> packet data load (~1460 bytes on TCP over ethernet), and you'll end up
> doing unaligned writes that require a read-modify-wrtie cycle and thus
> end up doing twice as much IO.
> 
> And not only does it do twice as much IO (and potentially more with
> read-ahead), the read will obviously be _synchronous_, so the slowdown
> is more than twice as much.
> 
> In contrast, when the source is a local file (or a pipe that ends up
> chunking stuff up in 4kB chunks instead of 1500-byte packets), you'll
> have nice write patterns that fill the whole buffer and make the read
> unnecessary. Which gets you nice streaming writes to disk.
> 
> With most fast disks, this is not unlikely to be performance difference
> on the order of a magnitude.
> 
> And there is _nothing_ the kernel can do about it. Your benchmark is
> bad, and has different behaviour depending on the source.
> 
>


This is almost certainly correct, I will be modifying the benchmark to
use aligned writes.

However, I was curious about the magnitude of the impact of misaligned
writes. I have been seeing performance differences of about a factor of
5.

I have written a trivial test program to explore the issue which just
writes and then rewrites a file with a given buffer size. By using an
odd buffersize we get misaligned writes. You have to use it on files
that are bigger than memory so that the file will not still be in the
page cache during the rewrite.
The source of the program is at
http://tltsu.anu.edu.au/~robert/aligntest.c

Here are some results under linux

Heres a baseline run with aligned buffers.

writing to file of size 300  Megs with buffers of 8192 bytes
write elapsed time=41.00 seconds, write_speed=7.32
rewrite elapsed time=38.26 seconds, rewrite_speed=7.84


As expected there is no penalty for rewrite.

Heres a run with misaligned buffers

writing to file of size 300  Megs with buffers of 5000 bytes
write elapsed time=37.55 seconds, write_speed=7.99
rewrite elapsed time=112.75 seconds, rewrite_speed=2.66


There is a bit more than a factor of 2 between write and rewrite speed.
Fair enough, if you do stupid things, you pay the penalty.

However, look what happens if I run 5 copies at once.

writing to file of size 60  Megs with buffers of 5000 bytes
writing to file of size 60  Megs with buffers of 5000 bytes
writing to file of size 60  Megs with buffers of 5000 bytes
writing to file of size 60  Megs with buffers of 5000 bytes
writing to file of size 60  Megs with buffers of 5000 bytes
write elapsed time=33.96 seconds, write_speed=1.77
write elapsed time=37.43 seconds, write_speed=1.60
write elapsed time=37.74 seconds, write_speed=1.59
write elapsed time=37.93 seconds, write_speed=1.58
write elapsed time=40.74 seconds, write_speed=1.47
rewrite elapsed time=512.44 seconds, rewrite_speed=0.12
rewrite elapsed time=518.59 seconds, rewrite_speed=0.12
rewrite elapsed time=518.05 seconds, rewrite_speed=0.12
rewrite elapsed time=518.96 seconds, rewrite_speed=0.12
rewrite elapsed time=517.08 seconds, rewrite_speed=0.12


Here we see a factor of about 15 between write speed and rewrite speed.
That seems a little extreme.
>From the amount of seeking happening, I believe that all the reads are
being done as single page separate reads. Surely there should be some
readahead happening.


I tested the same program under Solaris and I get about a factor of 2
difference regardless whether its one copy or 5 copies.

I believe that this is an odd situation and sure it only happens for
badly written program. I can see that it would be stupid to optimise for
this situation. But do we really need to do this badly for this case?


--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
