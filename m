Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTKZNri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263977AbTKZNri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:47:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50561 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263873AbTKZNre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:47:34 -0500
Date: Wed, 26 Nov 2003 08:49:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
In-Reply-To: <3FC4A8BA.9070907@softhome.net>
Message-ID: <Pine.LNX.4.53.0311260829340.9730@chaos>
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos>
 <3FC3E2F4.4080809@softhome.net> <Pine.LNX.4.53.0311260745190.9601@chaos>
 <3FC4A8BA.9070907@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Ihar 'Philips' Filipau wrote:

> Richard B. Johnson wrote:
> >
> >>   May I ask you one question? Did you were ever doing once graceful
> >>failure of application under memory pressure? Looks like not.
> >>
> >
> > Yes. I'm in the business of making embedded systems that cannot
> > fail. And they do not fail. They allocate memory once during
> > startup and they never fail or exit. They also do not use malloc()
> > but that's not an issue.
> >
>
>    So what do you use then in user space to reliably allocate memory?
>
>    As to me - memory is a resource. Is it virtual or is it physical - it
> is still resource. And I need to allocate part of this resource.
>
>    malloc() uses brk() inside. But brk() is "implementation details". I
> honestly do not care about them - I just want to be sure that what ever
> resource I have allocated - I can use it afterwards until I shall free
> it. POSIX even doesn't mention brk() BTW.
>
>    If you can hint me any other method to allocate memory without
> surprises - I will really appreciate.
>

Here is a dynamic allocation scheme that doesn't fail with
the usual, i.e., less that 1/2 megabyte temporary storage. It
also automatically frees the RAM it's allocated.

int function(void *what, size_t len)
{
    char tmp[len];
    ;;;;;
    return 0;
}

The additional pointer math is wasteful of time. You can just
do:

int function(void *what, size_t len)
{
    char tmp[0x00100000];
}

... and be done with it. That just subtracts 0x00100000 from the
stack-pointer. Simple, quick. Your access should check against
sizeof(tmp).

If you need really large buffers and have only a single
thread, you can still allocate memory at compile-time, i.e.,

char scratch[0x10000000];

Any single-threaded function can use that scratch space.
Note that since scratch[] was not initialized by the compiler
it is put in the ".bss" segment and initialized to zero
when the program is loaded. Therefore, at least when the
program was started, there was sufficient virtual RAM to
allow the entire buffer to be written.

>
>    Embedded? with swap?!?
>    What you have smoken?! - take me to your dealer!-)))
>

Absolutely. A RAM-Disk on non-paged RAM. It allows individual
tasks to keep track of a valuable resource with minimum
overhead. It would be nicer if there was a "get free pages"
function call but you can make a driver for a virtual device
that returns such information. Then you don't need the
RAM disk to keep track of virtual memory

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


