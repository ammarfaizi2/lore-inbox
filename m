Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319410AbSH2WFG>; Thu, 29 Aug 2002 18:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSH2VzT>; Thu, 29 Aug 2002 17:55:19 -0400
Received: from smtpout.mac.com ([204.179.120.86]:14549 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319410AbSH2Vy4>;
	Thu, 29 Aug 2002 17:54:56 -0400
Date: Thu, 29 Aug 2002 23:53:50 +0200
Subject: Re: [PATCH] POSIX message queues
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org
To: golbi@mat.uni.torun.pl
From: pwaechtler@mac.com
Content-Transfer-Encoding: 7bit
Message-Id: <CDB36B91-BB99-11D6-B9F3-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some comments as asked for:

I know that it's nowhere stated, but POSIX mqueues are perfectly 
designed to be
implemented in userspace with locking facilities provided by the system.

With PROCESS_SHARED mutexes and condvars in NGPT we have that - and I am
in the process in converting the mmap() based implementation of
Richard Stevens in UNPv2 onto Linux.

The messages are stored in shmem and the library routines access the 
structures
with proper locking. I am not very happy about the fact, that with 
futexes the whole
cooperating system get stuck when 1 process crashes inside a critical 
region
(yes, then your system is screwed anyway).
BUT the messages are not copied between user- and kernelspace like they 
are
in SysV  msgsnd.

POSIX mqueues have "kernel persistence", i.e. they live until 
mq_unlink() is called.
They do not vanish with the creator on exit().
Without rlimits you can easily consume all available kernel memory (DoS) 
by creating
a mqueue and filling it with garbage.

When implemented in kernel space, you have to create a thread with the 
brand new
sys_clone_startup (or whatever name it gets) as notification 
(SIGEV_THREAD) - which
is SCOPE_SYSTEM, no control about this and not always what is desired.




