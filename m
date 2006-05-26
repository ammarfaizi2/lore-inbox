Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWEZCXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWEZCXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 22:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWEZCXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 22:23:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:38642 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030218AbWEZCXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 22:23:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fyh/ZyKv0d0KkCgTvQgyPt9HPkEXQRWlbOk4p/Rcu5XS/kC1cskjiV3Rnhols5pj72EeyRo5HcEMNVv+Ec8nIpS4IkFBcYwXpYV+fUpX2zFj32BxnLR4M/CoxyztHo8ryV/R85EBs8ED2M+JCoHSW16kFLLpXEWr/WoemZG1wZk=
Message-ID: <aec7e5c30605251923y327f3b03g86939071e5e59106@mail.gmail.com>
Date: Fri, 26 May 2006 11:23:22 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH 01/03] kexec: Avoid overwriting the current pgd (V2, stubs)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m1u07edptu.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044237.14219.15615.sendpatchset@cherry.local>
	 <m1wtcasu5b.fsf@ebiederm.dsl.xmission.com>
	 <1148528742.5793.135.camel@localhost>
	 <m1bqtmsosw.fsf@ebiederm.dsl.xmission.com>
	 <aec7e5c30605250011y35f295a0rf15e152910e98b94@mail.gmail.com>
	 <m1u07edptu.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Eric,

Thank you for your comments so far.

On 5/26/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
>
> > On 5/25/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Magnus Damm <magnus@valinux.co.jp> writes:
> >> > On Wed, 2006-05-24 at 20:41 -0600, Eric W. Biederman wrote:
> >> >> Magnus Damm <magnus@valinux.co.jp> writes:
> >>
> >> I believe I gave a complete explanation the first round.
> >>
> >> By having an extra extern variable you can export the offset of
> >> a variable on the control code page, or what you need to compute
> >> the offset.
> >
> > You explained some things last round, but there were still some
> > questions left open. The main question was regarding "additional
> > protection".
>
> Memory that the kernel never sets up for DMA ever.

I had hoped that I would get a more detailed answer. I asked you the
following follow-up questions during the first round:

---

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

---

I'm trying to understand your argument, but it does not make sense to me.

If you are worried that struct kimage will get overwritten by
background DMA, then why the are you storing the pointer to the
control page there? That pointer is _very_ important...

And if your DMA issue it is that important, why do you not allocate
struct kimage from kimage_alloc_control_pages()?

> > I'd be happy to change to code into something that you would feel
> > comfortable with, I just like to understand why. Having a
> > per-architecture data area in struct kimage is by far the simplest way
> > IMO.
>
> But the problem is fundamentally hard.  I do not want to encourage
> people to make changes without thinking through all of the consequences.

That makes sense.

> So far my impression is that an additional per-architecture data area
> is struct kimage encourages people to be sloppy, and it moves key structures
> farther from where they are used.  I am coming to suspect it is as bad
> as ioctl.

I see it from the other side. By _not_ having per-architecture data
the current kexec code for x86_64 unnecessarily allocates 2 physically
contiguous pages (1-order allocation).

> I could probably be convinced with a good use of a per-architecture
> area and a well reasoned argument.  But at the moment changing the
> infrastructure is unnecessary noise, so please drop that for now.

But then I would have to make the code overly complex and duplicate
code that overloads the control page with a structure - both for i386
and x86_64. By adding a per-architecture data structure the amount of
code duplication is reduced IMO.

> >> Part of the reason is you do more than one thing at a time, which makes
> >> review much more difficult than it needs to be.
> >
> > Yeah, I know. I'm sorry about that. I took some time to split the
> > patches in the most logical way I could think of. The reason behind
> > not separating the segment code and the page_table_a code was that
> > they both touched more or less the same lines.
>
> Dependent patches are not a problem.

Good. I'm sorry that the patches are unreadable, they tend to get that
when one is modifying major parts of a file. I'd recommend that
instead of reading the patch directly it may be better to apply it and
read the resulting code.

> > And by global structure you mean the dynamically allocated struct
> > kimage? If you find that abusive then I think that _not_ using an
> > already existing structure is abusive. =)
> >
> > I just want to keep things as simple as possible.
>
> Simplicity is good.
>
> Doing unnecessary things is confusing and the issue is not good,
> and at least until the Xen support is merged you were doing
> unnecessary things.

Yes and no. I agree that modifying kernel code to fit code outside of
the tree is a bad thing, but I think my modification alone has value
for the kernel.

I think we both can agree on that overwriting the current page tables
should be avoided regardless of Xen. It's just a matter of where we
store data and if we are using one or two page tables.

> Please just take it carefully.  This is possibly the hardest
> to debug code path in the kernel and currently it works.  I
> don't want to break that.

I don't want to break it either, so careful is good. I think kexec
works pretty well, but I would not say it's working correctly in all
cases.

One issue on i386 with the current page table overwriting code is that
it may break with different kernel/userspace splits. I think my
"page_table_a" approach should work for all cases.

Also, I cannot get one x86_64 box here to work with kexec. It does not
work with the vanilla kexec, and not with my page_table_a patch. The
troublesome machine has a cpu reported as "AMD Athlon(tm) 64 Processor
3200+". The same code does however run on hardware with dual "AMD
Opteron(tm) Processor 244".

I'd like to work on solving these issues too, but I'd like to sort out
merging my current patches before starting on something new.

Thanks,

/ magnus
