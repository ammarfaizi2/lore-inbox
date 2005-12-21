Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVLUQfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVLUQfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVLUQfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:35:54 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:35264 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932469AbVLUQfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:35:54 -0500
Message-ID: <43A99618.6D6655C6@tv-sign.ru>
Date: Wed, 21 Dec 2005 20:51:20 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
References: <20051219013718.GA28038@elte.hu> <43A98101.364DB5CF@tv-sign.ru> <20051221155742.GA7375@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > > +   spin_lock(&lock->wait_lock);
> > > +   __add_waiter(lock, waiter, ti, task __IP__);
> > > +   set_task_state(task, task_state);
> >
> > I can't understand why __mutex_lock_common() does xchg() after adding
> > the waiter to the ->wait_list. We are holding ->wait_lock, we can't
> > race with __mutex_unlock_nonatomic() - it calls wake_up() and sets
> > ->count under this spinlock.
> 
> we must make sure that the drop has not been dropped meanwhile, on the
> way in, between the fastpath-unlock atomic op, and the xchg() here.

Sorry for noise, probably I should just re-read your explanation
tomorrow after some sleeping...

But why we can't add the waiter to ->wait_list _after_ xchg() ?
What makes the difference? Fastpath atomic op can happen before
or after xchg(), this is ok. Unlock path will look at ->wait_list
only after taking spinlock, at this time we already added this
waiter to the ->wait_list.

In other words: we are holding ->wait_lock, nobody can even look
at ->wait_list. We can add the waiter to ->wait_list before or
after atomic_xchg() - it does not matter.

Again no?

Oleg.
