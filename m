Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbSJDOFd>; Fri, 4 Oct 2002 10:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbSJDOFc>; Fri, 4 Oct 2002 10:05:32 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:2321 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261782AbSJDOFb>;
	Fri, 4 Oct 2002 10:05:31 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] improve wchan reporting 
In-reply-to: Your message of "Thu, 03 Oct 2002 18:21:44 -0400."
             <20021003182144.G16875@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Oct 2002 00:10:53 +1000
Message-ID: <4003.1033740653@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002 18:21:44 -0400, 
Benjamin LaHaise <bcrl@redhat.com> wrote:
>This patch attempts to fix up the way that wchan is reported on x86 by 
>allowing functions out side of schedule.c to be skipped over when reading 
>the stack.
>
>diff -urN linus-2.5/arch/i386/kernel/process.c test/arch/i386/kernel/process.c
>--- linus-2.5/arch/i386/kernel/process.c	Thu Oct  3 15:30:12 2002
>+++ test/arch/i386/kernel/process.c	Thu Oct  3 18:05:13 2002
>+	/* Our first attempt is to walk the chain of frame pointers. */
> 	do {
>-		if (ebp < stack_page || ebp > 8184+stack_page)
>-			return 0;
>+		if (ebp < stack_page || ebp > 8188+stack_page)
>+			break;

Use THREAD_SIZE-4 instead of 8188.  Some people like 4K stacks.

> 		eip = *(unsigned long *) (ebp+4);
>+		if (eip < text_start || eip > text_end)
>+			break;

Will incorrectly abort on schedule() called from modules.  eip will be
in the vmalloc area for modules on most architectures.

>diff -urN linus-2.5/arch/i386/vmlinux.lds.S test/arch/i386/vmlinux.lds.S
>--- linus-2.5/arch/i386/vmlinux.lds.S	Thu Oct  3 15:30:12 2002
>+++ test/arch/i386/vmlinux.lds.S	Thu Oct  3 18:05:13 2002
>@@ -11,8 +11,17 @@
>   _text = .;			/* Text and read-only data */
>   .text : {
> 	*(.text)

Add . = ALIGN(16); here.  Text may not end on a quad 16 byte boundary.

>+
>+	scheduling_functions_start_here = .;
>+	. += 0x10;
>+	*(.text.scheduler)

Why . += 0x10;?

