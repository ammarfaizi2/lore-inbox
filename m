Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSIAGsM>; Sun, 1 Sep 2002 02:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSIAGsM>; Sun, 1 Sep 2002 02:48:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43731 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316309AbSIAGsK>;
	Sun, 1 Sep 2002 02:48:10 -0400
Date: Sun, 1 Sep 2002 01:50:25 +0000
From: Amos Waterland <apw@us.ibm.com>
To: pwaechtler@mac.com
Cc: golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues
Message-ID: <20020901015025.A10102@kvasir.austin.ibm.com>
References: <CDB36B91-BB99-11D6-B9F3-00039387C942@mac.com> <20020830094803.A8283@kvasir.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020830094803.A8283@kvasir.austin.ibm.com>; from apw@us.ibm.com on Fri, Aug 30, 2002 at 09:48:03AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 01:43:56PM +0200, pwaechtler@mac.com wrote:
> Am Freitag den, 30. August 2002, um 11:48, schrieb Amos Waterland:
> 
> > On Thu, Aug 29, 2002 at 11:53:50PM +0200, pwaechtler@mac.com wrote:
> >> some comments as asked for:
> >>
> >> I know that it's nowhere stated, but POSIX mqueues are perfectly
> >> designed to be implemented in userspace with locking facilities
> >> provided by the system.
> >
> > I am not sure if this is correct.  You can achieve proper locking in
> > userspace, but I do not think you achieve proper security.
> 
> Well, I can't think of efficient inter process locks without 
> kernel/scheduler help.
> Do you want to use a spinlock, with lowering priority or even sleep, use
> a pipe/fifo/flock or waiting in sigsuspend? This all is implemented in
> kernel space.
> How would you implement entirely userspace locking?
> With futexes (fast "userspace" locks) only the uncontented case is 
> handled
> in userspace - if there's contention the process waits inside the 
> kernel - or
> does get a notification from the kernel (AWAIT or FD)

I think we are agreeing: POSIX mqueues are not perfectly designed to be
implemented in userspace.

> > I assume you are proposing an implementation based on shared memory:
> > which means that at least some pages of the shared memory must be
> > writable.  If the processes cooperate and only write to the shared pages
> > through library routines which use sychronization, things are ok, but a
> > malicious process could forge messages or perform DOS attacks etc. by
> > bypassing the mq_*() functions and using write().
> 
> yes, of course that could be compromised by a process with the same uid.
> This process could simply kill the other process too.
> The shm_open() employs proper file system permission on the object.

No, it is more complicated than that.  They can be compromised by an
arbitrary process if the permissions on the mq include S_IWOTH.

That is the fundamental problem with a userspace shared memory
implementation: write permissions on a message queue should grant
mq_send(), but write permissions on shared memory grant a lot more than
just that.

Amos Waterland
