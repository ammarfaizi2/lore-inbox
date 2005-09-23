Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVIWTGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVIWTGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVIWTGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:06:16 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:23936 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751157AbVIWTGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:06:15 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 Sep 2005 12:09:00 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Vadim Lobanov <vlobanov@speakeasy.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] epoll
In-Reply-To: <Pine.LNX.4.58.0509231123440.9215@shell4.speakeasy.net>
Message-ID: <Pine.LNX.4.63.0509231202160.10222@localhost.localdomain>
References: <Pine.LNX.4.58.0509221950010.15726@shell2.speakeasy.net>
 <Pine.LNX.4.63.0509222233020.7372@localhost.localdomain>
 <Pine.LNX.4.58.0509222254390.5524@shell2.speakeasy.net>
 <Pine.LNX.4.63.0509231027300.10222@localhost.localdomain>
 <Pine.LNX.4.58.0509231123440.9215@shell4.speakeasy.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005, Vadim Lobanov wrote:

> On Fri, 23 Sep 2005, Davide Libenzi wrote:
>
>>>>> 3. Wakeup
>>>>> As determined by testing with userland code, the sys_tgkill() and
>>>>> sys_tkill() functions currently will NOT wake up a sleeping
>>>>> epoll_wait(). Effectively, this means that epoll_wait() is NOT a pthread
>>>>> cancellation point. There are two potential issues with this:
>>>>> - epoll_wait() meets the unofficial(?) definition of a "system call that
>>>>> may block".
>>>>> - epoll_wait() behaves differently from poll() and friends.
>>>>
>>>> The epoll_wait() wait loop is the standard one that even poll() uses (prep
>>>> wait, make interruptible, test signals, sched timeo). So if poll() is woke
>>>> up, so should epoll_wait(). A minimal code snippet that proves poll()
>>>> behing woke up, and epoll_wait() not, would help.
>>>>
>>>
>>> Certainly. :-) See end of email for sample program.
>>
>> I'm afraid you need to bug the glibc guys, since I think they wrap
>> sys_poll(). Try the test program below, when defining _X_, that makes it
>> call sys_poll() directly. It will have the same epoll_wait() behaviour.
>
> I'm still a bit confused by how the pthread implementation fits
> together. Correct me if the following is wrong, please:
> Whenever the user wants to cancel a pthread, glibc eventually calls
> {sys-}tgkill() upon the given thread, causing the kernel to return EINTR
> to the blocking system call, in this case epoll_wait(). It is glibc's
> job to catch this return value and realize that the thread is ready to be
> killed, which it is not doing in the case of epoll_wait().
> Or is the "current thread has been cancelled and should be killed" check
> happening elsewhere / in some other way?

Please do not make me look at glibc/pthread code since I do not have time 
ATM. I can only speculate on what it is happening. The sys_poll() and 
sys_epoll_wait() system calls, when called directly, have the same 
behaviour (like you can see in the test code snippet). They both return 
EINTR to the caller. When you call glibc's poll(), the behaviour changes 
and function is explicitly made a pthread cancellation point. The glibc's 
epoll_wait() is not wrapped by the same code, and this makes it unable to 
be pthread-canceled. Try to post to glibc the code snippet, and see if 
they want to make epoll_wait() pthread-cancel enabled too.



> By the way, I already brought this up on the glibc mailing list (before
> I sent it to LKML), and it seems they couldn't care less.
> (http://sources.redhat.com/ml/libc-alpha/2005-09/msg00071.html)

Yeah, that's Uli :)



- Davide


