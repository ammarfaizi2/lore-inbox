Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUIPG04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUIPG04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUIPG04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:26:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30880 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267679AbUIPG0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:26:52 -0400
Date: Thu, 16 Sep 2004 08:27:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@fsmlabs.com>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916062759.GA10527@elte.hu>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916061359.GA12915@wotan.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> Known problem. Interrupts don't save regs->rbp, but the new profile_pc
> that was introduced recently uses it.
> 
> One quick fix is to just use SAVE_ALL in the interrupt entry code, but
> I don't like this because it will affect interrupt latency.
> 
> The real fix is to fix profile_pc to not reference it.

it would be nice if we could profile the callers of the spinlock
functions instead of the opaque spinlock functions.

the ebp trick is nice, but forcing a formal stack frame for every
function has global performance implications. Couldnt we define some
sort of current-> field [or current_thread_info() field] that the
spinlock code could set and clear, which field would be listened to by
profile_pc(), so that the time spent spinning would be attributed to the
callee? Something like:

spin_lock()
	current->real_pc = __builtin_return_address(0);
	...
	current->real_pc = 0;

profile_pc():
	...
	if (current->real_pc)
		pc = current->real_pc;
	else
		pc = regs->rip;

this basically means that we set up a 'conditional frame pointer' in the
spinlock functions - but only in the spinlock functions! It is true that 
this would be 1-2 cycles more expensive than using the frame pointer 
register but considering the totality of performance i believe this is 
wastly superior.

AFAIR __builtin_return_address(0) is nice and sweet on all platforms,
and it works even with -fomit-frame-pointers. (levels 1 and more are not
guaranteed to work, but level 0 always works.) On x86/x64 gcc derives it
from %esp so the overhead of setting up current->real_pc. On platforms
that have 'current' (or current_thread_info()) in a register, saving and
clearing current->real_pc ought to be a matter of 2-3 instructions.
(could be 2 instructions total on x64 - the same cost as
-fno-omit-frame-pointer ebp saving would have!)

->real_pc would have a small race window from the point it's cleared up
until it returns, but it's not a big issue because 99% of the spinlock
related profile overhead is either in the spinning section or the first
access to the cacheline. If there is some small overhead measured
spin_lock() it's not a big issue, as long as the brunt of the overhead
is attributed to the ->real_pc callee.

spin_unlock() doesnt even need to set up ->real_pc - making this
solution even cheaper.

hm?

	Ingo
