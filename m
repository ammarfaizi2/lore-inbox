Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWJ2G6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWJ2G6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 01:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWJ2G6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 01:58:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:44373 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965091AbWJ2G6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 01:58:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TLQOIvwUp6UqpUzTmGFxBtBIl1pPVlRq7FOjBPCg8aGQj6o2+Z10kZzvBCu+b/IjGbuuTToVtRq2gTVoZSrvIco/2bDk+XjkQ3t7/PJ0tYeMshMJwyNAXtjHtrod5iRLE3mmSGMUcCwRgRbcoxX7ryzcumzCnWqndQ3JbQKZBPo=
Message-ID: <84144f020610282358p6d2db50ybd1cbfa3716c53fb@mail.gmail.com>
Date: Sun, 29 Oct 2006 09:58:33 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, "Andy Whitcroft" <apw@shadowen.org>,
       "Linus Torvalds" <torvalds@osdl.org>, pgiri@yahoo.com,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <454442DC.9050703@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454442DC.9050703@google.com>
X-Google-Sender-Auth: edab127f15573280
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/29/06, Martin J. Bligh <mbligh@google.com> wrote:
> -git4 was fine. -git5 is broken (on PPC64 blade)
>
> As -rc2-mm2 seemed fine on this box, I'm guessing it's something
> that didn't go via Andrew ;-( Looks like it might be something
> JFS or slab specific. Bigger PPC64 box with different config
> was OK though.
>
> Full log is here: http://test.kernel.org/abat/59046/debug/console.log
> Good -git4 run: http://test.kernel.org/abat/58997/debug/console.log
>
> kernel BUG in cache_grow at mm/slab.c:2705!
> cpu 0x1: Vector: 700 (Program Check) at [c0000000fffb7710]
>      pc: c0000000000c8ad4: .cache_grow+0x64/0x4f0
>      lr: c0000000000c91a8: .cache_alloc_refill+0x248/0x2cc
>      sp: c0000000fffb7990
>     msr: 8000000000021032
>    current = 0xc0000000fffab800
>    paca    = 0xc00000000047e780
>      pid   = 1, comm = swapper
> kernel BUG in cache_grow at mm/slab.c:2705!
> enter ? for help
> [c0000000fffb7a60] c0000000000c91a8 .cache_alloc_refill+0x248/0x2cc
> [c0000000fffb7b20] c0000000000c9708 .kmem_cache_alloc_node+0xd0/0x10c
> [c0000000fffb7bc0] c0000000000b69cc .__get_vm_area_node+0xcc/0x230
> [c0000000fffb7c70] c0000000000b7640 .__vmalloc_node+0x60/0xc0
> [c0000000fffb7d10] c0000000001ad4c8 .txInit+0x2a0/0x3a8
> [c0000000fffb7e20] c00000000044c1ec .init_jfs_fs+0x78/0x27c
> [c0000000fffb7ec0] c0000000000094c0 .init+0x1f4/0x3e4
> [c0000000fffb7f90] c000000000027270 .kernel_thread+0x4c/0x68

I only skimmed through this briefly but it looks like due to
52fd24ca1db3a741f144bbc229beefe044202cac __get_vm_area_node is passing
GFP_HIGHMEM to kmem_cache_alloc_node which is a no-no.
