Return-Path: <linux-kernel-owner+w=401wt.eu-S1752394AbXACE6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbXACE6y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXACE6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:58:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:59671 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbXACE6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:58:53 -0500
Date: Wed, 3 Jan 2007 10:33:23 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20070103050323.GA3201@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <5A322D46-A73A-43DD-8667-CE218DDA48B0@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A322D46-A73A-43DD-8667-CE218DDA48B0@oracle.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 03:56:09PM -0800, Zach Brown wrote:
> Sorry for the delay, I'm finally back from the holiday break :)

Welcome back !

> 
> >(1) The filesystem AIO patchset, attempts to address one part of
> >the problem
> >    which is to make regular file IO, (without O_DIRECT)
> >asynchronous (mainly
> >    the case of reads of uncached or partially cached files, and
> >O_SYNC writes).
> 
> One of the properties of the currently implemented EIOCBRETRY aio
> path is that ->mm is the only field in current which matches the
> submitting task_struct while inside the retry path.

Yes and that as I guess you know is to enable the aio worker thread to
operate on the caller's address space for copy_from/to_user. 

The actual io setup and associated checks are expected to have been
handled at submission time.

> 
> It looks like a retry-based aio write path would be broken because of
> this.  generic_write_checks() could run in the aio thread and get its
> task_struct instead of that of the submitter.  The wrong rlimit will
> be tested and SIGXFSZ won't be raised.  remove_suid() could check the
> capabilities of the aio thread instead of those of the submitter.

generic_write_checks() are done in the submission path, not repeated during
retries, so such types of checks are not intended to run in the aio thread.

Did I miss something here ?

> 
> I don't think EIOCBRETRY is the way to go because of this increased
> (and subtle!) complexity.  What are the chances that we would have
> ever found those bugs outside code review?  How do we make sure that
> current references don't sneak back in after having initially audited
> the paths?

The EIOCBRETRY route is not something that is intended to be used blindly,
It is just one alternative to implement an aio operation by splitting up
responsibility between the submitter and aio threads, where aio threads 
can run in the caller's address space.

> 
> Take the io_cmd_epoll_wait patch..
> 
> >    issues). The IO_CMD_EPOLL_WAIT patch (originally from Zach
> >Brown with
> >    modifications from Jeff Moyer and me) addresses this problem
> >for native
> >    linux aio in a simple manner.
> 
> It's simple looking, sure.  This current flipping didn't even occur
> to me while throwing the patch together!
> 
> But that patch ends up calling ->poll (and poll_table->qproc) and
> writing to userspace (so potentially calling ->nopage) from the aio

Yes of course, but why is that a problem ?
The copy_from/to_user/put_user constructs are designed to handle soft failures,
and we are already using the caller's ->mm. Do you see a need for any
additional asserts() ?

If there is something that is needed by ->nopage etc which is not abstracted
out within the ->mm, then we would need to fix that instead, for correctness
anyway, isn't that so ?

Now it is possible that there are minor blocking points in the code and the
effect of these would be to hold up / delay subsequent queued aio operations;
which is an efficiency issue, but not a correctness concern.

> threads.  Are we sure that none of them will behave surprisingly
> because current changed under them?

My take is that we should fix the problems that we see. It is likely that
what manifests relatively more easily with AIO is also a subtle problem
in other cases.

> 
> It might be safe now, but that isn't really the point.  I'd rather we
> didn't have yet one more subtle invariant to audit and maintain.
> 
> At the risk of making myself vulnerable to the charge of mentioning
> vapourware, I will admit that I've been working on a (slightly mad)
> implementation of async syscalls.  I've been quiet about it because I
> don't want to whip up complicated discussion without being able to
> show code that works, even if barely.  I mention it now only to make
> it clear that I want to be constructive, not just critical :).

That is great and I look forward to it :) I am, however assuming that
whatever implementation you come up will have a different interface
from current linux aio -- i.e. a next generation aio model, that will be
easily integratable with kevents etc.

Which takes me back to Ingo's point - lets have the new evolve parallely
with the old, if we can, and not hold up the patches for POSIX AIO to
start using kernel AIO, or for epoll to integrate with AIO.

OK, I just took a quick look at your blog and I see that you
are basically implementing Linus' microthreads scheduling approach -
one year since we had that discussion. Glad to see that you found a way
to make it workable ... (I'm guessing that you are copying over the part
of the stack in use at the time of every switch, is that correct ? At what
point do you do the allocation of the saved stacks ? Sorry I should hold
off all these questions till your patch comes out)

Regards
Suparna

> 
> - z

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

