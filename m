Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWA0I27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWA0I27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWA0I27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:28:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18626 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751351AbWA0I26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:28:58 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <43D14578.6060801@watson.ibm.com>
	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	<43D52592.8080709@watson.ibm.com>
	<m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	<1138050684.24808.29.camel@localhost.localdomain>
	<m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
	<1138062125.24808.47.camel@localhost.localdomain>
	<m17j8pl95v.fsf@ebiederm.dsl.xmission.com>
	<1138137060.14675.73.camel@localhost.localdomain>
	<m1irs8k545.fsf@ebiederm.dsl.xmission.com>
	<20060126202314.GC20473@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 27 Jan 2006 01:28:03 -0700
In-Reply-To: <20060126202314.GC20473@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Thu, 26 Jan 2006 21:23:15 +0100")
Message-ID: <m1hd7qgjn0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> anyway, if that would be the aim, it could be done
> much simpler by 'just' adding a v/upid field to the
> task struct and use that for everything userspace
> related (i.e. locating tasks, sending signals, etc)
> no need to change the current *pid entries at all

Yes and no.  Changing the current pid entries as opposed
to adding the kpid/upid separation is a slightly different
problem.  

In particular there are 4 uses we need to change.  
 - Printing the pid in debug messages.
 - Comparing pids (because we need to add a context comparison)
 - Sending signals/localing tasks.
 - Entering a code path that wants to do one of the above.

Printing the pid in debug messages seems to be confined to
performing the action with reference to a task_struct, and
is a completeness issue not a correctness issue.

Sending signals and locating tasks by pid is fairly
straight forward to change the interface of all affected
functions.  And thus forcing an audit of all callers,
recursively also works well.

Comparing pids is where I think things get sticky but arguably
that case is rare enough we may be able to catch all of the users
with a code audit.

The only change I would really advocate at the moment beyond
adding the kpid fields to the task struct is to rename
(pid, tgid, pgrp, session) to (upid, utgid, upgrp, usession)
so we catch and break the users.  This would catch flush into
the open all of the users that are doing weird things like comparing
pids and would leave any rare untested and unspotted case broken where
it will not compile.

Arguably that it is overkill to break all of the users to catch the
stragglers that we can't easily spot with a code review.  Likely I be
satisfied with not breaking the code until I found a straggler that
affects correctness that made it through a kernel code review. 

So far I have yet to see a version of the code that does not miss
important stragglers.  Which is why to be correct I suspect we need
to break all users.

Eric
