Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752437AbWKBTdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWKBTdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbWKBTdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:33:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:16653 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752437AbWKBTdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:33:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R4MOXwKAuanaCcSbmouPOAOHJTcTwwFskmN1uC/8FwtTS14/s54BvqY0H9X0RJ89fRnOWZ7UpRYova+O13yNRxNwSJP/W1OeOLx7H8LMMuwypVWj+KkZz4H23bm03BNjiDtkQWAsD0DKVYi09akHLrauWDaG2BUa/tFBJslouqw=
Message-ID: <653402b90611021133i35683ac4i5f4da4098373603c@mail.gmail.com>
Date: Thu, 2 Nov 2006 19:33:48 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH update6] drivers: add LCD support
Cc: Franck <vagabon.xyz@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061102111311.1b2648c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061101014057.454c4f43.maxextreme@gmail.com>
	 <4549B19C.70304@innova-card.com>
	 <653402b90611020544l6e5ded94hc4c932fc1442fcb0@mail.gmail.com>
	 <454A0006.4090505@innova-card.com>
	 <653402b90611020644m57dac018r443fc91bccf6db0c@mail.gmail.com>
	 <20061102111311.1b2648c3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 2 Nov 2006 14:44:56 +0000
> "Miguel Ojeda" <maxextreme@gmail.com> wrote:
>
> > > Now let's say that some of the kernel frame buffer data are in the
> > > data cache and never be invalidate during this example. The
> >
> > Sorry, I don't understand what do you mean with this sentence.
>
> Some CPU architectures experience what Documentation/cachetlb.txt calls
> "virtual aliasing in the data cache".
>
> If you map the same physical page at virtual address A1 and also at another
> virtual address A2 then writes to address A1 do not necessarily appear
> correctly at address A2.  This because the write to A1 is stuck in the CPU
> cache and the CPU hardware doesn't know that read from A2 is accessing the
> same page.
>
> The solutions to this are:
>
> a) add lots of flushing everywhere (see Documentation/cachetlb.txt, I
>    guess) (this documentation is maddening: it uses the term "flush" for
>    both writeback and for invalidation.  In this context,
>    flush==writeback).
>
> b) If you select the correct virtual addresses for A1 and A2 (ie: ensure
>    that the mmap() handler returns an address which correlates with the
>    page's kernel address) then apparently the aliasing goes away.
>
>    So, for example, if the kernel's view of the page is at 0xd0102000
>    then you make sure that userspace's address for the page is at
>    0xnnn02000 (for some length of nnn).
>
>    I don't know what the mmap handler has to do to arrange for this to
>    happen.
>
> c) add `depends on x86' to your Kconfig ;)

I really like portable stuff :)

>
>
> davem and rmk are (amongst others) the guys for this stuff.  afaik it isn't
> documented anywhere.
>

Whoa, thanks you for the long explanation. May 2.6.18-new vmalloc
related functions help correlating userspace & kernel addresses? I
will try them and come with an answer tomorrow.

Quoting http://lwn.net/Articles/2.6-kernel-api/

"Some functions have been added to make it easy for kernel code to
allocate a buffer with vmalloc() and map it into user space. They are:

     void *vmalloc_user(unsigned long size);
     void *vmalloc_32_user(unsigned long size);
     int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
                             unsigned long pgoff);

The first two functions are a form of vmalloc() which obtain memory
intended to be mapped into user space; among other things, they zero
the entire range to avoid leaking data. vmalloc_32_user() allocates
low memory only. A call to remap_vmalloc_range() will complete the
job; it will refuse, however, to remap memory which has not been
allocated with one of the two functions above."
