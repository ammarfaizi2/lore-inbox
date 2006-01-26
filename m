Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWAZUBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWAZUBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWAZUBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:01:44 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:15498 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751253AbWAZUBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:01:43 -0500
Date: Thu, 26 Jan 2006 21:01:42 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Message-ID: <20060126200142.GB20473@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
	Cedric Le Goater <clg@fr.ibm.com>
References: <1137518714.5526.8.camel@localhost.localdomain> <20060118045518.GB7292@kroah.com> <1137601395.7850.9.camel@localhost.localdomain> <m1fyniomw2.fsf@ebiederm.dsl.xmission.com> <43D14578.6060801@watson.ibm.com> <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com> <CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com> <m18xt8mffq.fsf@ebiederm.dsl.xmission.com> <1137945325.3328.17.camel@laptopd505.fenrus.org> <m14q3wmds4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14q3wmds4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 09:24:27AM -0700, Eric W. Biederman wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> >> 
> >> A pointer to a task_struct while it kind of sort of works. Is
> >> not a good solution. The problem is that in a lot of cases we
> >> register a pid to get a signal or something similar and then we
> >> never unregister it. So by using a pointer to a trask_struct you
> >> effectively hold the process in memory forever.

> > this is not right. Both the PID and the task struct have the exact
> > same lifetime rules, they HAVE to, to guard against pid reuse
> > problems.

> Yes PIDs reserved for the lifetime of the task_struct (baring minor
> details). There are actually a few races in /proc where it can see the
> task_struct after the pid has been freed (see the pid_alive macro in
> sched.h)
>
> However when used as a reference the number can live as long as you
> want. The classic example is a pid file that can exist even after you
> reboot a machine.
>
> So currently a use of a PID as a reference to processes or process
> groups can last forever. An example of this is the kernel is the
> result of fcntl(fd, F_SETOWN). The session of a tty is similar.
>
> Since the in kernel references have a lifetime that is completely
> different than the lifetime of a process or a PID. It is not safe
> to simply replace such references with a direct reference to a
> task_struct (besides being technically impossible). Adding those
> references could potentially increase the lifespan of a task_struct
> for to the life of the kernel depending on the reference.

well, yes, but wouldn't that be the RightThing(tm) 
anway? because 'referencing' something via a pid, then
letting the task holding the pid go away and even be
replaced by a new one (with the same pid) which then
will get suddenly signaled from somewhere, just because
the pid matches seems very broken to me ...

best,
Herbert

> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
