Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUE2FSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUE2FSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 01:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbUE2FSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 01:18:30 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:51838 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263609AbUE2FS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 01:18:28 -0400
Message-ID: <40B81D21.3020907@yahoo.com.au>
Date: Sat, 29 May 2004 15:18:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: big bw_pipe drop due to sched-domain patch?
References: <16568.6306.306924.154136@napali.hpl.hp.com>
In-Reply-To: <16568.6306.306924.154136@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> Today I noticed that going from 2.6.6 to 2.6.7-rc1 caused a big drop
> in LMbench2 bw_pipe throughput on a dual-CPU machine (2.6.7-rc1 shows
> 10 times lower bandwidth than 2.6.6).  It appears that the drop is due
> to the two tasks being distributed across the two CPUs, rather than
> being kept on the same CPU.  If I force the tasks to be pinned on a
> single CPU, e.g., like so:
> 
> 	$ taskset 1 ./bw_pipe
> 
> then performance is "only" about 10% worse than with 2.6.6.
> 
> Is this kind of drop expected?
> 

(please CC Ingo for scheduler related stuff too)


Previously (ie. pre sched-domains), pipe based wakeups would
unconditionally migrate the "wakee" onto the same CPU as the waker.
Great for benchmarks, but possibly not really essential for real
workloads, especially when tasks start getting pulled across NUMA
nodes (I'd be happy to be shown otherwise though).

sched-domains introduces instead a "soft bias" that attempts to
get wakers and wakees together. The concept is applied to _all_
types of wakeups, not just pipe based.

I think this is a slightly better scheme, but we could increase
the aggressiveness of the bias if it is proven to be useful.

I don't know why your taskset performance is lower. taskset should
completely take the scheduler out of the equation AFAIKS...
