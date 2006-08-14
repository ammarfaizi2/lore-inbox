Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWHNHRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWHNHRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWHNHRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:17:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23490 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751592AbWHNHRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:17:49 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 14 Aug 2006 17:17:29 +1000
Message-ID: <17632.9097.195772.410011@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@google.com>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
In-Reply-To: message from Peter Zijlstra on Monday August 14
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
	<20060813215853.0ed0e973.akpm@osdl.org>
	<1155531835.5696.103.camel@twins>
	<20060813222208.7e8583ac.akpm@osdl.org>
	<1155537940.5696.117.camel@twins>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 14, a.p.zijlstra@chello.nl wrote:
> On Sun, 2006-08-13 at 22:22 -0700, Andrew Morton wrote:
> > 
> > We could track dirty anonymous memory and throttle.
> > 
> > Also, there must be some value of /proc/sys/vm/min_free_kbytes at which a
> > machine is no longer deadlockable with any of these tricks.  Do we know
> > what level that is?
> 
> Not sure, the theoretical max amount of memory one can 'lose' in socket
> wait queues is well over the amount of physical memory we have in
> machines today (even for SGI); this combined with the fact that we limit
> the memory in some way to avoid DoS attacks, could make for all memory
> to be stuck in wait queues. Of course this becomes rather more unlikely
> for ever larger amounts of memory. But unlikely is never a guarantee.

What is the minimum amount of memory we need to reserve for each
socket?  1K? 1 page?  Call it X
Suppose that whenever a socket is created (or bound or connected or
whatever is right) we first allocate that much to a recv pool.
If any socket has less than X queued, then it is allowed to allocate
up to a total of X from the reserve pool.  After that it can only
receive when memory can be allocated from elsewhere.  Then we will
never block on recv.

Note that X doesn't need to be the biggest possible incoming message.
It only needs to be enough to get an 'ack' over any possible network
storage protocol with any possible layering. I suspect that it well
within one page.

Would it be too much waste to reserve one page for every idle socket? 

Does this have some fatal flaw?

NeilBrown
