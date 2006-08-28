Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWH1RbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWH1RbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWH1RbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:31:07 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:47337 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750738AbWH1RbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:31:05 -0400
Date: Mon, 28 Aug 2006 13:30:59 -0400
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200 system
Message-ID: <20060828173059.GJ13641@csclub.uwaterloo.ca>
References: <20060825203047.GH13641@csclub.uwaterloo.ca> <1156540817.3007.270.camel@localhost.localdomain> <20060825210305.GL13639@csclub.uwaterloo.ca> <20060825212441.GC2246@martell.zuzino.mipt.ru> <20060825215724.GI13641@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825215724.GI13641@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 05:57:24PM -0400, Lennart Sorensen wrote:
> It would be 1/4 of the time given the code is this:
> 
> memcpy_toio(&ch->ch_neo_uart->txrxburst, ch->ch_wqueue + tail, s);
> 
> tail is the offset in the write queue in the jsm driver, which can be
> any offset whatsoever.  So sometimes it is 32bit aligned, but often it
> isn't.
> 
> The txrxburst of course is 32bit alligned.  Receiving works fine when
> copying from the alligned buffer in hardware to wherever in the receiver
> queue.
> 
> Of course given the __memcpy assembly seems to work fine unalligned on a
> pentium4, and probably most othe systems, what could make it not work
> correctly on a geode SC1200?
> 
> This is the chunk of assembly in use:
> 
> static __always_inline void * __memcpy(void * to, const void * from, size_t n)
> {
> int d0, d1, d2;
> __asm__ __volatile__(
>         "rep ; movsl\n\t"
>         "movl %4,%%ecx\n\t"
>         "andl $3,%%ecx\n\t"
> #if 1   /* want to pay 2 byte penalty for a chance to skip microcoded rep? */
>         "jz 1f\n\t"
> #endif
>         "rep ; movsb\n\t"
>         "1:"
>         : "=&c" (d0), "=&D" (d1), "=&S" (d2)
>         : "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
>         : "memory");
> return (to);
> }
> 
> I am affraid I don't know the rep instruction on x86, so it really
> doesn't make sense to me.
> 
> I suppose if nothing else works, I can do one byte at a time until the
> tail is 32bit alligned, and then do the rest of the transfer as a block
> and see if that makes it work, or whether it is broken no matter what
> the allignement of the buffer is.

I tried to do a check on the alignment, and only do the whole transfer
as a block with memcpy_toio if it was 32bit aligned.  It breaks the same
way no matter how it is aligned.  It really seems that somehow using
this __memcpy assembly block on the geode sc1200 doesn't work correctly.
Doing the call using a loop with d2=1 works fine, but anything bigger
seems broken.

--
Len Sorensen
