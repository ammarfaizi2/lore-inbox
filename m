Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSHCAdd>; Fri, 2 Aug 2002 20:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSHCAdd>; Fri, 2 Aug 2002 20:33:33 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:24594 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317380AbSHCAdc>;
	Fri, 2 Aug 2002 20:33:32 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition? 
In-reply-to: Your message of "Fri, 02 Aug 2002 10:00:13 MST."
             <3D4ABA9D.8060307@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 10:36:50 +1000
Message-ID: <9083.1028335010@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Aug 2002 10:00:13 -0700, 
Dave Hansen <haveblue@us.ibm.com> wrote:
>Kasper Dupont wrote:
>> Is there a race condition in this piece of code from do_fork in
>> linux/kernel/fork.c? I cannot see what prevents two processes
>> from calling this at the same time and both successfully fork
>> even though the user had only one process left.
>> 
>>         if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur
>>                       && !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
>>                 goto bad_fork_free;
>> 
>>         atomic_inc(&p->user->__count);
>>         atomic_inc(&p->user->processes);
>
>I don't see any locking in the call chain leading to this function, so 
>I think you're right.  The attached patch fixes this.  It costs an 
>extra 2 atomic ops in the failure case, but otherwise just makes the 
>processes++ operation earlier.

Does this race really justify extra locks?  AFAICT the worst case is
that a user can go slightly over their RLIMIT_NPROC, and that will only
occur if they fork on multiple cpus "at the same time".  Given the
timing constraints on that small window, I would be surprised if this
race could be exploited to gain more than a couple of extra processes.
This looks like a case where close enough is good enough.

