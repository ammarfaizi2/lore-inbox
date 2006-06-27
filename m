Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161324AbWF0VpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbWF0VpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161327AbWF0VpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:45:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14229 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161324AbWF0VpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:45:22 -0400
Subject: Re: [RFC][PATCH 3/3] Process events biarch bug: New process events
	connector value
From: Matt Helsley <matthltc@us.ibm.com>
To: "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
In-Reply-To: <1151435679.1412.16.camel@linuxchandra>
References: <20060627112644.804066367@localhost.localdomain>
	 <1151408975.21787.1815.camel@stark> <1151435679.1412.16.camel@linuxchandra>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 14:39:42 -0700
Message-Id: <1151444382.21787.1858.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 12:14 -0700, Chandra Seetharaman wrote:
> On Tue, 2006-06-27 at 04:49 -0700, Matt Helsley wrote:
> > "Deprecate" existing Process Events connector interface and add a new one
> > that works cleanly on biarch platforms.
> > 
> > Any expansion of the previous event structure would break userspace's ability
> > to workaround the biarch incompatibility problem. Hence this patch creates a
> > new interface and generates events (for both when necessary).
> 
> Is there a reason why the # of listeners part is removed (basically the
> LISTEN/IGNORE) ? and why as part of this patch ?

	Michael Kerrisk had some objections to LISTEN/IGNORE and I've been
looking into making a connector function that would replace them. They
exist primarily to improve performance by avoiding the memory allocation
in cn_netlink_send() when there are no listeners.

> <snip>
> 
> > @@ -158,16 +164,15 @@ static int cn_proc_watch_task(struct not
> >  			      void *t)
> >  {
> >  	struct task_struct *task = t;
> >  	struct cn_msg *msg;
> >  	struct proc_event *ev;
> > +	struct proc_event_deprecated *ev_old;
> > +	struct timespec timestamp;
> >  	__u8 buffer[CN_PROC_MSG_SIZE];
> >  	int rc = NOTIFY_OK;
> >  
> > -	if (atomic_read(&proc_event_num_listeners) < 1)
> > -		return rc;
> > -
> >  	msg = (struct cn_msg*)buffer;
> >  	ev = (struct proc_event*)msg->data;
> >  	switch (get_watch_event(val)) {
> >  	case WATCH_TASK_CLONE:
> >  		proc_fork_connector(task, ev);
> > @@ -189,16 +194,26 @@ static int cn_proc_watch_task(struct not
> >  		break;
> >  	}
> >  	if (rc != NOTIFY_OK)
> >  		return rc;
> >  	get_seq(&msg->seq, &ev->cpu);
> > -	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
> > +	ktime_get_ts(&timestamp); /* get high res monotonic timestamp */
> > +	ev->timestamp_ns = ((__u64)timestamp.tv_sec*(__u64)NSEC_PER_SEC) + (__u64)timestamp.tv_nsec;
> >  	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
> >  	msg->ack = 0; /* not used */
> >  	msg->len = sizeof(*ev);
> >  	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
> >  	/* If cn_netlink_send() fails, drop data */
> > +
> > +	if (atomic_read(&proc_event_num_old_listeners) < 1)
> > +		return rc;
> > +	ev_old = (struct proc_event_deprecated*)msg->data;
> > +	msg->len = sizeof(*ev_old);
> 
> A comment saying the fields cpu, what, and ack are filled above and is
> valid as is would help.

OK, good idea.

> > +	memmove(&ev_old->event_data, &ev->event_data, sizeof(ev->event_data));
> > +	memcpy(&ev_old->timestamp, &timestamp, sizeof(timestamp));
> > +	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
> > +	/* If cn_netlink_send() fails, drop data */
> >  	return rc;
> >  }
> >  
> >  static struct notifier_block __read_mostly cn_proc_nb = {
> >  	.notifier_call = cn_proc_watch_task,
> > @@ -211,20 +226,27 @@ static struct notifier_block __read_most
> >   */
> >  static int __init cn_proc_init(void)
> >  {
> >  	int err;
> >  
> > -	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
> > -	 			   &cn_proc_mcast_ctl))) {
> > -		printk(KERN_WARNING "cn_proc failed to register\n");
> > -		goto out;
> > -	}
> > +	err = cn_add_callback(&cn_proc_event_deprecated_id, "cn_proc_old",
> > +			      &cn_proc_mcast_old_ctl);
> > +	if (err)
> > +		goto error_old;
> 
> 
> > +	err = cn_add_callback(&cn_proc_event_id, "cn_proc", NULL);
> 
> is this needed if you are not going to have the callback ?

I believe so. Evgeniy?

> > +	if (err)
> > +		goto error;
> should not try to cn_del_callback(&cn_proc_event_id) ?! (goto error_old;
> perhaps)

Ack! Good catch.

Thanks,
	-Matt Helsley

