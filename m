Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTBPTgl>; Sun, 16 Feb 2003 14:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267355AbTBPTgl>; Sun, 16 Feb 2003 14:36:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55821 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267354AbTBPTgk>; Sun, 16 Feb 2003 14:36:40 -0500
Date: Sun, 16 Feb 2003 11:42:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <3E4FE86D.1010708@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0302161139530.2952-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Manfred Spraul wrote:
>
> ABBA is not a deadlock, because linux read_locks permit recursive calls.
> 
>     read_lock(tasklist_lock);
>     task_lock(tsk);
>     read_lock(tasklist_lock);
> 
> Does not deadlock, nor any other ordering.
> 
> The tasklist_lock is never taken for write from bh or irq context.

Doesn't matter.

	CPU1 - do_exit()			CPU2 - non-nested task_lock()

						task_lock(tsk)
	write_lock_irq(&tasklist_lock);		IRQ HAPPENS
	task_lock(tsk);				read_lock(&tasklist_lock)

BOOM, you're dead.

See? ABBA _does_ happen with the task lock, it's just that the magic 
required to do so is fairly unlikely thanks to the added requirement for 
the irq to happen at just the right moment (ie there are no static 
code-paths that can cause it).

		Linus

