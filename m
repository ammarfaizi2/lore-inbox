Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWFNXfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWFNXfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWFNXfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:35:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18894 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965035AbWFNXfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:35:14 -0400
Subject: Re: [PATCH 06/11] Task watchers:  Register audit task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Alexander Viro <aviro@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-audit@redhat.com, Alan Stern <stern@rowland.harvard.edu>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060614144625.GB18305@devserv.devel.redhat.com>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242886.21787.146.camel@stark>
	 <20060614144625.GB18305@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 16:28:25 -0700
Message-Id: <1150327705.21787.330.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 10:46 -0400, Alexander Viro wrote:
> On Tue, Jun 13, 2006 at 04:54:46PM -0700, Matt Helsley wrote:
> > Adapt audit to use task watchers.
> 
> audit_free(p) really expects that either p is a stillborn (never ran)
> *or* that p == current.

	Makes sense. I think the task watcher patches are consistent with this.
I think the first patch of this series helps explain how this patch
remains consistent with the above. I should have cc'd linux-audit when
posting that patch -- here's a link for now:
http://www.ussg.iu.edu/hypermail/linux/kernel/0606.1/1800.html

	In copy_process() and do_exit() notify_watchers() passes the same
pointers as audit_alloc() and audit_free() used before. The patches also
do not introduce or remove calls to audit_alloc() or audit_free(). The
patches trigger these calls with notify_watchers() while passing
WATCH_TASK_INIT and WATCH_TASK_FREE for audit_alloc() and audit_free()
respectively. WATCH_TASK_INIT (and hence audit_alloc()) only happens in
copy_process(). WATCH_TASK_FREE (and hence audit_free()) happens in
copy_process()'s error recovery path and in do_exit().

	This results in the same calls to audit_alloc() and audit_free() except
with an additional function call preceding them on the stack.

	Are you concerned that future modifications of task watchers would pass
in task structs that violate these expectations? I can alter the patches
to incorporate these restrictions:

copy_process()
{
	...
	notify_watchers(WATCH_TASK_INIT, p);
	...
	if (<succeeding>)
		notify_watchers(WATCH_TASK_CLONE, p);
	...
bad_foo:
	...
- 	notify_watchers(WATCH_TASK_FREE, p);
+ 	notify_watchers(WATCH_TASK_ABORT, p);
	...
}

<change all other notify_watchers() invocations to pass NULL as
the second parameter, e.g.>

do_exit()
{
	...
	notify_watchers(WATCH_TSK_FREE, NULL); /* callees must use current */
}

However this requires that I modify each user of task watchers with
something like:

int foo (struct notifier_block *nb, unsigned long val, void *v)
{
-	struct task_struct *tsk = v;
+	struct task_struct *tsk = current;
	...
	switch(get_watch_event(val)) {
	case WATCH_TASK_INIT:
+ 		tsk = v; /* INIT and ABORT use v, the rest use current */
	...
+ 	case WATCH_TASK_ABORT:
+ 		tsk = v; /* fall through */
	case WATCH_TASK_FREE:
		...
	}
	...
}

Which seems a bit more complicated. Is this worth it?

Cheers,
	-Matt Helsley

