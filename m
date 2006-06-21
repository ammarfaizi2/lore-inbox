Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWFUBqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWFUBqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWFUBqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:46:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751928AbWFUBqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:46:45 -0400
Date: Tue, 20 Jun 2006 18:46:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: pwil3058@bigpond.net.au, nagar@watson.ibm.com, sekharan@us.ibm.com,
       jtk@us.ibm.com, balbir@in.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH 09/11] Task watchers: Add support for
 per-task watchers
Message-Id: <20060620184617.7dbefed8.akpm@osdl.org>
In-Reply-To: <1150852848.21787.828.camel@stark>
References: <20060613235122.130021000@localhost.localdomain>
	<1150242901.21787.149.camel@stark>
	<44978793.8070109@bigpond.net.au>
	<1150844177.21787.774.camel@stark>
	<20060620161524.7c132eea.akpm@osdl.org>
	<1150852848.21787.828.camel@stark>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 18:20:48 -0700
Matt Helsley <matthltc@us.ibm.com> wrote:

> > > > > +static inline int notify_per_task_watchers(unsigned int val,
> > > > > +					   struct task_struct *task)
> > > > > +{
> > > > > +	if (get_watch_event(val) != WATCH_TASK_INIT)
> > > > > +		return raw_notifier_call_chain(&task->notify, val, task);
> > > > > +	RAW_INIT_NOTIFIER_HEAD(&task->notify);
> > > > > +	if (task->real_parent)
> > > > > +		return raw_notifier_call_chain(&task->real_parent->notify,
> > > > > +		   			       val, task);
> > > > > +}
> > > > 
> > > > It's possible for this task to exit without returning a result.
> > > 
> > > Assuming you meant s/task/function/:
> > > 
> > > 	In the common case this will return a result because most tasks have a
> > > real parent. The only exception should be the init task. However, the
> > > init task does not "fork" from another task so this function will never
> > > get called with WATCH_TASK_INIT and the init task.
> > > 
> > > 	This means that if one wants to use per-task watchers to associate data
> > > and a function call with *every* task, special care will need to be
> > > taken to register with the init task.
> > 
> > no......
> 
> 	I've been looking through the source and, from what I can see, the end
> of the function is not reachable. I think I need to add:
> 
> notify_watchers(WATCH_TASK_INIT, &init_task);
> 
> to make this into an applicable warning.

If the end of the function isn't reachable then the
`if (task->real_parent)' can simply be removed.
