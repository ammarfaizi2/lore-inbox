Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbTAPLfY>; Thu, 16 Jan 2003 06:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbTAPLfY>; Thu, 16 Jan 2003 06:35:24 -0500
Received: from nowaydude.rearden.com ([64.160.169.126]:6603 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S266995AbTAPLfX>; Thu, 16 Jan 2003 06:35:23 -0500
Date: Thu, 16 Jan 2003 03:45:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.5{4,5,6,7,8} with contest
Message-Id: <20030116034519.7753395c.akpm@digeo.com>
In-Reply-To: <200301162114.12467.conman@kolivas.net>
References: <200301162114.12467.conman@kolivas.net>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2003 11:44:14.0611 (UTC) FILETIME=[98137630:01C2BD54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <conman@kolivas.net> wrote:
>
> dbench_load:
> Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.54      3   118     66.1    3       24.6    1.49
> 2.5.55      3   117     68.4    2       16.2    1.50
> 2.5.56      3   89      60.7    4       24.7    1.13
> 2.5.57      4   96      64.6    2       20.7    1.22
> 2.5.58      3   122     64.8    3       24.6    1.54

Is this statistically significant?

Looks like the I/O scheduler has slipped a bit.  Nick did some testing which
shows that read-latency2 is still outperforming 2.5 by a factor of twenty on
read-vs-write fairness.  He's working on that, but there is still a lot to do
on this front.  We are nowhere near good enough yet.


> A full set of archived results and hardware specs can be found here:
> http://www.osdl.org/projects/ctdevel/results/
> 
> This is a good time to repeat the bug report that looked like spam last time I 
> posted it (sorry my mailer seemed to bork):
> 
> Since moving contest to c I get an error trying to fork with all 2.5 kernels I 
> try after running it on the 6th load. The error does not occur with any 2.4 
> kernels. I have confirmed it is still present on 2.5.58.
> 
> To reproduce the problem:
> Run the latest version of contest without arguments (0.61pre) and after
> no_load,cacherun,process_load,ctar_load,xtar_load and io_load it bombs out 
> with:
> bmark.c:43: SYSTEM ERROR: Cannot allocate memory : fork error
> 
> It seems to occur only after a few loads followed by io_load.
> 

Ho hum.  "it works for me".

My guess would be that ext3 has confused vm_enough_memory().  See, if you
delete an ext3 file immediately after writing it (as io_load does), ext3 will
leave all the pages on the page LRU, with attached buffers.

These pages are trivially reclaimable, but as far as the VM accounting is
concerned these pages are nowhere to be seen.  So vm_enough_memory() says
"nope, not enough memory to fork".   Perhaps.

Could you please do

	echo 1 > /proc/sys/vm/overcommit_memory

and see if it goes away?

I don't know what to do about this yet.  Probably need to try to release
those buffers in ext3.

