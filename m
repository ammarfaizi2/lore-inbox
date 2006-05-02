Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWEBIBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWEBIBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWEBIBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:01:51 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:48473 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932495AbWEBIBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:01:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RS7SoIgu2HMzpj5rWDG6ickH2Mqac9CKXNFF6Kq09e/Mx2Cq6OX3ktdgv/6W6H/QS05S0bgxhR7lOFBNIxVcODmU9+uXQiIiCwysJ5vHphMIr8eNy2bqNAGHUA9ghBN7UgvaWPydeJWZgdQsvRke7AP1aVQOSs3LS9qq/NXXKkw=
Message-ID: <aec7e5c30605020101w5c548586v669a76fb65f473a8@mail.gmail.com>
Date: Tue, 2 May 2006 17:01:49 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH] kexec: Avoid overwriting the current pgd (i386)
Cc: vgoyal@in.ibm.com, "Magnus Damm" <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m17j54aodw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060501095041.16897.49541.sendpatchset@cherry.local>
	 <20060501143512.GA7129@in.ibm.com>
	 <m1u089aegp.fsf@ebiederm.dsl.xmission.com>
	 <aec7e5c30605011856v5023b8fdwf8542c746a8a09dd@mail.gmail.com>
	 <m17j54aodw.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
>
> > On 5/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Well global variables don't quite work in the normal case.
> >>
> >> However it probably makes most sense to maintain the needed variables
> >> in a structure on the control page.  Which will keep them out of harms way,
> >> and won't require patches to the generic code.
> >
> > I agree with both of you that the #ifdefs in struct kimage should be
> > avoided, but I wonder if adding variables in a structure on the
> > control page is the easiest and cleanest way.
> >
> > I think that defining a structure for each architecture in
> > include/asm/kexec.h that is included in struct kimage is the best way
> > to go. Then each architecture can have whatever data it wants there,
> > and we both avoid #ifdefs in struct kimage _and_ we stay away from
> > overly complicated code that just allocates, frees and parses
> > architecture-dependent data.
>
> Well I think it would be fairly simple to have a structure:
> struct control_page {
>        type     variabe;
>        ...
>        code[0];
> };
>
> Or something like that we can work with.
>
> The big reason for doing this is that I believe control pages
> have additional protection that struct kimage does, being allocated
> in areas where the kernel never sets up DMA transfers.  Possibly
> that needs to be fixed, but this is something we need to be very
> careful with.

I suppose you mean that control pages have additional protection that
struct kimage does _not_ have. Protection provided by
kimage_alloc_control_pages(), right?

I agree with you that this protection is good. But I do not see how
that applies to my patch, because the page_table_a[] pages pointed out
by struct kimage are read out by machine_kexec() and passed as
arguments to the assembly code. So the assembly code itself never
tries to access struct kimage. All data accessed by the assembly code
is allocated with kimage_alloc_control_pages(), isn't that good
enough? Or maybe I'm misunderstanding?

On top of that I fear that my patch likes the fact that the assembly
code in the control page is page aligned. But it is probably no biggie
to change. I'm just lazy. =)

> For a page table all we need to store is the physical address of the
> first page.  Storing and working with a struct page entry is the wrong
> thing to do.  I would prefer to stomp the kernel data structures than
> to add an extra dependencies on the original panic'd kernel.  At first
> glance I am afraid that you current code introduces extra
> dependencies.

I used struct page *[] because the control page was a struct page *. I
never use the contents of what the struct page points to, I only use
them to convert to physical/virtual addresses or pfns. So I would say
that no extra dependencies are introduced at all actually. But I may
be wrong.

I would be happy to change the struct page *[] to unsigned long [] or
something else, but I must say I like the typing that struct page
provides.

Regarding storing the just root page or all pages - I stored all pages
because I need to pass them to the Xen hypervisor which will fill in
new values in page_table_a. page_table_b OTOH never gets modified by
the hypervisor, which is why page_table_a is an array of pointers and
page_table_b is just a root pointer.

> You don't need two x86_64 page tables as you can easily map
> all of the kernel virtual address, and the identity mapped physical
> address until the x86_64 kernel stops using an 8TB/8TB split.

Sure. I just thought that one page table with a mix of 4K pages and
huge pages would result in difficult code. The current page_table_a
code is actually more or less the same on x86 and x86_64, with the
exception of some macro magic.

Thanks for the detailed reply!

/ magnus
