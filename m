Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263127AbUK0APq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbUK0APq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUK0ALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:11:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28903 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263135AbUK0AHP
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:07:15 -0500
Date: Fri, 26 Nov 2004 16:58:33 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Andrew Morton <AKPM@Osdl.ORG>,
       Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-ID: <20041126185833.GA7740@logos.cnet>
References: <16800.47044.75874.56255@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16800.47044.75874.56255@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 06:44:04PM +0300, Nikita Danilov wrote:
> Batch mark_page_accessed() (a la lru_cache_add() and lru_cache_add_active()):
> page to be marked accessed is placed into per-cpu pagevec
> (page_accessed_pvec). When pagevec is filled up, all pages are processed in a
> batch.
> 
> This is supposed to decrease contention on zone->lru_lock.

Here are the STP 8way results:

8way:

reaim default (database IO intensive load), increases performance _significantly_:
------------------------------------------
kernel: patch-2.6.10-rc2
Peak load Test: Maximum Jobs per Minute 8491.96 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 8326.23 (average of 3 runs)

kernel: nikita-b2
Peak load Test: Maximum Jobs per Minute 9039.56 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 8325.09 (average of 3 runs)


reaim -w compute (compute intensive load), decreases performance:
-----------------------------------------
kernel: patch-2.6.10-rc2
Peak load Test: Maximum Jobs per Minute 9591.82 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 9359.76 (average of 3 runs)

kernel: nikita-b2
Peak load Test: Maximum Jobs per Minute 9533.34 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 9324.25 (average of 3 runs)

kernbench 

Decreases performance significantly (on -j4 more notably), probably due to 
the additional atomic operations as noted by Andrew:

kernel: nikita-b2                               kernel: patch-2.6.10-rc2
Host: stp8-002                                  Host: stp8-003

Average Optimal -j 32 Load Run:                 Average Optimal -j 32 Load Run:
Elapsed Time 130                                Elapsed Time 129.562
User Time 872.816                               User Time 871.898
System Time 88.978                              System Time 87.346
Percent CPU 739.2                               Percent CPU 739.8
Context Switches 35111.4                        Context Switches 34973.2
Sleeps 28182.6                                  Sleeps 28465.2

Average Maximal -j Load Run:                    Average Maximal -j Load Run:
Elapsed Time 128.862                            Elapsed Time 128.334
User Time 868.234                               User Time 867.702
System Time 86.888                              System Time 85.318
Percent CPU 740.6                               Percent CPU 742.2
Context Switches 27278.2                        Context Switches 27210
Sleeps 19889                                    Sleeps 19898.4

Average Half Load -j 4 Run:                     Average Half Load -j 4 Run:
Elapsed Time 274.916                            Elapsed Time 245.026
User Time 833.63                                User Time 832.34
System Time 73.704                              System Time 73.41
Percent CPU 335.8                               Percent CPU 373.6
Context Switches 12984.8                        Context Switches 13427.4
Sleeps 21459.2                                  Sleeps 21642


