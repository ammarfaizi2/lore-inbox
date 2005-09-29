Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVI2QDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVI2QDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVI2QDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:03:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932210AbVI2QDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:03:06 -0400
Date: Thu, 29 Sep 2005 09:02:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
In-Reply-To: <433C0F3D.30C19186@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0509290901060.3308@g5.osdl.org>
References: <433C0F3D.30C19186@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Oleg Nesterov wrote:
>
> do_signal_stop:
> 
> 	for_each_thread(t) {
> 		if (t->state < TASK_STOPPED)
> 			++sig->group_stop_count;
> 	}
> 
> However, TASK_NONINTERACTIVE > TASK_STOPPED, so this loop will not
> count TASK_INTERRUPTIBLE | TASK_NONINTERACTIVE threads.

Ok, I think your patch is correct (we really do try to keep an order to 
those task flags), but the _real_ issue is that the comparisons are bogus.

Using ">" for task states is wrong. It's a bitmask, and if you want to 
check multiple states, then we should just do so with

	if (t->state & (TASK_xxx | TASK_yyy | ...))

Oh, well. The inequality comparisons are shorter, and historical, so I 
guess it's debatable whether we should remove them all.

		Linus
