Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277027AbRJKW4m>; Thu, 11 Oct 2001 18:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277029AbRJKW4c>; Thu, 11 Oct 2001 18:56:32 -0400
Received: from [208.129.208.52] ([208.129.208.52]:35596 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277027AbRJKW4Z>;
	Thu, 11 Oct 2001 18:56:25 -0400
Date: Thu, 11 Oct 2001 16:01:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Zealey <mark@zealos.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question and patch about spinlocks (x86)
In-Reply-To: <20011011213655.D7138@itsolve.co.uk>
Message-ID: <Pine.LNX.4.40.0110111555170.968-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Mark Zealey wrote:

> Just looking through at the spinlock assembly I noticed a few things which I
> think are bugs:
>
>  	"js 2f\n" \
>  	".section .text.lock,\"ax\"\n" \
>  	"2:\t" \
> 	"cmpb $0,%0\n\t" \
>  	"rep;nop\n\t" \
> 	"jle 2b\n\t" \
>  	"jmp 1b\n" \
>  	".previous"
>
> We do the cmp loop as a 'soft' check, as the lock operand locks the whole system
> bus, stopping the system for a while (as much as 70 cycles, I believe). However,
> I don't understand why it was put before the 'rep; nop' which just sets the
> processor to wait for a bit. Surely it would be better to test *after* we have
> waited, as then we have a better chance of it being correct.

The effect of the rep-nop is not to wait but to slow down the cpu to the
speed of the memory bus.
This to not overload ( due pipeline prefetch ) the memory controller with
requests that 1) will be useless coz the watched memory location can
change only at the membus speed 2) will have a big cost on loop exit due
the invalidation of a number>1 requests issued on the memory controller.
Beside this i kindly agree to move the pause before the cmp.
There should be a valid reason to not have followed the intel scheme but i
don't know why.



- Davide


