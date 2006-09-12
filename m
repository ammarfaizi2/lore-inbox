Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWILGEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWILGEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWILGEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:04:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:12520 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751273AbWILGEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:04:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=twmDDY7UK1eQ9im1A7Cn/Yyr/xpu4PiFS5i8rcLJOiY4XhW57VXf/v/pIBQZTu/xG1zmPKipFe2yRJpCFBuImBdu5ETGZLFMmWBU3q7jrJqSx13eKhKhSQqUlQ8QJevOrtH/fLyOKPAYd/xNL4IbJCPAQrGfwTU+AyI2SSrOKs4=
Message-ID: <787b0d920609112304x3342e3bek88a8e12da62adac4@mail.gmail.com>
Date: Tue, 12 Sep 2006 02:04:30 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Cc: jbarnes@virtuousgeek.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <1158039004.15465.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
	 <1158039004.15465.62.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > Oh no, it's great for regular device driver work. I used this
> > type of system all the time on a different PowerPC OS.
> >
> > Suppose you need to set up a piece of hardware. Assume that the
> > hardware isn't across some nasty bridge. You do this:
> >
> > hw->x = 42;
> > hw->y = 19;
> > eieio();
> > hw->p = 11;
> > hw->q = 233;
> > hw->r = 87;
> > eieio()
> > hw->n = 101;
> > hw->m = 5;
> > eieio()
> >
> > In that ficticious example, I get 7 writes to the hardware device
> > with only 3 "eieio" operations. It's not hard at all. Sometimes
> > a "sync" is used instead, also explicitly.
>
> You can do that with my proposed __writel which is a simple store as
> writes to non-cacheable and guarded storage have to stay in order
> according to the PowerPC architecture. No need for __raw.

Oops, I forgot about store-store ordering being automatic.
Pretend I had some loads in my example.

A proper interface would be more explicit about what the
fence does, so that driver authors shouldn't need to know
this detail.

> > To get even more speed, you can mark memory as non-coherent.
>
> Ugh ? MMIO space is always marked non-coherent. You are not supposed to
> set the M bit if the I is set in the page tables. If you are talking
> about main memory, then it's a completely different discussion.

OK, a different discussion... though memory being used
for DMA seems rather related. You need to flush before
a DMA out, or invalidate before a DMA in.

> > Linux should probably do this:
> >
> > Plain stuff is like x86. If you want the performance of loose
> > ordering, ask for it when you get the mapping and use read/write
> > functions that have a "_" prefix. If you mix the "_" versions
> > with a plain x86-like mapping or the other way, the behavior you
> > get will be an arch-specific middle ground.
>
> No. I want precisely defined semantics in all cases.

So you say: never mix strict mappings with loose operations,
and never mix loose mappings with strict operations.

That is an excellent rule. I see no need to stop people from
actively trying to shoot their feet though. I'm certainly not
suggesting that people be mixing things.

For some CPUs, you want to be specifying things when you
set up the mapping. For other CPUs, the read/write code is
how this gets determined. So developers specify both.
