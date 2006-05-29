Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWE2Ike@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWE2Ike (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 04:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWE2Ike
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 04:40:34 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:47415 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750773AbWE2Ikd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 04:40:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bXk2nJdatbept0uIW0urOc5EWo/MlnbF4nBvCDIwVA3Tnnm+UuWv6i4cbZIOAZA0/a0eTD7oOD05mymhYqtOAkrq5Oz4vi1x+MreXP2fj/LdUCSYUKM4nr894jqil+hhDGLFQFXR1/GsFciN/F8gKvNjrH7tXMCy7nP6/iGO+c0=
Message-ID: <aec7e5c30605290140s5163b8c6k9806f23e2a26bf35@mail.gmail.com>
Date: Mon, 29 May 2006 17:40:32 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       "Vivek Goyal" <vgoyal@in.ibm.com>
In-Reply-To: <m1ejygbvcc.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044247.14219.13579.sendpatchset@cherry.local>
	 <m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	 <1148545616.5793.180.camel@localhost>
	 <m11wuif5zy.fsf@ebiederm.dsl.xmission.com>
	 <aec7e5c30605252017v1d8269a4jf75f055fe256f966@mail.gmail.com>
	 <m1ejygbvcc.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
>
> > The code is not broken. The code does exactly what you are talking
> > about. Maybe I was a bit unclear.
>
> Ack.  I got a little confused.  I was still thinking of what
> the identity mapping was trying to achieve, and you don't achieve
> the same thing.

No problem. The remapping code is all but simple.

> > "page_table_a" contains two mappings. One which is the same as where
> > the page is mapped in the kernel (the virtual address where
> > relocate_new_kernel is located), and one identity mapped. So when the
> > switch occurs the cpu will continue to run on the same virtual
> > address.
>
> In the general case which you want to cover page_table_a is still
> slightly wrong.  In particular you can theoretically get a conflict
> between the virtual address of your page table switching function and
> the physical address of the control code page.

Are you sure?

The mappings in page_table_a are created by C code in the
kernel/hypervisor, right? One of the mappings is an identity mapping,
and the other one is mapping the control page at the same address as a
"NX-safe" page in the kernel/hypervisor.

When we are about to kexec into the new kernel, the kernel/hypervisor
is accessing the regular page tables as usual. machine_kexec() then
jumps to the assembly code where we disable interrupts and switch page
tables. Could you please clarify what you mean by "page table
switching function"?

The only conflict that I see is when the two mappings in page_table_a
happen to be on the same address. But that is not a problem,
everything should work as expected in that case too. The page_table_a
code should in that case just use one mapping instead of two.

I could of course be wrong and I'd really like to hear all doubts
people have regarding my "page_table_a" solution. So if anyonel thinks
that there's a problem somewhere please give me a detailed
description.

> However while I agree that you need to do this in assembly for
> control I disagree that this code should be part of the
> relocate_new_kernel function.
>
> Please move the code that uses page_table_a to a separate function,
> that when it is done jumps to the control_code page.  Then you can
> map this page both virtually and physically with a statically
> allocated page table built a compile time.

This function, you write "uses page_table_a". Do you mean that the
function allocates it? Or fills it in? Or maybe switches to it? Please
clarify!

> This is a little simpler as you don't need to build this first
> page table dynamically and a little clearer as you aren't trying to
> get the control code page to serve two different functions.

But doesn't a static set of pages used for page_table_a just mean that
you are wasting valuable unswappable kernel memory? Also, how can you
be sure that the static pages are in a DMA-safe address range?

> If this function was more than 3 lines of assembly it could even
> be written in C for clarity with a special section so that
> the linker would not map it twice.  Of course that would still need
> to address the stack usage problem.

I do not really see the benefit with this static solution actually.
The special section also feels a bit complicated. Maybe it fits your
big picture better and that is of course good.

It does however make the Xen porting more difficult. =(

> >> So you need at least one additional entry in your page table.
> >>
> >> The fact that this bug did not jump out is a clear sign you were
> >> changing too many things at once, and did not have an adequate
> >> explanation in your change log.
> >
> > I will ignore that last part for now. I've tested the code on i386,
> > i386/pae, x86_64 (both opteron and athlon64) and all the combinations
> > with and without xen, and all configurations except x86_64 with both
> > kexec and kdump.
>
> Testing is important here.  But given that 99% of the bug hunting must
> be done via code review and thinking about the problem testing is not
> sufficient.

Agreed.

Thanks!

/ magnus
