Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVLSUN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVLSUN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLSUN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:13:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964941AbVLSUN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:13:56 -0500
Date: Mon, 19 Dec 2005 12:12:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
In-Reply-To: <20051219195553.GA14155@elte.hu>
Message-ID: <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu>
 <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219195553.GA14155@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Dec 2005, Ingo Molnar wrote:
> 
>  average cost per op:       206.59 usecs
>  average cost per op:       512.13 usecs

(mutex vs semaphore).

That looks suspiciously like exactly double the cost, so I do believe that 
the double wake_up() might be exactly what is going on.

However:

> hm, removing that wakeup quickly causes hung test-tasks.

So clearly it really is still hiding some bug.

> and even considering that the current semaphore implementation may have 
> a fairness bug, i cannot imagine that making it more fair would also 
> speed it up.

That's not the point. The extra wakeup() in th esemaphore code wakes up 
two processes for every single up(), so the semaphores end up not just 
being unfair, they also end up doing twice the work (because it will 
result in the other processes effectively just doing the down() twice).

> I personally find the semaphore implementation clever but too complex, 
> maybe that's a reason why such bugs might be hiding there.  (possibly 
> for many years already ...)

Oh, absolutely. It is too complex. 

And don't get me wrong: if it's easier to just ignore the performance bug, 
and introduce a new "struct mutex" that just doesn't have it, I'm all for 
it. However, if so, I do NOT want to do the unnecessary renaming. "struct 
semaphore" should stay as "struct semaphore", and we should not affect old 
code in the _least_.

Then code can switch to "struct mutex" if people want to. And if one 
reason for it ends up being that the code avoids a performance bug in the 
process, all the better ;)

IOW, I really think this should be a series of small patches that don't 
touch old users of "struct semaphore" at all. None of this "semaphore" to 
"arch_semaphore" stuff, and the new "struct mutex" would not re-use _any_ 
of the names that the old "struct semaphore" uses.

		Linus
