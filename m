Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVCaHfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVCaHfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVCaHfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:35:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30697 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262530AbVCaHad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:30:33 -0500
Date: Thu, 31 Mar 2005 09:30:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331073017.GA16577@elte.hu>
References: <1112192778.17365.2.camel@mindpipe> <1112194256.10634.35.camel@lade.trondhjem.org> <20050330115640.0bc38d01.akpm@osdl.org> <1112217299.10771.3.camel@lade.trondhjem.org> <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org> <1112237239.26732.8.camel@mindpipe> <1112240918.10975.4.camel@lade.trondhjem.org> <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330231801.129b0715.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Well.  The radix-tree approach's best-case is probably quite a lot 
> worse than the list-based approach's best-case.  It hits a lot more 
> cachelines and involves a lot more code.

The list-based approach's best-case are large continuous append writes.  
No sorting overhead, and light data structures.

i'd say this workload should be not that bad under the radix tree either 
- the gang lookup stuffs a nice vector of 16 pages into an array.

we definitely can say nothing based on the observation that a _single_ 
page took 1.9 msecs in Lee's previous measurement, while 7700 pages now 
take 6 msecs to process.

> But of course the radix-tree's worst-case will be far better than 
> list's.

the generic VM/pagecache has proven that the radix tree wins hands down 
for alot more workloads than the worst-case.

> And presumably that list-based code rarely hits the worst-case, else 
> it would have been changed by now.

that was my other point in a previous mail: most write benchmarks do 
continuous append writes, and CPU overhead easily gets lost in network 
latency.

Also, considering that a good portion of the NFS client's code is still 
running under the BKL one would assume if the BKL hurts performance it 
would have been changed by now? ;-)

	Ingo
