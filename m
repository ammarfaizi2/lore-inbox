Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVLSQwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVLSQwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVLSQwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:52:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63704 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750701AbVLSQwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:52:16 -0500
Date: Mon, 19 Dec 2005 17:51:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
Message-ID: <20051219165134.GI8160@elte.hu>
References: <20051219013718.GA28038@elte.hu> <1134968406.13138.235.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134968406.13138.235.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> How expensive is the xchg?  Since __mutex_lock_common is called even 
> when it's going to wake up. Maybe it might be more efficient to add 
> something like:
> 
>           if (atomic_cmpxchg(&lock->count, 1, 0) {
>               debug_set_owner(lock, ti __IP__);
>               debug_unlock_irqrestore(&debug_lock, *flags, ti);
>               return 1;
> 	  }
> 
> This way we save the overhead of grabbing another spinlock, adding the 
> task to the wait_list and changing it's state.

in the first pass we definitely need to add ourselves to the list first 
- hence have to grab the lock. Even after the schedule(), we have to 
xchg it to -1, not 0. This is crutial to 'not drop the ball' property of 
one-waiter-in-flight logic - we must not lose the -1 'there are more 
waiters pending' property. Plus, we have the grab the lock because we 
remove ourselves from the wait-list after the schedule(). So i'm not 
sure your suggested optimization is possible.

	Ingo
