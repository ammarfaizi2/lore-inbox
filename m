Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTJQQW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbTJQQW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:22:59 -0400
Received: from zeke.inet.com ([199.171.211.198]:28870 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S263556AbTJQQWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:22:55 -0400
Message-ID: <3F90175B.2000502@inet.com>
Date: Fri, 17 Oct 2003 11:22:51 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <3F8ECA3E.4030208@draigBrady.com> <20031016231235.GB29279@pegasys.ws> <200310170803.h9H83ahx000164@81-2-122-30.bradfords.org.uk> <3F90025A.7070504@inet.com> <200310171527.h9HFRvU2001448@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>>The upshot of all that would be that if you needed space, it would be
>>>there, (just overwrite the uncompressed versions of files), but until
>>>you do, you can access the uncompressed data quickly.
>>>
>>>You could even take it one step further, and compress files with gzip
>>>by default, and re-compress them with bzip2 after long periods of
>>>inactivity.
>>
>>Note that a file compressed with bzip2 is not necessarily smaller than 
>>the same file compressed with gzip.  (It can be quite a bit larger in fact.)
> 
> 
> Have you noticed that with real-life data, or only test cases?

Real-life data.  I don't remember the exact details for certain, but as 
best as I can recall:  I was dealing with copies of output from build 
logs, telnet sessions, messages files, or the like (i.e. text) that were 
(many,) many MB in size (and probably highly repetitititititive).  I 
wound up with a loop that compressed each file into a gzip and a bzip2, 
compared the sizes, and killed the larger.  There were a number of .gz's 
that won.  (I have also read that gzip is better at text compression 
whereas bzip2 is better at binary compression.  No, I don't remember the 
source.)

But that is immaterial... You have to deal with the case where the 
'better' algorithm gives 'worse' results (by size).  Keep in mind that 
some data won't compress at all (for a given algorithm), and winds up 
needing more space in the compressed form.  (In which case we add a byte 
to say "this is not compressed" and keep the original form.)

uncompressed -> gzip; gzip -> bzip2 would be by far the normal case
But, sometimes gzip can't get it any smaller, or would increase the 
size.  (Keep in mind we may be storing a file that is already compressed...)

So your scheme needs to note when compression fails so it doesn't try 
again, so we see:

uncompressed -> gzip or uncompressed(gzip failed)
gzip -> bzip2 or gzip(bzip2 failed)
uncompressed(gzip failed) -> bzip2 or uncompressed(bzip2 failed)

If it were me, I'd do it with one compression algorthim as a 
proof-of-concept, then add a second, and then generalize it to N cases 
(which would not be hard once the 2 cases was done).

But I must say, I like your idea of keeping the uncompressed form around 
until we need the space.  (I'd also want to track reads separately from 
writes.)

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

