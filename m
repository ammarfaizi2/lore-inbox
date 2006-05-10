Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWEJQ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWEJQ7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWEJQ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:59:00 -0400
Received: from www.osadl.org ([213.239.205.134]:3050 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964989AbWEJQ67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:58:59 -0400
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jakub Jelinek <jakub@redhat.com>
Cc: Sebastien Dugue <sebastien.dugue@bull.net>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <20060510150140.GR14147@devserv.devel.redhat.com>
References: <20060510112651.24a36e7b@frecb000686>
	 <20060510100858.GA31504@elte.hu> <1147266235.3969.31.camel@frecb000686>
	 <1147271536.27820.288.camel@localhost.localdomain>
	 <20060510150140.GR14147@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 19:02:01 +0200
Message-Id: <1147280521.27820.329.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 11:01 -0400, Jakub Jelinek wrote:
> But, there are 2 other futexes used by condvars - internal condvar's lock
> and __data.__futex.  If the associated mutex uses PI protocol, then
> I'm afraid the internal condvar lock needs to follow the same protocol
> (i.e. use FUTEX_*LOCK_PI), otherwise a low priority task calling
> pthread_cond_* and acquiring the internal lock, then scheduled away
> indefinitely because of some middle-priority CPU hog could delay
> some high priority task calling pthread_cond_* on the same condvar.

Did not think about __data.__lock

I said "hack_alert" explicitely as this was just a work around, so we
could use an PI futex for the outer one, which was used to protect other
things too. The assmebler code corrupted the lock field of the outer
mutex with 0/1/2.

> But, there is a problem here - pthread_cond_{signal,broadcast} don't
> have any associated mutexes, so you often don't know which type
> of protocol you want to use for the internal condvar lock.
> Now, for the __data.__futex lock POSIX seems to be more clear,
> all it says is that the wake up should happen according to the scheduling
> policy (but, on the other side for pthread_mutex_unlock it says the same
> and we still use FIFO there).

Sebastians patch might solve this.

Is there a way to (pre)set the policy of the inner lock or is there any
other solution in sight ?

	tglx


