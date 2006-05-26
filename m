Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWEZKmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWEZKmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWEZKmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:42:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:15984 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751383AbWEZKmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:42:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OKn8Pi9swSFCfc2X8IFJS6PFbDHYaDrTEdDF20W6nYzOphilW2qfzuUqFFnun2K+IYwCWwbdTSwTlVhfuwDuNzg/uhPIU0HSdSlEpbId26KmT291JZUaVTSBpL6x921XU2SRojflZcV5QNGT0XMv18k/vcCw0jRMlOKR1mlkLbE=
Message-ID: <aec7e5c30605260342w2fde795fr8f4d8120c74e3687@mail.gmail.com>
Date: Fri, 26 May 2006 19:42:53 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060525152112.GA6791@in.ibm.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Thu, May 25, 2006 at 05:26:56PM +0900, Magnus Damm wrote:
> > So, to answer your question regarding two page table copies. You may be
> > right that it can be made work with just one page table, but I feel my
> > two table approach is nice because it will always work - regardless of
> > the memory map used.
>
> So you seem to be suggesting that code can be made to work (even with Xen)
> with single identity mapped page table as used currently but it would fail
> in certain circumstances (different memory map used). Can you please explain
> a little more how?

Sorry about the delay, your question needed some thinking.

I do not think that vanilla kexec x86_64 has any memory map related
problems, apart for the page table overwriting. And the page table
overwriting is not a bug that will make kdump fail, it just makes the
memory image less accurate. I do however think the accuracy is quite
important given that kdump mainly is used for memory image collection.

The main reason for using two sets of page tables is simplicity. The
page_table_a code for allocation and page table setup is more or less
identical for i386 and x86_64. The code was written to be generic, but
during the testing I realized that the architecture-specific header
files defined things differently so I needed to add some
architecture-specific macros as workarounds. It should be possible to
share the code in a common file.

Simon and I have tried to make the Xen port of kexec as simple as
possible. One design decision that I know Eric dislikes is the array
of pages for page_table_a. The reason behind this array is simplicity,
especially for our Xen port.

Our Xen port makes the dom0 kernel responsible for allocating pages.
These pages are then used by the hypervisor. Some of these pages are
page_table_a pages, and these pages are overwritten by the hypervisor
with mappings that fit the memory map used by Xen. If we would pass
the root pointer instead of an array of pages then the hypervisor
would have to be extended to include code to parse page tables,
extract pages and then fill in the new page table. That would be all
but simple.

Using a single page table with Xen would probably result in a more
complex solution - the hypervisor code must be able to parse both page
tables with both huge and normal pages. I feel that such a solution is
error prone and overly complex. Especially since we already have
something that works.

I must admit that I got a bit scared of all the different page table
modes that Xen can run in. If and how they can affect the memory map
is beyond me. So instead of thinking of _how_ the memory maps are
arranged under x86_64, i386, i386/pae using all config options I
thought it was better to write something generic.
That's how the page_table_a strategy came up. It came up as a way of
jumping to a physical address from any virtual address, regardless of
memory map.

> This might be a very stupid question given the fact I am blissfully unaware
> of all the details of Xen.

No worries. "blissfully unaware of all the details of xen"... you
lucky bastard! =)

Thank you for your comments!

/ magnus
