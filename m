Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267634AbUHWWr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUHWWr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUHWWpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:45:33 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:18697 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267671AbUHWWYv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:24:51 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@muc.de>
Subject: Re: Obvious one-liner - Use 3DNOW on MK8
Date: Tue, 24 Aug 2004 01:24:43 +0300
User-Agent: KMail/1.5.4
References: <2vOfA-7Vg-7@gated-at.bofh.it> <200408222146.34798.vda@port.imtp.ilyichevsk.odessa.ua> <20040823195842.GA7952@muc.de>
In-Reply-To: <20040823195842.GA7952@muc.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408240124.43828.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > However, 3dnow _copy_page_ is a huge win. I explained why in an
> > > > emails
> > >
> > > On K8? Significant resources were spent on tuning the x86-64
> >
> > Sorry Andi, I cannot test on K8, don't have the hw...
> >
> > > memcpy and memset, and since C stepping K8 rep ; movsl/q are fastest.
> > > Before that an unrolled integer loop was best.
> > >
> > > On 32bit the same applies.
> > >
> > > Using SSE2 only helps for very large data sets that are
> > > never used in the kernel (several MB). 3dnow wasn't tested, but it is
> > > unlikely to be any better than SSE2.
> >
> > I sent to lkml an email with subject "copy_page(): non-temporal
> > stores look useful?". It's possible you never received it.
> > I'll resend it now. I'd like to have your comments, if any.
>
> Hmm, interesting. You're relying on the fact that normally
> only a few cache lines are touched in a copied page.  Still

Where? I think my test programs touch every cacheline in
zeroed/copied pages!

> I would be pretty careful, because you're optimizing one case
> a lot over another and it may fail badly on some workloads
> that use more of the pages.
>
> Also your Duron with its extremly small cache probably skews
> results a bit.
>
> We did some test on K8 (although no big macro benchmarks)
> and it was usually a loss there.
>
> It's really designed for very big data buffers (many MBs).

I did separate zero_page() and copy_page() tests (see other mail).
I totally agree that zero_page() isn't a win.
However, copy_page() usage pattern are sufficiently different,
and this has interesting consequences:

> And the kernel never processes that much at one piece.

No it does, at least on current CPUs:

fork() touches 12k via three zero_page calls and 2x32k via
eight copy_page()s, 76k in total. This is more than L1 size for
any existing x86 processor. "Standard" zero/copy ops thus evict
entire L1 at each fork(). Not-temporal ops do not, they evict
only 32k. This helps by keeping useful data still in cache.

Also, these eight copied pages aren't 100% used by fork(),
and thus fork() do not suffer from needing to pull NT-stored
data back to cache and is actually faster with NT copy_page().

To summarize: we get fork() speedup due to faster copies
*and* speedup elsewhere because cache is not flushed.

I think that explains why I was unable to find any buffer size
so that
	buf=alloc(size);
	for(10000) {
		fork();
		if(child) { touch(buf); exit(); }
	}
is running faster with "standard" ops. Let me repeat test results here:

128k copying, 5x5000 loops:
slow: š š š š š š š 0m4.732 0m4.747 0m4.751 0m4.773 0m4.776 75466/1000469
mmx_APn: š š š š š š0m4.258 0m4.331 0m4.343 0m4.386 0m4.422 75406/1000422
mmx_APN: š š š š š š0m3.658 0m3.672 0m3.784 0m3.798 0m3.818 75452/1000436
mmx_APn/APN: š š š š0m3.713 0m3.713 0m3.840 0m3.850 0m3.857 75435/1000413
64k copying, 5x10000 loops:
slow: š š š š š š š 0m5.869 0m5.885 0m5.894 0m5.904 0m5.906 150356/1200472
mmx_APn: š š š š š š0m5.369 0m5.391 0m5.404 0m5.424 0m5.426 150345/1200444
mmx_APN: š š š š š š0m4.804 0m4.826 0m4.843 0m4.843 0m4.934 150355/1200436
mmx_APn/APN: š š š š0m4.878 0m4.883 0m4.926 0m4.937 0m4.962 150343/1200441
32k copying, 5x20000 loops:
slow: š š š š š š š 0m8.088 0m8.125 0m8.241 0m8.245 0m8.326 300320/1600461
mmx_APn: š š š š š š0m7.527 0m7.662 0m7.706 0m7.750 0m7.802 300303/1600438
mmx_APN: š š š š š š0m6.630 0m6.661 0m6.681 0m6.696 0m6.735 300303/1600442
20k copying, 5x20000 loops:
slow: š š š š š š š 0m6.610 0m6.665 0m6.694 0m6.750 0m6.774 300315/1300468
mmx_APn: š š š š š š0m6.208 0m6.218 0m6.263 0m6.335 0m6.452 300352/1300448
mmx_APN: š š š š š š0m4.887 0m4.984 0m5.021 0m5.052 0m5.057 300295/1300443
mmx_APn/APN: š š š š0m5.115 0m5.160 0m5.167 0m5.172 0m5.183 300292/1300443
4k copying, 5x40000 loops:
slow: š š š š š š š 0m8.303 0m8.334 0m8.354 0m8.510 0m8.572 600313/1800473
mmx_APn: š š š š š š0m8.233 0m8.350 0m8.406 0m8.407 0m8.642 600323/1800467
mmx_APN: š š š š š š0m6.475 0m6.501 0m6.510 0m6.534 0m6.783 600302/1800436
mmx_APn/APN: š š š š0m6.540 0m6.551 0m6.603 0m6.640 0m6.708 600271/1800442

See? NT wins everywhere.

My main questions are:

* Is there any copy_page() benchmarks which do not
  use fork()?
* Maybe we simply should use "standard" zero_page()
  and "non-temporal" copy_page()?

> In general using write combining is a bit fragile from
> the performance perspective. There is a reason why AMD
> and Intel add more write combining buffers with each major
> CPU revision.  So if it's not an extremly clear win
> I would avoid it.

Speedups of 50% or more are a bit large to dismiss lightly.

I think we can benchmark and pick best at boot time.
--
vda

