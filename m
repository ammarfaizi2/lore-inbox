Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUGENpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUGENpt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUGENpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:45:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52512 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266110AbUGENpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:45:30 -0400
Date: Mon, 5 Jul 2004 15:22:45 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: FabF <fabian.frederick@skynet.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4
In-Reply-To: <1089034642.2129.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407051518300.18740-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2004, FabF wrote:
> > I noticed that in 2.4.x kernels the fs/proc/base.c:mem_read() function has 
> > this permission check:
> > 
> >         if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
> >                 return -ESRCH;
> > 
> > Are you sure it shouldn't be like this instead:
> > 
> >         if (!MAY_PTRACE(task) && !may_ptrace_attach(task))
> >                 return -ESRCH;
> > 
> > Because, normally MAY_PTRACE() is 0 (i.e. for any process worth looking at :)
> > so may_ptrace_attach() is never even called.
> > 
> MAY_PTRACE is 1 normally AFAICS.The check as it stands wants both to
> have non zero returns so is more restrictive than the one you're asking
> for.

MAY_PTRACE is defined as:

#define MAY_PTRACE(task) \
        (task == current || \
        (task->parent == current && \
        (task->ptrace & PT_PTRACED) && task->state == TASK_STOPPED))

so, if a process (current) is interested in another process (task) which
is not itself and not one of its children then MAY_PTRACE is 0. and the
test in mem_read() immediately returns ESRCH error without checking
may_ptrace_attach() at all. I questioned this behaviour as being too
restrictive and would like to know the reason for it.

Surely, the super user (i.e. CAP_SYS_PTRACE in this context) should be 
allowed to read any process' memory without having to do the 
PTRACE_ATTACH/PTRACE_PEEKUSER kind of thing which strace(8) is doing?

Kind regards
Tigran

