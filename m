Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSIGPEr>; Sat, 7 Sep 2002 11:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSIGPEr>; Sat, 7 Sep 2002 11:04:47 -0400
Received: from smtpout.mac.com ([204.179.120.86]:24547 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S315779AbSIGPEq>;
	Sat, 7 Sep 2002 11:04:46 -0400
Date: Sat, 7 Sep 2002 16:11:31 +0200
Subject: Re: [PATCH] POSIX message queues
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Ingo Molnar <mingo@elte.hu>, golbi@mat.uni.torun.pl,
       linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>
To: Amos Waterland <apw@us.ibm.com>
From: pwaechtler@mac.com
In-Reply-To: <20020906174832.A25611@kvasir.austin.ibm.com>
Message-Id: <B547AE30-C26B-11D6-87AD-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag den, 7. September 2002, um 00:48, schrieb Amos Waterland:

> On Wed, Sep 04, 2002 at 01:13:28PM +0200, Ingo Molnar wrote:
>>
>> On Sun, 1 Sep 2002, Amos Waterland wrote:
>>
>>> That is the fundamental problem with a userspace shared memory
>>> implementation: write permissions on a message queue should grant
>>> mq_send(), but write permissions on shared memory grant a lot more 
>>> than
>>> just that.
>>
>> is it really a problem? As long as the read and write queues are 
>> separated
>> per sender, all that can happen is that a sender is allowed to read his
>> own messages - that is not an exciting capability.
>
> Ingo:
>
> I can see no way to keep the queues separated per sender if userspace
> shared memory is used.  The data structures used to keep track of the
> messages must be writable by both the senders and receivers, because of
> the kernel persistent nature of message queues: messages must stay in
> the queue during the interval of arbitrary length between the sender
> calling mq_send() and the receiver calling mq_receive().

It would be really hard to fetch the oldest and highest priority message
out of several "per sender" queues. This effort is not worthwhile.
OTOH I can't see a _big_ problem when a process with sufficient 
permissions
can trash the message queues - otherwise I wonder why file permissions
are granted "per user" and not "per process".
The apps processes are designed to cooperate and trust each other for 
this.
The "application" would not work correctly if a message is not sent 
anyway.

>
> Ulrich/Jakub:
>
> Is the above related to glibc's position that mq's will not go in until
> there is kernel support?  Thanks.

I know this is no real argument, but: on IRIX 6.5 the POSIX mqueues are
implemented with shared mem and flocks in libc.
I have an almost working userspace implementation.

But I have another argument: speed and robustness.
I did some measurements with 32byte small messages and with 4KiB
messages, with the kernel implementation and with a userspace one:

userspace mqueue (NGPT PROCESS_SHARED MUTEX/COND)
==================================================
peewee:~/src/mqtest:>time ./uq_receive -c 99999 -q mmm >/dev/null
real    0m21.325s
user    0m9.140s
sys     0m8.340s
peewee:~/src/mqtest:>time ./uq_send -b 4092 -c 99999  mmm
real    0m21.039s
user    0m11.260s
sys     0m8.760s

kernel mqueue
==============
peewee:~/src/mqtest:>time ./mq_receive -c 99999 -q mmm >/dev/null
real    0m11.172s
user    0m0.260s
sys     0m7.130s
peewee:~/src/mqtest:>time ./mq_send -b 4092 -c 99999  mmm
real    0m10.880s
user    0m1.160s
sys     0m7.540s


The kernel one is about 2 times faster, regardless of message size!
I don't know yet where the user time is spent, I think it could be the
"slow" implementation of mutexes/condvars in NGPT.
I will retry the tests with futex-2.0 locks..

Then there are problems with the locks needed to protect the mq headers.
What happens when a signal arrives that causes the process to exit?
When I protect the calls with sigprocmask() there is even a higher
overhead in numbers of syscalls - if I don't protect, I get dangling 
locks...

I therefore vote for using mqueue in kernel and share most of the code
between SysV and POSIX mqueues.

