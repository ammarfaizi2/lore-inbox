Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSEXJW3>; Fri, 24 May 2002 05:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317079AbSEXJW2>; Fri, 24 May 2002 05:22:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51725 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317078AbSEXJW1>;
	Fri, 24 May 2002 05:22:27 -0400
Message-ID: <3CEE0758.27110CAD@zip.com.au>
Date: Fri, 24 May 2002 02:26:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: linux-kernel@vger.kernel.org, "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> 
> >> I did a IO test with one sequential read and one sequential write
> >> to different files. I expected somewhat similar throughput on read
> >> and write. But it seemed that the read is blocked until the write
> >> finishes. After the write process finished, the read process slowly
> >> picks up the speed. Is Linux buffer cache in favor of write? How
> >> to tune it?
> > [...]
> > 2: Apply http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/read-latency2.patch
> 
> Hmmm, someone wrote a patch to fix another related problem: the fact
> that multiple readers read at a very different speed. It's not unusual
> that one reader gets stuck until all other have finished. I don't
> remember who wrote that patch, sorry.

Oh absolutely.   That's the reason why 2.4 is beating 2.5 at tiobench with
more than one thread.  2.5 is alternating fairly between threads and 2.4
is not.  So 2.4 seeks less.

I've been testing this extensively on 2.5 + multipage BIO I/O and when you
increase readahead from 32 pages (two BIOs) to 64 pages (4 BIOs), 2.5 goes
from perfect to horrid - each threads grabs the disk head and performs many,
many megabytes of read before any other thread gets a share.  Net effect is
that the tiobench numbers are great, but any operation which involves
reading disk has 30 or 60 second latencies.

Interestingly, it seems specific to IDE.  SCSI behaves well.

I have tons of traces and debug code - I'll bug Jens about this in a week or
so.

-
