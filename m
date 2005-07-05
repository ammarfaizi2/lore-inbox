Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVGEOO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVGEOO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGEOO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 10:14:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:54187 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261860AbVGEOAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 10:00:30 -0400
From: Chris Mason <mason@suse.com>
To: suparna@in.ibm.com
Subject: Re: aio-stress throughput regressions from 2.6.11 to 2.6.12
Date: Tue, 5 Jul 2005 10:00:24 -0400
User-Agent: KMail/1.8
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20050701075600.GC4625@in.ibm.com>
In-Reply-To: <20050701075600.GC4625@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051000.25591.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 July 2005 03:56, Suparna Bhattacharya wrote:
> Has anyone else noticed major throughput regressions for random
> reads/writes with aio-stress in 2.6.12 ?
> Or have there been any other FS/IO regressions lately ?
>
> On one test system I see a degradation from around 17+ MB/s to 11MB/s
> for random O_DIRECT AIO (aio-stress -o3 testext3/rwfile5) from 2.6.11
> to 2.6.12. It doesn't seem filesystem specific. Not good :(
>
> BTW, Chris/Ben, it doesn't look like the changes to aio.c have had an
> impact (I copied those back to my 2.6.11 tree and tried the runs with no
> effect) So it is something else ...
>
> Ideas/thoughts/observations ?

Lets try to narrow it down a bit:

aio-stress -o 3 -d 1 will set the depth to 1, (io_submit then wait one request 
at a time).  This doesn't take the aio subsystem out of the picture, but it 
does make the block layer interaction more or less the same as non-aio 
benchmarks.  If this is slow, I would suspect something in the block layer, 
and iozone -I -i 2 -w -f testext3/rwfile5 should also show the regression.

If it doesn't regress, I would suspect something in the aio core.  My first 
attempts at the context switch reduction patches caused this kind of 
regression.  There was too much latency in sending the events up to userland.

Other options:

Try different elevators
Try O_SYNC aio random writes
Try aio random reads
Try buffers random reads

-chris
