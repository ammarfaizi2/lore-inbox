Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWGYBUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWGYBUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWGYBUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:20:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932374AbWGYBUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:20:07 -0400
Date: Mon, 24 Jul 2006 18:20:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] ps command race fix
Message-Id: <20060724182000.2ab0364a.akpm@osdl.org>
In-Reply-To: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 20:39:39 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> Hi, this is an experimental patch for the probelm
> 	- "ps command can miss some pid occationally"
> please comment 
> 
> 
> the problem itself is very rare case, but the result is sometimes terrible
> 
> for example, when a user does
> 
> alive=`ps | grep command | grep -v command | wc -l`
> 
> to check process is alive or not (I think this user should use kill-0 ;)
> 
> -Kame
> ==
> Now, prod_pid_readir() uses direct access to task and 
> indexing 'task list' as fallback.
> Of course, entries in this list can be removed randomly.
> 
> So, following can happen when using 'ps' command.
> ==
> 1. assume task_list as
> ....-(taskA)-(taskB)-(taskC)-(taskD)-(taskE)-(taskF)-(taskG)-...
> 
> 2. at getdents() iteration 'N', ps command's getdents() read entries before taskC.
> and remenbers "I read X entries".
> 
> ....-(taskA)-(taskB)-(taskC)-(taskD)-(taskE)-(taskF)-(taskG)-...
> ------(f_pos=X)---------^
> 
> getdents() remembers
> 	- "taskC is next candidate to be read"
> 	- "we already read X ents".
> 
> 3. consider taskA and taskC exits, before next getdents(N+1)
> 
> ....-(lost)-(taskB)-(lost)-(taskD)-(taskE)-(taskF)-(taskG)-...
> ------(f_pos=X)--------^
> 
> 4. at getdents(N+1), becasue getdents() cannot find taskC, it skips 'X'
>    ents in the list.
>    from head of the list.
> ....-(taskB)-(taskD)-(taskE)-(taskF)-(taskG)-..
> ------(f_pos=X)--------^
> 
> 5. in this case, taskD is skipped.
> ==
> 
> This patch changes indexing in the list to indexing in a table.
> Table is created only for storing valid tgid.(not pid)
> Tested on x86/ia64.
> 

It allocates a potentially-significant amount of memory per-task, until
that tasks exits (we could release it earlier, but the problem remains) and
it adds yet another global lock in the process exit path.

>  5 files changed, 138 insertions(+), 62 deletions(-)

And it adds complexity and code.

So I think we're still seeking a solution to this.

Options might be:

a) Pin the most-recently-visited task in some manner, so that it is
   still on the global task list when we return.  That's fairly simple to
   do (defer the release_task()) but it affects task lifetime and visibility
   in rare and worrisome ways.

b) Change proc_pid_readdir() so that it walks the pid_hash[] array
   instead of the task list.  Need to do something clever when traversing
   each bucket's list, but I'm not sure what ;) It's the same problem.

   Possibly what we could do here is to permit the task which is walking
   /proc to pin a particular `struct pid': take a ref on it then when we
   next start walking one of the pid_hash[] chains, we _know_ that the
   `struct pid' which we're looking for will still be there.  Even if it
   now refers to a departed process.

c) Nuke the pid_hash[], convert the whole thing to a radix-tree. 
   They're super-simple to traverse.  Not sure what we'd index it by
   though.

I guess b) is best.
