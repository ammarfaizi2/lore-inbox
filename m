Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264113AbRFNWYY>; Thu, 14 Jun 2001 18:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264117AbRFNWYP>; Thu, 14 Jun 2001 18:24:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41234 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264113AbRFNWYE>; Thu, 14 Jun 2001 18:24:04 -0400
Date: Thu, 14 Jun 2001 19:23:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: John Stoffel <stoffel@casc.com>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <15145.11683.861734.853957@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.33.0106141908220.28370-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, John Stoffel wrote:

> Rik> There's another issue.  If dirty data is written out in small
> Rik> bunches, that means we have to write out the dirty data more
> Rik> often.
>
> What do you consider a small bunch?  32k?  1Mb?  1% of buffer space?
> I don't see how delaying writes until the buffer is almost full really
> helps us.  As the buffer fills, the pressure to do writes should
> increase, so that we tend, over time, to empty the buffer.
>
> A buffer is just that, not persistent storage.
>
> And in the case given, we were not seeing slow degradation, we saw
> that the user ran into a wall (or inflection point in the response
> time vs load graph), which was pretty sharp.  We need to handle that
> more gracefully.

No doubt on the fact that we need to handle it gracefully,
but as long as we don't have any answers to any of the
tricky questions you're asking above it'll be kind of hard
to come up with a patch ;))

> Rik> This in turn means extra disk seeks, which can horribly interfere
> Rik> with disk reads.
>
> True, but are we optomizing for reads or for writes here?  Shouldn't
> they really be equally weighted for priority?  And wouldn't the
> Elevator help handle this to a degree?

We definately need to optimise for reads.

Every time we do a read, we KNOW there's a process waiting
on the data to come in from the disk.

Most of the time we do writes, they'll be asynchronous
delayed IO which is done in the background. The program
which wrote the data has moved on to other things long
since.

> Some areas to think about, at least for me.  And maybe it should be
> read and write pressure, not rate?
>
>  - low write rate, and a low read rate.
>    - Do seeks dominate our IO latency/throughput?

Seeks always dominate IO latency ;)

If you have a program which needs to get data from some file
on disk, it is beneficial for that program if the disk head
is near the data it wants.

Moving the disk head all the way to the other side of the
disk once a second will not slow the program down too much,
but moving the disk head away 30 times a second "because
there is little disk load" might just slow the program
down by a factor of 2 ...

Ie. if the head is in the same track or in the track next
door, we only have rotational latency to count for (say 3ms),
if we're on the other side of the disk we also have to count
in seek time (say 7ms). Giving the program 30 * 7 = 210 ms
extra IO wait time per second just isn't good ;)

> - low write rate, high read rate.
>   - seems like we want to keep writing the buffers, but at a lower
>     rate.

Not at a lower rate, just in larger blocks.  Disk transfer
rate is so rediculously high nowadays that seek time seems
the only sensible thing to optimise for.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

