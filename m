Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbTBDNBk>; Tue, 4 Feb 2003 08:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTBDNBk>; Tue, 4 Feb 2003 08:01:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:42257 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267252AbTBDNBj>; Tue, 4 Feb 2003 08:01:39 -0500
Message-ID: <3E3FBC1C.167E779A@aitel.hist.no>
Date: Tue, 04 Feb 2003 14:11:56 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Padraig@Linux.ie
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95 vs 3.21 performance
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com> <3E3F9C82.7000607@Linux.ie>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig@Linux.ie wrote:
[...]
> Interesting. I just noticed that I get 50% decrease in
> the speed of my program if I just insert a printf(). I.E.
> my program is like:
> 
> printf()
> for(;;) {
>      do_sorting_loop_test();
> }
> 
> If I remove the initial printf it doubles in speed?
> I assume this is some weird caching thing?

Looks like a cacheline alignment issue to me.
This loop of yours occupy x cachelines on your cpu,
moving it in memory by adding the printf
might cause it to ocupy x+1 cachelines.
That might be noticeable if x is a really small number,
such as 1.

> gcc is 3.2.1 (same happens for 2.95..)
> 
> <boggle>
> Note this is with -O3. If I don't specify -O then
> leaving the printf in speeds things up by about 15%
> </boggle>

Sure - going from -O3 to -O changes code generation so
your loop code hits the cachelines differently.
In this case the printf moved the loop into
better alignment.

My advice is to put your test loop in a function of its own,
and do the printing in the function that calls it.
functions are always aligned the same (good) way so
that calling them will be fast.

You can tune the speed of your inner loop by experimenting
with the insertion of one or more NOP asms in front
of the loop.  Just be aware that all such tuning is wasted once
you change anything at all in that function - you'll have to
re-do the tuning each time. 

The compiler should ideally align the loops for maximum performance.
That can be hard though, considering all the different processors
that might run your program.  And aligning everything optimally
could waste a _lot_ of code space - so do this only for
small loops with lots of iterations.

Helge Hafting
