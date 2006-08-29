Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965388AbWH2VPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965388AbWH2VPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbWH2VPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:15:48 -0400
Received: from gw.goop.org ([64.81.55.164]:14766 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965388AbWH2VPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:15:47 -0400
Message-ID: <44F4AE80.4010607@goop.org>
Date: Tue, 29 Aug 2006 14:15:44 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Peter Grandi <pg_lkm@lkm.for.sabi.co.UK>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>	<Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>	<a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>	<44F46E8C.1000308@goop.org> <17652.35152.661745.96581@base.ty.sabi.co.UK>
In-Reply-To: <17652.35152.661745.96581@base.ty.sabi.co.UK>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Grandi wrote:
> [ ... ]
>
> df> My question is actually why there is a 3G offset from linear
> df> kernel to physical kernel. Why not simply have kernel memory
> df> linear space located on 0-1G linear address, and therefore the
> df> physical kernel and linear kernel just coincide?
>
> First of all there are _three_ mapping regions:
>
> * for the per-process address space	(x86 default 3GiB at address 0);
> * the kernel address space		(x86 default 128MiB at address 3Gib);
> * the real memory address space		(x86 default the last 896MiB).
>
> The kernel address space is small and does not matter much in this
> discussionm except for stealing 128MiB. What really matter are the
> other two. Note also that the memory resident pages of a process
> are necessarily mapped twice, once in the per-process address
> space and once in the real memory space.
>
> There are actually three possible cases:
>
> 1) per-process mapped low, real memory mapped high (e.g. 3GiB+128MiB+896MiB).
> 2) real memory mapped low, per-process mapped high (e.g. 896MiB+128MiB+3GiB).
> 3) both per-process and real memory mapped low (e.g. 3.9GiB+128MiB), with 
>    real memory/per process flipping or something else.
>
> jeremy> If kernel virtual addresses were low, you would either
> jeremy> need to do an address-space switch (=TLB flush)
>
> This is case #3, which was the norm on many platforms, e.g. UNIX
> PDP-11. To be practical it requires special instructions to
> load/store from unmapped address spaces. Linus prefers to map
> both kernel and physical memory in every address space.
>   

Linux used to use segmentation to do something like this; %fs was set up 
to point to the user address space in the kernel, and accesses to 
userspace used an %fs segment override.  This history is still visible 
in the naming of get/set_fs (which has nothing to do with filesystems).

> * Only the real-memory address space has the 128MiB kernel
>   address space map, which seems what this phrase assumes.
>
> * Each address space, including both per-process ones and the
>   real memory one, have a 128MiB mapping for the kernel address
>   space.
>   

By "real" I assume you mean "physical".  What you're suggesting is 
something akin to highmem, but applied to all memory.  With highmem, the 
kernel can't assume it has direct access to all physical memory, and you 
must explicitly map it in with kmap() to use it.  You could do this with 
all memory all the time, but with an obvious performance (and 
complexity) overhead.

> Strange does not matter a lot; but it is somewhat surprising
> that the x86 ABI, which includes shared libs all over the place,
> does require low addresses. But if that is the case it must have
> been an important point in the past, when layout compatibility
> might have mattered for iBCS (anybody remembers that? :->).
>   

Well, if you're mapping kernel+physical memory at low addresses, it 
means that userspace moves about depending on where you want to put the 
user/kernel split.  That's a lot harder to deal with than just moving 
around the limit.

The load address for ET_EXEC executables is defined as 0x08048000; you 
can use ET_DYN if you want to load them elsewhere.  Using lower 
addresses allows the use of instructions with smaller pointers and 
offsets (though this might be less important on x86).  x86-64's normal 
compilation model requires non-relocatable code to be in the lower 
2Gbytes, for example.

> Odd, because this is an argument to have case #2 or #3: because
> then one loads the kernel code at low physical addresses, and
> then maps them 1-1 onto virtual addresses.
>   

I'm pointing out that the existing design has a reasonable technical 
justification, and is not somebody's arbitrary personal choice.  There 
are certainly other possible designs, with their own pros and cons.

    J
