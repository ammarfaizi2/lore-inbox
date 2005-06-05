Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVFEIzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVFEIzq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFEIzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:55:46 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:13782 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261539AbVFEIzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:55:20 -0400
Date: Sun, 5 Jun 2005 10:54:49 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050605082616.GA26824@elte.hu>
Message-Id: <Pine.OSF.4.05.10506051044340.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2005, Ingo Molnar wrote:

> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > + * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
> > + * Tested and made it functional. I'm still pondering if it is
> > + * worth the trouble.
> 
> you had a long Saturday night debugging session i guess:
> 
> > Date: Sun, 05 Jun 2005 02:17:12 +0200
> 
> but i think the fundamental question remains even on Sunday mornings -
> is the plist overhead worth it? Compared to the simple sorted list we 
> exchange O(nr_RT_tasks_running) for O(nr_RT_levels_used) [which is in 
> the 1-100 range], is that a significant practical improvement? By 
> overhead i dont just mean cycle cost, but also architectural flexibility 
> and maintainability.
>
Sorted lists works deterministicly O(1) on UP if no owner of the lock
blocks while having the lock. On SMP or worse if an owner blocks in the
lock, the wait list can grow very long. Thus insertion of new elements
takes a long time - with preemption disabled :-(

If this is supposed to be used for user-space PI as well I would say it
would have to be completely bounded, i.e. plists are certainly needed.
If it is in the kernel only, you might argue that the code is under
control and thus not make very long wait-lists. Therefore it is
not worth the extra CPU cycles to use them. However, there is no way
to know for sure. In extreme load situations we could end up with a lot of
waiters on mmap_sem forinstance.

Esben

