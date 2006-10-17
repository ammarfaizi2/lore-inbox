Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWJQMcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWJQMcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWJQMcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:32:13 -0400
Received: from sigtuna.hangingditch.net ([88.198.191.26]:32425 "EHLO
	sigtuna.hangingditch.net") by vger.kernel.org with ESMTP
	id S1750808AbWJQMcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:32:12 -0400
In-Reply-To: <20061017092410.16731.qmail@science.horizon.com>
References: <20061017092410.16731.qmail@science.horizon.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <13285D3A-ED97-40F1-9E0D-CBB1C9A0B706@garethknight.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org
Content-Transfer-Encoding: 7bit
From: Gareth Knight <gk@garethknight.com>
Date: Tue, 17 Oct 2006 05:32:00 -0700
To: linux@horizon.com
X-Mailer: Apple Mail (2.752.2)
X-SA-Exim-Connect-IP: 64.142.80.85
X-SA-Exim-Mail-From: gk@garethknight.com
Subject: Re: [PATCH] generic signal code (small new feature - userspace signal mask), kernel 2.6.16
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on sigtuna.hangingditch.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A way to cancel delivery / push things back onto the signal queue  
would indeed be a worthy addition.  The way I would see that working  
would be where you passed a special or new parameter to sigreturn()  
to indicate you wanted that signal requeued, presumably the  
implication would be that is was also added to the blocked mask at  
the same time.

The scheme for critical sections described below is a decent  
compromise, but it does require more application change than just  
speeding up sigprocmask.  My idea was that glibc could take advantage  
of the sigprocmask speedup when it was available and thus you  
automatically roll out the benefit to existing applications.

Linus pretty much mauled the suggested patch, but I don't think its  
quite as bad as it may first appear.  The suggestion from Andi to  
pin / lock the page (inspired from the futex code) I think solves a  
number of edge cases right off the bat and is straightforward to do.   
The concern over a copy_from_user whilst holding the &current- 
 >sighand->siglock I think is just a case of ensuring  
recalc_sigpending is not called in that situation - it doesn't seem  
necessary to hold the siglock to recalc the pending signals.

I also re-read the signal code and whilst it is quite true that  
recalc_sigpending is not called in every path, the omissions seem to  
me to be places that would be irrelevant anyway - in the case of  
forcing signal delivery for instance, where you wish to ignore any mask.

I do agree that in the case of unblocking a pending signal with my  
scheme, delivery is not instantaneous (typically the next syscall),  
but I would argue that this is only the case for signals which would  
not have been temporally deterministic anyway - some synchronous  
event such as a SIGBUS will cause pre-emption in a deterministic  
manner as always.

Suggestions and comments most welcome,

Gareth.


>> This is a proposed addition to the linux kernel to reduce the
>> overhead required to mask signals.  The intended usage is an
>> application with critical sections that need to be guarded against
>> deadlock by preventing signals from being delivered whilst inside one
>> of the critical sections.  Currently such applications may be very
>> heavy users of the sigprocmask syscall, this proposal provides an
>> additional signal mask stored in userspace that can be updated with a
>> simple store rather than a syscall.
>
> Wouldn't a simpler solution be to provide a way to cancel signal
> delivery after it's hit user-space?
>
> Then user space can keep its own block mask, which is maintained as
> a superset of the kernel block mask.  Then a critical section would,
> in the fast path, proceed like:
>
> - Block signals -> Noted in user-space only
> - Do critical section (part 1)
> - Do critical section (part 2)
> - Unblock signals -> Noted in user-space only
> - More code
>
> And if something bad happened
>
> - Block signals -> Noted in user-space only
> - Do critical section (part 1)
>   - Signal arrives
>   - Test against user-space mask
>   - Tell kernel about all blocked signals -> Note new kernel mask
>   - Return "please try again later" from signal handler
> - Do critical section (part 2)
> - Unblock signals -> Note that it's less than kernel mask
>   - Tell kernel about newly unblocked signals
>   - Signal arrives (again)
>   - Test against user-space mask
>   - Call registered signal handler
>   - Return "signal handled"
> - More code
>
> This does do the whole signal delivery dance twice if it gets unlucky,
> but keeps a conceptually simpler kernel interface.
>
> The one thing that might be complicated is pthread signal delivery.
> "Please try again later" could need to go back to the process layer  
> and
> immediately re-deliver it to a different thread.

