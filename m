Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUFFPep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUFFPep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 11:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUFFPep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 11:34:45 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:63731 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263743AbUFFPej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 11:34:39 -0400
Message-ID: <40C33A84.4060405@elegant-software.com>
Date: Sun, 06 Jun 2004 11:38:44 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Using getpid() often, another way? [was Re: clone() <-> getpid()
 bug in 2.6?]
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com>
In-Reply-To: <40C32A44.6050101@elegant-software.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus said he could not imagine a program using getpid() more than a 
handful of times...
well, (I am ashamed to admit it) I found this getpid() bug with just 
such a program.

Could someone can suggest an alternative to using getpid() for me? 
Here's the problem...

I have a library that creates 2 threads using clone().
[NOTE: I can't use pthreads for a variety of reasons, mostly due
to the wacky signal handling rules...it turns out that using clone() is 
cleaner for me anyway.]

Some of the code can ONLY be executed in one of the threads
called the 'handler' thread. The reason for that restriction is that 
there are
performance, locking and synchronization issues that demand this
constraint.

Entry points to this code are exported for programmers to use.
I currently have a check in these functions similar to:

   if ( !INHANDLERCONTEXT(mon) ) barf();

where:

#define INHANDLERCONTEXT(mon) ( (mon)->handler_q.thread->pid == getpid() )

So the questions are:

  Given a code library with some exported functions which CAN be 
executed outside a particular thread and others that MUST be executed in 
a particular thread, how can I efficiently prevent or trap using of 
these functions outside the proper execution context?

 Would gettid() be any better?

Thx

Russ

Russell Leighton wrote:

>
> I have read the discussion on this issue and I wanted to get 
> confirmation of my understanding...
>
> Issue:
>    It seems glibc is caching getpid() which is wrong and breaks 
> programs like mine.
>
>    You are using an older version of  glibc than I and that is why you 
> could run the test program.
>
> Given the above, that means that:
>    Upgrading my kernel on the FedoraCore2 system won't help because 
> the bug is in glibc
>
>    Assuming that this is a "new" feature of glibc, any others 
> upgrading would then starting seeing this bug
>
> Linus Torvalds wrote:
>
>> On Sat, 5 Jun 2004, Russell Leighton wrote:
>>  
>>
>>> I have a test program (see attached) that shows what looks like a 
>>> bug in 2.6.5-1.358 (FedoraCore2)...and breaks my program :(
>>>
>>> In summary, I am doing:
>>>
>>> clone(run_thread, stack + sizeof(stack) -1,
>>>            CLONE_FS|CLONE_FILES|CLONE_VM|SIGCHLD, NULL))
>>>
>>> According to the man page the child process should have its own pid 
>>> as returned by getpid()...much like fork().
>>>
>>> In 2.6 the child receives the parent's pid from getpid(), while 2.4 
>>> works as documented:
>>>
>>> In 2.4 the test program does:
>>> parent pid: 26647
>>> clone returned pid: 26648
>>> thread reported pid: 26648
>>>
>>> In 2.6 the test program does:
>>> parent pid: 16665
>>> thread reported pid: 16665
>>> clone returned pid: 16666
>>>   
>>
>>
>> Hmm.. The above is the correct behaviour if you use CLONE_THREAD 
>> ("getpid()" will then return the _thread_ ID), but it shouldn't 
>> happen without that. And clearly you don't have it set.
>>
>> And indeed, it doesn't happen for me on my system:
>>
>>     parent pid: 13552
>>     thread reported pid: 13553
>>     clone returned pid: 13553
>>
>> so I wonder if either the Fedora libc always adds that CLONE_THREAD 
>> thing
>> to the clone() calls, or whether the FC2 kernel is buggy.
>>
>> Arjan?
>>
>>         Linus
>>
>>
>>  
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

