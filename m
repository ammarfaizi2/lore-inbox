Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUFLJPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUFLJPu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 05:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUFLJPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 05:15:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:39905 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264689AbUFLJPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 05:15:48 -0400
Message-ID: <40CAC9BE.6050400@gmx.de>
Date: Sat, 12 Jun 2004 11:15:42 +0200
From: =?ISO-8859-1?Q?Dominik_Stra=DFer?= <einmal_rupert@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en-us, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid()
 bug in 2.6?]
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com> <40C33A84.4060405@elegant-software.com> <Pine.LNX.4.58.0406061013250.7010@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406061013250.7010@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:7996899f8b3439e83b57f413cfdb276d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 6 Jun 2004, Russell Leighton wrote:
>  
>
>>Linus said he could not imagine a program using getpid() more than a 
>>handful of times...
>>    
>>
>
>No, I said that I could not imagine using it more than a handful of times 
>_except_ for the cases of:
>
> - thread identification without a native thread area
> - benchmarking.
>
>(and in both of these cases it is _wrong_ to cache the pid value)
>
>  
>
>>well, (I am ashamed to admit it) I found this getpid() bug with just 
>>such a program.
>>
>>Could someone can suggest an alternative to using getpid() for me? 
>>Here's the problem...
>>
>>I have a library that creates 2 threads using clone().
>>    
>>
>
>Your problem falls under the thread ID thing. It's fine and understandable 
>to use getpid() for that, although you could probably do it faster if you 
>are willing to use the support that modern kernels give you and that glibc 
>uses: the "TLS" aka Thread Local Storage support.
>
>Thread-local storage involved having a user-mode register that points some 
>way to a special part of the address space. On x86, where the general 
>register set is very limited and stealing a general reg would thus be bad, 
>it uses a segment and loads the TLS pointer into a segment register 
>(segment registers are registers too - and since nobody sane uses them for 
>anything else these days, both %gs and %fs are freely usable).
>
>  
>
>> Would gettid() be any better?
>>    
>>
>
>You'd avoid this particular glibc bug with gettid.
>  
>
I am facing the following problem:
I want to sum up the time spent in the main thread + all threads that 
ever existed.
getrusage dosn't work (and didn't do so in pre-NPTL-times) as the time 
spent in threads is not taken into account.
To work around this problem I created a map pid->time used which used 
getpid in the pre-NPTL-time and looked up the time in /proc/<pid>. As 
this doesn't work with NPTL, changed it to use the gettid syscall as I 
didn't find a saner way.

Regards

Dominik
