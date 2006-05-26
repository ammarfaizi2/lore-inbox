Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWEZPIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWEZPIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWEZPIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:08:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48309 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750870AbWEZPIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:08:37 -0400
Date: Fri, 26 May 2006 11:08:22 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Message-ID: <20060526150822.GA30069@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060524044232.14219.68240.sendpatchset@cherry.local> <20060524044247.14219.13579.sendpatchset@cherry.local> <m1slmystqa.fsf@ebiederm.dsl.xmission.com> <1148545616.5793.180.camel@localhost> <20060525152112.GA6791@in.ibm.com> <aec7e5c30605260342w2fde795fr8f4d8120c74e3687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30605260342w2fde795fr8f4d8120c74e3687@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 07:42:53PM +0900, Magnus Damm wrote:
> On 5/26/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >On Thu, May 25, 2006 at 05:26:56PM +0900, Magnus Damm wrote:
> >> So, to answer your question regarding two page table copies. You may be
> >> right that it can be made work with just one page table, but I feel my
> >> two table approach is nice because it will always work - regardless of
> >> the memory map used.
> >
> >So you seem to be suggesting that code can be made to work (even with Xen)
> >with single identity mapped page table as used currently but it would fail
> >in certain circumstances (different memory map used). Can you please 
> >explain
> >a little more how?
> 
> Sorry about the delay, your question needed some thinking.
> 
> I do not think that vanilla kexec x86_64 has any memory map related
> problems, apart for the page table overwriting.

So we are trying to solve two problems here.

- Page table overwriting during kexec.
- Creating framework in advance to ensure kexec compatibility with Xen.

Definitely first one need to be solved now. But given the fact Xen code
is not mainline yet, I feel that second one should be solved once
Xen code is mainline. 

> And the page table
> overwriting is not a bug that will make kdump fail, it just makes the
> memory image less accurate. I do however think the accuracy is quite
> important given that kdump mainly is used for memory image collection.
> 
> The main reason for using two sets of page tables is simplicity. The
> page_table_a code for allocation and page table setup is more or less
> identical for i386 and x86_64. The code was written to be generic, but
> during the testing I realized that the architecture-specific header
> files defined things differently so I needed to add some
> architecture-specific macros as workarounds. It should be possible to
> share the code in a common file.
> 
> Simon and I have tried to make the Xen port of kexec as simple as
> possible. One design decision that I know Eric dislikes is the array
> of pages for page_table_a. The reason behind this array is simplicity,
> especially for our Xen port.
> 
> Our Xen port makes the dom0 kernel responsible for allocating pages.
> These pages are then used by the hypervisor. Some of these pages are
> page_table_a pages, and these pages are overwritten by the hypervisor
> with mappings that fit the memory map used by Xen. If we would pass
> the root pointer instead of an array of pages then the hypervisor
> would have to be extended to include code to parse page tables,
> extract pages and then fill in the new page table. That would be all
> but simple.
> 

Again I am trying to understand the need for two page tables. So your
concern is that if current user space/kernel space memory split changes
in x86_64, it will break down the kexec and that's why the need of a
page_table_a which will help jump to identity mapped address in control
page and then you will switch to page_table_b which will help copying the
pages to destination.

Can't we create an additional entry in identity mapped page table
(page_table_b) to map the control page at the same virtual address
as current page table and then jump to control page (using virtual address)
and then swith to identity mapped page table (page_table_b).

This would make sure that existing page tables are not overwritten as
well there is no dependency on user space/kernel space memory split being
used by the current page tables.

I hope I understood the problem right. :-)

Thanks
Vivek
