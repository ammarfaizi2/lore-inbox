Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRDJTb2>; Tue, 10 Apr 2001 15:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRDJTbT>; Tue, 10 Apr 2001 15:31:19 -0400
Received: from [216.33.104.134] ([216.33.104.134]:38154 "HELO mail.lig.net")
	by vger.kernel.org with SMTP id <S131886AbRDJTbF>;
	Tue, 10 Apr 2001 15:31:05 -0400
Message-ID: <3AD35119.D1C5E90D@lig.net>
Date: Tue, 10 Apr 2001 14:29:45 -0400
From: "Stephen D. Williams" <sdw@lig.net>
Organization: CCI / Insta, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1dp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Antill <james@and.org>
Cc: Michael Lindner <mikel@att.net>, Chris Wedgwood <cw@f00f.org>,
        Dan Maas <dmaas@dcine.com>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data   
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no>
		<015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net>
		<20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net>
		<3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph>
		<20010121133433.A1112@metastasis.f00f.org> <3A6A558D.5E0CF29E@att.net>
		<3AD1CD13.F1A917FA@lig.net> <nnbsq5opdz.fsf@code.and.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Antill wrote:
> 
> "Stephen D. Williams" <sdw@lig.net> writes:
> 
> > An old thread, but important to get these fundamental performance
> > numbers up there:
> >
> > 2.4.2 on an 800mhz PIII Sceptre laptop w/ 512MB ram:
> >
> > elapsed time for 100000 pingpongs is
> > 3.81327
> > 100000/3.81256
> >         ~26229.09541095746689888159
> > 10000/.379912
> >         ~26321.88506812103855629724
...
>  I seemed to miss the original post, so I can't really comment on the
> tests. However...

It was a thread in January, but just ran accross it looking for
something else.  See below for results.


> > Michael Lindner wrote:
...
> > >      0.052371 send(7, "\0\0\0
> > > \177\0\0\1\3243\0\0\0\2\4\236\216\341\0\0\v\277"..., 32, 0) = 32
> > > <0.000529>
> > >      0.000882 rt_sigprocmask(SIG_BLOCK, ~[], [RT_0], 8) = 0 <0.000021>
> > >      0.000242 rt_sigprocmask(SIG_SETMASK, [RT_0], NULL, 8) = 0
> > > <0.000021>
> > >      0.000173 select(8, [3 4 6 7], NULL, NULL, NULL) = 1 (in [6])
> > > <0.000047>
> > >      0.000328 read(6, "\0\0\0 ", 4)     = 4 <0.000031>
> > >      0.000179 read(6,
> > > "\177\0\0\1\3242\0\0\0\2\4\236\216\341\0\0\7\327\177\0\0"..., 28) = 28
> > > <0.000075>
> 
>  The strace here shows select() with an infinite timeout, you're
> numbers will be much better if you do (pseudo code)...
> 
>   struct timeval zerotime;
> 
>   zerotime.tv_sec = 0;
>   zerotime.tv_usec = 0;
> 
>  if (!(ret = select( ... , &zerotime)))
>   ret = select( ... , NULL);
> 
> ...basically you completely miss the function call for __pollwait()
> inside poll_wait (include/linux/poll.h in the linux sources, with
> __pollwait being in fs/select.c).

Apparently the extra system call overhead outweighs any benefit.  In any
case, what you suggest would be better done in the kernel anyway.  The
time went from 3.7 to 4.4 seconds per 100000.

> 
> --
> # James Antill -- james@and.org
> :0:
> * ^From: .*james@and\.org
> /dev/null

-- 
sdw@lig.net  http://sdw.st
Stephen D. Williams
43392 Wayside Cir,Ashburn,VA 20147-4622 703-724-0118W 703-995-0407Fax 
Dec2000
