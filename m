Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWEZPw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWEZPw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWEZPw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:52:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:48825 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750931AbWEZPw0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:52:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kQGck0wM3SuFnK1Fzb6zKeQoQIRvxY13cLTBuoxiKNwEy4DBtixic0qsk86Nr3Ey9itf9f4ZFxt2lP70tmHqRshXJDwrtu1I1sNxMVqsAG5wQmh9SV9+fUJWoWioyjegmdBtsUSK6LmxuV8mPSY/7sphTM5uckiK5TNTDpjxYUA=
Message-ID: <aec7e5c30605260852g28699603qcaf02da08bea1fc5@mail.gmail.com>
Date: Sat, 27 May 2006 00:52:24 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060526150822.GA30069@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044247.14219.13579.sendpatchset@cherry.local>
	 <m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	 <1148545616.5793.180.camel@localhost>
	 <20060525152112.GA6791@in.ibm.com>
	 <aec7e5c30605260342w2fde795fr8f4d8120c74e3687@mail.gmail.com>
	 <20060526150822.GA30069@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Fri, May 26, 2006 at 07:42:53PM +0900, Magnus Damm wrote:
> > On 5/26/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > >On Thu, May 25, 2006 at 05:26:56PM +0900, Magnus Damm wrote:
> > >> So, to answer your question regarding two page table copies. You may be
> > >> right that it can be made work with just one page table, but I feel my
> > >> two table approach is nice because it will always work - regardless of
> > >> the memory map used.
> > >
> > >So you seem to be suggesting that code can be made to work (even with Xen)
> > >with single identity mapped page table as used currently but it would fail
> > >in certain circumstances (different memory map used). Can you please
> > >explain
> > >a little more how?
> >
> > Sorry about the delay, your question needed some thinking.
> >
> > I do not think that vanilla kexec x86_64 has any memory map related
> > problems, apart for the page table overwriting.
>
> So we are trying to solve two problems here.
>
> - Page table overwriting during kexec.
> - Creating framework in advance to ensure kexec compatibility with Xen.

Correct. I'm actually supposed to only work on porting kexec to Linux
under Xen, but the page table overwriting issue annoyed me so I
thought that I would try to solve both problems at once.

> Definitely first one need to be solved now. But given the fact Xen code
> is not mainline yet, I feel that second one should be solved once
> Xen code is mainline.

That makes sense. My goal here is trying to write Xen-friendly code
which does not give too much penalty when used without Xen and will
not generate too much many conflicts when merging with Xen.

> > And the page table
> > overwriting is not a bug that will make kdump fail, it just makes the
> > memory image less accurate. I do however think the accuracy is quite
> > important given that kdump mainly is used for memory image collection.
> >
> > The main reason for using two sets of page tables is simplicity. The
> > page_table_a code for allocation and page table setup is more or less
> > identical for i386 and x86_64. The code was written to be generic, but
> > during the testing I realized that the architecture-specific header
> > files defined things differently so I needed to add some
> > architecture-specific macros as workarounds. It should be possible to
> > share the code in a common file.
> >
> > Simon and I have tried to make the Xen port of kexec as simple as
> > possible. One design decision that I know Eric dislikes is the array
> > of pages for page_table_a. The reason behind this array is simplicity,
> > especially for our Xen port.
> >
> > Our Xen port makes the dom0 kernel responsible for allocating pages.
> > These pages are then used by the hypervisor. Some of these pages are
> > page_table_a pages, and these pages are overwritten by the hypervisor
> > with mappings that fit the memory map used by Xen. If we would pass
> > the root pointer instead of an array of pages then the hypervisor
> > would have to be extended to include code to parse page tables,
> > extract pages and then fill in the new page table. That would be all
> > but simple.
> >
>
> Again I am trying to understand the need for two page tables. So your
> concern is that if current user space/kernel space memory split changes
> in x86_64, it will break down the kexec and that's why the need of a
> page_table_a which will help jump to identity mapped address in control
> page and then you will switch to page_table_b which will help copying the
> pages to destination.

If we omit the Xen case I'm pretty sure it can be done with just one
page table. No concerns about memory split on x86_64.

I don't see the problem with two page tables though. The two page
table approach makes the x86_64 port very similar to i386 and it makes
it possible to share code. And on top of that it will make the Xen
porting work much much simpler.

> Can't we create an additional entry in identity mapped page table
> (page_table_b) to map the control page at the same virtual address
> as current page table and then jump to control page (using virtual address)
> and then swith to identity mapped page table (page_table_b).
>
> This would make sure that existing page tables are not overwritten as
> well there is no dependency on user space/kernel space memory split being
> used by the current page tables.
>
> I hope I understood the problem right. :-)

Your reasoning seems right to me. =)
An additional entry in page_table_b will most likely do.

But, I think that the mix of large size and 4k pages (page_table_b is
mapped with large pages, and page_table_a with 4k) might introduce
some corner cases. I'm thinking about the case when the virtual
address for the control page (the only 4k mapping) happens to be in
the identity mapping range. In that case you will have to break up the
large page mapping and add several 4k mappings. Breaking up the large
page will require more pages to be allocated for the page table.

And if we build the Xen port on top of that (without an array of
pages) we will have to parse that mess in the hypervisor. And Xen
might have a different memory map which leads to a page table that has
a different virtual address for the 4k mapping. And this might
introduce a need to allocate extra pages from within the hypervisor,
which is something I definitely want to avoid.

To summarize, the single page table solution will work for most cases,
but it might be complicated if we happen to have the control page
mapped at a low address in the kernel/hypervisor. Mapping the page at
a low address forces us to allocate more pages for the page table. In
other words, the number of pages required to build the page table
varies depending on the virtual address where the control page is
mapped in the kernel/hypervisor.

The problematic case above might be very unlikely to happen with the
current x86_64 memory map, but I still think that the two page table
solution is a small price to pay for something that is guaranteed to
work in all cases.

Thank you for your comments!

/ magnus
