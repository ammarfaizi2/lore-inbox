Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWGYGKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWGYGKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWGYGKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:10:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65153 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751432AbWGYGKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:10:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ps command race fix
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
Date: Tue, 25 Jul 2006 00:09:17 -0600
In-Reply-To: <20060724182000.2ab0364a.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 24 Jul 2006 18:20:00 -0700")
Message-ID: <m13bcqmd0y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> So I think we're still seeking a solution to this.
>
> Options might be:
>
> a) Pin the most-recently-visited task in some manner, so that it is
>    still on the global task list when we return.  That's fairly simple to
>    do (defer the release_task()) but it affects task lifetime and visibility
>    in rare and worrisome ways.
>
> b) Change proc_pid_readdir() so that it walks the pid_hash[] array
>    instead of the task list.  Need to do something clever when traversing
>    each bucket's list, but I'm not sure what ;) It's the same problem.
>
>    Possibly what we could do here is to permit the task which is walking
>    /proc to pin a particular `struct pid': take a ref on it then when we
>    next start walking one of the pid_hash[] chains, we _know_ that the
>    `struct pid' which we're looking for will still be there.  Even if it
>    now refers to a departed process.
>
> c) Nuke the pid_hash[], convert the whole thing to a radix-tree. 
>    They're super-simple to traverse.  Not sure what we'd index it by
>    though.
>
> I guess b) is best.

The advantage with walking the task list is new entries are always added
at the end.  Neither of the other two proposed orders does that.  So
in fact I think the problem will get worse leaving more tasks skipped,
because in those cases new tasks can be inserted before our cursor in
the list.  The proposed snapshot implementation has a similar problem
in that new process could get skipped.

The simplest version I can think of is to place a cousin of the
tasklist into struct pid.  Allowing us to use a very similar
algorithm to what we use now.  But since we can pin struct pid we
won't have the chance of our current position being deleted.

Eric
