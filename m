Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUJRTv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUJRTv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUJRTu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:50:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267730AbUJRTt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:49:29 -0400
Date: Mon, 18 Oct 2004 15:49:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] in i386 semaphores.
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3017FBE1C@scl-exch2k.phoenix.com>
Message-ID: <Pine.LNX.4.61.0410181529350.4356@chaos.analogic.com>
References: <5F106036E3D97448B673ED7AA8B2B6B3017FBE1C@scl-exch2k.phoenix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Aleksey Gorelov wrote:

>
> Hi.
>
> I sent this yesterday, but seems like it missed the list somehow :
>
>  There are several assembly 'helpers' in arch/i386/semaphore.c, for
> example, __up_wakeup. __up_wakeup's purpose is to call C function:
> asmlinkage void __up(struct semaphore *sem)
>
> this is how it does it:
>
> 	pushl %eax
> 	pushl %edx
> 	pushl %ecx
> 	call __up
> 	popl %ecx
> 	popl %edx
> 	popl %eax
>

__up is declared 'asmlinkage', which means that conventional
'C' calling convention is used, that eax and/or edx/eax pair
is used for return values and the input values are pushed on
  the stack. The last parameter passed is a pointer in %ecx.

Therefore, the called 'C' function, that 'knows' only about
the first parameter passed, will get the correct pointer value.
The 'C' function also never changes the value of that pointer,
only something that it points to.

Now, wake_up() gets a pointer to the variable sem->wait. wake_up()
never modifies 'sem', only sem->wait.

>  As one can see, actual parameter in %ecx is not only being copied in
> formal parameter sem (which is correct), but also being restored from it
> after function call via %ecx (which is incorrect). Since formal
> parameter is not a constant one, it may be overwritten inside C
> function, or gcc may (and in fact does that in some cases) use it for
> something else.
> If we want to keep %ecx, correct behavior would be
>


> 	pushl %ecx
> 	pushl %ecx
> 	call _up
> 	add $4, %ecx
> 	popl %ecx
>

Very wrong. In fact, it would unbalance the stack. The register
value, %ecx must be restored exactly as the code does it. One
can't assume that %ecx magically got changed and needs to be
'corrected'.

Maybe you meant:

 	pushl	%eax
 	pushl	%edx
 	pushl	%ecx
 	call	__up
 	addl	$0x04, %esp	# Bypass ecx on stack
 	popl	%edx
 	popl	%eax

At least the stack would be correct and the return-address wouldn't
be clobbered. However, now ecx ends up being whatever value some
called 'C' function left it. This will result in a system failure
because previous code expected all registers to be preserved.

> Above applies for other functions in semaphore.c in latest 2.6 kernels.
> 2.4 might also be affected.
>
> Thanks,
> Aleks.
>

It 'taint broke. Don't "fix" it.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

