Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWCDKdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWCDKdV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 05:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWCDKdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 05:33:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53157 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751841AbWCDKdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 05:33:21 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, serue@us.ibm.com,
       frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
Subject: Re: sysctls inside containers
References: <43F9E411.1060305@sw.ru>
	<m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	<1141062132.8697.161.camel@localhost.localdomain>
	<m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
	<1141442246.9274.14.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 04 Mar 2006 03:27:32 -0700
In-Reply-To: <1141442246.9274.14.camel@localhost.localdomain> (Dave Hansen's
 message of "Fri, 03 Mar 2006 19:17:25 -0800")
Message-ID: <m1veuucxnv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> Trimming the cc list down, because the scope has narrowed
> significantly...

Undoing some of the trimming to include the vserver guys at least.
Herbert at least has a better handle on how to do resource limits
than I do.

> On Mon, 2006-02-27 at 14:14 -0700, Eric W. Biederman wrote: 
>> So it looks like a good start.  There are a lot of details yet to be filled
>> in, proc, sysctl, cleanup on namespace release.  (We can still provide
>> the create destroy methods even if we don't hook the up). 
>
> Well, I at least got to the point of seeing how the sysctls interact
> when I tried to containerize them.  Eric, I think the idea of the sysv
> code being nicely and completely isolated is pretty much gone, due to
> their connection to sysctls.  I think I'll go back and just isolate the
> "struct ipc_ids" portion.  We can do the accounting bits later.


> The patches I have will isolate the IDs, but I'm not sure how much sense
> that makes without doing the things like the shm_tot variable.  Does
> anybody think we need to go after sysctls first, perhaps?  Or, is this a
> problem graph with cycles in it? :)

There is a reason I'm cleaning up /proc at the moment :)

But the only real gotcha I see is how do we do per namespace resource
limits.  As opposed to global resource limits.  For the moment
just having truly global limits seems reasonable.

> I don't see an immediately clear solution on how to containerize sysctls
> properly.  The entire construct seems to be built around getting data
> from in and out of global variables and into /proc files.

I successfully handled pid_max.  So while it is awkward you can get
per task values in and out if sysctl.

> We obviously want to be rid of many of these global variables.  So, does
> it make sense to introduce different classes of sysctls, at least
> internally?  There are probably just two types: global, writable only
> from the root container and container-private.  Does it make sense to
> have _both_?  Perhaps a sysadmin 

So having both is doable.  Although most of that goes to resource
limits, and resource limits are something we clearly need to discuss
but they really are a separate problem.

> Eric, can you think of how you would represent these in the hierarchical
> container model?  How would they work?

There is nothing in the implementation of sysvipc that is inherently
hierarchical.  So it would simply be disjoin flat namespaces.  That
are only hierarchical in the sense that they are connected to
processes which form a hierarchical process tree.

As for the resource limit problem that is the domain of CKRM and the
bean counter patches.  The isolation work we are doing may put a new
spin on the problem and help it get solved but it isn't something we
need to solve.

Herbert Poetzl has suggest in the past is that we may need some kind
of namespace off to the side that is the essence of a container and
has all of the container resource limits.

> On another note, after messing with putting data in the init_task for
> these things, I'm a little more convinced that we aren't going to want
> to clutter up the task_struct with all kinds of containerized resources,
> _plus_ make all of the interfaces to share or unshare each of those.
> That global 'struct container' is looking a bit more attractive.

There aren't that many of them, and what different groups want to
share/unshare is different.  The biggest difference is that for
migration restart it is not necessary to solve the problem of having
the same UID map to multiple user_structs depending on the context and
all of the weird things that will do to permission checking in the
kernel.

There are also a few items migration cares about that people doing
virtual private servers don't.  Like the ability to isolate monotonic
timers, so even after migration the monotonic properties are
maintained.  If you always remain on the same kernel that is a problem
that simply does not come up.

Eric

