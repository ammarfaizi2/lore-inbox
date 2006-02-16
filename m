Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWBPUi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWBPUi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWBPUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:38:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:65196 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964888AbWBPUi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:38:26 -0500
Date: Thu, 16 Feb 2006 21:36:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
Message-ID: <20060216203626.GB21415@elte.hu>
References: <1140118455.4117.91.camel@laptopd505.fenrus.org> <Pine.OSF.4.05.10602162057040.20911-100000@da410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10602162057040.20911-100000@da410>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > On Thu, 2006-02-16 at 20:06 +0100, Esben Nielsen wrote:
> > > I just jump into a thread somewhere to ask my question :-)
> > > 
> > > Why does the list have to be in userspace?
> > 
> > because it's faster ;)
> > 
> >
> Faster??? 

yes, it's faster.

> As I see it, extra manipulations have to be done even in the non-congested
> case: Every time the lock is taken the locking thread has to add the lock
> to a the list, and reversely remove the lock from the list. I.e.
> instructions are _added_ to the fast path where you stay purely in
> userspace.

Note that glibc was already doing these list ops for the current 
(limited, userspace-only) implementation of robust mutexes, so moving 
the cleanup to kernel-space has only a small effect on the userspace 
fastpath.

even considering the list ops, they are 2-3 (non-LOCK-ed) instructions 
of memory values that are already cached => it's almost for free. Ulrich 
(who is a kind of person who writes glibc code in assembly whenever he 
can excuse it with a performance argument) would be pretty upset if it 
wasnt cheap :-)

> I am ofcourse comparing to a solution where you do a syscall on 
> everytime you do a lock. What I am asking about is whethere it 
> wouldn't be enough to maintain the list at the FUTEX_WAIT/FUTEX_WAKE 
> operation - i.e. the slow path where you have to go into the kernel.

no, that's not enough at all: we need to be able to clean up after 
futexes even if the kernel was _never involved_ with them. The pure 
userspace futex fastpath still can keep a lock stuck! In fact that is 
the common-case.

	Ingo
