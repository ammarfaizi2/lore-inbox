Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbULIOhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbULIOhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbULIOhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:37:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:12777 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261488AbULIOgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:36:44 -0500
Date: Thu, 9 Dec 2004 08:36:32 -0600
From: Dean Nelson <dcn@sgi.com>
To: Chris Wright <chrisw@osdl.org>
Cc: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041209143632.GA6904@sgi.com>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <20041115132749.N2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115132749.N2357@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 01:27:49PM -0800, Chris Wright wrote:
> * Dean Nelson (dcn@sgi.com) wrote:
> > On Mon, Nov 15, 2004 at 10:58:01AM -0800, Chris Wright wrote:
> > > * Dean Nelson (dcn@sgi.com) wrote:
> > > > +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
> > > 
> > > this should be static.
> > 
> > You're right. I made another change in that one now passes the task_struct
> > pointer to sched_setscheduler() instead of the pid. This requires that
> > the caller of sched_setscheduler() hold the tasklist_lock. The new patch
> > for people's feedback follows.
> 
> This now means callers of sched_setscheduler hold tasklist_lock, also
> with irq off.  I think it's safer to let the core function do that.
> It's a touchy area that's ripe for deadlock.

After some further investigation, I think I was mistaken in saying that
the caller of sched_setscheduler() must hold the tasklist_lock.

If you look at the example of sys_setpriority() and sys_nice(), both
of which call set_user_nice(), the first one does so via set_one_prio()
while holding the tasklist_lock, the second one does so while not
holding the tasklist_lock. The difference seems to be whether the caller
was operating against a task_struct located by way of pid or uid (like
calling find_task_by_pid()), which is the case for sys_setpriority(),
whereas sys_nice() operates against the current task_struct.

Now my proposed sched_setscheduler() is very similar to set_user_nice().
And sys_sched_setscheduler()/do_sched_setscheduler() is very similar to
sys_setpriority()/set_one_prio(). And the kernel module (XPC) that I'm
attempting to get accepted by the community would be analagous to
sys_nice() in that its call to sched_setscheduler() would be against
the current task.

So if there is a problem with my proposed patch in regards to the
tasklist_lock, then it would seem to me that there is a problem
with the exiting sys_setpriority(), set_one_prio(), sys_nice(),
set_user_nice() code.

Or am I missing something?

Thanks,
Dean

