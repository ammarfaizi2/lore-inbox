Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267807AbTBPW7M>; Sun, 16 Feb 2003 17:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267813AbTBPW7M>; Sun, 16 Feb 2003 17:59:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64676 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267807AbTBPW7K>; Sun, 16 Feb 2003 17:59:10 -0500
Date: Sun, 16 Feb 2003 15:08:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <63040000.1045436929@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302161432130.3917-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302161432130.3917-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c sdet3/fs/proc/array.c
>> > --- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
>> > +++ sdet3/fs/proc/array.c	Sun Feb 16 11:44:24 2003
>> > @@ -252,8 +252,11 @@ int proc_pid_status(struct task_struct *
>> > 		buffer = task_mem(mm, buffer);
>> > 		mmput(mm);
>> > 	}
>> > -	buffer = task_sig(task, buffer);
>> > +	task_lock(task);
>> > +	if (task->sighand)
>> > +		buffer = task_sig(task, buffer);
>> > 	buffer = task_cap(task, buffer);
>> > +	task_unlock(task);
>> > # if defined(CONFIG_ARCH_S390)
>> > 	buffer = task_show_regs(task, buffer);
>> > # endif
>> >  
>> > 
>> I think it's needed for 2.4, too.
> 
> It's not wrong, but it shouldn't help. Simply because "task_lock()"  
> isn't even relevant to "task->sighand" as it stands now. It will be 
> cleared without holding the task lock, as far as I can see.
> 
> So I suspect it fixes things for Martin only because it changes timings 
> enough not to hit the race.

Ah, fair enough ... it's probably the if, rather than the task_lock.

So what does protect sighand? tasklist_lock? It doesn't seem to
as people do things like:

spin_unlock_irq(&current->sighand->siglock);

all the time ... so is it just protected by good faith and the direction
of the wind?

M.

