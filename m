Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267735AbUHEOPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267735AbUHEOPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267677AbUHEOOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:14:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63712 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267726AbUHEOKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:10:25 -0400
Date: Thu, 5 Aug 2004 12:42:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, inaky.perez-gonzalez@intel.com,
       linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       rusty@rustcorp.com.au, jamie@shareable.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Message-ID: <20040805104200.GB20171@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407> <20040804232123.3906dab6.akpm@osdl.org> <4111DC8C.7050504@redhat.com> <20040805001737.78afb0d6.akpm@osdl.org> <4111E3B5.1070608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4111E3B5.1070608@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ulrich Drepper <drepper@redhat.com> wrote:

> Andrew Morton wrote:
> 
> > How large is the slowdown, and on what workloads?
> 
> The fast path for all locking primitives etc in nptl today is entirely
> at userlevel.  Normally just a single atomic operation with a dozen
> other instructions.  With the fusyn stuff each and every locking
> operation needs a system call to register/unregister the thread as it
> locks/unlocks mutex/rwlocks/etc. [...]

actually, the way i understand the patch it is not that bad: normally
(in non-KCO mode) the fastpath locks/unlocks (uncontended locks) are
userspace-only. Non-KCO mode still gives all the priority guarantees. 
(There's also KCO mode for guaranteed-unlock-on-thread-death and for
broken architectures - but it doesnt have any real advantage other than
the slowdown.)

there's overhead in the wakeup handling and in the registration need for
non-KCO locks, but once things are up and running it should be quite
comparable to current futex costs - it's pure userspace.

so i think what would be nice is an extension of sys_futex() to
incorporate the fusyn primitives, and then a nice glibc patch to
introduce a robust mode for all the sync objects.

and if fusyn.c is fast enough then we could even try to do normal
futexes via fusyn.c - but not doing the registration/unregistration
(hence losing the priority guarantee, but still sharing much of the
codepath). This would be the most robust internal design i believe.

	Ingo
