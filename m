Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVKDPSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVKDPSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVKDPSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:18:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:37010 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751504AbVKDPSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:18:49 -0500
Date: Fri, 4 Nov 2005 16:18:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andy Nelson <andy@thermo.lanl.gov>
Cc: torvalds@osdl.org, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051104151842.GA5745@elte.hu>
References: <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051104145628.90DC71845CE@thermo.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104145628.90DC71845CE@thermo.lanl.gov>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Nelson <andy@thermo.lanl.gov> wrote:

> I think it was Martin Bligh who wrote that his customer gets 25% 
> speedups with big pages. That is peanuts compared to my factor 3.4 
> (search comp.arch for John Mashey's and my name at the University of 
> Edinburgh in Jan/Feb 2003 for a conversation that includes detailed 
> data about this), but proves the point that it is far more than just 
> me that wants big pages.

ok, this posting of you seems to be it:

 http://groups.google.com/group/comp.sys.sgi.admin/browse_thread/thread/39884db861b7db15/e0332608c52a17e3?lnk=st&q=&rnum=35#e0332608c52a17e3

|  Timing for the tree traveral+gravity calculation were
|
|   16MBpages    1MBpages    64kpages
|    1  *          *         2361.8s
|    8  86.4s     198.7s      298.1s
|   16  43.5s      99.2s      148.9s
|   32  22.1s      50.1s       75.0s
|   64  11.2s      25.3s       37.9s
|   96   7.5s      17.1s       25.4s
|
|   (*) test not done.
|
|   As near as I can tell the numbers show perfect
|   linear speedup for the runs for each page size.
|
|   Across different page sizes there is degradation
|   as follows:
|
|   16m --> 64k   decreases by a factor 3.39 in speed
|   16m --> 1m    decreases by a factor 2.25 in speed
|   1m  --> 64k   decreases by a factor 1.49 in speed

[...]
|
|   Sum over cpus of TLB miss times for each test:
|
|   16MBpages    1MBpages    64kpages
|    1                       3489s
|    8  64.3s     1539s      3237s
|   16  64.5s     1540s      3241s
|   32  64.5s     1542s      3244s
|   64  64.9s     1545s      3246s
|   96  64.7s     1545s      3251s
|
|   Thus the 16MB pages rarely produced page misses,
|   while the 64kB pages used up 2.5x more time than
|   the floating point operations that we wanted to
|   have. I have at least some feeling that the 16MB pages
|   rarely caused misses because with a 128 entry
|   TLB (on the R12000 cpu) that gives about 1GB of
|   addressible memory before paging is required at all,
|   which I think is quite comparable to the size of
|   the memory actually used.

to me it seems that this slowdown is due to some inefficiency in the 
R12000's TLB-miss handling - possibly very (very!) long TLB-miss 
latencies? On modern CPUs (x86/x64) the TLB-miss latency is rarely 
visible. Would it be possible to run some benchmarks of hugetlbs vs. 4K 
pages on x86/x64?

if my assumption is correct, then hugeTLBs are more of a workaround for 
bad TLB-miss properties of the CPUs you are using, not something that 
will inevitably happen in the future. Hence i think the 'factor 3x' 
slowdown should not be realistic anymore - or are you still running 
R12000 CPUs?

	Ingo
