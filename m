Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTLUWFf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 17:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTLUWFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 17:05:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:57273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbTLUWFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 17:05:31 -0500
Date: Sun, 21 Dec 2003 14:05:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <3FE616AE.5030103@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0312211357200.1621@home.osdl.org>
References: <3FE492EF.2090202@colorfullife.com> <8765ga6moe.fsf@devron.myhome.or.jp>
 <3FE5F116.9020608@colorfullife.com> <Pine.LNX.4.58.0312211250370.13039@home.osdl.org>
 <3FE60BCC.5090305@colorfullife.com> <Pine.LNX.4.58.0312211313070.13039@home.osdl.org>
 <3FE616AE.5030103@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Manfred Spraul wrote:
>
> >Here's a big clue: if you make code worse than it is today, it won't be 
> >accepted. I don't even see why you'd bother in the first place.
>
> fasync_helper != kill_fasync
> fasync_helper is rare, and usually running under lock_kernel().

But we want to get rid of lock_kernel(), not create new code that depends 
on it.

And _especially_ if fasync_helper() is rarely used, that means that 
changing the callers to have a nicer calling convention would not be 
painful.

> kill_fasync is far more common (every pipe_read and _write), I want to 
> remove the unconditional read_lock(&global_lock).

Note that my personal preference would be to kill off "kill_fasync()" 
entirely.

We actually have almost all the infrastructure in place already: it's 
called a "wait queue". In 2.5.x it took a callback function, and the only 
thing missing is really the "band" information at wakeup time.

So if we instead made the whole fasync infrastructure use the existing 
wait-queues, and made wakeup() say what kind of wakeup it is, we could 
probably get rid of the specific fasync datastructures entirely. And we'd 
only take locks that we take _anyway_.

I dunno. But to me that at least sounds like a real cleanup.

> Today's solution is two copies of fasync_helper: one with lock_sock in 
> net/socket.c, one with write_lock_irq(&fasync_lock) in fs/fcntl.c.

And two functions that statically do something different is actually 
_better_ than one function that does two different things dynamically.

And if the two cases have different locking, then they should remain as 
two separate cases.

			Linus
