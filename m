Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSHIVgx>; Fri, 9 Aug 2002 17:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSHIVgx>; Fri, 9 Aug 2002 17:36:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58891 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315971AbSHIVgw>;
	Fri, 9 Aug 2002 17:36:52 -0400
Message-ID: <3D543645.8EBD2C36@zip.com.au>
Date: Fri, 09 Aug 2002 14:38:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Daniel Phillips <phillips@arcor.de>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
References: <E17dBZN-0001Ng-00@starship> <Pine.LNX.4.44.0208090854001.1547-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> Also, I think the jury (ie Andrew) is still out on whether rmap is worth
> it.

The most glaring problem has been the fork/exec/exit overhead.  

Anton had a program which did 10,000 forks and we were looking at
the time it took for them all to exit.  Initial rmap slowed the exitting
by 400%, and we now have that down to 70%.

I've been treating a gcc configure script as the most forky workload
which we're likely to care about.  rmap slowed configure down by 7%
and the work Daniel and I have done has reduced that to 2.8%.

(Not that rmap is the biggest problem for configure:

c013c07c 176      1.93046     __page_add_rmap         
c013c194 225      2.46792     __page_remove_rmap      
c012a274 236      2.58857     free_one_pgd            
c012a7f8 405      4.44225     __constant_c_and_count_memset 
c01055fc 917      10.0581     poll_idle               
c012a6cc 1253     13.7436     __constant_memcpy       

It's that i387 struct copy.)

There don't seem to be any catastrophic failure modes here, and
I expect tests could be concocted against the virtual scan which
_do_ have gross performance problems.

So.  Not great, but OK if the reverse map gives us something back.
And I don't agree that the quality of page replacement is all too
hard to measure.  It's just that nobody has got off their butt
and tried to measure it.

The other worry is the ZONE_NORMAL space consumption of pte_chains.
We've halved that, but it will still make high sharing levels
unfeasible on the big ia32 machines.  We are dependant upon large
pages to solve that problem.  (Resurrection of pte_highmem is in
progress, but it doesn't work yet).

I don't see a sufficient case for reverting rmap at present, and
it's time to move on with other work.  There is nothing in the
queue at present which _requires_ rmap, so if we do hit a
showstopper then going back to a virtual scan will be feasible
for at least the next month.

Two points:

1) It would be most useful to have *some* damn test on the table
   which works better with 2.4-rmap, along with a believable
   description of why it's better.

2) If would be most irritating to reach 2.6.5 before discovering
   that there is some terrible resource consumption problem
   arising from the reverse map.  Now is a good time for people
   with large machines to be testing 2.5, please.  This is 
   happening, and I expect we'll be in better shape in a month
   or so.
