Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWKEQDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWKEQDI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWKEQDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:03:08 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:55198 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932711AbWKEQDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:03:05 -0500
Message-ID: <454E0B1F.7090106@colorfullife.com>
Date: Sun, 05 Nov 2006 17:02:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Falk Hueffner <falk@debian.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ipc/msg.c "cleanup" breaks fakeroot on Alpha
References: <87d583f97t.fsf@debian.org> <20061104172954.GA3668@elte.hu> <Pine.LNX.4.64.0611040938490.25218@g5.osdl.org> <87bqnnjd1w.fsf@debian.org> <Pine.LNX.4.64.0611041019180.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611041019180.25218@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>[ Removed the kernel mailing list ]
>  
>
[kernel mailing list added back]

>As far as I can tell, people hold one or the other, but not both, and 
>happily do strange things to "r_msg". The code seems to _know_ that it is 
>racy, since in addition to the volatile, it does things like:
>
>		...
>                msr->r_msg = NULL;
>                wake_up_process(msr->r_tsk);
>                smp_mb();
>                msr->r_msg = ERR_PTR(res);
>		...
>
>and that memory barrier again doesn't really seem to make a whole lot of 
>sense.
>
>  
>
msr is a msg_receiver structure. The structure is stored on the stack of 
msr->r_tsk.
The smp_mb() guarantees that the wake_up_process is complete before 
ERR_PTR(res) is stored into msr->r_msg.

>But I don't know. It clearly _tries_ to do some smart locking, I just 
>don't see what the rules are. 
>
>  
>
The codes tries to to a lockless receive:
- the mutex is only required to create/destroy queues.
- normal queue operations are protected by msg_lock(msqid), which is a 
spinlock. One spinlock for each queue.
- if a receiving thread doesn't find a message, then it adds a 
msg_receiver structure into msq->q_receivers. This linked list is stored 
in the message queue structure and protected by msg_lock(msqid).
- if a sending thread finds a msg_receiver structure, then it removes 
the structure from the msq->q_receivers linked list, places the message 
into msr->r_msg and wakes up the receiver. All operations happen under 
msg_lock(msqid)
- the receiver notices that there is a message in it's msr->r_msg 
structure and copies it to user space, without acquiring msg_lock(msqid).

ipc/sem.c uses the same idea, I added a longer block with documentation 
(around line 150 in ipc/sem.c)

I'm only aware of one tricky race:
- the sender calls wake_up_process().
- as soon as the receiver finds something in r_msg, it can return to 
user space. user space can call exit(3). do_exit destroys the task 
structure.
- wake_up_process will cause an oops if it's called after do_exit().
This race happened on s390. The solution is this block:

                msr->r_msg = NULL;
                wake_up_process(msr->r_tsk);
                smp_mb();
                msr->r_msg = ERR_PTR(res);

Initially, r_msg is ERR_PTR(-EAGAIN). The sender first sets it to NULL 
("message pending"), then calls wake_up_process(), then a memory 
barrier, then the final value.

Back to the bug report:
"volatile" shouln't be necessary. The critical part is this loop:

                msg = (struct msg_msg*)msr_d.r_msg;
                while (msg == NULL) {
                        cpu_relax();
                        msg = (struct msg_msg *)msr_d.r_msg;
                }
And cpu_relax is a barrier().
On i386, removing the "volatile" has no effect, the .o remains identical.
Falk, could you compare the .o files with/without volatile? Are there 
any differences?

The oops was caused by try_to_wake_up, called by expunge_all.
I.e.:
- either the msq->q_receivers linked list got corrupted
- or the target thread was destroyed before wake_up_process completed.
Theoretically, both things are impossible:
- msq->q_receivers is protected by msq_lock()
- the target thread task_struct is guaranteed to remain in scope due to 
the "msg == NULL" loop.

I'll try to reproduce the oops on i386 - but I don't see a bug right now.

--
    Manfred
