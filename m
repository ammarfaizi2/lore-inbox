Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311050AbSCHTX3>; Fri, 8 Mar 2002 14:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311044AbSCHTXT>; Fri, 8 Mar 2002 14:23:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29448 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311051AbSCHTXF>; Fri, 8 Mar 2002 14:23:05 -0500
Date: Fri, 8 Mar 2002 11:22:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <20020308190232.A2D273FE06@smtp.linux.ibm.com>
Message-ID: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Mar 2002, Hubertus Franke wrote:
> 
> Could you also comment on the functionality that has been discussed. 

First off, I have to say that I really like the current patch by Rusty. 
The hashing approach is very clean, and it all seems quite good. As to 
specific points:

> (I) the fairness issues that have been raised.
>     do you support two wakeup mechanism: FUTEX_UP and FUTEX_UP_FAIR 
>     or you don't care about fairness and starvation

I don't think fairness and starvation is that big of a deal for
semaphores, usually being unfair in these things tends to just improve
performance through better cache locality with no real downside. That
said, I think the option should be open (which it does seem to be).

For rwlocks, my personal preference is the fifo-fair-preference (unlike
semaphore fairness, I have actually seen loads where read- vs
write-preference really is unacceptable). This might be a point where we 
give users the choice.

I do think we should make the lock bigger - I worry that atomic_t simply
won't be enough for things like fair rwlocks, which might want a
"cmpxchg8b" on x86. 

So I would suggest making the size (and thus alignment check) of locks at
least 8 bytes (and preferably 16). That makes it slightly harder to put
locks on the stack, but gcc does support stack alignment, even if the code
sucks right now.

		Linus


