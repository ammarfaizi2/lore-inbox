Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVDKT5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVDKT5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVDKT5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:57:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41378 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261905AbVDKT5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:57:33 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1113244710.4413.38.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 11 Apr 2005 20:57:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-04-11 at 19:38, Mingming Cao wrote:

> I agree. We should not skip the home block group of the file.  I guess
> what I was suggesting is, if allocation from the home group failed and
> we continuing the linear search the rest of block groups, we could
> probably try to skip the block groups without enough usable free blocks
> to make a reservation. 

Fair enough.  Once those are the only bgs left, performance is going to
drop pretty quickly, but that's not really avoidable on a very full
filesystem.

> Ah.. I see the win with the read lock now: once the a reservation window
> is added, updating it (either winding it forward and or searching for a
> avaliable window) probably is the majorirty of the operations on the
> tree, and using read lock for that should help reduce the latency.

Right.  The down side is that for things like a kernel "tar xf", we'll
be doing lots of small file unpacks, and hopefully most files will be
just one or two reservations --- so there's little winding forward going
on.  The searching will still be improved in that case.

Note that this may improve average case latencies, but it's not likely
to improve worst-case ones.  We still need a write lock to install a new
window, and that's going to have to wait for us to finish finding a free
bit even if that operation starts using a read lock.  

I'm not really sure what to do about worst-case here.  For that, we
really do want to drop the lock entirely while we do the bitmap scan.

That leaves two options.  Hold a reservation while we do that; or don't.
Holding one poses the problems we discussed before: either you hold a
large reservation (bad for disk layout in the presence of concurrent
allocators), or you hold smaller ones (high cost as you continually
advance the window, which requires some read lock on the tree to avoid
bumping into the next window.)

Just how bad would it be if we didn't hold a lock _or_ a window at all
while doing the search for new window space?  I didn't like that
alternative at first because of the problem when you've got multiple
tasks trying to allocate in the same space at the same time; but given
the locking overhead of the alternatives, I'm wondering if this is
actually the lesser evil.

--Stephen

