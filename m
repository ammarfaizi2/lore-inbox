Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUFGARA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUFGARA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 20:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUFGAQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 20:16:59 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:4745 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264269AbUFGAQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 20:16:44 -0400
Message-ID: <40C3B4E6.8020809@elegant-software.com>
Date: Sun, 06 Jun 2004 20:20:54 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <->	getpid()
 bug in 2.6?]
References: <40C1E6A9.3010307@elegant-software.com>	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>	 <40C32A44.6050101@elegant-software.com>	 <40C33A84.4060405@elegant-software.com> <1086536650.2804.20.camel@localhost>
In-Reply-To: <1086536650.2804.20.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ah, the stack. Yes, I think that will work. You see, the functions that 
need this test
always take a pointer to a struct that holds all the thread info called 
'mon'. That info is the pid of the
thread , the ptr to the stack mmap'd and the size of the stack, I think 
I can change the test to:

{
   int32_t
     stackvar;

    /* if address of the stackvar is OUTSIDE the stack of handler 
thread, then
         you are not running this function from the handler thread */
   if ( &stackvar < mon->handler_q.thread->stack ||
         &stackvar > mon->handler_q.thread->stack + 
mon->handler_q.thread->stacksize - 1) {

        fprintf(stderr, "bad, bad, bad!\n");
        exit(-1);

    }

}

Would that work? If so, that is nice because no syscall.

Robert Love wrote:

>On Sun, 2004-06-06 at 11:38 -0400, Russell Leighton wrote:
>
>  
>
>>  Given a code library with some exported functions which CAN be 
>>executed outside a particular thread and others that MUST be executed in 
>>a particular thread, how can I efficiently prevent or trap using of 
>>these functions outside the proper execution context?
>>    
>>
>
>Are you sure you cannot use pthreads?  The new implementation (NPTL) has
>a lot of improvements, including saner signal handling behavior.
>
>If not, you probably are out of luck.  Best I can think of is somehow
>using thread-specific storage, but you would obviously need to index
>into it using something OTHER than the PID.  Which basically leaves you
>with the stack.  So, unless you could cache the PID in a local
>variable..
>
>  
>
>> Would gettid() be any better?
>>    
>>
>
>If you aren't using CLONE_THREAD, gettid() will just return the PID.
>And if you were using CLONE_THREAD, then getpid() would be worthless for
>you and you would have to use gettid().  Either way, though, they
>basically do the same thing (return current->tid vs. current->pid).
>
>	Robert Love
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

