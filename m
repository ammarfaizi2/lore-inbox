Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWCTSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWCTSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWCTSd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:33:56 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:58559 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751193AbWCTSdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:33:55 -0500
Message-ID: <441EF4D7.AEC1AE8C@tv-sign.ru>
Date: Mon, 20 Mar 2006 21:30:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify/fix first_tid()
References: <441DB045.87C4134C@tv-sign.ru> <m1fyldvvvo.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > first_tid:
> >
> >       /* If nr exceeds the number of threads there is nothing todo */
> >       if (nr) {
> >               if (nr >= get_nr_threads(leader))
> >                       goto done;
> >       }
> >
> > This is not reliable: sub-threads can exit after this check, so the
> > 'for' loop below can overlap and proc_task_readdir() can return an
> > already filldir'ed dirents.
> >
> >       for (; pos && pid_alive(pos); pos = next_thread(pos)) {
> >               if (--nr > 0)
> >                       continue;
> >
> > Off-by-one error, will return 'leader' when nr == 1.
> >
> > This patch tries to fix these problems and simplify the code.
> 
> This is better however if I read this code correctly.  It modifies
> the code so the last time user space goes trough this loop
> with nr > nr_threads.  Then we will walk the entire threads
> list to achieve nothing.

This can happen only if the thread we stopped at has exited, and
some other threads have exited too, so that nr >= ->signal->count.

I think it's not worth optimizing this rare and anyway slow path.
However, you are the code author, I'll send a trivial patch which
restores this optimization if you don't change you mind.

> So we really still need the nr_threads test in there so we don't
> traverse the list twice everytime through readdir.

How so? We don't do it twice?

Oleg.
