Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTAYXaQ>; Sat, 25 Jan 2003 18:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbTAYXaP>; Sat, 25 Jan 2003 18:30:15 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:57231 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264936AbTAYXaJ>; Sat, 25 Jan 2003 18:30:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 25 Jan 2003 15:44:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [patch] epoll for 2.4.20 updated ...
In-Reply-To: <20030125215844.GA3750@werewolf.able.es>
Message-ID: <Pine.LNX.4.50.0301251541040.1855-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0301242004010.2858-100000@blue1.dev.mcafeelabs.com>
 <20030125215844.GA3750@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, J.A. Magallon wrote:

>
> On 2003.01.25 Davide Libenzi wrote:
> >
> > I updated the 2.4.20 patch with the changes posted today and I fixed a
> > little error about the wait queue function prototype :
> >
> > http://www.xmailserver.org/linux-patches/sys_epoll-2.4.20-0.61.diff
> >
>
> Mixing epoll ontop of current aa, I found this:
>
> #define add_wait_queue_cond(q, wait, cond) \
>     ({                          \
>         unsigned long flags;                \
>         int _raced = 0;                 \
>         wq_write_lock_irqsave(&(q)->lock, flags);   \
>         (wait)->flags = 0;              \
>         __add_wait_queue((q), (wait));          \
>         mb();                       \
>         if (!(cond)) {                  \
>             _raced = 1;             \
>             __remove_wait_queue((q), (wait));   \
>         }                       \
>         wq_write_unlock_irqrestore(&(q)->lock, flags);  \
>         _raced;                     \
>     })
>
> this is the -aa version. Version from epoll uses just a rmb() barrier
> (afaik, just a _read_ barrier). In -aa they are just the same, but I also
> use a patch that does this:
>
>
> +#ifdef CONFIG_X86_MFENCE
> +#define mb()   __asm__ __volatile__ ("mfence": : :"memory")
> +#else
>  #define mb()   __asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
> +#endif
> +
> +#ifdef CONFIG_X86_LFENCE
> +#define rmb()  __asm__ __volatile__ ("lfence": : :"memory")
> +#else
>  #define rmb()  mb()
> +#endif
>
> so for modern processors they are different, and can affect performance and
> correctness. So  which one it the correct one for the above code snipet ?

It depends on what "cond" does. Being it a macro I'd feel safer with an mb().



- Davide

