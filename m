Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWEWSEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWEWSEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEWSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:04:55 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:29824 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1751146AbWEWSEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:04:55 -0400
Message-Id: <7.0.0.16.2.20060523094646.02429fd8@llnl.gov>
X-Mailer: QUALCOMM Windows Eudora Version 7.0.0.16
Date: Tue, 23 May 2006 11:04:23 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
From: Dave Peterson <dsp@llnl.gov>
Subject: Re: [PATCH (try #3)] mm: avoid unnecessary OOM kills
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com, ak@suse.de,
       linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov, dsp@llnl.gov
In-Reply-To: <4472A006.2090006@yahoo.com.au>
References: <200605230032.k4N0WCIU023760@calaveras.llnl.gov>
 <4472A006.2090006@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:39 PM 5/22/2006, Nick Piggin wrote:
>Does this fix observed problems on real (or fake) workloads? Can we have
>some more information about that?

The problems were observed when executing the C program shown below on a
machine with swap turned off.  Soon we will be deploying diskless clusters
(i.e. clusters with no swap space).  Our goal is to get an idea of how well
the machines will recover if users push their memory allocations a bit too
far.  This is a rather common occurrence in our environment since our users
run memory-intensive workloads and tend to try to push the machines to
their limits.  We are doing tests such as the one below in an effort to
identify and resolve problems before the diskless machines go into
production.  The fact that we see the bad behavior with reasonable
frequency even when testing on a single machine suggests to us that we
are likely to see it much more often in production on our 1000+ node
clusters.

On somewhat of a tangent, our motivations for going diskless are as follows:

    - Hard drive failure is by far our largest source of equipment failure.
    - Hard drives generate extra heat and take up space.  Both of these are
      substantial drawbacks when dealing with large clusters (i.e. 1000+ nodes).
    - cost savings (hard drives cost money)

>I still don't quite understand why all this mechanism is needed. Suppose
>that we single-thread the oom kill path (which isn't unreasonable, unless
>you need really good OOM throughput :P), isn't it enough to find that any
>process has TIF_MEMDIE set in order to know that an OOM kill is in progress?
>
>down(&oom_sem);
>for each process {
>  if TIF_MEMDIE
>     goto oom_in_progress;
>  else
>    calculate badness;
>}
>up(&oom_sem);

That would be another way to do things.  It's a tradeoff between either

    option A: Each task that enters the OOM code path must loop over all
              tasks to determine whether an OOM kill is in progress.

    or...

    option B: We must declare an oom_kill_in_progress variable and add
              the following snippet of code to mmput():

                put_swap_token(mm);
+               if (unlikely(test_bit(MM_FLAG_OOM_NOTIFY, &mm->flags)))
+                       oom_kill_finish();  /* terminate pending OOM kill */
                mmdrop(mm);

I think either option is reasonable (although I have a slight preference
for B since it eliminates substantial looping through the tasklist).

>Is all this really required? Shouldn't you just have in place the
>mechanism to prevent concurrent OOM killings in the OOM code, and
>so the page allocator doesn't have to bother with it at all (ie.
>it can just call into the OOM killer, which may or may not actually
>kill anything).

I agree it's desirable to keep the OOM killing logic as encapsulated
as possible.  However unless you are holding the oom kill semaphore
when you make your final attempt to allocate memory it's a bit racy.
Holding the OOM kill semaphore guarantees that our final allocation
failure before invoking the OOM killer occurred _after_ any previous
OOM kill victim freed its memory.  Thus we know we are not shooting
another process prematurely (i.e. before the memory-freeing effects
of our previous OOM kill have been felt).




#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CHUNKS 32

int 
main(int argc, char *argv[])
{
        unsigned long mb;
        unsigned long iter = 1;
        char *buf[CHUNKS];
        int i;

        if (argc < 2 || argc > 3) {
                fprintf(stderr, "usage: usemem megabytes [iterations]\n");
                exit(1);
        }
        mb = strtoul(argv[1], NULL, 0);
        if (argc == 3)
                iter = strtoul(argv[2], NULL, 0);
        if (mb < CHUNKS) {
                fprintf(stderr, "megabytes must be >= %d\n", CHUNKS);
                exit(1);
        }       

        for (i = 0; i < CHUNKS; i++) {
                fprintf(stderr, "%d: Mallocing %lu megabytes\n", i, mb/CHUNKS);
                buf[i] = (char *)malloc(mb/CHUNKS * 1024L * 1024L);
                if (!buf[i]) {
                        fprintf(stderr, "malloc failure\n");
                        exit(1);
                }
        }

        while (iter-- > 0) {
                for (i = 0; i < CHUNKS; i++) {
                        fprintf(stderr, "%d: Zeroing %lu megabytes at %p\n", 
                                        i, mb/CHUNKS, buf[i]);
                        memset(buf[i], 0, mb/CHUNKS * 1024L * 1024L);
                }
        }


        exit(0);
}


