Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVC3OL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVC3OL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVC3OL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:11:29 -0500
Received: from pat.uio.no ([129.240.130.16]:13477 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261887AbVC3OLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:11:24 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050330080224.GB19683@elte.hu>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
	 <1112139155.5386.35.camel@mindpipe>
	 <1112139263.11892.0.camel@lade.trondhjem.org>
	 <20050330080224.GB19683@elte.hu>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 09:11:00 -0500
Message-Id: <1112191860.10634.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.512, required 12,
	autolearn=disabled, AWL 1.44, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 30.03.2005 Klokka 10:02 (+0200) skreiv Ingo Molnar:

> the comment suggests that this is optimized for append writes (which is 
> quite common, but by far not the only write workload) - but the 
> worst-case behavior of this code is very bad. How about disabling this 
> sorting altogether and benchmarking the result? Maybe it would get 
> comparable coalescing (higher levels do coalesce after all), but wastly 
> improved CPU utilization on the client side. (Note that the server 
> itself will do sorting of any write IO anyway, if this is to hit any 
> persistent storage - and if not then sorting so agressively on the 
> client side makes little sense.)

No. Coalescing on the client makes tons of sense. The overhead of
sending 8 RPC requests for 4k writes instead of sending 1 RPC request
for a single 32k write is huge: among other things, you end up tying up
8 RPC slots on the client + 8 nfsd threads on the server instead of just
one of each.
You also end up allocating 8 times a much memory for supporting
structures such as rpc_tasks. That sucks when you're in a low memory
situation and are trying to push dirty pages to the server as fast as
possible...

What we can do instead is to do the same thing that the VM does: use a
radix tree with tags to do the sorting of the nfs_pages when we're
actually building up the list of dirty pages to send.
We already have the radix tree to do that, all we need to do is add the
tags and modify the scanning function to use them.

Cheers,
 Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

