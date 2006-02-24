Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWBXLMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWBXLMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWBXLMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:12:31 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:3532 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751046AbWBXLMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:12:30 -0500
Date: Fri, 24 Feb 2006 16:42:40 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: akpm@osdl.org, sct@redhat.com, mason@suse.com,
       linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       kenneth.w.chen@intel.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, sonny@burdell.org
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
Message-ID: <20060224111239.GA2180@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060223072955.GA14244@in.ibm.com> <43FE5F84.4000001@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE5F84.4000001@oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:21:08PM -0800, Zach Brown wrote:
> Suparna Bhattacharya wrote:
> 
> > A recent AIO-DIO bug reported by Kenneth Chen, came very close
> > to being the proverbial last straw for me.
> 
> Me too, though I found out about it from a different path.  Our QA guys
> were pulling drives under load and it got stuck.  Trying to fix that bug
> (io error setting dio->result to -EIO stops finished_one_bio() from
> calling aio_complete()) without introducing other regressions involved
> an incredible amount of squinting and head scratching.  In wandering
> around I found what seem to be other additional bugs:
> 
> - errors that hit after dio->result is sampled in the buffered fallback
> case are lost.  dio->result should be checked again after waiting.
> 
> - a few paths try to do arithmetic with dio->result assuming it's the
> number of bytes transferred when it could be -EIO.

Yes there is a race in the way dio->result is used both by completion
path and the post submission path.

> 
> - the AIO path seems to forget to check dio->page_errors, but I didn't
> look very hard to see what that means.
> 
> - the AIO bio completion paths don't populate dio->bio_list so reaping
> doesn't happen in the AIO issuing case.. maybe that's intentional?

It is intentional. The async case operates differently in that it
doesn't need/use the reaping logic at all. It just submits the entire
IO outright, without the pipelining sophistication of the original
synchronous DIO code. That's yet another point of divergence between
AIO and synchronous path, perhaps it would have been simpler if both
followed the same logic.

> 
> > It would be quite pointless (and painful!), if the rewrite ends up becoming
> > just as tricky and error prone as before. Such a patch will need a very
> > close critical review by many sharp eyes, to avoid disrupting the current
> > state of stability.
> 
> So, I'm all for wringing the current bugs and confusion out of the
> current code.  But the words "a patch" and "rewrite" terrify me.  It

Perhaps I shouldn't have used the term rewrite. The proposal retains
much of the current core logic, but mainly alters the way we
serialise vs concurrent buffered IO, and other pain points. But it
would certainly be more than incremental patches to fix individual
problems.

My concern is that incremental fixes seem to be adding to the complexity
over time, making subsequent modifications trickier, because they have
to conform to the current base which is a little messy. Can you
think of an incremental path towards greater simplicity ?

> seems much more prudent to make progress with incremental patches that
> can be tested and reviewed.  Especially if that is tied to writing tests
> as changes are made.

Stephen Tweedie's original test and Daniel McNeil's set of tests already
cover some of the cases. I suspect that either way we'll need to keep
adding regression tests which can be run everytime someone makes a change
or bug fix to the code. It is easy to forget or miss the implication of
a subtle step during reviews because the code is so complex.

> 
> Let me think harder about the specific proposals..

Thanks for taking a look at it, I'll wait for your inputs ...

Regards
Suparna

> 
> - z
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

