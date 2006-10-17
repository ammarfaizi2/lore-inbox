Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423185AbWJQJYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423185AbWJQJYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423184AbWJQJYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:24:13 -0400
Received: from science.horizon.com ([192.35.100.1]:50489 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1423185AbWJQJYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:24:12 -0400
Date: 17 Oct 2006 05:24:10 -0400
Message-ID: <20061017092410.16731.qmail@science.horizon.com>
From: linux@horizon.com
To: gk@garethknight.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic signal code (small new feature - userspace signal mask), kernel 2.6.16
Cc: ak@suse.de, linux@horizon.com, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a proposed addition to the linux kernel to reduce the  
> overhead required to mask signals.  The intended usage is an  
> application with critical sections that need to be guarded against  
> deadlock by preventing signals from being delivered whilst inside one  
> of the critical sections.  Currently such applications may be very  
> heavy users of the sigprocmask syscall, this proposal provides an  
> additional signal mask stored in userspace that can be updated with a  
> simple store rather than a syscall.

Wouldn't a simpler solution be to provide a way to cancel signal
delivery after it's hit user-space?

Then user space can keep its own block mask, which is maintained as
a superset of the kernel block mask.  Then a critical section would,
in the fast path, proceed like:

- Block signals -> Noted in user-space only
- Do critical section (part 1)
- Do critical section (part 2)
- Unblock signals -> Noted in user-space only
- More code

And if something bad happened

- Block signals -> Noted in user-space only
- Do critical section (part 1)
  - Signal arrives
  - Test against user-space mask
  - Tell kernel about all blocked signals -> Note new kernel mask
  - Return "please try again later" from signal handler
- Do critical section (part 2)
- Unblock signals -> Note that it's less than kernel mask
  - Tell kernel about newly unblocked signals
  - Signal arrives (again)
  - Test against user-space mask
  - Call registered signal handler
  - Return "signal handled"
- More code
   
This does do the whole signal delivery dance twice if it gets unlucky,
but keeps a conceptually simpler kernel interface.

The one thing that might be complicated is pthread signal delivery.
"Please try again later" could need to go back to the process layer and
immediately re-deliver it to a different thread.
