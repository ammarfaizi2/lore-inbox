Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272278AbRHXRon>; Fri, 24 Aug 2001 13:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272279AbRHXRod>; Fri, 24 Aug 2001 13:44:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62993 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272278AbRHXRoY>; Fri, 24 Aug 2001 13:44:24 -0400
Date: Fri, 24 Aug 2001 14:43:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <200108240739.f7O7dWj01330@mailc.telia.com>
Message-ID: <Pine.LNX.4.33L.0108241433130.31410-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Roger Larsson wrote:

> I earlier questioned this too...
> And I found out that read ahead was too short for modern disks.
> This is a patch I did it does also enable the profiling, the only needed
> line is the
> -#define MAX_READAHEAD  31
> +#define MAX_READAHEAD  511
> I have not tried to push it further up since this resulted in virtually
> equal total throughput for read two files than for read one.

Note that this can have HORRIBLE effects if the total
size of all the readahead windows combined doesn't fit
in your memory.

If you have 100 IO streams going on and you have space
for 50 of them, you'll find yourself with 100 threads
continuously pushing each other's read-ahead data out
of RAM.

100 threads may sound much, but 100 clients really isn't
that special for an ftp server...

This effect is made a lot worse with the use-once
strategy used in recent Linus kernels because:

1) under memory pressure, the inactive_dirty list is
   only as large as 1 second of pageout IO, meaning
   the sum of the readahead windows is smaller than
   with a kernel which doesn't do the use-once thing
   (eg. Alan's kernel)

2) the drop-behind strategy makes it much more likely
   that we'll replace the data we already used, instead
   of the read-ahead data we haven't used yet ... this
   means the data we are about to use has a better chance
   to be in memory

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

