Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSHaLme>; Sat, 31 Aug 2002 07:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSHaLme>; Sat, 31 Aug 2002 07:42:34 -0400
Received: from smtpout.mac.com ([204.179.120.88]:22514 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S317434AbSHaLmd>;
	Sat, 31 Aug 2002 07:42:33 -0400
Date: Sat, 31 Aug 2002 13:43:56 +0200
Subject: Re: [PATCH] POSIX message queues
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org
To: Amos Waterland <apw@us.ibm.com>
From: pwaechtler@mac.com
In-Reply-To: <20020830094803.A8283@kvasir.austin.ibm.com>
Message-Id: <EE7BCBB6-BCD6-11D6-87AD-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag den, 30. August 2002, um 11:48, schrieb Amos Waterland:

> On Thu, Aug 29, 2002 at 11:53:50PM +0200, pwaechtler@mac.com wrote:
>> some comments as asked for:
>>
>> I know that it's nowhere stated, but POSIX mqueues are perfectly
>> designed to be implemented in userspace with locking facilities
>> provided by the system.
>
> I am not sure if this is correct.  You can achieve proper locking in
> userspace, but I do not think you achieve proper security.

Well, I can't think of efficient inter process locks without 
kernel/scheduler help.
Do you want to use a spinlock, with lowering priority or even sleep, use
a pipe/fifo/flock or waiting in sigsuspend? This all is implemented in
kernel space.
How would you implement entirely userspace locking?
With futexes (fast "userspace" locks) only the uncontented case is 
handled
in userspace - if there's contention the process waits inside the 
kernel - or
does get a notification from the kernel (AWAIT or FD)

> I assume you are proposing an implementation based on shared memory:
> which means that at least some pages of the shared memory must be
> writable.  If the processes cooperate and only write to the shared pages
> through library routines which use sychronization, things are ok, but a
> malicious process could forge messages or perform DOS attacks etc. by
> bypassing the mq_*() functions and using write().

yes, of course that could be compromised by a process with the same uid.
This process could simply kill the other process too.
The shm_open() employs proper file system permission on the object.

> The mq_maxmsg and mq_msgsize members of the mq_attr structure required
> if O_CREAT is passed to mq_open() ensure that an implementation can
> prevent the kernel memory DoS you mention: a malicious application can
> only fill up the MQ memory.

And how many mqueues am I allowed to create?
You would need an extra resource limit for that.

