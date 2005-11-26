Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVKZJbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKZJbv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 04:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVKZJbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 04:31:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:26315 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750745AbVKZJbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 04:31:51 -0500
Message-ID: <43883D01.8CCB31A6@tv-sign.ru>
Date: Sat, 26 Nov 2005 13:46:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu> <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> I'm not entirely convinced.
> 
> The thing is, We used to have DEAD in the task state flags, ie TASK_ZOMBIE
> was it.
> 
> We started using PF_DEAD in 2003 with this commit message:
> 
> Author: Linus Torvalds <torvalds@home.osdl.org>  2003-10-26 03:16:23
> 
>     Add a sticky "PF_DEAD" task flag to keep track of dead processes.
> 
>     Use this to simplify 'finish_task_switch', but perhaps more
>     importantly we can use this to track down why some processes
>     seem to sometimes not die properly even after having been
>     marked as ZOMBIE. The "task->state" flags are too fluid to
>     allow that well.
> 
> ie the PF_DEAD flag was never really about is _needing_ it: it was all
> about being able to safely check it _without_ having to rely on
> task->state.
> 
> So putting it back into task->state is not wrong per se, but it kind of
> misses the point of why it was somewhere else in the first place (or
> rather, why it was there in the _second_ place, since it was in
> task->state in the first place and got moved out of there).

schedule:

	if (unlikely(prev->flags & PF_DEAD))
		prev->state = EXIT_DEAD;

Which means: "If PF_DEAD is set, ignore ->state value. It should be TASK_RUNNING,
but we have to change it, otherwise the task won't be deactivated. We are using
EXIT_DEAD (which should live only in ->exit_state) because other TASK_XXX values
won't work".

So in my opinion PF_DEAD has already slipped into the ->state partly. And I still
think that at least the first patch is ok, it does not change the things, but may
be considered as microoptimization.

On the other hand this microoptimization is negligible, all cleanups is a matter
of taste always, so let's forget about it if you don't change you mind.

Oleg.
