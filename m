Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbVLGRrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVLGRrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVLGRrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:47:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5529 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751483AbVLGRrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:47:20 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 09:47:03 -0800
Message-Id: <1133977623.24344.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 07:46 -0700, Eric W. Biederman wrote:
> This set of patches looks like a global s/current->pid/task_pid(current)/
> Which may be an interesting exercise but I don't see how this
> helps your problem.  And as has been shown by a few comments
> this process making all of these changes is subject to human error.

As with any good set of kernel changes, this is step one.  Step two will
include calling something _other_ than task_pid().  But, in the
interests of small, incremental changes, this is what we decided to do
first.

> Many of the interesting places that deal with pids and where you
> want translation are not where the values are read from current->pid,
> but where the values are passed between functions.  Think about
> the return value of do_fork.

Exactly.  The next phase will focus on such places.  Hubertus has some
stuff working that's probably not ready for LKML, but could certainly be
shared.

> There are also a lot of cases you haven't even tried to address.
> You haven't touched process groups, or sessions.

I preferred to keep the number of patches at 13, rather than 130.  Those
are in the pipeline, but pids are the most important first step which
gets the most functionality.

> At the current time the patch definitely fails the no in kernel
> users test because it doesn't go as far as taking advantage
> of the abstraction it attempts to introduce.  Which means
> other people can't read through the code and make sense
> of what you are trying to do or to see if there is a better way.

This isn't excatly a new feature, nor does it add any appreciable code
or complexity.  I'm not sure that test even applies. 

> I will also contend that walking down a path that does not cause
> compilation to fail when the subtle things like which flavor of
> pid you want to see is a problem.

I agree.  I'm trying to figure out which way is best to go about this.
I have the feeling that using sparse tags like __user and __kernel is
the way to go, but we might also want to take the embedded struct
approach like atomic_t.  

> Another question is how do your pid spaces nest.

They don't, and thankfully there is anybody asking for it.  It adds
loads of complexity, and nobody apparently needs it.

> Currently
> it sounds like you are taking the vserver model and allowing
> everyone outside your pid space to see all of your internal
> pids.  Is this really what you want?

For our application, yes.  For vserver, maybe not.  We'd like things
like 'top' to still work like normal, even though there are processes in
their own pidspace around.

> Who do you report as the source of your signal.  

I've never dealt with signal enough from userspace to give you a good
answer.  Can you explain the mechanics of how you would go about doing
this?

> What pid does waitpid return when the parent of your pidspace exits?
> What pid does waitpid return when both processes are in the same pidspace?

The pids coming out of system calls are always in the context of the
process doing the call.  

> How does /proc handle multiple pid spaces?

I'm working on it :)

Right now, there's basically a hack in d_hash() to get new dentries for
each pidspace.  It is horrible and causes a 50x decrease in performance
on some benchmarks like dbench.

I think the long-term solution is to make multiple, independent proc
mounts, and give each pidspace a separate filesystem view.  That
requires some of the nifty new bind mount functionality and a chroot
when a new pidspace is created, but I think it works.

> While something allowing multiple pidspaces may be mergeable,
> unnecessary and incomplete changes rarely are.  This is a fundamental
> change to the unix API so it will take a lot of scrutiny to get
> merged.

Lots of good questions.  I think we need to take some of our initial,
private discussions and get them out on an open list somewhere.  Any
suggestions?  I hate creating new sourceforge projects :)

-- Dave

