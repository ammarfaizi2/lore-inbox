Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWFUVdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWFUVdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFUVdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:33:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:27322 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932067AbWFUVdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:33:21 -0400
Subject: Re: [PATCH] Per-task watchers: Enable inheritance
From: Matt Helsley <matthltc@us.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <44991FB3.4060209@bigpond.net.au>
References: <1150879635.21787.964.camel@stark>
	 <44991FB3.4060209@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 14:27:57 -0700
Message-Id: <1150925277.21787.1053.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 20:30 +1000, Peter Williams wrote:
> Matt Helsley wrote:
> > This allows per-task watchers to implement inheritance of the same function
> > and/or data in response to the initialization of new tasks. A watcher might
> > implement inheritance using the following notifier_call snippet:
> > 
> > int my_notify_func(struct notifier_block *nb, unsigned long val, void *t)
> > {
> > 	struct task_struct *tsk = t;
> > 	struct notifier_block *child_nb;
> > 	
> > 	switch(get_watch_event(val)){
> > 	case WATCH_TASK_INIT: /* use container_of() to associate extra data */
> > 		child_nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
> > 		if (!child_nb)
> > 			return NOTIFY_DONE;
> > 		child_nb->notifier_call = my_notify_func;
> > 		register_per_task_watcher(tsk, child_nb);
> > 		return NOTIFY_OK;
> > 	case WATCH_TASK_FREE:
> > 		unregister_per_task_watcher(tsk, nb);
> > 		kfree(nb);
> > 		return NOTIFY_OK;
> > 
> > Compile tested only. Peter, is this useful to you?
> 
> I think that it's what I want (i.e. the implementation is what I would 
> have done) but I'm confused by you reference to inheritance.  My concern 
> is to NOT inherit the data (via the notifier_block) but to have separate 
> data for each task which is why I was concerned about not finding where 
> "notify" was being initialized on boot.

Sorry, "inheritance" isn't exactly what it is. Poor choice of wording on
my part.

> What I'm doing is using an ordinary watcher to catch new tasks being 
> created via WATCH_TASK_INIT and attaching a per task watcher to them at 
> that time.  As per your suggestion the notifier_block for the per task 
> watcher is contained in a struct which contains the data that I need to 
> maintain for each task.  So two layers of watchers :-)

	Hmm. Ideally you should need only one layer. When caps have been
established on a group you'd need to create the per-task watchers. From
there on I'd expect new tasks that fork to be added to the same group
using existing per-task watchers. Of course the trick is getting the
initial task(s) into the group. With per-task watchers that's difficult
because the group assignment might originate externally but registration
must happen from the context of the task being registered. I could
remove this restriction by paying an increased cost in complexity.
Please let me know if you run into extreme difficulties with per-task
watchers due to this context constraint.

> It will be a good test of your mechanism if I can get it to work.

Yes.

> It'll probably take me another couple of days to complete this code as 
> I'm having to figure out how it all hangs together as I go.  I'll let 
> you know when I've finished.
> 
> Peter

	Thanks, I look forward to seeing it. Partially as a test and partially
because I'm curious if it will be compatible with the resource groups
(formerly CKRM) group structure.

Cheers,
	-Matt Helsley

