Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWFUB2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWFUB2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWFUB2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:28:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:27024 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750730AbWFUB2y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:28:54 -0400
Subject: Re: [Lse-tech] [PATCH 09/11] Task watchers: Add support for
	per-task watchers
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pwil3058@bigpond.net.au, Shailabh Nagar <nagar@watson.ibm.com>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       "John T. Kohl" <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       LSE <lse-tech@lists.sourceforge.net>
In-Reply-To: <20060620161524.7c132eea.akpm@osdl.org>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242901.21787.149.camel@stark> <44978793.8070109@bigpond.net.au>
	 <1150844177.21787.774.camel@stark>  <20060620161524.7c132eea.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 18:20:48 -0700
Message-Id: <1150852848.21787.828.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 16:15 -0700, Andrew Morton wrote:
> Matt Helsley <matthltc@us.ibm.com> wrote:
> >
> > > > +static inline int notify_per_task_watchers(unsigned int val,
> > > > +					   struct task_struct *task)
> > > > +{
> > > > +	if (get_watch_event(val) != WATCH_TASK_INIT)
> > > > +		return raw_notifier_call_chain(&task->notify, val, task);
> > > > +	RAW_INIT_NOTIFIER_HEAD(&task->notify);
> > > > +	if (task->real_parent)
> > > > +		return raw_notifier_call_chain(&task->real_parent->notify,
> > > > +		   			       val, task);
> > > > +}
> > > 
> > > It's possible for this task to exit without returning a result.
> > 
> > Assuming you meant s/task/function/:
> > 
> > 	In the common case this will return a result because most tasks have a
> > real parent. The only exception should be the init task. However, the
> > init task does not "fork" from another task so this function will never
> > get called with WATCH_TASK_INIT and the init task.
> > 
> > 	This means that if one wants to use per-task watchers to associate data
> > and a function call with *every* task, special care will need to be
> > taken to register with the init task.
> 
> no......

	I've been looking through the source and, from what I can see, the end
of the function is not reachable. I think I need to add:

notify_watchers(WATCH_TASK_INIT, &init_task);

to make this into an applicable warning.

> It's possible for this function to fall off the end without returning
> anything.  The compiler should have spat a warning.

	I'll add a return value at the end of the function as well as the above
notification to keep things uniform and address the compiler warning.

	Incidentally, I've looked at my compilation logs and I did not get any
warnings (gcc version 3.3.4 (Debian 1:3.3.4-3)).

Cheers,
	-Matt Helsley

