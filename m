Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUIMJX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUIMJX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUIMJX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:23:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48043 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266465AbUIMJXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:23:21 -0400
Date: Mon, 13 Sep 2004 11:24:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kirill Korotaev <dev@sw.ru>
Cc: Roel van der Made <roel@telegraafnet.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
Message-ID: <20040913092443.GA19437@elte.hu>
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru> <20040913083100.GA16921@elte.hu> <41456536.6090801@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41456536.6090801@sw.ru>
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


* Kirill Korotaev <dev@sw.ru> wrote:

> >the BUG() is useful for all the code that uses next_thread() - you can
> >only do a safe next_thread() iteration if you've locked ->sighand.

> 1. I don't see spin_lock() on p->sighand->siglock in do_task_stat() 
> before calling next_thread(). And the check inside next_thread() permits 
> only one of the locks to be taken:
> 
>         if (!spin_is_locked(&p->sighand->siglock) &&
>                                 !rwlock_is_locked(&tasklist_lock))
> 
> which is probably wrong, since tasklist_lock is always required!

It's not 'wrong' in terms of correctness it's simply too restrictive for
no reason. I agree that we should check for the tasklist lock only.

> 2. I think the idea of checking sighand is quite obscure. Probably it
> would be better to call pid_alive() for check at such places in proc,
> isn't it?

yeah, it's just as good of a check.

> 3. And yes, now I agree that this check and BUG() prevented
> next_thread() from walking through the deleted list_head in
> tsk->pid_list.

good.

> But I would propose to reorganize these checks in next_thread() to
> something like this:
> 
> if (!rwlock_is_locked(&tasklist_lock) || p->pids[PIDTYPE_TGID].nr == 0)
> 	BUG();
> 
> the last check ensures that we are still hashed and this check is more 
> straithforward for understanding, agree?

yep - please send a new patch to Andrew.

> 4. If we do checks this way, then we can found strange proc numeric
> results. Suppose, you have read the do_task_stat() and it iterated
> through the threads and summed the times in this loop with
> next_thread(). Next, the thread dies and you can read the results w/o
> this loop and threads times, only this thread stats. Looks a bit
> invalid. Don't you think so? Maybe we should return an error?

i'd just skip filling out that statistics field - like my minimal patch
does.

	Ingo
