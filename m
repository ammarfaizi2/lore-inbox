Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283879AbRLABa7>; Fri, 30 Nov 2001 20:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283874AbRLABat>; Fri, 30 Nov 2001 20:30:49 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:60934 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283878AbRLABap>; Fri, 30 Nov 2001 20:30:45 -0500
Date: Fri, 30 Nov 2001 17:41:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <3C083150.3060906@zytor.com>
Message-ID: <Pine.LNX.4.40.0111301738420.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, H. Peter Anvin wrote:

> Davide Libenzi wrote:
>
> >
> > Again this is the  "current"  diff :
> >
> >  static inline struct task_struct * get_current(void)
> >  {
> > -       struct task_struct *current;
> > -       __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
> > -       return current;
> > +       unsigned long *tskptr;
> > +       __asm__("andl %%esp,%0; ":"=r" (tskptr) : "0" (~8191UL));
> > +       return (struct task_struct *) *tskptr;
> >  }
> >
> > that will probably resolve in something like:
> >
> > movl %esp, %eax
> > andl $-8192, %eax
> > movl (%eax), %eax
> >
>
>
> This seems to confuddle the idea of colouring the kernel stack.

It's task_truct colouring not stack, to colour the stack you've to go in
arch/??/kernel/process.c and jitter the stack pointer.
The task_struct colouring is done at task_struct creation time :


+struct task_struct *alloc_task_struct(void)
+{
+       unsigned long tskb = __get_free_pages(GFP_KERNEL, 1), tsk;
+       tsk = tskb | ((tskb >> 13) & 0x00000060) | SMP_CACHE_BYTES;
+       *(unsigned long *) tskb = tsk;
+       return (struct task_struct *) tsk;
+}




- Davide


