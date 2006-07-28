Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752061AbWG1SxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbWG1SxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWG1SxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:53:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46292 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752061AbWG1SxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:53:04 -0400
Subject: Re: 2.6.18-rc2-mm1
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>
In-Reply-To: <20060728013442.6fabae54.akpm@osdl.org>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
	 <6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
	 <20060728013442.6fabae54.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 11:49:27 -0700
Message-Id: <1154112567.21787.2522.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 01:34 -0700, Andrew Morton wrote:
> On Fri, 28 Jul 2006 10:17:44 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
> > Matt, can you look at this?
> > 
> > My hunt file shows me, that this patches are causing oops.
> > GOOD
> > #
> > #
> > task-watchers-task-watchers.patch
> > task-watchers-register-process-events-task-watcher.patch
> > task-watchers-refactor-process-events.patch
> > task-watchers-make-process-events-configurable-as.patch
> > task-watchers-allow-task-watchers-to-block.patch
> > task-watchers-register-audit-task-watcher.patch
> > task-watchers-register-per-task-delay-accounting.patch
> > task-watchers-register-profile-as-a-task-watcher.patch
> > task-watchers-add-support-for-per-task-watchers.patch
> > task-watchers-register-semundo-task-watcher.patch
> > task-watchers-register-per-task-semundo-watcher.patch
> > BAD
> 
> Thanks for working that out.

	I noticed the delay accounting functions in the stack trace. Perhaps
task-watchers-register-per-task-delay-accounting.patch is causing the
problem. With all of the recent churn in per-task delay accounting I'm
wondering if that patch is still correct. Balbir, Shailabh, what do you
think?

> I've actually been thinking that we shouldn't proceed with those patches.
> 
> They're a nice cleanup and make the kernel code _look_ better and I really
> like them because of this.  But the cost is potentially significant.  We
> replace N direct calls with a walk of a notifier chain, more than N
> indirect calls, demultiplexing at the other end and then a direct call. 
> That's a significant amount of additional overhead to make the kernel
> source look nicer.

OK. The multiple notifier chain approach you suggested gets rid of
demultiplexing. We'd replace N direct calls with a walk of a notifier
chain and (more than??) N indirect calls.

	An alternative suggested to me by Al Viro is to handle these functions
much like the *_initcall() macros in include/linux/init.h. This replaces
N direct calls with an array walk and N indirect calls. Unfortunately,
this does not work for modules.

> Plus, ugly though it is, you can look at the current code and see what it's
> doing.  With a notifier chain you have to grep around the tree and work out
> what might be hooking into the chain, which is harder.

	The same is true when using function pointers in other areas of the
kernel. They make the code harder to trace but have advantages you can't
get by simply pasting the function call into the path.

	That said, I think walking the code is a bit easier with the multichain
approach. Lastly, at each invocation I could put in a comment explaining
how to find users of the chain.

> Finally, the consolidation into a notifier chain forces all the
> fork/exit/exec hooks into an one-size-fits-all model.  What happens if one
> subsystem wants to hook in before exit_mmap() and another one wants to hook
> in after exit_mmap() (for example)?

	As I see it there's not much I can do about the one-size-fits-all
model. So I tried to find the one size that fits most.

	I think many systems that place calls in these paths aren't as
sensitive to their precise location as you might imagine. Many need to
initialize their per-task data and clean it up. They tend to depend on a
valid task structure and little else. Fewer systems -- profile for
instance -- have very specific requirements for when/where they get
called. Yet even profile can use some of task watchers.

	I considered some obvious alternatives but they had worse problems.
Adding more notifications will run into naming problems. Using notifier
block priorities would have similar problems and be even harder to trace
by hand.

	For those special systems that don't fit this "size" I think leaving
them in these paths is the best approach.

Cheers,
	-Matt Helsley

