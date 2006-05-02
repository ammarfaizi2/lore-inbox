Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWEBB4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWEBB4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 21:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWEBB4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 21:56:11 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:40433 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932353AbWEBB4K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 21:56:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VEvOdOc3jzGY/t0Ix22y8hLPpEcCLQ+8l0UkqTEw7x+sh7OjYEFc/JW/ol9rB0HMMTiWcp5WDQHsSHsEe0xPVPbO4qrwoTziEcAGRC3QB6PYhTVAb9Q7KNjADv1cj6KWqUwKWXUW5qUTRUKWcb8pQbMoas1ZukxNQH5OHUOCJPk=
Message-ID: <aec7e5c30605011856v5023b8fdwf8542c746a8a09dd@mail.gmail.com>
Date: Tue, 2 May 2006 10:56:09 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH] kexec: Avoid overwriting the current pgd (i386)
Cc: vgoyal@in.ibm.com, "Magnus Damm" <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m1u089aegp.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060501095041.16897.49541.sendpatchset@cherry.local>
	 <20060501143512.GA7129@in.ibm.com>
	 <m1u089aegp.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> > On Mon, May 01, 2006 at 06:49:16PM +0900, Magnus Damm wrote:
> >> --- 0001/include/linux/kexec.h
> >> +++ work/include/linux/kexec.h       2006-05-01 11:13:14.000000000 +0900
> >> @@ -69,6 +69,17 @@ struct kimage {
> >>      unsigned long start;
> >>      struct page *control_code_page;
> >>
> >> +    /* page_table_a[] holds enough pages to create a new page table
> >> +     * that maps the control page twice..
> >> +     */
> >> +
> >> +#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
> >> +    struct page *page_table_a[3]; /* (2 * pte) + pgd */
> >> +#endif
> >> +#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
> >> +    struct page *page_table_a[5]; /* (2 * pte) + (2 * pmd) + pgd */
> >> +#endif
> >> +
> >
> > Would it make a cleaner interface if these array of pointers are maintained
> > in arch dependent code as global variables instead of putting in arch
> > independent code. Existing code does something simlar. This becomes further
> > ugly when another array comes into the picture for x86_64 in next patch.
> > (page_table_b)
>
> Well global variables don't quite work in the normal case.
>
> However it probably makes most sense to maintain the needed variables
> in a structure on the control page.  Which will keep them out of harms way,
> and won't require patches to the generic code.

I agree with both of you that the #ifdefs in struct kimage should be
avoided, but I wonder if adding variables in a structure on the
control page is the easiest and cleanest way.

I think that defining a structure for each architecture in
include/asm/kexec.h that is included in struct kimage is the best way
to go. Then each architecture can have whatever data it wants there,
and we both avoid #ifdefs in struct kimage _and_ we stay away from
overly complicated code that just allocates, frees and parses
architecture-dependent data.

Thanks for the input,

/ magnus
