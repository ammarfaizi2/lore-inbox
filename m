Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132823AbRDITVt>; Mon, 9 Apr 2001 15:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132826AbRDITVk>; Mon, 9 Apr 2001 15:21:40 -0400
Received: from code.and.org ([63.113.167.33]:46309 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S132823AbRDITVW>;
	Mon, 9 Apr 2001 15:21:22 -0400
To: "Stephen D. Williams" <sdw@lig.net>
Cc: Michael Lindner <mikel@att.net>, Chris Wedgwood <cw@f00f.org>,
        Dan Maas <dmaas@dcine.com>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data   available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no>
	<015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net>
	<20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net>
	<3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph>
	<20010121133433.A1112@metastasis.f00f.org> <3A6A558D.5E0CF29E@att.net>
	<3AD1CD13.F1A917FA@lig.net>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 09 Apr 2001 15:16:08 -0400
In-Reply-To: "Stephen D. Williams"'s message of "Mon, 09 Apr 2001 10:54:11 -0400"
Message-ID: <nnbsq5opdz.fsf@code.and.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen D. Williams" <sdw@lig.net> writes:

> An old thread, but important to get these fundamental performance
> numbers up there:
> 
> 2.4.2 on an 800mhz PIII Sceptre laptop w/ 512MB ram:
> 
> elapsed time for 100000 pingpongs is
> 3.81327                                    
> 100000/3.81256
>         ~26229.09541095746689888159     
> 10000/.379912
>         ~26321.88506812103855629724  
> 
> 26300 compares to 8000/sec. quite well ;-)  You didn't give specs for
> your test machine unfortunately.
> 
> Since this tests both 'sides' of an application communication, it
> indicates a 'null transaction' rate of twice that.
> 
> This was typical cpu usage on a triple run of 10000:
> CPU states:  7.2% user, 92.7% system,  0.0% nice,  0.0% idle  

 I seemed to miss the original post, so I can't really comment on the
tests. However...

> Michael Lindner wrote:
> > 
> > OK, 2.4.0 kernel installed, and a new set of numbers:
> > 
> > test            kernel          ping-pongs/s. @ total CPU util  w/SOL_NDELAY
> > sample (2 skts) 2.2.18          100 @ 0.1%                      800 @ 1%
> > sample (1 skt)  2.2.18          8000 @ 100%                     8000 @ 50%
> > real app        2.2.18          100 @ 0.1%                      800 @ 1%
> > 
> > sample (2 skts) 2.4.0           8000 @ 50%                      8000 @ 50%
> > sample (1 skt)  2.4.0           10000 @ 50%                     10000 @ 50%
> > real app        2.4.0           1200 @ 50%                      1200 @ 50%
> > 
> > real app        Windows 2K      4000 @ 100%
> > 
> > The two points that still seem strange to me are:
> > 
> > 1. The 1 socket case is still 25% faster than the 2 socket case in 2.4.0
> > (in 2.2.18 the 1 socket case was 10x faster).
> > 
> > 2. Linux never devotes more than 50% of the CPU (average over a long
> > run) to the two processes (25% to each process, with the rest of the
> > time idle).
> > 
> > I'd really love to show that Linux is a viable platform for our SW, and
> > I think it would be doable if I could figure out how to get the other
> > 50% of my CPU involved. An "strace -rT" of the real app on 2.4.0 looks
> > like this for each ping/pong.
> > 
> >      0.052371 send(7, "\0\0\0
> > \177\0\0\1\3243\0\0\0\2\4\236\216\341\0\0\v\277"..., 32, 0) = 32
> > <0.000529>
> >      0.000882 rt_sigprocmask(SIG_BLOCK, ~[], [RT_0], 8) = 0 <0.000021>
> >      0.000242 rt_sigprocmask(SIG_SETMASK, [RT_0], NULL, 8) = 0
> > <0.000021>
> >      0.000173 select(8, [3 4 6 7], NULL, NULL, NULL) = 1 (in [6])
> > <0.000047>
> >      0.000328 read(6, "\0\0\0 ", 4)     = 4 <0.000031>
> >      0.000179 read(6,
> > "\177\0\0\1\3242\0\0\0\2\4\236\216\341\0\0\7\327\177\0\0"..., 28) = 28
> > <0.000075>

 The strace here shows select() with an infinite timeout, you're
numbers will be much better if you do (pseudo code)...

  struct timeval zerotime;

  zerotime.tv_sec = 0;
  zerotime.tv_usec = 0;

 if (!(ret = select( ... , &zerotime)))
  ret = select( ... , NULL);

...basically you completely miss the function call for __pollwait()
inside poll_wait (include/linux/poll.h in the linux sources, with
__pollwait being in fs/select.c).

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
