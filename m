Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbTDBKCg>; Wed, 2 Apr 2003 05:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbTDBKCg>; Wed, 2 Apr 2003 05:02:36 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41088 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262959AbTDBKCc>;
	Wed, 2 Apr 2003 05:02:32 -0500
Date: Wed, 2 Apr 2003 15:49:01 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: akpm@digeo.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem aio rdwr patchset
Message-ID: <20030402154901.A1511@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030401215957.A1800@in.ibm.com> <20030401152713.B26513@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401152713.B26513@redhat.com>; from bcrl@redhat.com on Tue, Apr 01, 2003 at 03:27:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 03:27:13PM -0500, Benjamin LaHaise wrote:
> On Tue, Apr 01, 2003 at 09:59:57PM +0530, Suparna Bhattacharya wrote:
> > I would really appreciate comments and review feedback 
> > from the perspective of fs developers especially on
> > the latter 2 patches in terms of whether this seems a 
> > sound approach or if I'm missing something very crucial
> > (which I just well might be)
> > Is this easy to do for other filesystems as well ?
> 
> I disagree with putting the iocb pointer in the task_struct: it feels 
> completely bogus as it modifies semantics behind the scenes without 
> fixing APIs.

You mean we could pass the iocb as a parameter all the way down 
for the async versions of the ops and do_sync_op() could just do 
a wait_for_sync_iocb() ?  

That was what I'd originally intended to do.
But then I experimented with the current->iocb alternative
because:

1. I wasn't sure how much API fixing, we could do at this stage.
   (it is after all pretty late in the 2.5 cycle) 
   If you notice I've been trying to tread very carefully in
   terms of the modifications to interfaces, especially anything
   that requires changes to all filesystems.
2. I wanted to quickly have something we could play with and run 
   performance tests on, with minimal changes/impact on existing
   code paths and sync i/o operations. Additionally current->iocb 
   gave me an simple way to detect blocking operations (schedules) 
   during aio, no matter how deep a subroutine we are in. (I have
   been using those indicators to prioritize which blocking 
   points to tackle)
3. After a first pass of trying to use retries for sync ops 
   as well, it seemed like being able to continue from a blocking 
   point directly as we do today would be more efficient (In 
   this case, we do care more about latency than we do for async 
   ops). So that meant a switch between return -EIOCBQUEUED and 
   blocking depending on whether this was an async or sync
   context. I could do that with an is_sync_iocb() check as 
   well (vs current->iocb), but even that would be changing 
   semantics. 

So if (1) is sorted out, i.e. we still have the opportunity 
to alter some APIs, then we could do it that way.
Do we ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

