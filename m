Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281463AbRLICAg>; Sat, 8 Dec 2001 21:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281484AbRLICA0>; Sat, 8 Dec 2001 21:00:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:28431 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281463AbRLICAN>; Sat, 8 Dec 2001 21:00:13 -0500
Message-ID: <3C12C57C.FF93FAC0@zip.com.au>
Date: Sat, 08 Dec 2001 17:59:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: zlatko.calusic@iskon.hr
CC: sct@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ext3 writeback mode slower than ordered mode?
In-Reply-To: <871yi5wh93.fsf@atlas.iskon.hr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic wrote:
> 
> Hi!
> 
> My apologies if this is an FAQ, and I'm still catching up with
> the linux-kernel list.
> 
> Today I decided to convert my /tmp partition to be mounted in
> writeback mode, as I noticed that ext3 in ordered mode syncs every 5
> seconds and that is something defenitely not needed for /tmp, IMHO.
> 
> Then I did some tests in order to prove my theory. :)
> 
> But, alas, writeback is slower.
> 

I cannot reproduce this.  Using http://www.zip.com.au/~akpm/writer.c

ext2:            0.03s user 1.43s system 97% cpu 1.501 total
ext3 writeback:  0.02s user 2.33s system 96% cpu 2.431 total
ext3 ordered:    0.02s user 2.52s system 98% cpu 2.574 total

ext3 is significantly more costly in either journalling mode,
probably because of the bitmap manipulation - each time we allocate
a block to the file, we have to muck around doing all sorts
of checks and list manipulations against the buffer which holds
the bitmap.  Not only is this costly, but ext2 speculatively
sets a bunch of bits at the same time, which ext3 cannot do
for consistency reasons.

There are a few things we can do to pull this back, but given that
this is all pretty insignificant once you actually start doing disk
IO, we couldn't justify the risk of destabilising the filesystem
for small gains.
