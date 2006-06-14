Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWFNBA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWFNBA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWFNBA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:00:26 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:46269 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932345AbWFNBAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:00:24 -0400
Subject: Re: [PATCH 02/11] Task watchers:  Register process events task
	watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
In-Reply-To: <200606131940.00539.chase.venters@clientec.com>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242874.21787.142.camel@stark>
	 <200606131940.00539.chase.venters@clientec.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 17:52:37 -0700
Message-Id: <1150246357.21787.187.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 19:39 -0500, Chase Venters wrote:
> On Tuesday 13 June 2006 18:54, Matt Helsley wrote:
> 
> > +static int cn_proc_watch_task(struct notifier_block *nb, unsigned long
> > val, +			      void *t)
> > +{
> > +	struct task_struct *task = t;
> 
> Why the copy?

	It shouldn't result in a copy. Since t is a void* I don't think any
additional instructions or stack space are required. This should have
zero runtime cost while improving clarity of the code. It's also needed
in the next patch.

> > +	int rc = NOTIFY_OK;
> > +
> > +	switch (get_watch_event(val)) {
> > +	case WATCH_TASK_CLONE:
> > +		proc_fork_connector(task);
> > +		break;
> > +	case WATCH_TASK_EXEC:
> > +		proc_exec_connector(task);
> > +		break;
> > +	case WATCH_TASK_UID:
> > +		proc_id_connector(task, PROC_EVENT_UID);
> > +		break;
> > +	case WATCH_TASK_GID:
> > +		proc_id_connector(task, PROC_EVENT_GID);
> > +		break;
> > +	case WATCH_TASK_EXIT:
> > +		proc_exit_connector(task);
> > +		break;
> > +	default: /* we don't care about WATCH_TASK_INIT|FREE because we
> > +		    don't keep per-task info */
> > +		rc = NOTIFY_DONE; /* ignore all other notifications */
> > +		break;
> > +	}
> > +	return rc;
> > +}
> > +
> 
> >  /*
> >   * cn_proc_init - initialization entry point
> >   *
> >   * Adds the connector callback to the connector driver.
> >   */
> > @@ -219,11 +259,16 @@ static int __init cn_proc_init(void)
> >  	int err;
> >
> >  	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
> >  	 			   &cn_proc_mcast_ctl))) {
> >  		printk(KERN_WARNING "cn_proc failed to register\n");
> > -		return err;
> > +		goto out;
> >  	}
> > -	return 0;
> > +
> > +	err = register_task_watcher(&cn_proc_nb);
> > +	if (err != 0)
> 
> if (err)

I don't see any benefit to changing this. Care to elaborate on why this
is important?

> Thanks,
> Chase

