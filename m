Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTD0SUo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 14:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTD0SUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 14:20:44 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:1887 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261294AbTD0SUi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 14:20:38 -0400
Date: Sun, 27 Apr 2003 14:31:25 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Re:  Swap Compression
In-reply-to: <20030427175147.GA5174@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304271431250990.01A281C7@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <200304251848410590.00DEC185@smtp.comcast.net>
 <20030426091747.GD23757@wohnheim.fh-wedel.de>
 <200304261148590300.00CE9372@smtp.comcast.net>
 <20030426160920.GC21015@wohnheim.fh-wedel.de>
 <200304262224040410.031419FD@smtp.comcast.net>
 <20030427090418.GB6961@wohnheim.fh-wedel.de>
 <200304271324370750.01655617@smtp.comcast.net>
 <20030427175147.GA5174@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 4/27/2003 at 7:51 PM Jörn Engel wrote:

>On Sun, 27 April 2003 13:24:37 -0400, rmoser wrote:
>> >int fox_compress(unsigned char *input, unsigned char *output,
>> >		uint32_t inlen, uint32_t *outlen);
>> >
>> >int fox_decompress(unsigned char *input, unsigned char *output,
>> >		uint32_t inlen, uint32_t *outlen);
>> 
>> Ey? uint32_t*?  I assume that's a mistake....
>
>Nope. outlen is changed, you need a pointer here.
>

ahh okay, gotcha

>> Anyhow, this wasn't what
>> I was asking.  What I was asking was about how to determine how much
>> data to send to compress it.  Read the message again, the whole thing
>> this time.
>
>I did. But modularity is the key here. The whole idea may be great or
>plain bullshit, depending on the benchmarks. Which one it is depends
>on the compression algorithm used, among other things. Maybe your
>compression algo is better for some machines, zlib for others, etc.
>

Yeah I know.  I really need to get a working user-space version of this
thing so I can bench it against source tarballs and extractions from
/dev/random a bunch of times.


>Why should someone decide on an algorithm before measuring?
>

Erm.  You can use any one of the other algos you want, there's a lot
out there.  Go ahead and try zlib/gzip/bzip2/7zip/compress if you
want.  I just figured, the simplest algo would hopefully be the fastest.
But really we need some finished code to make this work :-)

The real reason I'm working on this is because I favor speed completely
over size in this application.  It's all modular; make the interface for the
kernel module flexible enough to push in gzip/bzip2 modules or whatever
else you want:

<M> Swap partition support
____<M> Compressed Swap
________<M> fcomp
____________<M> fcomp-extended support
________<M> zlib
________<M> gzip
________<M> bzip2
________<M> compress
____<M> Swap on RAM

As far as I know, zlib, gzip, and compress use Huffman trees.  I am pretty
sure about zlib, not sure about the others.  gzip I believe uses 16 bit
backpointers as well, which means you need a 64k processing window
for [de]compression, not to mention that it takes more work.  bzip2 we
all know is CPU-intensive, or at least it was last time I checked.

>> >Then the mm code can pick any useful size for compression.
>> 
>> Eh?  I rather the code alloc space itself and do all its own handling. 
>That
>> way you don't have to second-guess the buffer size for decompressed
>> data if you don't do all-at-once decompression (i.e. decompressing x86
>> segments, all-at-once would be to decompress the whole compressed
>> block of N size to 64k, where partial would be to pull in N/n at a time
>and
>> decompress in n sets of N/n, which would give varying sized output).
>
>Segments are old, stupid and x86 only. What you want is a number of
>pages, maybe just one at a time. Always compress chunks of the same
>size and you don't have to guess the decompressed size.
>

Yeah true.  But for guessing the decompressed size I meant like when
you don't want to load the WHOLE block into RAM at once.  Ahh, so you
swap in pages?  Well whatever unit you swap in, that's how you should
compress things.  Look I'm confusing myself here, just ignore anything
that sounds retarded--I'm just a kid after all :-p

>> Another thing is that the code isn't made to strictly stick to
>compressing
>> or decompressing a whole input all at once; you may break down the
>> input into smaller pieces.  Therefore it does need to think about how
>much
>> it's gonna actually tell you to pull off when you inquire about the size
>to
>> remove from the stream (for compression at least), because you might
>> break it if you pull too much data off midway through compression.  The
>> advantage of this method is in when you're A) Compressing files, and
>> B) trying to do this kind of thing on EXTREMELY low RAM systems,
>> where you can't afford to pass whole buffers back and forth.  (Think 4
>meg)
>
>a) Even with 4M, two pages of 4k each don't hurt that much. If they
>do, the whole compression trick doesn't pay off at all.
>b) Compression ratios usually suck with small buffers.
>
a)
True, two chunks of 4k don't hurt.  But how big are swap pages?  Assuming
the page can't be compressed at all, it's [page size / 256] * 3 + [page size]
for the maximum compressed data size.  (4144 bytes for 4k of absolutely
non-redundant data within 256 bytes).

b)
Yeah they do.  But to find the compression performance (ratio) loss, you
do [max pointer distance]/[block size], meaning like for this one
256/[page size].  If you do a 4k page size, you lose 6.25% of the compression
performance (so if we average 2:1, we'll average 1.875:1).  What IS the page
size the kernel uses?

>> You do actually understand the code, right?  I have this weird habit of
>> making code and doing such obfuscating comments that people go
>> "WTF is this?" when they see it.  Then again, you're probably about
>> 12 classes past me in C programming, so maybe it's just my logic that's
>> flawed. :)
>
>I didn't look that far yet. What you could do, is read through
>/usr/src/linux/Documentation/CodingStyle. It is just so much nicer
>(and faster) to read and sticking to it usually produces better code.
>

Eh, I should just crack open the kernel source and immitate it.  But I have
that file on my hard disk, so mebbe I should look.  Mebbe I should take a
whack at getting the compression algo to work too, instead of pushing it
on someone else.


>Jörn
>
>-- 
>Beware of bugs in the above code; I have only proved it correct, but
>not tried it.
>-- Donald Knuth



