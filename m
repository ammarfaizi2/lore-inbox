Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVC3ICn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVC3ICn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 03:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVC3ICn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 03:02:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10183 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261814AbVC3ICd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 03:02:33 -0500
Date: Wed, 30 Mar 2005 10:02:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS client latencies
Message-ID: <20050330080224.GB19683@elte.hu>
References: <1112137487.5386.33.camel@mindpipe> <1112138283.11346.2.camel@lade.trondhjem.org> <1112139155.5386.35.camel@mindpipe> <1112139263.11892.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112139263.11892.0.camel@lade.trondhjem.org>
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


* Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> ty den 29.03.2005 Klokka 18:32 (-0500) skreiv Lee Revell:
> > On Tue, 2005-03-29 at 18:18 -0500, Trond Myklebust wrote:
> > > ty den 29.03.2005 Klokka 18:04 (-0500) skreiv Lee Revell:
> > > > I am seeing long latencies in the NFS client code.  Attached is a ~1.9
> > > > ms latency trace.
> > > 
> > > What kind of workload are you using to produce these numbers?
> > > 
> > 
> > Just a kernel compile over NFS.
> 
> In other words a workload consisting mainly of mmap()ed writes?

new files created during a kernel compile are done via open()/write().

looking at the trace it seems that the NFS client code is doing list 
walks over ~7000 entries (!), in nfs_list_add_request(). Whatever 
protocol/server-side gain there might be due to the sorting and 
coalescing, this CPU overhead seems extremely high - more than 1 msec 
for this single insertion!

the comment suggests that this is optimized for append writes (which is 
quite common, but by far not the only write workload) - but the 
worst-case behavior of this code is very bad. How about disabling this 
sorting altogether and benchmarking the result? Maybe it would get 
comparable coalescing (higher levels do coalesce after all), but wastly 
improved CPU utilization on the client side. (Note that the server 
itself will do sorting of any write IO anyway, if this is to hit any 
persistent storage - and if not then sorting so agressively on the 
client side makes little sense.)

i think normal NFS benchmarks would not show this effect, as writes are 
typically streamed in benchmarks. But once you have lots of outstanding 
requests and a write comes out of order, CPU utilization (and latency) 
skyrockets.

	Ingo
