Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWAZUXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWAZUXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWAZUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:23:16 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:20618 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751416AbWAZUXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:23:16 -0500
Date: Thu, 26 Jan 2006 21:23:15 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Message-ID: <20060126202314.GC20473@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
	Cedric Le Goater <clg@fr.ibm.com>
References: <43D14578.6060801@watson.ibm.com> <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com> <43D52592.8080709@watson.ibm.com> <m1oe22lp69.fsf@ebiederm.dsl.xmission.com> <1138050684.24808.29.camel@localhost.localdomain> <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com> <1138062125.24808.47.camel@localhost.localdomain> <m17j8pl95v.fsf@ebiederm.dsl.xmission.com> <1138137060.14675.73.camel@localhost.localdomain> <m1irs8k545.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irs8k545.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 02:51:22AM -0700, Eric W. Biederman wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > On Maw, 2006-01-24 at 12:26 -0700, Eric W. Biederman wrote:
> 
> >> At least for this first round I think talking about a kpid
> >> as a container, pid pair makes a lot of sense for the moment, as
> >> the other implementations just confuse things.
> >
> > As an abstract object a kpid to me means a single identifier which
> > uniquely identifies the process and which in its component parts be they
> > pointers or not uniquely identifies the process in the container and the
> > container in the system, both correctly refcounted against re-use.
> 
> Correct.
> 
> Currently by using pids internally we are not correctly refcounted
> against reuse.  Nor in the process group case do we even have an
> object off of which we can hang a reference count.
> 
> In the case of a multiple instances of a process space the problem
> is much more acute as we must properly ref count the pid space as
> well.
> 
> Now to further make this fun we have variables like spawnpid in 
> drivers/char/vt_ioctl.c and drivers/char/keyboard.c that
> persist indefinitely.  Which cause problems for most traditional
> reference counting techniques.
> 
> Further in cases where the references persist indefinitely we don't
> want to pin the task_struct in memory indefinitely even after
> the task has exited and it's zombie has been reaped.
> 
> So how do we solve this problem?
> 
> There are two possible approaches I can see to solving this problem.
> 1) Use a non-pointer based kpid and simply accept identifier
>    wrap-around problems with kpids just like we currently accept
>    these problems with pids.

sounds like a poor approach (well similar to the
current one, except that the issues might get more
comples when processes are signalled or referenced
across pid spaces :) ...

anyway, if that would be the aim, it could be done
much simpler by 'just' adding a v/upid field to the
task struct and use that for everything userspace
related (i.e. locating tasks, sending signals, etc)
no need to change the current *pid entries at all

best,
Herbert

> 2) Implement weak references for kpids.
> 
> Semantically a weak reference is a pointer that becomes NULL when the
> object it refers to goes away.
> 
> A couple days ago I conducted an experiment, to see if I could
> implement this in the kernel and surprisingly it is fairly straight
> forward to do.  First you define a weak kpid as a kpid with a
> list_head attached, and whenever you setup a weak kpid you
> register it with the pid hash table.  
> 
> Then in detach_pid when the last reference to the pid goes away, you
> walk the list of weak kpids and you NULL the appropriate entries.
> 
> This seems to solve the reference counting problem neatly and
> without needing to disturb the logic of the existing code.  Even
> outside the context of multiple pid spaces then I think weak
> kpids are desirable.
> 
> Thoughts?
> 
> from kernel/pid.c:
> > void fastcall detach_pid(task_t *task, enum pid_type type)
> > {
> > 	int tmp, nr;
> > 
> > 	nr = __detach_pid(task, type);
> > 	if (!nr)
> > 		return;
> 
> Walk the list of weak kpids here.
> 
> > 
> > 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
> > 		if (tmp != type && find_pid(tmp, nr))
> > 			return;
> > 
> > 	free_pidmap(nr);
> > }
> 
> 
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
