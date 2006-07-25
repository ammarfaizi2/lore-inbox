Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWGYCGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWGYCGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGYCGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:06:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932068AbWGYCGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:06:30 -0400
Date: Mon, 24 Jul 2006 19:06:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060724190626.75b71d02.akpm@osdl.org>
In-Reply-To: <20060725105339.e8c25775.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060725105339.e8c25775.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 10:53:39 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Mon, 24 Jul 2006 18:20:00 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> > 
> > It allocates a potentially-significant amount of memory per-task, until
> > that tasks exits (we could release it earlier, but the problem remains) and
> > it adds yet another global lock in the process exit path.
> > 
> I see.
> 
> > >  5 files changed, 138 insertions(+), 62 deletions(-)
> > 
> > And it adds complexity and code.
> > 
> > So I think we're still seeking a solution to this.
> > 
> > Options might be:
> > 
> > a) Pin the most-recently-visited task in some manner, so that it is
> >    still on the global task list when we return.  That's fairly simple to
> >    do (defer the release_task()) but it affects task lifetime and visibility
> >    in rare and worrisome ways.
> > 
> > b) Change proc_pid_readdir() so that it walks the pid_hash[] array
> >    instead of the task list.  Need to do something clever when traversing
> >    each bucket's list, but I'm not sure what ;) It's the same problem.
> > 
> >    Possibly what we could do here is to permit the task which is walking
> >    /proc to pin a particular `struct pid': take a ref on it then when we
> >    next start walking one of the pid_hash[] chains, we _know_ that the
> >    `struct pid' which we're looking for will still be there.  Even if it
> >    now refers to a departed process.
> > 
> > c) Nuke the pid_hash[], convert the whole thing to a radix-tree. 
> >    They're super-simple to traverse.  Not sure what we'd index it by
> >    though.
> > 
> > I guess b) is best.
> > 
> 
> I tried b) at the first place.

OK.

> but it was not very good because 
> proc_pid_readdir() has to traverse all pids, not tgids.

You mean "all tgids, not pids".

> So, I had to access
> task_struct of the pid. I wanted to avoid to access task struct itself,

Why do you wish to avoid accessing the task_struct?

> my patch implemented a table made only from tgids.
> 
> But as you say, my patch is much intrusive. 
> I'll dig this more. thank you for advise.

Thanks.
