Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTJQROL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTJQROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:14:11 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:11650 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263131AbTJQROG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:14:06 -0400
Date: Fri, 17 Oct 2003 18:15:34 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310171715.h9HHFYUi001735@81-2-122-30.bradfords.org.uk>
To: Eli Carter <eli.carter@inet.com>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
In-Reply-To: <3F90175B.2000502@inet.com>
References: <1066163449.4286.4.camel@Borogove>
 <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com>
 <20031016162926.GF1663@velociraptor.random>
 <3F8ECA3E.4030208@draigBrady.com>
 <20031016231235.GB29279@pegasys.ws>
 <200310170803.h9H83ahx000164@81-2-122-30.bradfords.org.uk>
 <3F90025A.7070504@inet.com>
 <200310171527.h9HFRvU2001448@81-2-122-30.bradfords.org.uk>
 <3F90175B.2000502@inet.com>
Subject: Re: Transparent compression in the FS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Eli Carter <eli.carter@inet.com>:
> John Bradford wrote:
> >>>The upshot of all that would be that if you needed space, it would be
> >>>there, (just overwrite the uncompressed versions of files), but until
> >>>you do, you can access the uncompressed data quickly.
> >>>
> >>>You could even take it one step further, and compress files with gzip
> >>>by default, and re-compress them with bzip2 after long periods of
> >>>inactivity.
> >>
> >>Note that a file compressed with bzip2 is not necessarily smaller than 
> >>the same file compressed with gzip.  (It can be quite a bit larger in fact.)
> > 
> > 
> > Have you noticed that with real-life data, or only test cases?
> 
> Real-life data.  I don't remember the exact details for certain, but as 
> best as I can recall:  I was dealing with copies of output from build 
> logs, telnet sessions, messages files, or the like (i.e. text) that were 
> (many,) many MB in size (and probably highly repetitititititive).  I 
> wound up with a loop that compressed each file into a gzip and a bzip2, 
> compared the sizes, and killed the larger.  There were a number of .gz's 
> that won.  (I have also read that gzip is better at text compression 
> whereas bzip2 is better at binary compression.  No, I don't remember the 
> source.)

Wow, I'm really suprised, I've always had good results with text,
although quite possibly not as repetitive as yours.  I have noticed
that uncompressable data such as /dev/random is almost always expanded
to a greater extent with bzip2, which is why I asked.

> But that is immaterial... You have to deal with the case where the 
> 'better' algorithm gives 'worse' results (by size).  Keep in mind that 
> some data won't compress at all (for a given algorithm), and winds up 
> needing more space in the compressed form.  (In which case we add a byte 
> to say "this is not compressed" and keep the original form.)
> 
> uncompressed -> gzip; gzip -> bzip2 would be by far the normal case
> But, sometimes gzip can't get it any smaller, or would increase the 
> size.  (Keep in mind we may be storing a file that is already compressed...)
> 
> So your scheme needs to note when compression fails so it doesn't try 
> again, so we see:
> 
> uncompressed -> gzip or uncompressed(gzip failed)
> gzip -> bzip2 or gzip(bzip2 failed)
> uncompressed(gzip failed) -> bzip2 or uncompressed(bzip2 failed)

It might also be worth only using a much slower compressor if we get
at least N% better results.  Literally saving 0.1% of the size at the
expense of 5x worse decompression time is possibly not worth while in
most cases.

> If it were me, I'd do it with one compression algorthim as a 
> proof-of-concept, then add a second, and then generalize it to N cases 
> (which would not be hard once the 2 cases was done).
> 
> But I must say, I like your idea of keeping the uncompressed form around 
> until we need the space.  (I'd also want to track reads separately from 
> writes.)

Yes - one write would be worth a lot of reads in terms of keeping it
uncompressed.

Heh, it might also help if you get a bad sector on one of the copies
:-).

John.
