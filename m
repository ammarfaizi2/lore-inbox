Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVKJNLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKJNLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVKJNLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:11:22 -0500
Received: from gold.veritas.com ([143.127.12.110]:37024 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750822AbVKJNLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:11:21 -0500
Date: Thu, 10 Nov 2005 13:10:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051108213407.GB31746@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
 <20051108213407.GB31746@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 13:11:21.0252 (UTC) FILETIME=[3E765640:01C5E5F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Michael S. Tsirkin wrote:
> 
> Hugh, did you have something like the following in mind
> (this is only boot-tested and only on x86-64)?

Yes, that looks pretty good to me, a few comments below.
Only another twenty or so architectures to go ;)

(I had been imagining VM_DONTCOPY plus another flag to say set by the
user: better your way, we would like to merge these vmas, and VM_DONTCOPY
is in that peculiar list of special flags that prevent merging.)

> Hmm, maybe MADV_INHERIT and MADV_DONT_INHERIT would be better names,

You're right, and it would be a good choice, except that MAP_INHERIT on
some OSes has a particular meaning (about inheriting across an exec),
so I think avoid confusion with that.  MADV_DONTFORK and MADV_DOFORK?
Accompanied by VM_DONTFORK?

> since the copy is only dont one write ...

"only done on write"?

> Index: linux-2.6.14-dontcopy/include/linux/mm.h
> ===================================================================
> --- linux-2.6.14-dontcopy.orig/include/linux/mm.h	2005-11-08 23:24:58.000000000 +0200
> +++ linux-2.6.14-dontcopy/include/linux/mm.h	2005-11-08 23:25:09.000000000 +0200
> @@ -154,6 +154,7 @@ extern unsigned int kobjsize(const void 
>  					/* Used by sys_madvise() */
>  #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
>  #define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
> +#define VM_UDONTCOPY	0x02000000      /* App wants to set VM_DONTCOPY */

Please place it where you'd expect to find it by value.

>  #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
>  #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
> Index: linux-2.6.14-dontcopy/include/asm-x86_64/mman.h
> ===================================================================
> --- linux-2.6.14-dontcopy.orig/include/asm-x86_64/mman.h	2005-11-08 23:19:35.000000000 +0200
> +++ linux-2.6.14-dontcopy/include/asm-x86_64/mman.h	2005-11-08 23:19:46.000000000 +0200
> @@ -36,6 +36,8 @@
>  #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
>  #define MADV_WILLNEED	0x3		/* pre-fault pages */
>  #define MADV_DONTNEED	0x4		/* discard these pages */
> +#define MADV_DONTCOPY	0x30		/* dont inherit across fork */
> +#define MADV_DOCOPY	0x31		/* do inherit across fork */
>  
>  /* compatibility flags */
>  #define MAP_ANON	MAP_ANONYMOUS

I think that's probably a good idea, to choose a range away from the rest.
But I'm not quite sure: anyone familiar with adding APIs listening?

Hugh
