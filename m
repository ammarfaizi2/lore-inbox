Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbSKPVsz>; Sat, 16 Nov 2002 16:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbSKPVsz>; Sat, 16 Nov 2002 16:48:55 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:62103 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267375AbSKPVsv> convert rfc822-to-8bit; Sat, 16 Nov 2002 16:48:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Date: Sat, 16 Nov 2002 22:55:43 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200211161958.57677.m.c.p@wolk-project.de>
In-Reply-To: <200211161958.57677.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211162235.39620.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 November 2002 19:58, Marc-Christian Petersen wrote:

Hi Andrea,

> > just to make a quick test, can you try an hack like this combined with a
> > setting of elvtune -r 128 -w 256 on top of 2.4.20rc1?
> >
> > --- x/drivers/block/ll_rw_blk.c.~1~     Sat Nov  2 19:45:33 2002
> > +++ x/drivers/block/ll_rw_blk.c Sat Nov 16 19:44:20 2002
> > @@ -432,7 +432,7 @@ static void blk_init_free_list(request_q
> >
> >         si_meminfo(&si);
> >         megs = si.totalram >> (20 - PAGE_SHIFT);
> > -       nr_requests = 128;
> > +       nr_requests = 16;
> >         if (megs < 32)
> >                 nr_requests /= 2;
> >         blk_grow_request_list(q, nr_requests);
>
> hehe, Andrea, it seem's we both think of the same ... :-) ... I am just
> recompiling the kernel ... hang on.
Andrea, this makes a difference! The pausings are much less than before, but 
still occur. Situation below.

Another thing I've noticed, while doing the "cp -a xyz abc" in 
a loop the available memory decreases alot (silly caching of files)


Before copying:
---------------
MemTotal:       515992 kB
MemFree:        440876 kB
Buffers:          3808 kB
Cached:          24128 kB


While copying:
--------------
root@codeman:[/usr/src] # ./bla.sh
+ cd /usr/src
+ rm -rf linux-2.4.19-blaold linux-2.4.19-blanew
+ COUNT=0
+ echo 0
0
+ cp -a linux-2.4.19-vanilla linux-2.4.19-blaold
+ cp -a linux-2.4.19-vanilla linux-2.4.19-blanew

not yet finished the above and memory is this:

MemTotal:       515992 kB
MemFree:          3348 kB
Buffers:         12244 kB
Cached:         451608 kB

swap (500mb) turned off. Pausings are almost none. (without your patch / 
elvtune) even there were massive pauses.

If swap is turned on, swapusage grows alot and then, if SWAP is used, we have 
pauses (even more less than without your patch).

To free the used/cached memory I use umount /usr/src.

I think your proposal is good. Anything else I should test/change? Any further 
informations/test I can/should run?

Thnx alot!

ciao, Marc


