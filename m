Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWJBIwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWJBIwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 04:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJBIwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 04:52:41 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:40868 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1750975AbWJBIwk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 04:52:40 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: [PATCH 4/4] fdtable: Implement new pagesize-based fdtable allocation scheme.
Date: Mon, 2 Oct 2006 10:52:34 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200610011414.30443.vlobanov@speakeasy.net>
In-Reply-To: <200610011414.30443.vlobanov@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610021052.35731.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 23:14, Vadim Lobanov wrote:
> This patch provides an improved fdtable allocation scheme, useful for
> expanding fdtable file descriptor entries. The main focus is on the
> fdarray, as its memory usage grows 128 times faster than that of an fdset.
>
> The allocation algorithm sizes the fdarray in such a way that its memory
> usage increases in easy page-sized chunks. Additionally, it tries to
> account for the optimal usage of the allocators involved: kmalloc() for
> sizes less than a page, and vmalloc() with page granularity for sizes
> greater than a page. Namely, the following sizes for the fdarray are
> considered, and the smallest that accommodates the requested fd count is
> chosen:
>     pagesize / 4
>     pagesize / 2
>     pagesize      <- memory allocator switch point
>     pagesize * 2
>     pagesize * 3
>     pagesize * 4
>     ...etc...
> Unlike the current implementation, this allocation scheme does not require
> a loop to compute the optimal fdarray size, and can be done in straightline
> code.
>
> Furthermore, since the fdarray overflows the pagesize boundary long before
> any of the fdsets do, it makes sense to optimize run-time by allocating
> both fdsets
> in a single swoop. Even together, they will still be, by far, smaller than
> the fdarray.
>
> As long as we're replacing the guts of fs/file.c, it makes sense to tidy up
> the code. This work includes:
>     simplification via refactoring,
>     elimination of unnecessary code, and
>     extensive commenting throughout the entire file.
> This is the last patch in the series. All the code should now be sparkly
> clean.
>

Vadim, I think your patch is way too complex, and some changes are dubious.
You mix cleanups and changes in the same patch, making hard to match your 
patch description and its content.

Current scheme is to allocate power of two sizes, and not 'the smallest that 
accommodates the requested fd count'. This is for a good reason, because we 
don't want to call vmalloc()/vfree() each time a process opens 512 or 1024 
more files (x86_64 or ia32)

I  personally prefer that table grows by a two factor, especially when they 
are huge. Also, power of two sizes gives less vmalloc space fragmentation 
(might be a concern for some people that are LOWMEM tight and that reduce 
VMALLOC space to get more LOWMEM)
default __VMALLOC_RESERVE on i386 is 128Mo, but I have some servers where I 
use
vmalloc=16M just to give more LOWMEM for kernel use.



diff -Npru old/include/linux/file.h new/include/linux/file.h
--- old/include/linux/file.h    2006-09-28 20:13:13.000000000 -0700
+++ new/include/linux/file.h    2006-09-28 20:22:05.000000000 -0700
@@ -29,8 +29,8 @@ struct embedded_fd_set {
 struct fdtable {
        unsigned int max_fds;
        struct file ** fd;      /* current fd array */
-       fd_set *close_on_exec;
        fd_set *open_fds;
+       fd_set *close_on_exec;
        struct rcu_head rcu;
        struct fdtable *next;
 };

Whats the reason for moving this close_on_exec definition in struct fdtable ?

Eric
