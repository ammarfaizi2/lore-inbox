Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266120AbUGEOZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUGEOZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 10:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUGEOZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 10:25:52 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:18081 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266120AbUGEOZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:25:37 -0400
Subject: Re: question about /proc/<PID>/mem in 2.4
From: FabF <fabian.frederick@skynet.be>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0407051518300.18740-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0407051518300.18740-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1089037523.2129.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 05 Jul 2004 16:25:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 16:22, Tigran Aivazian wrote:
> On Mon, 5 Jul 2004, FabF wrote:
> > > I noticed that in 2.4.x kernels the fs/proc/base.c:mem_read() function has 
> > > this permission check:
> > > 
> > >         if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
> > >                 return -ESRCH;
> > > 
> > > Are you sure it shouldn't be like this instead:
> > > 
> > >         if (!MAY_PTRACE(task) && !may_ptrace_attach(task))
> > >                 return -ESRCH;
> > > 
> > > Because, normally MAY_PTRACE() is 0 (i.e. for any process worth looking at :)
> > > so may_ptrace_attach() is never even called.
> > > 
> > MAY_PTRACE is 1 normally AFAICS.The check as it stands wants both to
> > have non zero returns so is more restrictive than the one you're asking
> > for.
> 
> MAY_PTRACE is defined as:
> 
> #define MAY_PTRACE(task) \
>         (task == current || \
>         (task->parent == current && \
>         (task->ptrace & PT_PTRACED) && task->state == TASK_STOPPED))
> 
> so, if a process (current) is interested in another process (task) which
> is not itself and not one of its children then MAY_PTRACE is 0. and the
> test in mem_read() immediately returns ESRCH error without checking
> may_ptrace_attach() at all. I questioned this behaviour as being too
> restrictive and would like to know the reason for it.
> 
> Surely, the super user (i.e. CAP_SYS_PTRACE in this context) should be 
> allowed to read any process' memory without having to do the 
> PTRACE_ATTACH/PTRACE_PEEKUSER kind of thing which strace(8) is doing?

FYI may_ptrace_attach plugged somewhere between 2.4.21 & 22.This one get
used as is (ie without MAY_PTRACE) in proc_pid_environ but dunno about
reason why CAP_SYS_PTRACE isn't authoritative elsewhere.

Regards,
FabF



> 
> Kind regards
> Tigran
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

