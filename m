Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWEaGan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWEaGan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWEaGan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:30:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16589 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751713AbWEaGam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:30:42 -0400
Date: Wed, 31 May 2006 08:31:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531063103.GC21779@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <1149045448.28264.4.camel@localhost.localdomain> <20060530211442.a260a32e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530211442.a260a32e.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Without having looked at it very hard, I'd venture that this is a 
> false positive - that driver uses disable_irq() to prevent reentry 
> onto that lock.

correct.

> It does that because it knows it's about to spend a long time talking 
> with the mii registers and it doesn't want to do that with interrupts 
> disabled.

i still consider it a 'quirky' locking construct, because disabling 
interrupts for a long time also disables all other devices sharing the 
same IRQ line - not nice.

Also, this is a really hard case for lockdep to detect automatically. 
(fortunately it's also relatively rare)

OTOH, the straightforward lockdep workaround would be to take the 
spinlock and thus disable all local interrupts - not too nice either. 

Albeit in some ways it's still a bit nicer conceptually than disabling 
the irq line, because other CPUs are still operational, and under 
certain locking designs [preempt-rt] spin_lock_irq() does not disable 
local interrupts.
 
Steve, can you think of any better solution? I dont have this card.

	Ingo
