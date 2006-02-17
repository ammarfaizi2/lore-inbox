Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWBQXrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWBQXrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWBQXrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:47:15 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:20422 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751803AbWBQXrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:47:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=XriLehEQj8/2Z8jmn1J12drfpGumLmG+hUIzgZeRcBHUd/5y2SLjF0gLJ55kQ3WWpmHAIgAeqQoRpffCZP/nWKGIaR63GTLadM9PXH91kFDnPaA1I82PRidbrSQRbYANHzOexeixJ7f8122mTly2TGfVzJk/gj+FZkNRNV0Wmjo=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
Date: Fri, 17 Feb 2006 18:47:08 -0500
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
References: <Pine.OSF.4.05.10602170003380.22107-100000@da410>
In-Reply-To: <Pine.OSF.4.05.10602170003380.22107-100000@da410>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171847.09553.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending: I accidentally did reply one.]

On Thursday 16 February 2006 18:20, Esben Nielsen wrote:
> On Thu, 16 Feb 2006, Ingo Molnar wrote:
>
> >
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> >
> > > As I understand the protocol the userspace task writes it's pid into
> > > the lock atomically when locking it and erases it atomically when it
> > > leaves the lock. If it is killed inbetween the pid is still there. Now
> > > if another task comes along it reads the pid, sets the wait flag and
> > > goes into the kernel. The kernel will now be able to see that the pid
> > > is no longer valid and therefore the owner must be dead.
> >
> > this is racy - we cannot know whether the PID wrapped around.
> >
> What about adding more bits to check on? The PID to lookup the task_t and
> then some extra bits to uniquely identify the actual task.

The extra identifying bits don't even have to be written at the same
time/place as the PID. They can be written after the futex is aquired,
and cleared before the futex is released. A mechanism similar to
list_op_pending can be used to fill the races: If the extra-id field is
clear, the kernel checks all the list_op_pendings registered for that PID
to see if any of the threads is in the process of aquiring/releasing that
futex. If not, FUTEX_OWNER_DIED. This last process is liable to be quite
nasty and heavy-weight, but it should also be rare if the races are small.

I believe all the races in the last process can be closed if we can count
on FUTEX_WAITERS informing us (the testing process) if the futex is
released. For each thread that might be holding the futex, if
list_op_pending doesn't equal the futex, then that thread can't be aquiring
the futex. If the extra_id is still clear, then that thread can't be holding
the futex. If list_op_pending still doesn't equal the futex, then that
thread can't be freeing the futex. Therefore that thread doesn't have the
futex. So if no threads are holding the futex, and the futex hasn't been
released during this process, then the owner must be dead.

[This assumes that the freeing thread is the same as the one that aquired
the mutex. This assumption can be relaxed to the freeing thread
being merely in the same process, but beyond that a syscall would be
needed on the freeing side to avoid races.]

I hope this is clear, I'd need to get up to speed on kernel hacking before
I could turn this into code.

Andrew Wade
