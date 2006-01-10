Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWAJQq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWAJQq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWAJQq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:46:56 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:48582 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751144AbWAJQqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:46:55 -0500
Message-ID: <43C3F6DB.FEFDA101@tv-sign.ru>
Date: Tue, 10 Jan 2006 21:03:07 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: balbir@in.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <Pine.LNX.4.64.0512191148460.4827@g5.osdl.org> <43A985E6.CA9C600D@tv-sign.ru> <20060110102851.GB18325@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>
> On Wed, Dec 21, 2005 at 07:42:14PM +0300, Oleg Nesterov wrote:
> >
> > Note that subsequent up() will not call wakeup(): ->count == 0,
> > it just increment it. That is why we are waking the next waiter
> > in advance. When it gets cpu, it will decrement ->count by 1,
> > because ->sleepers == 0. If up() (++->count) was already called,
> > it takes semaphore. If not - goes to sleep again.
> >
> > Or my understanding is completely broken?
>
> [ ... long snip ... ]
>
> The question now remains as to why we have the atomic_add_negative()? Why do
> we change the count in __down(), when down() has already decremented it
> for us?

... and why __down() always sets ->sleepers = 0 on return.

I don't have an answer, only a wild guess.

Note that if P1 releases this semaphore before pre-woken P2 actually
gets cpu what happens is:

	P1->up() just increments ->count, no wake_up() (fastpath)

	P2 takes the semaphore without schedule.

So *may be* it was designed this way as some form of optimization,
in this scenario P2 has some chances to run with sem held earlier.

Oleg.
