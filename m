Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUIASVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUIASVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUIASVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:21:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:28886 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267400AbUIASVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:21:03 -0400
Date: Wed, 1 Sep 2004 11:19:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040901111911.66e89189.akpm@osdl.org>
In-Reply-To: <20040901180352.GH642@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
	<20040827172337.638275c3.davem@davemloft.net>
	<20040827173641.5cfb79f6.akpm@osdl.org>
	<20040828010253.GA50329@muc.de>
	<20040827183940.33b38bc2.akpm@osdl.org>
	<16687.59671.869708.795999@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com>
	<20040827204241.25da512b.akpm@osdl.org>
	<Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
	<20040827223954.7d021aac.akpm@osdl.org>
	<20040901180352.GH642@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> On Fri, Aug 27, 2004 at 10:39:54PM -0700, Andrew Morton wrote:
> > And we need larger atomic types _anyway_ for page->_count.  An unprivileged
> > app can mmap the same page 4G times and can then munmap it once.  Do it on
> > purpose and it's a security hole.  Due it by accident and it's a crash.
> 
> Sure, but the same kind of app can also do this on 32-bit architectures.
> Assuming there's only 2.5GB of address space available per process,
> you'd need 1638 cooperating processes to do it.  OK, that's a lot but
> the lowest limit I can spy on a quick poll of multiuser boxes I have a
> login on is 3064.  Most are above 10,000 (poll sample includes Debian,
> RHAS and Fedora).

It requires 32GB's worth of pte's.

So yeah, it might be possible on a 64GB ia32 box.

> I think it would be better to check for overflow of the atomic_t (atomic_t
> is signed) in the mmap routines.  Then kill the process that caused the
> overflow.  OK, this is a local denial-of-service if someone does it to
> glibc, but at least the admin should be able to reboot the box.

The overflow can happen in any get_page(), anywhere.  If we wanted to check
for it in this manner I guess we could do

	if (page_count(page) > (unsigned)-1000)
		barf();

in the pagefault handler.

But I don't think it's a serious issue on 32-bit machines, and on 64 bit
machines the 64-bit counter kinda makes sense?

