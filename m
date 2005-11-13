Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVKMUaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVKMUaI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 15:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVKMUaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 15:30:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750835AbVKMUaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 15:30:06 -0500
Date: Sun, 13 Nov 2005 12:29:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com>
 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com>
 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Nov 2005, Linus Torvalds wrote:
> 
> The only question being whether you'd actually want to nop out the 
> spinlock instructions _entirely_ (in addition to changing the nops on 
> things like semaphores). Without the lock, they're not that expensive, but 
> hey, it's still a useless (memory-modifying) instruction.

Actually, that may turn out to be a dangerous idea.

Sad but true: There's a few tests like

	#define assert_spin_locked(x)  BUG_ON(!spin_is_locked(x))

and

	#define __raw_spin_unlock_wait(lock) \
		do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)

that would also need to be nopped out if we nop out the code that updates 
the spinlock (right now they are just disabled entirely on UP, exactly 
because tests like this don't work without the lock being instantiated).

But it would be wonderful if we could just nop out the whole call to the 
spinlock (most of them are out-of-line). It would help I$ footprint, and 
likely help improve dynamic scheduling around that call on many CPU's too.

So we can easily remove the lock prefix on the spinlock ops, but sadly we 
can't do some other "obvious" optimizations.

We _could_ nop out the actual conditional on the lock result for a 
spinlock, and turn

	lock ; decb %0
	js ...

into

	nop ; decb %0
	multi-byte-nop

which would help avoid some unnecessary branch prediction etc.

			Linus
