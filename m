Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbTDXOKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTDXOKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:10:21 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:12166 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261767AbTDXOKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:10:17 -0400
Date: Thu, 24 Apr 2003 19:57:21 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Filesystem AIO read-write patches
Message-ID: <20030424195721.A3271@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com> <20030424091312.E9036@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424091312.E9036@redhat.com>; from bcrl@redhat.com on Thu, Apr 24, 2003 at 09:13:12AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 09:13:12AM -0400, Benjamin LaHaise wrote:
> On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> > The task->io_wait field reflects the wait context in which
> > a task is executing its i/o operations. For synchronous i/o
> > task->io_wait is NULL, and the wait context is local on
> > stack; for threads doing io submits or retries on behalf 
> > of async i/o callers, tsk->io_wait is the wait queue 
> > function entry to be notified on completion of a condition 
> > required for i/o to progress. 
> 
> This is seriously wrong.  Changing the behaviour of functions to depend on 
> a hidden parameter is bound to lead to coding errors.  It is far better to 
> make the parameter explicite rather than implicite.

I really did think this over for several days before 
putting out the new iteration. And I'm still in two minds 
about this.

To me it seems like part of the context of execution rather
than a hidden parameter as you see it, much like an address 
space (the way you do a use_mm() for retries) or credentials 
for that matter (other operating systems for example pass a 
cred structure to vfs routines, but Linux doesn't). And 
because wait is typically associated with a task context 
anyway (in the synchronous world).

What differentiates if something should be picked up as 
part of a context or a parameter ? 

It should be a parameter if different values may be passed 
in within the same context (e.g routines which can modify
a different address space would take an mm parameter).

That's why all the _wq routines take a wait queue parameter,
and only routines which really are meant to be context
sensitive reference tsk->io_wait. That's why I got rid of
do_sync_op(), but still kept tsk->io_wait ...

The only thing that nags me is that the context of
an io operation is not a very long-lived one. 

That said, the main problem in implementing what you suggest
is that we'll need to change at least the following APIs 
rightaway for all filesystems:

- aops->prepare_write() 
- fs specific get block routines

to take a wait queue parameter (I don't say iocb
here, because these are per page or per block routines, 
which don't use the iocb information)

If there is a general agreement that we should do this for
2.5, then sure, we can go ahead. But at least I need to
hear a "yes its worth the pain, and yes its the right thing
to do for 2.5" from affected people.

The more asynchrony we decide to add, the more such api
changes would be needed. 

So if the decision is to go ahead and break all filesystems 
anyway, can we decide how far we should go with these and 
have the API changes made sooner rather than later ?

Should we be adding a wait queue or parameter to more
address space operations ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

