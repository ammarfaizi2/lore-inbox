Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVI2WPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVI2WPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVI2WPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:15:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751342AbVI2WPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:15:53 -0400
Date: Thu, 29 Sep 2005 15:15:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
In-Reply-To: <20050929215442.74EE0180E20@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.64.0509291504200.5362@g5.osdl.org>
References: <20050929215442.74EE0180E20@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Roland McGrath wrote:
>
> I am dubious about this change.  I don't see a corresponding change to
> fs/proc/array.c where it knows what all the bit values are.

You're right. Not only that, but "TASK_NONINTERACTIVE" is special in that 
it's an _additional_ flag to the task state, not an independent flag at 
all.

Ie it's _really_ only valid as a bitmask.

So I think we're better off reverting that ordering change, and testing 
the bitmap properly.

> Any tests using < TASK_STOPPED or the like are left over from the time when
> the TASK_ZOMBIE and TASK_DEAD bits were in the same word, and it served to
> check for "stopped or dead".

Correct again.

Btw, that brings up another thing: those EXIT_ZOMBIE/EXIT_DEAD flags are 
really really confusing. 

It's two different words, but the way we use them in get_task_state(), 
they are or'ed together, which is why they need to have non-overlapping 
bit definitions. But there's no comment about that anywhere.

I'll add a comment to <linux/sched.h> about it.

Thanks,

		Linus
