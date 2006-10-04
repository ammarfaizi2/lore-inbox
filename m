Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030734AbWJDCfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030734AbWJDCfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030737AbWJDCfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:35:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:55285 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030734AbWJDCfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:35:08 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=bO9u0Ev2Q7eS5de6rEabRVO87nhayddF3Rw8LtT5EJvvNGtFXgkdqELKgO4ZGy24b
	n4+YdKGMLO6kGYNNIVXEg==
Message-ID: <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
Date: Tue, 3 Oct 2006 19:34:55 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [RFC][PATCH 0/4] Generic container system
Cc: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, winget@google.com, mbligh@google.com,
       rohitseth@google.com, jlan@sgi.com
In-Reply-To: <1159925752.24266.22.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002095319.865614000@menage.corp.google.com>
	 <1159925752.24266.22.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> Hi Paul,
>
> Thanks for doing the exercise of removing the container part of cpuset
> to provide some process aggregation.
>
> With this model, I think I agree with you that RG can be split into
> individual controllers (need to look at it closely).
>
> I have few questions/concerns w.r.t this implementation:
>
> - Since we are re-implementing anyways, why not use configfs instead of
>   having our own filesystem ?

The filesystem was lifted straight from cpuset.c, and hence isn't a
reimplementation, it's a migration of code already in the tree. Wasn't
there also a problem with the maximum output size of a configfs file,
which would cause problems e.g. listing the task members in a
container?

> - I am little nervous about notify_on_release, as RG would want
>   classes/RGs to be available even when there are no tasks or sub-
>   classes. (Documentation says that the user level program can rmdir
>   the container, which would be a problem). Can the user level program
>   be _not_ called when there are other subsystems registered ? Also,
>   shouldn't it be cpuset specific, instead of global ?

This again is taken straight from cpusets. The idea is that if you
don't have some kind of middleware polling the
container/cpuset/res_group directories to see if they're empty, you
can instead ask the kernel to call you back (via
"container_release_agent") at a point when a container is empty and
hence removable. I don't think there's any guarantee that the
container will still be empty by the time the userspace agent runs.

> - Export of the locks: These locks protect container data structures.
>   But, most of the usages in cpuset.c are to protect the cpuset data
>   structure itself. Shouldn't the cpuset subsystem have its own locks ?
>   IMO, these locks should be used by subsystem only when they want data
>   integrity in the container data structure itself (like walking thru
>   the sibling list).

It would certainly be possible to have finer-grained locking. But the
cpuset code seems pretty happy with coarse-grained locking (only one
writer at any one time) and having just the two global locks does make
the whole synchronization an awful lot simpler. There's nothing to
stop you having additional analogues of the callback_mutex to protect
specific data in a particular resource controller's private data.

My inclination would be to find a situation where generic fine-grained
locking is really required before forcing it on all container
subsystems. The locking model in RG is certainly finer-grained than in
cpusets, but don't a lot of the operations end up taking the
root_group->group_lock anyway as their first action?

> - Tight coupling of subsystems: I like your idea (you mentioned in a
>   reply to the previous thread) of having an array of containers in task
>   structure than the current implementation.

Can you suggest some scenarios that require this?

Paul
