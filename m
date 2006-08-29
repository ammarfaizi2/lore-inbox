Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWH2OkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWH2OkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWH2OkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:40:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52494 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965000AbWH2OkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:40:06 -0400
Date: Tue, 29 Aug 2006 10:40:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 0/4] Change return values from queue_work et al.
In-Reply-To: <44F36EB9.4070204@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.44L0.0608291002300.6392-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006, Stefan Richter wrote:

> Alan Stern wrote:
> [...]
> > It turned out these functions were used in ~800 places, and in ~90% of
> > them the return value was ignored!  This is perhaps understandble, because
> > the only way these functions can fail is if their work_struct argument is
> > uninitialized or already in use.  (Whether it's robust for callers to
> > depend on this behavior remaining unchanged into the indefinite future is
> > more questionable.)
> 
> You are changing this behavior right now...

Indeed yes.  As stated in portions of the patch description that you have
omitted.  Note that the change falls within the bounds of the documented
behavior, in the sense that any code which was originally written
correctly (i.e., in accordance with the documentation) will continue to
work correctly without generating any warnings.

> > So I took a short cut which allowed most of the usages to remain as they
> > are.  queue_work(), schedule_work(), and their friends still exist and do
> > what they did before, but now they return void.  In addition, they call
> > WARN_ON if the submission fails; this seems safer than letting the failure
> > go silently unnoticed.  
> [...]
> 
> ...by adding a WARN_ON even though "work not enqueued because it is 
> already in queue" may not be a "failure" at all.

Again yes, as mentioned in the patch description.  The underlying problem 
is that the API does not provide any way to distinguish between failure 
because the request is already in a queue and other types of failure, 
such as forgetting to initialize the data structure.

In fact, to be _really_ robust about it would require walking through the
list of structures attached to the work queue, to verify that the
submitted request actually was attached to that queue already and not to
some other one (or to none).  Of course, any individual caller is probably
able to guarantee this, so it's not worthwhile to add such a check.

> It _is_ robust for callers to depend on the old behavior. This is 
> because /we/ who use these functions will remind /you/ who alters these 
> functions to first research what the actual usage is. So please check 
> every caller which ignores the return code for the actual intent of the 
> caller.

Thank you, but I do not intend to spend the next five years of my life
working on this issue.  The fact that the callers ignore the return code
clearly indicates that they do not care whether the functions fail or why
they fail.  This may be due to inside knowledge ("the only reason it would
fail is if the request is already queued" -- which is certainly not robust
because it is not documented and in the future there may be other reasons
for failure) or because of sheer laziness.  In the absence of comments
it's impossible or extremely difficult to tell.

However, if you can point to specific examples of places where callers 
rely on undocumented behavior, I will be happy to fix them as I did for 
the call in drivers/char/vt.c.  (I will admit, that particular change was 
not ideal.  It really should check for errors other than -EBUSY -- but at 
least now the functions are _documented_ as returning no errors other than 
-EBUSY.)

> Do not add WARN_ON to queue_work() etc.. Instead add WARN_ON or BUG_ON 
> or an actual failure handling to callers which _incorrectly_ expect they 
> could add the same instance of work_struct to queues more than once 
> before the work was executed.

No.  I cannot go through hundreds of usages, learning them and their
contexts in sufficient detail to understand the reasoning behind them.  
(If _you_ are capable of doing this... then my hat's off to you.)  If the
usage is correct then there is no harm in leaving the WARN_ON call where
it is.  If the usage is wrong then the call needs to be fixed, and the
maintainer for the subsystem containing the call will soon find out about
it, thanks to the WARN_ON.

By the way, you left out a couple of possible _incorrect_ usages.  
Callers may _incorrectly_ expect they can add an instance of work_struct
to a queue without having completely initialized it.  Or they may
_potentially_ _incorrectly_ expect that even though the structure is
properly initialized and not in use, the submission is certain to succeed.

> Furthermore, if you already change the type of widely-used exported 
> functions (i.e. you change the workqueue API), why don't you delete 
> these functions right away?

This question was answered in a section you quoted above ("So I took a 
short cut...").  Leaving the existing calls as they are is an opportunity 
for finding about errors that otherwise would be silently ignored.

Alan Stern

