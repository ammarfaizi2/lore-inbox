Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279599AbRKAT2g>; Thu, 1 Nov 2001 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279613AbRKAT20>; Thu, 1 Nov 2001 14:28:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:35569 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S279599AbRKAT2R>; Thu, 1 Nov 2001 14:28:17 -0500
Message-ID: <3BE18674.789AA1FB@mvista.com>
Date: Thu, 01 Nov 2001 09:29:24 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.3.95.1011101102602.30559A-101000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 1 Nov 2001, vda wrote:
> 
> > On Thursday 01 November 2001 00:52, Tim Schmielau wrote:
> >
> > > OK, absolutely last patch for today. Sorry to bother everyone, but the
> > > jiffies wraparound logic was broken in the previous patch.
> > >
> > > As stated before, I would kindly ask for widespread testing PROVIDED IT IS
> > > OK FOR YOU TO RISK THE STABILITY OF YOUR BOX!
> >
> > I see you dropped jiffies_hi update in timer int.
> > IMHO argument on wasting 6 CPU cycles or so per each timer int:
> >
> > -     jiffies++;
> > +     if(++jiffies==0) jiffies_hi++;
> >
> > is not justified. I'd rather see simple and correct code in timer int
> > rather than jumping thru the hoops in get_jiffies_64().
> >
> > For CPU cycle saving zealots: I advocate saving 2 static longs in get_jiffies
> > instead :-)
> > --
> > vda
> > -
> 
> Well not exactly zealots. I test a lot of stuff. In fact, the code
> you propose:
> 
>         if(++jiffies==0) jiffies_hi++;
> 
> ... actually works quite well:
> 
I think that bumping a u64 is actually faster.  We have to remember that
this code is executed every 10 ms.  It is not in a loop.  This means
that the chance of branch prediction being available is nil.  In this
case the processor will predict the branch as not taken and be wrong
(except for once every 1.3 years). 

On the other hand, the u64 bump has no branches, just an add carry. 
This amounts to 1 add carry each bump (assuming we can get cc to do the
add carry to memory) and no branches to predict.  We should also take
care to put the u64 in one cache line, of course.

George



> Script started on Thu Nov  1 10:23:54 2001
> # ./chk
> Simple bump = 13
> Bump chk and incr = 15
> # ./chk
> Simple bump = 13
> Bump chk and incr = 15
> # ./chk
> Simple bump = 13
> Bump chk and incr = 15
> # exit
> exit
> Script done on Thu Nov  1 10:24:08 2001
> 
> It adds only two CPU clock cycles if (iff) the 'C' compiler is
> well behaved.
> 
> Test code is appended. In the test code, I calculate everything, then
> print the results. This is so the 'C' library + system call doesn't
> mess up the cache. Note this if you use this as a template to test
> other questionable code snippets.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
>   ------------------------------------------------------------------------
>                        Name: test_jiff.tar.gz
>    test_jiff.tar.gz    Type: Unix Tape Archive (application/x-tar)
>                    Encoding: BASE64
