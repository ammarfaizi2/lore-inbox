Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWHYV50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWHYV50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWHYV50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:57:26 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:11426 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751525AbWHYV5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:57:25 -0400
Date: Fri, 25 Aug 2006 17:57:24 -0400
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200 system
Message-ID: <20060825215724.GI13641@csclub.uwaterloo.ca>
References: <20060825203047.GH13641@csclub.uwaterloo.ca> <1156540817.3007.270.camel@localhost.localdomain> <20060825210305.GL13639@csclub.uwaterloo.ca> <20060825212441.GC2246@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825212441.GC2246@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 01:24:41AM +0400, Alexey Dobriyan wrote:
> But you can check. Insert something like this in right place:
> 
> 	printk("%p\n", buffer);

It would be 1/4 of the time given the code is this:

memcpy_toio(&ch->ch_neo_uart->txrxburst, ch->ch_wqueue + tail, s);

tail is the offset in the write queue in the jsm driver, which can be
any offset whatsoever.  So sometimes it is 32bit aligned, but often it
isn't.

The txrxburst of course is 32bit alligned.  Receiving works fine when
copying from the alligned buffer in hardware to wherever in the receiver
queue.

Of course given the __memcpy assembly seems to work fine unalligned on a
pentium4, and probably most othe systems, what could make it not work
correctly on a geode SC1200?

This is the chunk of assembly in use:

static __always_inline void * __memcpy(void * to, const void * from, size_t n)
{
int d0, d1, d2;
__asm__ __volatile__(
        "rep ; movsl\n\t"
        "movl %4,%%ecx\n\t"
        "andl $3,%%ecx\n\t"
#if 1   /* want to pay 2 byte penalty for a chance to skip microcoded rep? */
        "jz 1f\n\t"
#endif
        "rep ; movsb\n\t"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
        : "memory");
return (to);
}

I am affraid I don't know the rep instruction on x86, so it really
doesn't make sense to me.

I suppose if nothing else works, I can do one byte at a time until the
tail is 32bit alligned, and then do the rest of the transfer as a block
and see if that makes it work, or whether it is broken no matter what
the allignement of the buffer is.

--
Len Sorensen
