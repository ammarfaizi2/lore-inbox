Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279449AbRKASEJ>; Thu, 1 Nov 2001 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279429AbRKASEA>; Thu, 1 Nov 2001 13:04:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22658 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279449AbRKASDy>; Thu, 1 Nov 2001 13:03:54 -0500
Date: Thu, 1 Nov 2001 13:03:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <20011101120222.B11773@redhat.com>
Message-ID: <Pine.LNX.3.95.1011101125206.1496A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Benjamin LaHaise wrote:

> On Thu, Nov 01, 2001 at 10:34:53AM -0500, Richard B. Johnson wrote:
> > Well not exactly zealots. I test a lot of stuff. In fact, the code
> > you propose:
> > 
> > 	if(++jiffies==0) jiffies_hi++;
> > 
> > ... actually works quite well:
> 
> Uhm, no, it really doesn't.  See how it pairs with other instructions and 
> what the cost is when it doesn't have to be as bad:
> 
> this:
> 	unsigned long a, b;
> 	if (++a == 0) b++;
> gives:
>         movl    a, %eax
>         movl    %esp, %ebp
>         incl    %eax
>         testl   %eax, %eax
>         movl    %eax, a
>         je      .L3
> .L2:
>         popl    %ebp
>         ret
>         .p2align 4,,7
> .L3:
>         incl    b
>         jmp     .L2
> 
> which is really gross considering that:
> 
> 	unsigned long long c;
> 	c++;
> 
> gives:
> 
>         addl    $1, c
>         adcl    $0, c+4
> 
> which is quite excellent.
> 
> 		-ben
> 

Look I tested it, and I provided code to test it! You will not
convince the 'C' compiler to do:

	addl	$1, c
	adcl	$0, c+4

... with a long long (at least not egcs-2.91.66). Further, that's
not the whole story. If jiffies is a long long, then every operation
on that counter, all the timing queues, sleeps, etc., end up doing
multiple operations on the long long (which I showed on Monday with
some additional, best possible, code).

... which is code I showed initially. Knowing that the C compiler
does the jumps on condition and tests for zero, even after the
flags have been set by the previous operation, I tested what
the result was. It turns out that it's only a couple of clock
cycles, not the 6 extra clocks that the hand calculation shows.

So, if you leave jiffies alone, but bump another variable when it
wraps, you get to eat your cake and keep it too.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


