Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSKUEwW>; Wed, 20 Nov 2002 23:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSKUEwW>; Wed, 20 Nov 2002 23:52:22 -0500
Received: from netrealtor.ca ([216.209.85.42]:38148 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262884AbSKUEwV>;
	Wed, 20 Nov 2002 23:52:21 -0500
Date: Thu, 21 Nov 2002 00:06:07 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <20021121050607.GA1554@mark.mielke.cc>
References: <19005.1037854033@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19005.1037854033@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few weeks ago I was surprised to find that code compiled with
-fomit-frame-pointers reliably executed a few percentages slower.
Since the functions I was testing were not anywhere big enough to
fill even the I1 cache, I wrote it off as 'the CPU is obviously
optimized to expect certain instruction sequences after call and
before ret'. Something to think about anyways...

mark


On Thu, Nov 21, 2002 at 03:47:13PM +1100, Keith Owens wrote:
> The conventional wisdom is that compiling x86 without frame pointer
> results in smaller code.  It turns out to be the opposite, compiling
> with frame pointers results in a smaller kernel.  gcc version 3.2
> 20020822 (Red Hat Linux Rawhide 3.2-4).
> 
> # size 2.4.20-rc2-*/vmlinux
>    text    data     bss     dec     hex filename
> 2669584  337972  402697 3410253  34094d 2.4.20-rc2-fp/vmlinux
> 2676919  337972  402697 3417588  3425f4 2.4.20-rc2-nofp/vmlinux
> 
> Without frame pointers, vmlinux is 7K bigger.  The difference is that
> code with frame pointers can use ebp to directly access the stack,
> without frame pointers it has to use esp with an index.
> 
> With frame pointers:
> 
> 00000c10 <inet_dgram_connect>:
>      c10:       55                      push   %ebp
>      c11:       89 e5                   mov    %esp,%ebp
>      c13:       83 ec 14                sub    $0x14,%esp
>      c16:       89 75 fc                mov    %esi,0xfffffffc(%ebp)
>      c19:       8b 45 08                mov    0x8(%ebp),%eax
>      c1c:       8b 75 0c                mov    0xc(%ebp),%esi
>      c1f:       89 5d f8                mov    %ebx,0xfffffff8(%ebp)
>      c22:       8b 58 18                mov    0x18(%eax),%ebx
>      c25:       66 83 3e 00             cmpw   $0x0,(%esi)
>      c29:       74 3d                   je     c68 <inet_dgram_connect+0x58>
> 
> Without frame pointers:
> 
> 00000c10 <inet_dgram_connect>:
>      c10:       83 ec 14                sub    $0x14,%esp
>      c13:       8b 44 24 18             mov    0x18(%esp,1),%eax
>      c17:       89 74 24 10             mov    %esi,0x10(%esp,1)
>      c1b:       8b 74 24 1c             mov    0x1c(%esp,1),%esi
>      c1f:       89 5c 24 0c             mov    %ebx,0xc(%esp,1)
>      c23:       8b 58 18                mov    0x18(%eax),%ebx
>      c26:       66 83 3e 00             cmpw   $0x0,(%esi)
>      c2a:       74 44                   je     c70 <inet_dgram_connect+0x60>
> 
> The difference is that stack accesses via ebp are 3 bytes, stack
> accesses via esp+index are 4 bytes.  On any function with a large
> number of stack accesses, this quickly outweighs the extra prologue
> code for frame pointers.
> 
> The smaller instruction set will improve icache usage.  Whether this is
> offset by the increased register pressure is something for
> benchmarking.  Any of the benchmarkers care to test x86 kernels with
> and without frame pointers?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

