Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWDNA6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWDNA6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWDNA6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:58:00 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:19189 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965082AbWDNA57 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:57:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JBBh8ff7N8TfxHZT+5d8AlaFsk3Ez4KKr9LN+uLphUgU9t4uFpoFUSlASefC+4Y6HSqsW6hejXpKw4k5rp2qQ0FlGQ+338jtQnETDQIAPreaSUYKK/cmbP2z0gtZ1NnAjD0NiGROrsjfaB/Z9K+FqnqtTzBWqth5MRAfq88SDuE=
Message-ID: <aec7e5c30604131757o228d79bbh2d3bed44085ae7f8@mail.gmail.com>
Date: Fri, 14 Apr 2006 09:57:58 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] Re: [PATCH] Kexec: Remove order
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       "Magnus Damm" <magnus@valinux.co.jp>
In-Reply-To: <m1wtdt6bge.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060413030040.20516.9231.sendpatchset@cherry.local>
	 <m164le6rcg.fsf@ebiederm.dsl.xmission.com>
	 <aec7e5c30604122321p2bedb370l945009ccdb725bac@mail.gmail.com>
	 <m1wtdt6bge.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
>
> > On 4/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> >> Feel free to fix x86_64, to use only page sized allocates.
> >
> > I will. But first - questions:
> >
> > Should KEXEC_CONTROL_CODE_SIZE be left in even if it's always 4096?
>
> So far I don't see a compelling case to remove it.  To a certain
> extent I am happily surprised to see that everyone's code
> across several architectures has managed to fit in 4KB.

I'm happy about that fact too. So I will not remove that constant then.

> > Do you like how I added image->arch_private?
>
> At a quick glance I couldn't make sense of the interactions.
> So I totally missed that.
>
> So you actually did 3 things at once. That makes a very hard
> to digest patch.

Ok, I will break out the x86_64 stuff and resend.

> >> Until I see a reasonable argument that none of the architectures
> >> currently supported by the linux kernel would need a multi order
> >> allocation for a kexec port am I interested in removing support.
> >
> > I argue that it is quite pointless to have code to support N-order
> > allocations that no one is using. Especially since the code is more
> > complex and it may be harder for the buddy allocator to fulfill
> > N-order allocations compared to 0-order allocations.
>
> The complexity as your patch shows is currently is 2 for loops.
> Refactoring the entire code base to save 2 for loops when
> using N-order allocations are totally voluntary is over kill.
>
> Most of the complexity in the code actually comes from having
> to use 0-order allocations.

I'm not saying that the kexec code itself should be made simpler, I
just think it is bad to keep unused code left in the source tree. And
regarding the complexity from 0-order allocations - yes - it becomes
more complex to handle single pages but that's what you have to pay
for to avoid fragmentation, right?

My argument against keeping support for N-order allocations is that
someone might feel that it is a good solution to allocate contiguous
pages to workaround something (like x86_64 does) instead of only using
N-order allocations for situations where physically contiguous pages
really are required by hardware.

Non-0-order allocations should be avoided as much as possible IMO.
This is somewhat related to the 4K vs 8K stack discussion, but a much
less frequent allocation problem of course.

> > And on top of the reasons above I'd like to stay away from N-order
> > allocations because Xen doesn't guarantee that (pseudo-)physical pages
> > handled out by the buddy allocator are contiguous.
>
> Yes. Xen doesn't have enough sense to use 4MB pages so kernels can
> execute efficiently.  That may be overly harsh.  But given the
> efficiency that you can get from using large pages in the kernel
> not guaranteeing large page allocations seems quite foolish.

Many things can be said about Xen. Maybe they use the keep-it-simple
strategy to begin with. I'm quite sure it will be handled (or at least
will be put on a road map) if it significantly improves performance.

> >> As I recall the alpha had an architectural need for a 32KB
> >> allocation or something like that.
> >
> > Oh. So if someone is working on kexec for alpha I guess we need
> > N-order allocations, right?
>
> To be clear.  Until some one shows me that on no architecture
> that the linux kernel supports there are no data structures
> that the cpus use directly that exceed 1 page there is the potential
> to need > 0 order allocations.
>
> My investigation into the basic problem says the are occasions
> when order-N allocations are needed.

I'm absolutely sure you are right about that. But keeping unused code
in kernel is another question IMO.

> I am overjoyed that currently there are multiple architectures
> supported by kexec but the porting work has yet to slow
> down as your Xen work shows.
>
> kexec currently does not have the volume of development and the number
> of people who understand it to handle being refactored very often.
> For preparation phase we are likely ok.  For later when it gets into
> very tricky arch specific assembly things are much worse.  Unless the
> basic skeleton gets it the way please use what is provided has been
> debugged.

Ok, I will avoid modifying the generic framework then.

Thanks for the detailed explanation.

/ magnus
