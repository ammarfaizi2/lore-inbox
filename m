Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVAEXvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVAEXvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAEXvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:51:46 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:57785 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262663AbVAEXvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:51:44 -0500
Message-ID: <41DC7D86.8050609@yahoo.com.au>
Date: Thu, 06 Jan 2005 10:51:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, riel@redhat.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com> <20050105020859.3192a298.akpm@osdl.org> <20050105180651.GD4597@dualathlon.random> <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com> <20050105174934.GC15739@logos.cnet> <20050105134457.03aca488.akpm@osdl.org> <20050105203217.GB17265@logos.cnet>
In-Reply-To: <20050105203217.GB17265@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>>The caller would need to wait on all the zones which can satisfy the
>>caller's allocation request.  A bit messy, although not rocket science. 
>>One would have to be careful to avoid additional CPU consumption due to
>>delivery of multiple wakeups at each I/O completion.
>>
>>We should be able to demonstrate that such a change really fixes some
>>problem though.  Otherwise, why bother?
> 
> 
> Agreed. The current scheme works well enough, we dont have spurious OOM kills
> anymore, which is the only "problem" such change ought to fix. 
> 
> You might have performance increase in some situations I believe (because you 
> have perzone waitqueues), but I agree its does not seem to be worth the
> trouble.

I think what Andrea is worried about is that blk_congestion_wait is
fairly vague, and can be a source of instability in the scanning
implementation.

For example, if you have a heavy IO workload that is saturating your
disks, blk_congestion_wait may do the right thing and sleep until
they become uncongested and writeout can continue.

But at 2:00 am, when your backup job is trickling writes into another
block device, blk_congestion_wait returns much earlier, and before
many pages have been cleaned.

Bad example? Yeah maybe, but I think this is what Andrea is getting
at. Would it be a problem to replace those blk_congestion_waits with
unconditional io_schedule_timeout()s? That would be the dumb-but-more
-deterministic solution.
