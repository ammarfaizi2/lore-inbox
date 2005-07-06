Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVGFPEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVGFPEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 11:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVGFPEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 11:04:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59281 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262328AbVGFK2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:28:22 -0400
Date: Wed, 6 Jul 2005 16:07:29 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Chris Mason <mason@suse.com>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio-stress throughput regressions from 2.6.11 to 2.6.12
Message-ID: <20050706103729.GA4600@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050701075600.GC4625@in.ibm.com> <200507051000.25591.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507051000.25591.mason@suse.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 10:00:24AM -0400, Chris Mason wrote:
> On Friday 01 July 2005 03:56, Suparna Bhattacharya wrote:
> > Has anyone else noticed major throughput regressions for random
> > reads/writes with aio-stress in 2.6.12 ?
> > Or have there been any other FS/IO regressions lately ?
> >
> > On one test system I see a degradation from around 17+ MB/s to 11MB/s
> > for random O_DIRECT AIO (aio-stress -o3 testext3/rwfile5) from 2.6.11
> > to 2.6.12. It doesn't seem filesystem specific. Not good :(
> >
> > BTW, Chris/Ben, it doesn't look like the changes to aio.c have had an
> > impact (I copied those back to my 2.6.11 tree and tried the runs with no
> > effect) So it is something else ...
> >
> > Ideas/thoughts/observations ?
> 
> Lets try to narrow it down a bit:
> 
> aio-stress -o 3 -d 1 will set the depth to 1, (io_submit then wait one request 
This doesn't regress - the problem really happens when we don't wait one
at a time.

> at a time).  This doesn't take the aio subsystem out of the picture, but it 
> does make the block layer interaction more or less the same as non-aio 
> benchmarks.  If this is slow, I would suspect something in the block layer, 
> and iozone -I -i 2 -w -f testext3/rwfile5 should also show the regression.
> 
> If it doesn't regress, I would suspect something in the aio core.  My first 
> attempts at the context switch reduction patches caused this kind of 
> regression.  There was too much latency in sending the events up to userland.
> 
> Other options:
> 
> Try different elevators

Still regresses (I tried noop instead of as)

> Try O_SYNC aio random writes
> Try aio random reads
> Try buffers random reads

Again all these end up waiting one at a time with mainline because it
forces buffered AIO to be synchronous, so we the regression doesn't
show up. But, when I apply my patches to make buffered fsAIO async,
so we aren't waiting one at a time -- there is a similar regression.
In fact it was this regression that made me go back and check if it
was happening with AIO-DIO as well.

Regards
Suparna

> 
> -chris

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

