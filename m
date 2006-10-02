Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWJBGw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWJBGw2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWJBGw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:52:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:19877 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932695AbWJBGw0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:52:26 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=HmEMK2hXRjzpSx7JmlHFd79Q+1mLrb2jkD4J3rFQKr8CUB3XDNnh7QF+rFUPoOxwk
	UwRGD3umYHv1ZkImaQJ6Q==
Message-ID: <6599ad830610012348p1059f424ua48b62dd30a6c3fd@mail.gmail.com>
Date: Sun, 1 Oct 2006 23:48:16 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [RFC][PATCH 1/4] Generic container system abstracted from cpusets code
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, mbligh@google.com,
       rohitseth@google.com, winget@google.com, dev@sw.ru, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060928164536.84039937.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060928104035.840699000@menage.corp.google.com>
	 <20060928111407.762783000@menage.corp.google.com>
	 <20060928164536.84039937.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Paul Jackson <pj@sgi.com> wrote:
>
> Be sure to spell out, if you haven't already, that there is just a
> single container hierarchy, with each task attached to a single
> container in that hierarchy, and each subsystem (e.g. cpusets)
> adding its own special files to the common container hierarchy
> directories.
>
> It is not the case that each subsystem using containers gets to
> concoct its own hierarchy, independent of any other subsystem.

Well, it wouldn't be too hard to have the container code manage
multiple container hierarchies in parallel if people wanted the
ability to do this. You'd just replace the

    struct container *container;

field in task_struct with

    struct container *containers[MAX_CONTAINER_HIERARCHIES]

and have each instance of the container filesystem manage a different
hierarchy. Perhaps to configure this from userspace you could do
something like

mount -t container xxx -octype=cpuset /dev/cpuset
mount -t container yyy -octype=resgroup,ctype=cpuacct /mnt/rescontainer

i.e. mount one container hierarchy on /dev/cpuset with just the cpuset
container type, and mount an independent hierarchy on
/mnt/rescontainer with the resgroup and cpuacct container types
attached to it. You'd probably want to enforce a rule that each
container type could only be attached to a single hierarchy at a time.

Anyone have any thoughts on the usefulness/insanity of such an idea?
The most useful part of it may be the ability to e.g. create a
container hierarchy that explicitly doesn't cause e.g. multiple
cpusets to be created, if you want to avoid the overhead that kicks in
when there are multiple cpusets in use. That could be approximated
without the overhead of multiple container hierarchy support by having
a control file(s) in the top container dir that lets you configure
which container subsystems are actually in use. So e.g. if you turned
cpusets off before creating any subcontainers, all containers would
actually share the same cpuset instance, and we could avoid any of the
overheads associated with having multiple cpusets.

This would be somewhere in between the existing state of a single
hierarchy with multiple fixed container types, and the full-blown
multiple hierarchies with configurably-attachable container types that
I outlined above.

>
> If someone configures in one or more of the subsystems, such as
> cpusets, that requires CONTAINERS, then we need to enable containers.
> Otherwise we don't need to enable CONTAINERS.  I don't see what
> user input we need here specific to CONTAINERS.

Fair enough - so have the various container types do "select
CONTAINERS" rather than "depends on CONTAINERS"?

>
> > + *  Copyright (C) 2003 BULL SA.
> > + *  Copyright (C) 2004-2006 Silicon Graphics, Inc.
>
> Perhaps you want to add a Google or Menage copyright here?
>
> > + *  2003-10-22 Updates by Stephen Hemminger.
> > + *  2004 May-July Rework by Paul Jackson.
>
> Perhaps time for another log line here, such as:
>   + *  2006 Generalized to containers by Paul Menage.

I already had something like that at the top - I've now made it
clearer that these copyright statements came from the cpuset.c code
from which this code was abstracted.

Paul
