Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318670AbSG0BTV>; Fri, 26 Jul 2002 21:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318671AbSG0BTV>; Fri, 26 Jul 2002 21:19:21 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:57582 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318670AbSG0BTU>;
	Fri, 26 Jul 2002 21:19:20 -0400
Date: Fri, 26 Jul 2002 21:22:31 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
Message-ID: <20020727012231.GA17490@www.kroptech.com>
References: <20020726120248.GI14839@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726120248.GI14839@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 02:02:48PM +0200, Jens Axboe wrote:
> The 2nd version of the deadline i/o scheduler is ready for some testing.
...
> Finally, I've done some testing on it. No testing on whether this really
> works well in real life (that's what I want testers to do), and no
> testing on benchmark performance changes etc. What I have done is
> beat-up testing, making sure it works without corrupting your data. I'm
> fairly confident that does. Most testing was on SCSI (naturally),
> however IDE has also been tested briefly.

Hi, Jens,

I'm interested in i/o performance (though more so in throughput than latency)
so I tried out the patches. I needed an extra bit (below) to get a compile
on 2.5.28.

My performance testing showed essentially no change with the deadline i/o
scheduler, but there are a multitude of possible reasons for that, including
user stupdity. Here's an outline of what I tried and what I observed:

The concept of deadline scheduling makes me think "latency" rather than 
"throughput" so I tried to run tests involving small i/os in the
presence of large streaming reads. I expected to see an improvement in
the time taken to service the small i/os. (Obviously, let me know if my
assumptions are all washed up ;) At the same time I wanted to see if there was
any impact (negative or positive) on the streaming workload.

Test #1: Simultaneously untarring two kernel trees (untar only, no gzip). The
idea here was that reading the source tarball was essentially a streaming read
while writing the output was a large number of relatively small writes. There
was less than 3 seconds difference in overall time between stock 2.5.28 and
-deadline. 

Test #2: Same as Test #1 with the addition of reading each *.c file in another
kernel tree while the untarring is going in the background. The idea here was
to see if the large set of small reads in the readonly workload would benefit.
Again, the difference was only a few seconds over several minutes.

Part of the issue here may be my test setup... All i/o was to the same (rather
slow) IDE disk. (The good news being 2.5 IDE did not blow up in my face under
all this stress.) Machine is a 2 CPU SMP PPro.

If these results are totally bogus, feel free to ignore them. If you have ideas
for other tests I should run, let me know and I'll oblige.

--Adam

--- elevator.h.orig	Fri Jul 26 20:59:06 2002
+++ elevator.h	Fri Jul 26 20:59:15 2002
@@ -93,10 +93,4 @@
 #define ELEVATOR_FRONT_MERGE	1
 #define ELEVATOR_BACK_MERGE	2
 
-/*
- * will change once we move to a more complex data structure than a simple
- * list for pending requests
- */
-#define elv_queue_empty(q)	list_empty(&(q)->queue_head)
-
 #endif

