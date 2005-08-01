Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVHAH5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVHAH5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVHAH5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:57:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40082 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261527AbVHAH5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:57:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ulrich Drepper <drepper@gmail.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: sigwait() breaks when straced
In-Reply-To: Ulrich Drepper's message of  Monday, 1 August 2005 00:09:53 -0700 <a36005b50508010009453fdfb7@mail.gmail.com>
X-Zippy-Says: Now that we're in LOVE, you can BUY this GOLDFISH for a 48% DISCOUNT.
Message-Id: <20050801075704.D5120180EC0@magilla.sf.frob.com>
Date: Mon,  1 Aug 2005 00:57:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But sigwait is not a function specified with an EINTR error number. 
> As I said before, this does not mean that EINTR cannot be returned. 
> But it will create havoc among programs and it causes undefined
> behavior wrt to SA_RESTART.  I think it is best to not have any
> function for which EINTR is not a defined error to fail this way. 
> This causes the least amount of surprises and unnecessary loops around
> the userlevel call sites.

We use the same rt_sigtimedwait system call for sigtimedwait and
sigwaitinfo, which do list EINTR for the case of a handled signal.
It's for this scenario that the system call gives EINTR in this case.
We could have libc's sigwait repeat the system call on EINTR.

Unfortunately it is already the case that stop signals cause signal
interruption of system calls when they should be restarted.
rt_sigtimedwait is no different from other system calls in this regard.
It's a general problem.  There is a signal wakeup in order to process the
stop signal.  The blocking system call wakes up diagnoses this with EINTR.
In the case of a handled signal, this gets to the handler setup and the
first thing that does is the SA_RESTART processing.  But when the signal
instead causes a stop (for job control or ptrace) and a later resumption
without running a signal handler, no restart happens.  In the case of the
sleep calls, this causes early wakeups.  In other blocks it produces the
spurious EINTR returns.



Thanks,
Roland
