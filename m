Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVKLOBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVKLOBa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVKLOB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:01:29 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:49800 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbVKLOB3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:01:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pYM6BAWdNGD53peLuX/VcRJtZvTon+R4KYIDPgIDWlR1LMfG4U62FtwsAQiwOcItkESWxkCaWbJuKb+HuEkovIeaSD3cCA/auHrQE6DF0X5njenXxlEdEXQvlxLoDWi1f5v0POfGimfgxm6SfyWZBUY5ofEEPDdX3F8mcA45DHc=
Message-ID: <2cd57c900511120601y3461f4c4i@mail.gmail.com>
Date: Sat, 12 Nov 2005 22:01:27 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [patch] mark text section read-only
Cc: Coywolf Qi Hunt <coywolf@sosdg.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       ak@suse.de, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0511111425500.4991@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051107105624.GA6531@infradead.org>
	 <20051107105807.GB6531@infradead.org>
	 <1131372374.23658.1.camel@windu.rchland.ibm.com>
	 <1131373248.2858.17.camel@laptopd505.fenrus.org>
	 <2cd57c900511110139v221ed3f3m@mail.gmail.com>
	 <1131702428.2833.8.camel@laptopd505.fenrus.org>
	 <2cd57c900511111057n3a7741ddw@mail.gmail.com>
	 <20051111190447.GA14481@everest.sosdg.org>
	 <Pine.LNX.4.61.0511111425500.4991@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/12, linux-os (Dick Johnson) <linux-os@analogic.com>:
>
> On Fri, 11 Nov 2005, Coywolf Qi Hunt wrote:
>
> > On Sat, Nov 12, 2005 at 02:57:02AM +0800, Coywolf Qi Hunt wrote:
> >> And we could also mark text section read-only and data/stack section
> >> noexec if NX is supported. But I doubt the whole thing would really
> >> help much. Kill the kernel thread? We can't. We only run into a panic.
> >> Anyway I'd attach a quick patch to mark text section read only in the
> >> next mail.
> >>
> >> If it's ok, I'd add Kconfig support. Comments?
> >
> >
> > Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
> > ---
> >
> > diff -pruN 2.6.14-mm2/init/main.c 2.6.14-mm2-cy/init/main.c
> > --- 2.6.14-mm2/init/main.c    2005-11-11 22:34:21.000000000 +0800
> > +++ 2.6.14-mm2-cy/init/main.c 2005-11-12 02:50:45.000000000 +0800
> > @@ -660,6 +660,18 @@ static inline void fixup_cpu_present_map
> > #endif
> > }
> >
> > +void mark_text_ro(void)
> > +{
> > +     unsigned long addr = (unsigned long)&_text;
> > +
> > +     for (; addr < (unsigned long)&_etext; addr += PAGE_SIZE)
> > +             change_page_attr(virt_to_page(addr), 1, PAGE_KERNEL_RO);
> > +
> > +     printk ("Write protecting the kernel text data: %luk\n",
> > +                     (unsigned long)(_etext - _text) >> 10);
> > +     global_flush_tlb();
> > +}
> > +
> > static int init(void * unused)
> > {
> >       lock_kernel();
> > @@ -716,6 +728,7 @@ static int init(void * unused)
> >        */
> >       free_initmem();
> >       unlock_kernel();
> > +     mark_text_ro();
> >       mark_rodata_ro();
> >       system_state = SYSTEM_RUNNING;
> >       numa_default_policy();
> > -
>
>
> Assuming ix86, what is read-only? Certainly the text section needs
> to be marked execute!
>
> So is it:
>         Execute-Only
>         Execute-Only, accessed
>         Execute/Read
>         Execute/Read, accessed
>         Execute-only, conforming
>         Execute-only, conforming, accessed
>         Execute/Read-Only, conforming
>         Execute/Read-Only, conforming, accessed.
> (all from page 5-12 of ix484 programmer's reference)
>
> ????
>
> You need to WRITE to the text segment to be able to load executables
> (modules) and kernel threads. The user-mode code, children of `init`
> need to have writable .text segments to be able to exec().

Ah, thanks, Mr Wrong.

>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.48 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
>
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
> Thank you.
>
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
