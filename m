Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262544AbSI0RTQ>; Fri, 27 Sep 2002 13:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbSI0RTQ>; Fri, 27 Sep 2002 13:19:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62649 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262544AbSI0RTO>;
	Fri, 27 Sep 2002 13:19:14 -0400
Date: Fri, 27 Sep 2002 19:33:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271001030.2013-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209271921481.15791-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thinking about it some more, first attaching the vcache does not help.

the problem is that we want to catch all COW events of the virtual
address, *and* we want to have a correct (physpage,offset) futex hash.

if we do the following:

        q.page = NULL;
        attach_vcache(&q.vcache, uaddr, current->mm, futex_vcache_callback);

        page = pin_page(uaddr - offset);
        ret = IS_ERR(page);
        if (ret)
                goto out;
        head = hash_futex(page, offset);
(*)
        set_current_state(TASK_INTERRUPTIBLE);
        init_waitqueue_head(&q.waiters);
        add_wait_queue(&q.waiters, &wait);
        queue_me(head, &q, page, offset, -1, NULL, uaddr);

then we have the following race at (*): the futex is not yet hashed, but
it's already in the vcache hash. Nevertheless a parallel COW only
generates a useless callback - the futex is not hashed yet. The effect is
that the above 'page' address is in fact the old COW page [after the race
only mapped into some other MM], and the queue_me() futex hashing uses the
old page.

the only way i can see to do this race-less is what i suggested two mails
ago: when hashing the futex we have to take the pagetable lock and have to
check the actual current page that is mapped.

in fact there's another race as well: what if a parallel thread COWs the
page, faults it in (thus creates a new physical page), which then kswapd
swaps out. Ie. purely checking the pte (and using any potential new page
for the hash) is not enough, we really have to re-try the pin_pages() call
if the pte has changed meanwhile.

	Ingo

