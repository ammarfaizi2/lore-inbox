Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUJSMbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUJSMbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUJSMbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:31:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268316AbUJSMbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:31:07 -0400
Date: Tue, 19 Oct 2004 08:30:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] in i386 semaphores.
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3017FBF3E@scl-exch2k.phoenix.com>
Message-ID: <Pine.LNX.4.61.0410190813100.3541@chaos.analogic.com>
References: <5F106036E3D97448B673ED7AA8B2B6B3017FBF3E@scl-exch2k.phoenix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Aleksey Gorelov wrote:

>
>
>> -----Original Message-----
>> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
>> Sent: Monday, October 18, 2004 12:49 PM
>> __up is declared 'asmlinkage', which means that conventional
>> 'C' calling convention is used, that eax and/or edx/eax pair
>> is used for return values and the input values are pushed on
>>  the stack. The last parameter passed is a pointer in %ecx.
>
> Can not disagree here, except that %ecx is the only parameter.
> eax/edx are just saved in the stack, and then restored (see comments
> before the assembly in semaphore.c).
>>
>> Therefore, the called 'C' function, that 'knows' only about
>> the first parameter passed, will get the correct pointer value.
>> The 'C' function also never changes the value of that pointer,
>> only something that it points to.
>
> This is an assumption. AFAIK, according to C standard, formal parameters
> are
> COPIED from actual parameters. Formal parameters can not be used outside
> the function, and as far as they are not constant ones, C compiler
> is free to mofidy them after their last use, and use the memory for
> other purposes.
>>

So you are saying that the stack area that was used by the passed-
parameter (that was never modified) can be destroyed at the whim of
the compiler?

void funct(int param)
{
    printf("%d\n", param);
    compiler_destroy(param);  // Not coded, just done?
}


Some C-compiler expert has to answer that question. If the
answer is true, then you need this patch:


--- linux-2.6.8/arch/i386/kernel/semaphore.c.orig	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.8/arch/i386/kernel/semaphore.c	2004-10-19 08:06:15.000000000 -0400
@@ -198,9 +198,11 @@
  #endif
  	"pushl %eax\n\t"
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"	// Register to save
+	"pushl %ecx\n\t"	// Passed parameter
  	"call __down\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\t\n"	// Bypass corrupted parameter
+	"popl %ecx\n\t"		// Restore original
  	"popl %edx\n\t"
  	"popl %eax\n\t"
  #if defined(CONFIG_FRAME_POINTER)
@@ -220,9 +222,11 @@
  	"movl  %esp,%ebp\n\t"
  #endif
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"	// Save register
+	"pushl %ecx\n\t"	// Passed parameter
  	"call __down_interruptible\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\n\t"	// Bypass corrupted parameter
+	"popl %ecx\n\t"		// Restore register
  	"popl %edx\n\t"
  #if defined(CONFIG_FRAME_POINTER)
  	"movl %ebp,%esp\n\t"
@@ -241,9 +245,11 @@
  	"movl  %esp,%ebp\n\t"
  #endif
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"		// Save register
+	"pushl %ecx\n\t"		// Passed parameter
  	"call __down_trylock\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\n\t"		// Bypass corrupted parameter
+	"popl %ecx\n\t"			// Restore register
  	"popl %edx\n\t"
  #if defined(CONFIG_FRAME_POINTER)
  	"movl %ebp,%esp\n\t"
@@ -259,9 +265,11 @@
  "__up_wakeup:\n\t"
  	"pushl %eax\n\t"
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"	// Save register
+	"pushl %ecx\n\t"	// Passed parameter
  	"call __up\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\n\t"	// Bypass corrupted parameter
+	"popl %ecx\n\t"		// Restore register
  	"popl %edx\n\t"
  	"popl %eax\n\t"
  	"ret"



...and if you need this patch, then there is no reason for
the 'helper' functions at all and the code should be rewritten
to get rid of them.

>> Now, wake_up() gets a pointer to the variable sem->wait. wake_up()
>> never modifies 'sem', only sem->wait.
>
> Well, build the kernel with DEBUG_KERNEL disabled with gcc 3.2 for
> instance,
> objdump it and check __up() code. You'll be surprised. And this is NOT
> gcc issue.

I'm not sure about that. I don't think the 'C' compiler is allowed
to whack at things that were never touched by the code. For instance,
we have "main(int argc, char *argv[], char *env[]);" Normally main()
is only declared to have two arguments, but the environment strings
are really there also. Can the 'C' compiler destroy them? I think
not.

>>>  As one can see, actual parameter in %ecx is not only being copied in
>>> formal parameter sem (which is correct), but also being
>> restored from it
>>> after function call via %ecx (which is incorrect). Since formal
>>> parameter is not a constant one, it may be overwritten inside C
>>> function, or gcc may (and in fact does that in some cases) use it for
>>> something else.
>>> If we want to keep %ecx, correct behavior would be
>>>
>>
>>
>>> 	pushl %ecx
>>> 	pushl %ecx
>>> 	call _up
>>> 	add $4, %ecx
>              ^^^^
>              %esp
>
> Sorry, there was a typo as specified above. Of cause, you still need
> push/pop eax & edx, that was ommited for brevity, cause it is not really
> relevant.
>
>>> 	popl %ecx
>>>
>>
>> Very wrong. In fact, it would unbalance the stack. The register
>> value, %ecx must be restored exactly as the code does it. One
>> can't assume that %ecx magically got changed and needs to be
>> 'corrected'.
>>
>> Maybe you meant:
>>
>> 	pushl	%eax
>> 	pushl	%edx
>      pushl %ecx   # <- you still need to keep ecx
>> 	pushl	%ecx
>> 	call	__up
>> 	addl	$0x04, %esp	# Bypass ecx on stack
>      popl  %ecx   # <- this one as well
>> 	popl	%edx
>> 	popl	%eax
>
> I meant as indicated above.
>
> Aleks.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

