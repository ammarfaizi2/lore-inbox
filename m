Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUJRWFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUJRWFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUJRWE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:04:59 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:19829 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S267502AbUJRWEL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:04:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] in i386 semaphores.
Date: Mon, 18 Oct 2004 15:04:10 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3017FBF3E@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] in i386 semaphores.
Thread-Index: AcS1S5Uj6NL3OyPpTSqBPyVt0KlUHwADchBw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2004 22:04:10.0631 (UTC) FILETIME=[656B7170:01C4B55E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
>Sent: Monday, October 18, 2004 12:49 PM
>__up is declared 'asmlinkage', which means that conventional
>'C' calling convention is used, that eax and/or edx/eax pair
>is used for return values and the input values are pushed on
>  the stack. The last parameter passed is a pointer in %ecx.

Can not disagree here, except that %ecx is the only parameter.
eax/edx are just saved in the stack, and then restored (see comments
before the assembly in semaphore.c).
>
>Therefore, the called 'C' function, that 'knows' only about
>the first parameter passed, will get the correct pointer value.
>The 'C' function also never changes the value of that pointer,
>only something that it points to.

This is an assumption. AFAIK, according to C standard, formal parameters
are
COPIED from actual parameters. Formal parameters can not be used outside
the function, and as far as they are not constant ones, C compiler
is free to mofidy them after their last use, and use the memory for
other purposes.
>
>Now, wake_up() gets a pointer to the variable sem->wait. wake_up()
>never modifies 'sem', only sem->wait.

Well, build the kernel with DEBUG_KERNEL disabled with gcc 3.2 for
instance,
objdump it and check __up() code. You'll be surprised. And this is NOT
gcc issue.
>>  As one can see, actual parameter in %ecx is not only being copied in
>> formal parameter sem (which is correct), but also being 
>restored from it
>> after function call via %ecx (which is incorrect). Since formal
>> parameter is not a constant one, it may be overwritten inside C
>> function, or gcc may (and in fact does that in some cases) use it for
>> something else.
>> If we want to keep %ecx, correct behavior would be
>>
>
>
>> 	pushl %ecx
>> 	pushl %ecx
>> 	call _up
>> 	add $4, %ecx
              ^^^^
              %esp

Sorry, there was a typo as specified above. Of cause, you still need
push/pop eax & edx, that was ommited for brevity, cause it is not really
relevant.

>> 	popl %ecx
>>
>
>Very wrong. In fact, it would unbalance the stack. The register
>value, %ecx must be restored exactly as the code does it. One
>can't assume that %ecx magically got changed and needs to be
>'corrected'.
>
>Maybe you meant:
>
> 	pushl	%eax
> 	pushl	%edx
      pushl %ecx   # <- you still need to keep ecx 
> 	pushl	%ecx
> 	call	__up
> 	addl	$0x04, %esp	# Bypass ecx on stack
      popl  %ecx   # <- this one as well
> 	popl	%edx
> 	popl	%eax

I meant as indicated above.

Aleks.
