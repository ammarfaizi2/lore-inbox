Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVCWNp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVCWNp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVCWNp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:45:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6532 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262398AbVCWNne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:43:34 -0500
Date: Wed, 23 Mar 2005 08:43:12 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: paul@linuxaudiosystems.com
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Chris Morgan <cmorgan@alum.wpi.edu>,
       seto.hidetoshi@jp.fujitsu.com
Subject: Re: kernel bug: futex_wait hang
Message-ID: <20050323134312.GZ32746@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1111463950.3058.20.camel@mindpipe> <20050321202051.2796660e.akpm@osdl.org> <20050322044838.GB32432@mail.shareable.org> <20050321210802.14be70cc.akpm@osdl.org> <1111469453.3563.0.camel@mindpipe> <20050322063405.GN32746@devserv.devel.redhat.com> <1111535887.4691.26.camel@mindpipe> <3726.71.100.26.22.1111583579.spork@webmail.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3726.71.100.26.22.1111583579.spork@webmail.linuxaudiosystems.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 05:12:59AM -0800, paul@linuxaudiosystems.com wrote:
> the hang occurs during an attempted thread cancel+join. we know from
> strace that one thread calls tgkill() on the other. the other thread is
> blocked in a poll call on a FIFO. after tgkill, the first thread enters a
> futex wait, apparently waiting for the thread ID of the cancelled thread
> to appear at some location (just a guess based on the info from strace).
> the wait never returns, and so the first thread ends up hung in
> pthread_join(). there are no user-defined mutexes or condvars involved.

If the thread that is to be cancelled is in async cancel state (it should
be when waiting in a poll and if cancellation is not disabled in that thread),
then pthread_cancel sends a SIGCANCEL signal to it via tgkill.
If tgkill succeeds (and thus pthread_cancel succeeds too) and you call
pthread_join on it, in the likely case the thread is still alive
pthread_join will FUTEX_WAIT on pd->tid, waiting until the thread dies.
NPTL threads are created with CLONE_CHILD_CLEARTID &self->tid, so this
futex will be FUTEX_WAKEd by mm_release in kernel whenever the thread is
exiting (or dying in some other way).

So, if pthread_join waits for the thread forever, the thread must be
around (otherwise pthread_join would not block on it; well, there could
be memory corruption in the program and anything would be possible then).
This would mean either that the poll has not been awaken by the SIGCANCEL
signal, or e.g. that one of the registered cleanup handlers (or C++
destructors) in the thread that is being cancelled get stuck for whatever
reason (deadlock, etc.).

	Jakub
