Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTD0SxC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 14:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTD0SxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 14:53:02 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:52964 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261405AbTD0Swj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 14:52:39 -0400
Date: Sun, 27 Apr 2003 21:04:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re:  Swap Compression
Message-ID: <20030427190444.GC5174@wohnheim.fh-wedel.de>
References: <200304251848410590.00DEC185@smtp.comcast.net> <20030426091747.GD23757@wohnheim.fh-wedel.de> <200304261148590300.00CE9372@smtp.comcast.net> <20030426160920.GC21015@wohnheim.fh-wedel.de> <200304262224040410.031419FD@smtp.comcast.net> <20030427090418.GB6961@wohnheim.fh-wedel.de> <200304271324370750.01655617@smtp.comcast.net> <20030427175147.GA5174@wohnheim.fh-wedel.de> <200304271431250990.01A281C7@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304271431250990.01A281C7@smtp.comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 April 2003 14:31:25 -0400, rmoser wrote:
> 
> Yeah I know.  I really need to get a working user-space version of this
> thing so I can bench it against source tarballs and extractions from
> /dev/random a bunch of times.

Your compression won't be too good on /dev/random. ;)
But /dev/kmem might be useful test data.

> >Why should someone decide on an algorithm before measuring?
> 
> Erm.  You can use any one of the other algos you want, there's a lot
> out there.  Go ahead and try zlib/gzip/bzip2/7zip/compress if you
> want.  I just figured, the simplest algo would hopefully be the fastest.

Hopefully, yes. Also, the one that doesn't trash the L[12] caches too
much will be "fast" in that it doesn't slow down the rest of the
system. This aspect really favors current uncompressing code, as it is
very easy on the CPU.

> But really we need some finished code to make this work :-)

Yes!

> The real reason I'm working on this is because I favor speed completely
> over size in this application.  It's all modular; make the interface for the
> kernel module flexible enough to push in gzip/bzip2 modules or whatever
> else you want:
> 
> <M> Swap partition support
> ____<M> Compressed Swap
> ________<M> fcomp
> ____________<M> fcomp-extended support
> ________<M> zlib
> ________<M> gzip
> ________<M> bzip2
> ________<M> compress
> ____<M> Swap on RAM

Exactly. It might also be possible to choose the algorithm at bootup
or during runtime.

> As far as I know, zlib, gzip, and compress use Huffman trees.  I am pretty
> sure about zlib, not sure about the others.  gzip I believe uses 16 bit
> backpointers as well, which means you need a 64k processing window
> for [de]compression, not to mention that it takes more work.  bzip2 we
> all know is CPU-intensive, or at least it was last time I checked.

Yes, zlib eats up several 100k of memory. You really notice this when
you add it to a bootloader that was (once) supposed to be small. :)

> Yeah true.  But for guessing the decompressed size I meant like when
> you don't want to load the WHOLE block into RAM at once.  Ahh, so you
> swap in pages?  Well whatever unit you swap in, that's how you should
> compress things.  Look I'm confusing myself here, just ignore anything
> that sounds retarded--I'm just a kid after all :-p

Will do. :)
It should be fine to load a page (maybe several pages) at once. There
is read-ahead code all over the kernel and this is nothing else. Plus
it simplifies things.

> >a) Even with 4M, two pages of 4k each don't hurt that much. If they
> >do, the whole compression trick doesn't pay off at all.
> >b) Compression ratios usually suck with small buffers.
> >
> a)
> True, two chunks of 4k don't hurt.  But how big are swap pages?  Assuming
> the page can't be compressed at all, it's [page size / 256] * 3 + [page size]
> for the maximum compressed data size.  (4144 bytes for 4k of absolutely
> non-redundant data within 256 bytes).

4k + sizeof(header). If the compression doesn't manage to shrink the
code, it should return an error. The calling code will then put an
uncompressed flag in the header and we're done.
The header may be as small as one byte.

> b)
> Yeah they do.  But to find the compression performance (ratio) loss, you
> do [max pointer distance]/[block size], meaning like for this one
> 256/[page size].  If you do a 4k page size, you lose 6.25% of the compression
> performance (so if we average 2:1, we'll average 1.875:1).  What IS the page
> size the kernel uses?

4k on most architectures, 8k on alpha.

> >I didn't look that far yet. What you could do, is read through
> >/usr/src/linux/Documentation/CodingStyle. It is just so much nicer
> >(and faster) to read and sticking to it usually produces better code.
> >
> 
> Eh, I should just crack open the kernel source and immitate it.  But I have
> that file on my hard disk, so mebbe I should look.  Mebbe I should take a
> whack at getting the compression algo to work too, instead of pushing it
> on someone else.

:)

Imitating the kernel source may or may not be a good idea, btw. It is
very diverse in style and quality. Some drivers are absolutely
horrible, but they are just drivers, so noone without that hardware
cares.

Another thing: Did you look at the links John Bradford gave yet? It
doesn't hurt to try something alone first, but once you have a good
idea about what the problem is and how you would solve it, look for
existing code.

Most times, someone else already had the same idea and the same
general solution. Good, less work. Sometimes you were stupid and the
existing solution is much better. Good to know. And on very rare
occasions, your solution is better, at least in some details.

Well, in this case, the sourceforge project appears to be silent since
half a year or so, whatever that means.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
