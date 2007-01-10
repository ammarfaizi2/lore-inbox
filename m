Return-Path: <linux-kernel-owner+w=401wt.eu-S932805AbXAJNC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbXAJNC6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbXAJNC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:02:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932805AbXAJNC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:02:57 -0500
Date: Wed, 10 Jan 2007 07:54:16 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: Ulrich Drepper <drepper@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Jakub Jelinek <jakub@redhat.com>,
       Darren Hart <dvhltc@us.ibm.com>,
       Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
Message-ID: <20070110125416.GW29911@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <45A3B330.9000104@bull.net> <45A3BFC8.1030104@bull.net> <45A3C2CE.7070500@redhat.com> <45A4D249.8080904@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A4D249.8080904@bull.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 12:47:21PM +0100, Pierre Peiffer wrote:
> So, yes it (logically) has a cost, depending of the number of different 
> priorities used, so it's specially measurable with real-time threads.
> With SCHED_OTHER, I suppose that the priorities are not be very distributed.
> 
> May be, supposing it makes sense to respect the priority order only for 
> real-time pthreads, I can register all SCHED_OTHER threads to the same 
> MAX_RT_PRIO priotity ?
> Or do you think this must be set behind a CONFIG* option ?
> (Or finally not interesting enough for mainline ?)

As soon as there is at least one non-SCHED_OTHER thread among the waiters,
there is no question about whether plist should be used or not, that's
a correctness issue and if we want to conform to POSIX, we have to use that.

I guess Ulrich's question was mainly about performance differences
with/without plist wakeup when all threads are SCHED_OTHER.  I'd say for
that a pure pthread_mutex_{lock,unlock} benchmark or even just a program
which uses futex FUTEX_WAIT/FUTEX_WAKE in a bunch of threads would be
better.

In the past we talked with Ingo about the possibilities here, one is use
plist always and prove that it doesn't add measurable overhead over current
FIFO (when only SCHED_OTHER is involved), the other possibility would be
to start using FIFOs as before, but when the first non-SCHED_OTHER thread
decides to wait on the futex, switch it to plist wakeup mode (convert the
FIFO into a plist) and from that point on just use plist wakeups on it.

	Jakub
