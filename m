Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUHMQsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUHMQsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHMQr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:47:59 -0400
Received: from jade.spiritone.com ([216.99.193.136]:49072 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266200AbUHMQrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:47:41 -0400
Date: Fri, 13 Aug 2004 09:47:33 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <92140000.1092415652@[10.10.2.4]>
In-Reply-To: <200408130934.20913.jbarnes@engr.sgi.com>
References: <200408121646.50740.jbarnes@engr.sgi.com> <200408130859.24637.jbarnes@engr.sgi.com> <89760000.1092414010@[10.10.2.4]> <200408130934.20913.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Jesse Barnes <jbarnes@engr.sgi.com> wrote (on Friday, August 13, 2004 09:34:20 -0700):

> On Friday, August 13, 2004 9:20 am, Martin J. Bligh wrote:
>> >> I really don't think this is a good idea - you're assuming there's
>> >> really no locality of reference, which I don't think is at all true in
>> >> most cases.
>> > 
>> > No, not at all, just that locality of reference matters more for stack
>> > and anonymous pages than it does for page cache pages.  I.e. we don't
>> > want a node to be filled up with page cache pages causing all other
>> > memory references from the process to be off node.
>> 
>> Does that actually happen though? Looking at the current code makes me
>> think it'll keep some pages free on all nodes at all times, and if kswapd
>> does it's job, we'll never fall back across nodes. Now ... I think that's
>> broken, but I think that's what currently happens - that was what we
>> discussed at KS ... I might be misreading it though, I should test it.
> 
> Not nearly enough pages for any sizeable app though.  Maybe the behavior could 
> be configurable?

Well, either we're:

1. Falling back and putting all our most recent accesses off-node.

or.

2. Not falling back and only able to use one node's memory for any one 
(single threaded) app.

Either situation is crap, though I'm not sure which turd we picked right
now ... I'd have to look at the code again ;-) I thought it was 2, but
I might be wrong.
 
>> Even if that's not true, allocating all your most recent stuff off-node is
>> still crap (so either way, I'd agree the current situation is broken), but
>> I don't think the solution is to push ALL your accesses (with n-1/n
>> probability) off-node ... we need to be more careful than that ...
> 
> Only page cache references...

Yeah, depends how important those are to the app though ;-) I absolutely
agree with you that the current situation is broken ... we need to do 
*something*.

>> Not sure I'd agree with that - it's the same problem as swappiness on a
>> global basis for non-NUMA machines. We want the pages we're using MOST to
>> be local, the others to be not-local, and that doesn't equate (necessarily)
>> to whether it's pagecache or not. Shared pages could indeed be dealt with
>> differently, and spread more global ... but I don't agree that pagecache
>> pages equate 1-1 with being globally shared - in fact, I think most often
>> the opposite is true.
> 
> Yeah, that's a good point.  That argues for configurability too.  We should 
> behave differently depending on whether the page is shared or not.

Right. An app that mmap'ed a big file then thrashed on it would be a good
example, though simple read-write heavily across a small fileset would do 
much same thing.

M.
