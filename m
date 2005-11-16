Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVKPKDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVKPKDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVKPKDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:03:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:64462 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932595AbVKPKDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:03:17 -0500
Date: Wed, 16 Nov 2005 11:03:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, pavel@suse.cz,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] race condition in fs/compat.c with compat_sys_ioctl
Message-ID: <20051116100323.GA26822@elte.hu>
References: <5bdc1c8b0511121725u6df7ad9csb9cb56777fa6fe64@mail.gmail.com> <Pine.LNX.4.58.0511122149020.25152@localhost.localdomain> <5bdc1c8b0511121914v12dc4402u424fbaf416bf3710@mail.gmail.com> <1131853456.5047.14.camel@localhost.localdomain> <5bdc1c8b0511130634h501fb565v58906bdfae788814@mail.gmail.com> <1131994030.5047.17.camel@localhost.localdomain> <5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com> <1132115386.5047.61.camel@localhost.localdomain> <p73y83pp25r.fsf@verdi.suse.de> <1132134370.5047.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132134370.5047.73.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> It's still there in 2.6.15-rc1-git3 (the sem is the down_read of 
> ioctl32_sem in fs/compat.c).
> 
> No, the problem was unique to the rt patch.  In -rt the default 
> down_read is just like a down (since it is very hard to do PI on 
> readers and writer locks).  So the solution in -rt was to convert this 
> back to a normal RW sem.

to be precise: rwsems in PREEMPT_RT are "only one reader, but reader 
might self-recurse". I.e. the sequence of:

	down_read();
	...
		down_read();
		...
		up_read();
	...
	up_read();

is still supported.

this very simple rw-semaphore type covers the overwhelming majority of 
uses: out of hundreds of rwsems in the kernel, ioctl32_sem is the first 
one that had to be converted to a 'compat' rwsem.

	Ingo
