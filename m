Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVAAQsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVAAQsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 11:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVAAQsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 11:48:21 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:61092 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261160AbVAAQsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 11:48:12 -0500
Message-ID: <41D6D449.3080907@free.fr>
Date: Sat, 01 Jan 2005 17:48:09 +0100
From: Guilhem Lavaux <guilhem.lavaux@free.fr>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PThreads, signals, futex and SMP
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am one of the developer of kaffe, a GPL implementation of the Java 
Virtual Machine, and we encountered some problems on Linux/2.6/SMP. I am 
currently running 2.6.8.1 Mandrake Kernel. I can try whether the problem 
is reproduceable on a vanilla kernel but I don't think this part has 
been touched.

Here is the problem: we have a regression test which is quite intense in 
thread creation/destruction, each thread can start the garbage 
collector. The garbage collector needs to stop all running thread to be 
able to walk the heap/stack. For this, it uses a particular signal which 
is sent to all threads. The signal handler calls sigwait to stop the 
thread. 50% of the time everything is fine but from time to time, kaffe 
has a deadlock. It appears that it always happen when we are in the 
following configuration:

Thread 1
------------

sigwait
<signal handler>
futex syscall
pthread_mutex_unlock

Thread 2
------------
futex syscall
pthread_mutex_lock
Garbage Collector thread

Now if we look at the futex code in the linux kernel, we see this:

static int futex_wait(unsigned long uaddr, int val, unsigned long time)
{
       DECLARE_WAITQUEUE(wait, current);
       int ret, curval;
       struct futex_q q;

       down_read(&current->mm->mmap_sem);

the kernel then prepares the wait queue and unlock mmap_sem. 


Concerning the mutex_unlock  part we have this:

static int futex_wake(unsigned long uaddr, int nr_wake)
{
       union futex_key key;
       struct futex_hash_bucket *bh;
       struct list_head *head;
       struct futex_q *this, *next;
       int ret;

       down_read(&current->mm->mmap_sem);

and the kernel iterates the semaphores and wakes up all threads.


What may happen if the signal handler is called after down_read in 
futex_wake ? My guess is that we are not able to call futex_wait because 
the application will deadlock because the first thread is frozen by a 
sigwait.

So either we have a limitation of the kernel either a bug if the 
analysis is correct.
The only point is that I am not sure whether a signal is allowed to 
interrupt a syscall just in the middle of futex_wake. If this is not 
possible there may be a bug in our application somewhere else.

Regards,

Guilhem Lavaux.
