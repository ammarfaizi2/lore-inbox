Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUEXHfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUEXHfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUEXHfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:35:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264097AbUEXHes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:34:48 -0400
Date: Mon, 24 May 2004 03:34:07 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040524073407.GC4736@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520233639.126125ef.akpm@osdl.org> <20040521074358.GG30909@devserv.devel.redhat.com> <200405221858.44752.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405221858.44752.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 06:58:41PM +0200, Arnd Bergmann wrote:
> On Friday 21 May 2004 09:43, Jakub Jelinek wrote:
> > Well, for s390/s390x there is a problem that it doesn't allow (yet) 6
> > argument syscalls at all, so one possibility for s390* is adding a wrapper around
> > sys_futex which will take the 5th and 6th arguments for FUTEX_CMP_REQUEUE
> > from a structure pointed to by 5th argument and pass that to sys_futex.
> 
> I would really prefer not re-inventing brain-damage like ipc_kludge. I
> have tried to do a special s390_futex_cmp_requeue() syscall, which is
> still somewhat ugly. At least it has the advantage that it does not break
> the de-facto calling conventions for s390 syscalls that either pass
> up to five arguments in r2 to r6 or everything in an array pointed to
> by r2.
> 
> Martin and Jakub, does the patch below look ok to you or should we do
> it in yet another way?

My personal preference is:
1) change s390* entry*.S so that all syscalls can use up to 6 arguments,
   otherwise we'll have the same problem every now and then
   (last syscall before this one was fadvise64_64 if I remember well)
2) allow sys_futex to have 6 arguments (the 6th on the stack, get_user'ed
   from an s390 wrapper)
3) special structure passed in 5th argument for FUTEX_CMP_REQUEUE
4) your solution
   (you have a special wrapper around futex anyway, so why not to handle
   it there already and create completely new syscall).

That said, NPTL can deal with any of these variants and the decision
is up to Martin I think (assuming the base patch gets accepted, that is).
http://listman.redhat.com/archives/phil-list/2004-May/msg00031.html
is the latest version of the userland part of FUTEX_CMP_REQUEUE changes
(against CVS glibc) and there futex_requeue () macro is defined
in arch specific headers, so nptl/sysdeps/unix/sysv/linux/s390/lowlevellock.h
can do there its own black magic.

	Jakub
