Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVLGOrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVLGOrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVLGOrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:47:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55489 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751109AbVLGOrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:47:40 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 07 Dec 2005 07:46:27 -0700
In-Reply-To: <20051114212341.724084000@sergelap> (Serge E. Hallyn's message
 of "Mon, 14 Nov 2005 15:23:41 -0600")
Message-ID: <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> --
>
> I'm part of a project implementing checkpoint/restart processes.
> After a process or group of processes is checkpointed, killed, and
> restarted, the changing of pids could confuse them.  There are many
> other such issues, but we wanted to start with pids.
>
> Does something like this, presumably after much working over, seem
> mergeable?

This set of patches looks like a global s/current->pid/task_pid(current)/
Which may be an interesting exercise but I don't see how this
helps your problem.  And as has been shown by a few comments
this process making all of these changes is subject to human error.

Many of the interesting places that deal with pids and where you
want translation are not where the values are read from current->pid,
but where the values are passed between functions.  Think about
the return value of do_fork.

There are also a lot of cases you haven't even tried to address.
You haven't touched process groups, or sessions.

At the current time the patch definitely fails the no in kernel
users test because it doesn't go as far as taking advantage
of the abstraction it attempts to introduce.  Which means
other people can't read through the code and make sense
of what you are trying to do or to see if there is a better way.

I will also contend that walking down a path that does not cause
compilation to fail when the subtle things like which flavor of
pid you want to see is a problem.

Another question is how do your pid spaces nest.  Currently
it sounds like you are taking the vserver model and allowing
everyone outside your pid space to see all of your internal
pids.  Is this really what you want?  Who do you report as
the source of your signal.  

What pid does waitpid return when the parent of your pidspace exits?
What pid does waitpid return when both processes are in the same pidspace?

How does /proc handle multiple pid spaces?

While something allowing multiple pidspaces may be mergeable,
unnecessary and incomplete changes rarely are.  This is a fundamental
change to the unix API so it will take a lot of scrutiny to get
merged.

Eric
