Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWIVNvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWIVNvg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWIVNvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:51:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51002 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932479AbWIVNvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:51:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ndtxqIpp9wNSLBdDgrbSenfQwSyPIPB3+Q+1ropRNGZpjkw0jNt/1S1CBITf06mnLU7oCP3uUUSjtVznVgWyl7Sh3onm3nyYfZpzOIzycuPcC1AqDtAZK0SCpGbsg4L/C6MzVWQHQfXariVghmLBuKTe0OW2ZzWuQyE1+deud90=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] delay: add generic udelay(), mdelay() and ssleep()
Date: Fri, 22 Sep 2006 15:46:37 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200609220955.35826.vda.linux@googlemail.com> <200609221000.33978.vda.linux@googlemail.com> <20060922093659.GA8609@flint.arm.linux.org.uk>
In-Reply-To: <20060922093659.GA8609@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221546.37492.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 September 2006 11:36, Russell King wrote:
> On Fri, Sep 22, 2006 at 10:00:33AM +0200, Denis Vlasenko wrote:
> > * __const_udelay for all arches is removed or renamed to
> > ? __const_delay (it did not do microsecond delays anyway)

> You never explained this properly - in fact I think your logic is
> reversed.

linux-2.6.18/arch/i386/lib/delay.c:

void __udelay(unsigned long usecs)
{
       __const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
}

__udelay(n) is meant to busy loop for N microseconds,
and it is easy to see from above code that
__udelay(n) == __const_udelay(n*0x10c7).
So __const_udelay(x) doesn not delay for x microseconds.
It's a bad name.


> Let me remind you of my reply (which afaics never got
> a response):

> On Wed, Aug 23, 2006 a 09:14:52AM +0100, Russell King wrote:
> > On Wed, Aug 23, 2006 at 07:50:24AM +0200, Denis Vlasenko wrote:
> > > On Tuesday 22 August 2006 18:55, Russell King wrote:
> > > > Please keep a "const" version in ARM.  Thanks.
> > >
> > > Are you talking about this hunk? Why do you want to keep it?
> > >
> > > I mean, without it udelay(n) will become slower by the time
> > > needed for one extra multiply. So we will have maybe
> > > udelay(n) ==> udelay(n+0.1).
> > 
> > Why do you think that?  With the constant version, the additional
> > unnecessary multiply is optimised away by the compiler (since
> > constant * constant = constant), so it's actually slightly faster,
> > not sligntly slower as you seem to think.
> > 
> > Since the multiply is pure overhead, it's better to get rid of it.


I did send a reply. Maybe the problem was that I removed
l-k from CC...

On Wednesday 23 August 2006 10:39, Denis Vlasenko wrote:
> > Why do you think that?  With the constant version, the additional
> > unnecessary multiply is optimised away by the compiler (since
> > constant * constant = constant), so it's actually slightly faster,
> > not sligntly slower as you seem to think.
> 
> We are not disagreeind. I said it wrong way. I meant
> "with this #define removed, udelay(n) will become slower...".
> 
> And I am saying that it is _100% okay_ for it to become slower:
> 
> > Since the multiply is pure overhead, it's better to get rid of it.
> 
> You do not need to optimize delay for speed. If you
> really want to, then you can do:
> 
> #define udelay(n) do {} while(0)
> 
> Makes sense? No it does not. That's what I'm trying to say.
> You WANT to pause for thousands of cycles. Why you are trying
> to shave off ~10 cycles at the very same time?
> 
> Hope it makes things clearer.

So, to reiterate, optimizing udelay(N) for speed makes no sense.
--
vda
