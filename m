Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSHBSpi>; Fri, 2 Aug 2002 14:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSHBSpi>; Fri, 2 Aug 2002 14:45:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:41972 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316623AbSHBSpE>; Fri, 2 Aug 2002 14:45:04 -0400
Message-ID: <3D4AD3EF.7080409@us.ibm.com>
Date: Fri, 02 Aug 2002 11:48:15 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition?
References: <3D4A8D45.49226E2B@daimi.au.dk> <3D4ABA9D.8060307@us.ibm.com> <200208021748.g72Hm8m02852@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Freitag, 2. August 2002 19:00 schrieb Dave Hansen:
> 
>>Kasper Dupont wrote:
>>
>>>Is there a race condition in this piece of code from do_fork in
>>>linux/kernel/fork.c? I cannot see what prevents two processes
>>>from calling this at the same time and both successfully fork
>>>even though the user had only one process left.
>>>
>>>        if (atomic_read(&p->user->processes) >=
>>>p->rlim[RLIMIT_NPROC].rlim_cur && !capable(CAP_SYS_ADMIN) &&
>>>!capable(CAP_SYS_RESOURCE)) goto bad_fork_free;
>>>
>>>        atomic_inc(&p->user->__count);
>>>        atomic_inc(&p->user->processes);
>>
>>I don't see any locking in the call chain leading to this function, so
>>I think you're right.  The attached patch fixes this.  It costs an
>>extra 2 atomic ops in the failure case, but otherwise just makes the
>>processes++ operation earlier.
>>
>>Patch is against 2.5.27, but applies against 30.
> 
> It has the opposite failure mode. Forks only some of which should
> succeed may all fail.

You beat me to it.  I haven't had a chance to test it yet.

 >>>        if (atomic_read(&p->user->processes) >=
 >>>p->rlim[RLIMIT_NPROC].rlim_cur && !capable(CAP_SYS_ADMIN) &&
 >>>!capable(CAP_SYS_RESOURCE)) goto bad_fork_free;
-- 
Dave Hansen
haveblue@us.ibm.com

