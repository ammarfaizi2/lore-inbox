Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265655AbRGCJY3>; Tue, 3 Jul 2001 05:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbRGCJYS>; Tue, 3 Jul 2001 05:24:18 -0400
Received: from [195.66.192.167] ([195.66.192.167]:46610 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265655AbRGCJYF>; Tue, 3 Jul 2001 05:24:05 -0400
Date: Tue, 3 Jul 2001 12:15:55 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <2114620503.20010703121555@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
CC: bgerst@didntduck.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 07:52:02AM -0400, Brian Gerst wrote:
> Actually, you will never get a stack fault exception, since with a flat
> stack segment you can never get a limit violation. All you will do is
> corrupt the data in task struct and cause an oops later on when the
> kernel tries to use the task struct. There are only two ways to
> properly trap a kernel stack overflow:

> - Make the stack segment non-flat, putting the limit just above the task
> struct. Ugly, because we want to stay away from segmentation. The
> stack fault handler would have to be a task gate. This also causes
> problems because pointers accessed through %ebp also use the stack
> segment by default. We would either need to leave frame pointers turned
> on or teach GCC to use %ds overrides when using %ebp as a pointer.

> - Add a not-present guard page at the bottom of the stack. This means
> the stack would have to live in vmalloc'ed memory, which I don't think
> the kernel can handle at this time (with lazy vmalloc mapping). The
> task struct would have to be moved elsewhere or it would still get
> overwritten. Then a double fault task would be able to detect this and
> kill the task.

You're talking about something like this?

0.............|taskstruct|guardpage(s)|stack space............FFFFFFFF
^^^^^^^^^^^^              ^^^^^^^^^^^^
This is not               these cause
a stack space             a page fault
                          -> double fault
                          thru task gate

I don't see why task struct have to be moved elsewhere. A couple of
(not-present) pages and some support from MM subsystem is needed as
well as double fault handling code.

> In other words, with the current x86 architecture, there isn't really
> much we can do to handle stack overflows without sacrificing
> performance. Good discipline is the best we have.

It could be useful as a debug feature for testing experimental kernels
(selectable by make config).

Pls CC me. I'm not on the list
--
vda@port.imtp.ilyichevsk.odessa.ua


