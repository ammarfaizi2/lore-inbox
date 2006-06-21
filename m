Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWFUKag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWFUKag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWFUKag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:30:36 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:63957 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751480AbWFUKad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:30:33 -0400
Message-ID: <44991FB3.4060209@bigpond.net.au>
Date: Wed, 21 Jun 2006 20:30:11 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH] Per-task watchers: Enable inheritance
References: <1150879635.21787.964.camel@stark>
In-Reply-To: <1150879635.21787.964.camel@stark>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Jun 2006 10:30:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> This allows per-task watchers to implement inheritance of the same function
> and/or data in response to the initialization of new tasks. A watcher might
> implement inheritance using the following notifier_call snippet:
> 
> int my_notify_func(struct notifier_block *nb, unsigned long val, void *t)
> {
> 	struct task_struct *tsk = t;
> 	struct notifier_block *child_nb;
> 	
> 	switch(get_watch_event(val)){
> 	case WATCH_TASK_INIT: /* use container_of() to associate extra data */
> 		child_nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
> 		if (!child_nb)
> 			return NOTIFY_DONE;
> 		child_nb->notifier_call = my_notify_func;
> 		register_per_task_watcher(tsk, child_nb);
> 		return NOTIFY_OK;
> 	case WATCH_TASK_FREE:
> 		unregister_per_task_watcher(tsk, nb);
> 		kfree(nb);
> 		return NOTIFY_OK;
> 
> Compile tested only. Peter, is this useful to you?

I think that it's what I want (i.e. the implementation is what I would 
have done) but I'm confused by you reference to inheritance.  My concern 
is to NOT inherit the data (via the notifier_block) but to have separate 
data for each task which is why I was concerned about not finding where 
"notify" was being initialized on boot.

What I'm doing is using an ordinary watcher to catch new tasks being 
created via WATCH_TASK_INIT and attaching a per task watcher to them at 
that time.  As per your suggestion the notifier_block for the per task 
watcher is contained in a struct which contains the data that I need to 
maintain for each task.  So two layers of watchers :-)

It will be a good test of your mechanism if I can get it to work.

It'll probably take me another couple of days to complete this code as 
I'm having to figure out how it all hangs together as I go.  I'll let 
you know when I've finished.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
