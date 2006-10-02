Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWJBRAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWJBRAJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWJBRAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:00:08 -0400
Received: from mail.impinj.com ([206.169.229.170]:16588 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S965126AbWJBRAG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:00:06 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH 4/4] fdtable: Implement new pagesize-based fdtable allocation scheme.
Date: Mon, 2 Oct 2006 10:00:00 -0700
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200610011414.30443.vlobanov@speakeasy.net> <200610021052.35731.dada1@cosmosbay.com>
In-Reply-To: <200610021052.35731.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610021000.00768.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 01:52, Eric Dumazet wrote:
> On Sunday 01 October 2006 23:14, Vadim Lobanov wrote:
> > This patch provides an improved fdtable allocation scheme, useful for
> > expanding fdtable file descriptor entries. The main focus is on the
> > fdarray, as its memory usage grows 128 times faster than that of an
> > fdset.
> >
> > The allocation algorithm sizes the fdarray in such a way that its memory
> > usage increases in easy page-sized chunks. Additionally, it tries to
> > account for the optimal usage of the allocators involved: kmalloc() for
> > sizes less than a page, and vmalloc() with page granularity for sizes
> > greater than a page. Namely, the following sizes for the fdarray are
> > considered, and the smallest that accommodates the requested fd count is
> > chosen:
> >     pagesize / 4
> >     pagesize / 2
> >     pagesize      <- memory allocator switch point
> >     pagesize * 2
> >     pagesize * 3
> >     pagesize * 4
> >     ...etc...
> > Unlike the current implementation, this allocation scheme does not
> > require a loop to compute the optimal fdarray size, and can be done in
> > straightline code.
> >
> > Furthermore, since the fdarray overflows the pagesize boundary long
> > before any of the fdsets do, it makes sense to optimize run-time by
> > allocating both fdsets
> > in a single swoop. Even together, they will still be, by far, smaller
> > than the fdarray.
> >
> > As long as we're replacing the guts of fs/file.c, it makes sense to tidy
> > up the code. This work includes:
> >     simplification via refactoring,
> >     elimination of unnecessary code, and
> >     extensive commenting throughout the entire file.
> > This is the last patch in the series. All the code should now be sparkly
> > clean.
>
> Vadim, I think your patch is way too complex, and some changes are dubious.
> You mix cleanups and changes in the same patch, making hard to match your
> patch description and its content.

Sorry; it was simply easier to roll all the really intrusive fs/file.c changes 
into a single patch, rather than making several smaller but equally-intrusive 
patches in a row. It was a timesaver for me, and I thought it would 
ultimately be a timersaver for those trying to follow the changes as well. If 
necessary, I can always split up the last patch in the series into multiple 
patches -- no problems there. :) Andrew, any preference in this particular 
case?

> Current scheme is to allocate power of two sizes, and not 'the smallest
> that accommodates the requested fd count'. This is for a good reason,
> because we don't want to call vmalloc()/vfree() each time a process opens
> 512 or 1024 more files (x86_64 or ia32)

Yep, that is most definitely a consideration. I was balancing it against the 
fact that, when the table becomes big, growing it by a power of two 
regardless of the size results in massive memory usage deltas. The worry here 
is that an application may likely cause the table to grow by a huge amount, 
due to the power-of-two increase, and then actually use only a modest number 
of further fds, wasting the rest of the allocated table memory.

Which applications open so many file handles so quickly? Do they actually need 
the amortized power-of-two table area increase? In those cases, would the 
actual process of opening these files take more time than growing the table 
in fixed-size steps? Or at least outweigh it enough that it would be more 
preferable to try to reduce memory waste instead of improve file open time?

> I  personally prefer that table grows by a two factor, especially when they
> are huge. Also, power of two sizes gives less vmalloc space fragmentation
> (might be a concern for some people that are LOWMEM tight and that reduce
> VMALLOC space to get more LOWMEM)
> default __VMALLOC_RESERVE on i386 is 128Mo, but I have some servers where I
> use
> vmalloc=16M just to give more LOWMEM for kernel use.

Is it really true that it will create less fragmentation? It seems to me that 
this will only be the true if most of the other heavy users of vmalloc also 
tried to use power-of-two allocation sizes.

What do you think of Andi Kleen's follow-up suggestion about eliminating 
vmalloc use altogether?

>
> diff -Npru old/include/linux/file.h new/include/linux/file.h
> --- old/include/linux/file.h    2006-09-28 20:13:13.000000000 -0700
> +++ new/include/linux/file.h    2006-09-28 20:22:05.000000000 -0700
> @@ -29,8 +29,8 @@ struct embedded_fd_set {
>  struct fdtable {
>         unsigned int max_fds;
>         struct file ** fd;      /* current fd array */
> -       fd_set *close_on_exec;
>         fd_set *open_fds;
> +       fd_set *close_on_exec;
>         struct rcu_head rcu;
>         struct fdtable *next;
>  };
>
> Whats the reason for moving this close_on_exec definition in struct fdtable
> ?

Better code readability. The code in fs/file.c initializes all the fields in 
the fdtable in the same order as they appear in the struct definition: this 
makes it easy to spot any omissions in the field initializations or verify 
that all members are, in fact, initialized correctly. (Simply read downwards 
in both the header file and the source file.) Since open_fds is the anchor 
for the fdset memory area, it is easier to initialize it first, then jump 
ahead, and initialize close_on_exec from this offset.

> Eric

Thanks for the input.

-- Vadim Lobanov
