Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTE2Rdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTE2Rdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:33:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60937 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262464AbTE2Rdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:33:41 -0400
Date: Thu, 29 May 2003 19:46:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Willy TARREAU <willy@w.ods.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529174626.GA27477@alpha.home.local>
References: <3ED2DE86.2070406@storadinc.com> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local> <200305291607.33211.m.c.p@wolk-project.de> <20030529160604.GA4985@pcw.home.local> <20030529164940.GS1453@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529164940.GS1453@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 06:49:40PM +0200, Andrea Arcangeli wrote:
> btw, were you running parallel reads or writes at the same time? (i.e.
> launching xterms or ps etc.. in parallel?) I ask because if xterm
> startups quick is because the write workload is getting more seeks in
> its way.

Well, you're right, I was starting some xterms, but not that much perhaps
a tens during all the test.
 
> I'd be very interested if you can measure a bonnie performance change in
> contigous reads and writes on a otherwise completely idle machine, the
> size of the queue has to be big enough to keep the I/O pipeline full
> during contigous writes at full speed.

for this I'll have to install bonnie, I won't do it right now.

> you can also try with:
> 
> 	echo 20 500 0 0 500 3000 30 10 >/proc/sys/vm/bdflush

interestingly, it seems as the lower the last 2 values, the longer it takes.
I retried without opening any xterm, and it took 130 seconds. With the above
changes to bdflush, 135 s. With '80 50', 118s.

vmstat also show me that the test begins at a sustained 16-19 MB/s write
throughput during about the first minute. Then it starts to show regular drops
to 5-7 MB/s for 6-7s, and goes back to full speed. Since this is on reiserfs,
I wonder if this activity is not related to the journal.

Moreover, the disk still writes during about 10s after the end of the dd, so
I don't think that mesuring the time dd takes to complete is a good indicator
of anything (or I should try with a final sync).

If I write simultaneously to two 1G files, wait a few time and then read from
them while still writing, I begin to wait a few seconds for xterm to give me
the prompt. But when writes finish and there are only concurrent reads,
everything gets smooth again, eventhough the disk emits a terrible seek sound !

Cheers,
Willy

