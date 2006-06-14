Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWFNBJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWFNBJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWFNBJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:09:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:63410 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964843AbWFNBDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:31 -0400
Subject: Re: [PATCH 01/11] Task watchers:  Task Watchers
From: Matt Helsley <matthltc@us.ibm.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Hellwig <hch@lst.de>
In-Reply-To: <200606131919.52364.chase.venters@clientec.com>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242810.21787.140.camel@stark>
	 <200606131919.52364.chase.venters@clientec.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 17:55:43 -0700
Message-Id: <1150246543.21787.192.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 19:19 -0500, Chase Venters wrote:
> On Tuesday 13 June 2006 18:53, Matt Helsley wrote:
> 
> > @@ -847,12 +848,15 @@ static void exit_notify(struct task_stru
> >  fastcall NORET_TYPE void do_exit(long code)
> >  {
> >  	struct task_struct *tsk = current;
> >  	struct taskstats *tidstats, *tgidstats;
> >  	int group_dead;
> > +	int notify_result;
> >
> >  	profile_task_exit(tsk);
> > +	tsk->exit_code = code;
> > +	notify_result = notify_watchers(WATCH_TASK_EXIT, tsk);
> 
> Are you using this specific return value?

Nope. I was wary of compiler warnings. I'll try removing this first
assignment. However, the variable is necessary for another
notify_watchers() call later in the function. I introduced it because I
didn't think wrapping the function call like this:

WARN_ON(notify_watchers(WATCH_TASK_FREE, tsk) & NOTIFY_STOP_MASK);

would be very readable.

> > +int notify_watchers(unsigned long val, void *v)
> > +{
> > +	return atomic_notifier_call_chain(&task_watchers, val, v);
> > +}
> 
> Might this be called notify_task_watchers()?

Seems like a good idea. I'll make the necessary changes.

> Thanks,
> Chase

Cheers,
	-Matt Helsley

