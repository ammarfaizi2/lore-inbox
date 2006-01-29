Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWA2T5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWA2T5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWA2T5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:57:11 -0500
Received: from kanga.kvack.org ([66.96.29.28]:38786 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751133AbWA2T5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:57:09 -0500
Date: Sun, 29 Jan 2006 14:52:42 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, kiran@scalex86.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060129195242.GC28400@kvack.org>
References: <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org> <43DABAA4.8040208@cosmosbay.com> <20060129004459.GA24099@kvack.org> <43DC6691.9000001@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DC6691.9000001@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 07:54:09AM +0100, Eric Dumazet wrote:
> Well, I think that might be doable, maybe RCU magic ?
> 
> 1) local_t are not that nice on all archs.

It is for the users that matter, and the hooks are there if someone finds 
it to be a performance problem.

> 2) The consolidation phase (summing all the cpus local offset to 
> consolidate the central counter) might be more difficult to do (we would 
> need kind of 2 counters per cpu, and a index that can be changed by the cpu 
> that wants a consolidation (still 'expensive'))

For the vast majority of these sorts of statistics counters, we don't 
need 100% accurate counts.  And I think it should be possible to choose 
between a lightweight implementation and the expensive implementation.  
On a chip like the Core Duo the cost of bouncing between the two cores 
is minimal, so all the extra code and data is a waste.

> 3) Are the locked ops so expensive if done on a cache line that is mostly 
> in exclusive state in cpu cache ?

Yes.  What happens on the P4 is that it forces outstanding memory 
transactions in the reorder buffer to be flushed so that the memory barrier 
semantics of the lock prefix are observed.  This can take a long time as
there can be over a hundred instructions in flight.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
