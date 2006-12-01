Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030845AbWLAMIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030845AbWLAMIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 07:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030873AbWLAMIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 07:08:55 -0500
Received: from smtpout.mac.com ([17.250.248.181]:26821 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030845AbWLAMIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:08:54 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEDBABAC.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKMEDBABAC.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0BE44B2C-6589-4CFB-AE3A-F62317C355B8@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Fri, 1 Dec 2006 07:08:49 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 01, 2006, at 06:24:54, David Schwartz wrote:
>> Imagine we change the code to read from some auto-increment hardware
>> at a specific MMIO address instead of a global:
>>> static int my_func(int a)
>>> {
>>> 	return a + *(volatile int *)(0xABCD1234);
>>> }
>
>> But you're telling me that the change in the header file (where the
>> new function returns the exact same series of values with every call
>> as the old) causes the program to enter an infinite loop?
>>
>> How do you rationalize this again?
>
> No, I'm not saying that. I'm saying it *can*.

No, it can't.  If you leave the prototype alone and the function when  
called in sequence returns the same list of values, then by  
definition the internals can have no effect on the code which uses  
that function.  As further proof, if you wrapped my "my_func()" with  
this in some C file:
int my_other_func(int a)
{
	return my_func(a);
}

Next you stick a my_other_func declaration in a header and use  
my_other_func instead of my_func() in the main function.  Now the  
result is that the compiler has no damn clue what my_other_func()  
contains so it can't optimize it out of the loop with either  
version.  You cannot treat "volatile" the way you are saying it is  
treated without severely violating both the C99 spec *and* common sense.

> In some cases, it's very unlikely that compilers will ever become  
> smart enough to demonstrate that our code is broken, but that  
> doesn't make the code any less broken, just less likely to fail.

No, the code is not broken because the language simply isn't defined  
that way.  Essentially when the compiler is looking at any volatile  
data it cannot ignore or optimize-away any operations on that data.   
On the other hand, when you cast volatile data into non-volatile  
data, the compiler must preserve linearity of program execution.  If  
you call a function in a loop which dereferences a pointer to a  
volatile then the compiler *MUST* always dereference the pointer,  
even if it later discards the result and continues on its merry way.

>> Actually, no.  The reason for the volatile in the pointer  
>> dereference is to force the memory access to *always* happen.
>
> That's why it was placed there, however it was thrown away right  
> after it was placed, in the same step it was supposed to force a  
> memory access.

Doesn't matter if you throw away the result.  The C standard defines  
this:
   (void)( *(volatile int *)0xABCD1234 );
to imply that the code reads an integer from that memory location and  
then discards the result.  The whole point of volatile is you still  
MUST do the read.  Feel free to read the bugzilla entry mentioned in  
this thread as it even quotes all the pertinent sections of the C  
standard for you.

> The problem is that '*(volatile unsigned int *)' results in a  
> 'volatile unsigned int'. The *assignment* occurs in the return  
> operation, after the 'volatile unsigned int' is *cast* to a plain  
> 'unsigned int'. The assignment is *not* in any sense volatile or  
> inviolate, so neither is the return value.

No, the assignment is irrelevant but the pointer dereference in  
rvalue context *is* relevant.  The dereference forces a read operation.

> One solution would be this:
>
> static inline unsigned int readl(const volatile void __iomem *addr)
> {
>  volatile unsigned int j;
>  j=*(volatile unsigned int __force *) addr;
>  return j;
> }

This is no different from the current code.  You cast the pointer to  
a volatile unsigned int, you dereference that pointer, and you cast  
the result to an unsigned int.  C does not have the same "assignment"  
distinctions that C++ has.

> (This may or may not fix the issue though. There is at least one  
> known compiler issue that might be causing the breakage. However,  
> correct compiler optimizations should be ruled out first.)

Nope, any GCC behavior requiring code such as the above is broken,  
not just in my opinion but in the opinion of the GCC developers  
themselves, as you'd notice if you took the time to read down to the  
end of the bugzilla discussion.

Cheers,
Kyle Moffett

