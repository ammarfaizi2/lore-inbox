Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283865AbRLABUu>; Fri, 30 Nov 2001 20:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283869AbRLABUi>; Fri, 30 Nov 2001 20:20:38 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:56838 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283865AbRLABTr>; Fri, 30 Nov 2001 20:19:47 -0500
Date: Fri, 30 Nov 2001 17:30:19 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <9u9acg$rrl$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.40.0111301725480.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2001, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.4.40.0111301614000.1600-100000@blue1.dev.mcafeelabs.com>
> By author:    Davide Libenzi <davidel@xmailserver.org>
> In newsgroup: linux.dev.kernel
> >
> > The point is why store kernel pointers in global registers when You can
> > achieve the same functionality, with a smaller patch, that does not need
> > to be recoded for each CPU, without using global registers.
> >
>
> Because global registers are faster!  This is exactly the kind of
> stuff that is properly CPU-dependent and should be treated as such.
> Heck, it even depends on what kind of multiprocessor architecture, if
> any, you're using!
>
> That being said, I belive that on most, if not all, processors, the
> idea of having the pointer point not to "current" but to a per-CPU
> memory area is *very* appealing, and a change that should be made
> uniform unless it's a significant lose on some machines...

Again this is the  "current"  diff :

 static inline struct task_struct * get_current(void)
 {
-       struct task_struct *current;
-       __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
-       return current;
+       unsigned long *tskptr;
+       __asm__("andl %%esp,%0; ":"=r" (tskptr) : "0" (~8191UL));
+       return (struct task_struct *) *tskptr;
 }

that will probably resolve in something like:

movl %esp, %eax
andl $-8192, %eax
movl (%eax), %eax





- Davide


