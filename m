Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbTD0ROF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 13:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTD0ROF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 13:14:05 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:49051 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264704AbTD0RNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 13:13:51 -0400
Date: Sun, 27 Apr 2003 13:24:37 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Re:  Swap Compression
In-reply-to: <20030427090418.GB6961@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304271324370750.01655617@smtp.comcast.net>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 4/27/2003 at 11:04 AM Jörn Engel wrote:

>On Sat, 26 April 2003 22:24:04 -0400, rmoser wrote:
>> 
>> So what's the best way to do this?  I was originally thinking like this:
>> 
>> Grab some swap data
>> Stuff it into fcomp_push()
>> When you have 100k of data, seal it up
>> Write that 100k block
>
>I would like something like this:
>
>/*	fox_compress
> *	@input: Pointer to uncompressed data
> *	@output: Pointer to buffer
> *	@inlen: Size of uncompressed data
> *	@outlen: Size of the buffer
> *
> *	Return:
> *	0 on successful compression
> *	-Esomething on error
> *
> *	Side effects:
> *	Output buffer is filled with random data after an error
> *	condition or the compressed input data on success.
> *	outlen remains unchanged on error and holds the compressed
> *	data size on success
> *
> *	If the output buffer is too small, this is an error.
> */
>int fox_compress(unsigned char *input, unsigned char *output,
>		uint32_t inlen, uint32_t *outlen);
>
>/*	fox_decompress
> *	see above, basically
> */
>int fox_decompress(unsigned char *input, unsigned char *output,
>		uint32_t inlen, uint32_t *outlen);
>

Ey? uint32_t*?  I assume that's a mistake....  Anyhow, this wasn't what
I was asking.  What I was asking was about how to determine how much
data to send to compress it.  Read the message again, the whole thing
this time.

>Then the mm code can pick any useful size for compression.
>
>Jörn

Eh?  I rather the code alloc space itself and do all its own handling.  That
way you don't have to second-guess the buffer size for decompressed
data if you don't do all-at-once decompression (i.e. decompressing x86
segments, all-at-once would be to decompress the whole compressed
block of N size to 64k, where partial would be to pull in N/n at a time and
decompress in n sets of N/n, which would give varying sized output).

Another thing is that the code isn't made to strictly stick to compressing
or decompressing a whole input all at once; you may break down the
input into smaller pieces.  Therefore it does need to think about how much
it's gonna actually tell you to pull off when you inquire about the size to
remove from the stream (for compression at least), because you might
break it if you pull too much data off midway through compression.  The
advantage of this method is in when you're A) Compressing files, and
B) trying to do this kind of thing on EXTREMELY low RAM systems,
where you can't afford to pass whole buffers back and forth.  (Think 4 meg)

You do actually understand the code, right?  I have this weird habit of
making code and doing such obfuscating comments that people go
"WTF is this?" when they see it.  Then again, you're probably about
12 classes past me in C programming, so maybe it's just my logic that's
flawed. :)

--Bluefox Icy
(John Moser in case something winds up with my name on it)

>
>-- 
>My second remark is that our intellectual powers are rather geared to
>master static relations and that our powers to visualize processes
>evolving in time are relatively poorly developed.
>-- Edsger W. Dijkstra
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



