Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267794AbTBPW2r>; Sun, 16 Feb 2003 17:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267795AbTBPW2r>; Sun, 16 Feb 2003 17:28:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267794AbTBPW2q>; Sun, 16 Feb 2003 17:28:46 -0500
Date: Sun, 16 Feb 2003 14:34:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <3E5000E8.1030406@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0302161432130.3917-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Manfred Spraul wrote:
> Martin J. Bligh wrote:
> 
> >diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c sdet3/fs/proc/array.c
> >--- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
> >+++ sdet3/fs/proc/array.c	Sun Feb 16 11:44:24 2003
> >@@ -252,8 +252,11 @@ int proc_pid_status(struct task_struct *
> > 		buffer = task_mem(mm, buffer);
> > 		mmput(mm);
> > 	}
> >-	buffer = task_sig(task, buffer);
> >+	task_lock(task);
> >+	if (task->sighand)
> >+		buffer = task_sig(task, buffer);
> > 	buffer = task_cap(task, buffer);
> >+	task_unlock(task);
> > #if defined(CONFIG_ARCH_S390)
> > 	buffer = task_show_regs(task, buffer);
> > #endif
> >  
> >
> I think it's needed for 2.4, too.

It's not wrong, but it shouldn't help. Simply because "task_lock()"  
isn't even relevant to "task->sighand" as it stands now. It will be 
cleared without holding the task lock, as far as I can see.

So I suspect it fixes things for Martin only because it changes timings 
enough not to hit the race.

		Linus

