Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVLGTVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVLGTVB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVLGTVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:21:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64964 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964848AbVLGTVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:21:00 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
	<m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	<1133977623.24344.31.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 07 Dec 2005 12:19:53 -0700
In-Reply-To: <1133977623.24344.31.camel@localhost> (Dave Hansen's message of
 "Wed, 07 Dec 2005 09:47:03 -0800")
Message-ID: <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Wed, 2005-12-07 at 07:46 -0700, Eric W. Biederman wrote:
>> There are also a lot of cases you haven't even tried to address.
>> You haven't touched process groups, or sessions.
>
> I preferred to keep the number of patches at 13, rather than 130.  Those
> are in the pipeline, but pids are the most important first step which
> gets the most functionality.

Process groups are also pids, and there are direct relationships
between pids and process group ids and session ids.  I agree keeping
the focus tight make sense but not so tight that you miss pieces.

>> At the current time the patch definitely fails the no in kernel
>> users test because it doesn't go as far as taking advantage
>> of the abstraction it attempts to introduce.  Which means
>> other people can't read through the code and make sense
>> of what you are trying to do or to see if there is a better way.
>
> This isn't excatly a new feature, nor does it add any appreciable code
> or complexity.  I'm not sure that test even applies. 

A very common comment on the thread up to now is that people haven't
seen the big picture so they can't comment.

>> I will also contend that walking down a path that does not cause
>> compilation to fail when the subtle things like which flavor of
>> pid you want to see is a problem.
>
> I agree.  I'm trying to figure out which way is best to go about this.
> I have the feeling that using sparse tags like __user and __kernel is
> the way to go, but we might also want to take the embedded struct
> approach like atomic_t.  

You can also make the kernel functions that take a pidspace argument
and you will have instant compile failures :)

>> Another question is how do your pid spaces nest.
>
> They don't, and thankfully there is anybody asking for it.  It adds
> loads of complexity, and nobody apparently needs it.

So only very special pids can generate a pidspace.  That will
tend to reduce the generality of the solution.  What do you do
if I am running your code in a vserver?

There enough possibilities to the solution space a few extra
constraints I think would help in this case.

>> Currently
>> it sounds like you are taking the vserver model and allowing
>> everyone outside your pid space to see all of your internal
>> pids.  Is this really what you want?
>
> For our application, yes.  For vserver, maybe not.  We'd like things
> like 'top' to still work like normal, even though there are processes in
> their own pidspace around.

I can see the desire.  But top is already strongly challenged if
you are talking hpc computing.  It only works on one node.  Anything
that teaches proc about multiple node mounts ought to work just
as well for an internal checkpoint restart implementation.

>> Who do you report as the source of your signal.  
>
> I've never dealt with signal enough from userspace to give you a good
> answer.  Can you explain the mechanics of how you would go about doing
> this?

Look at siginfo_t si_pid....


>> What pid does waitpid return when the parent of your pidspace exits?
>> What pid does waitpid return when both processes are in the same pidspace?
>
> The pids coming out of system calls are always in the context of the
> process doing the call.  

This is of course the definition.  But how you implement those cases
is interesting.

>> How does /proc handle multiple pid spaces?
>
> I'm working on it :)
>
> Right now, there's basically a hack in d_hash() to get new dentries for
> each pidspace.  It is horrible and causes a 50x decrease in performance
> on some benchmarks like dbench.
>
> I think the long-term solution is to make multiple, independent proc
> mounts, and give each pidspace a separate filesystem view.  That
> requires some of the nifty new bind mount functionality and a chroot
> when a new pidspace is created, but I think it works.

I think you will ultimately want a new filesystem namespace
not just a chroot, so you can ``virtualize'' your filesystem namespace
as well.

>> While something allowing multiple pidspaces may be mergeable,
>> unnecessary and incomplete changes rarely are.  This is a fundamental
>> change to the unix API so it will take a lot of scrutiny to get
>> merged.
>
> Lots of good questions.  I think we need to take some of our initial,
> private discussions and get them out on an open list somewhere.  Any
> suggestions?  I hate creating new sourceforge projects :)

I wonder if you could hook up with the linux vserver project.  The
requirements are strongly similar, and making a solution that
would work for everyone has a better chance of getting in.

Eric

