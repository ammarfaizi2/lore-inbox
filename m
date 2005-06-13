Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVFMGyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVFMGyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVFMGyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:54:04 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18924 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261390AbVFMGxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:53:45 -0400
Message-ID: <42AD2DA4.1070309@jp.fujitsu.com>
Date: Mon, 13 Jun 2005 15:54:28 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 07/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>	<42A83CF2.90304@jp.fujitsu.com>	<17064.32552.507932.62892@napali.hpl.hp.com>	<42A96BA6.1070300@jp.fujitsu.com> <17065.52506.707169.903319@napali.hpl.hp.com>
In-Reply-To: <17065.52506.707169.903319@napali.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Fri, 10 Jun 2005 19:29:58 +0900, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> said:
> 
>   Hidetoshi> +#define ia64_poison_check(val)					\
>   Hidetoshi> +{	register unsigned long gr8 asm("r8");			\
>   Hidetoshi> +	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val)); }
> 
>   >> I have only looked that this briefly and I didn't see off hand where you get
>   >> the "r9=[r10]" sequence from --- I hope you're not relying on the compiler
>   >> happening to generate this sequence!
> 
>   Hidetoshi> +static inline unsigned char
>   Hidetoshi> +___ia64_readb (const volatile void __iomem *addr)
>   Hidetoshi> +{
>   Hidetoshi> +    unsigned char val;
>   Hidetoshi> +
>   Hidetoshi> +    val = *(volatile unsigned char __force *)addr;
>   Hidetoshi> +    ia64_poison_check(val);
>   Hidetoshi> +
>   Hidetoshi> +    return val;
>   Hidetoshi> +}
> 
> Ah, I see now what you're trying to do.  I think it's really a
> machine-check barrier that you want there.

Yes, thanks for your understanding.

> I'm doubtful whether this is the right approach, though: your
> ia64_poison_check() will cause _every single_ readX() operation to
> stall the CPU for 1,000+ cycles.  Why not define an explicit
> iochk_barrier() instead?  Then you could do things like this:
> 
> 	a = readb(X);
> 	b = readb(Y);
> 	c = readb(Z);
> 	iochk_barrier(a + b + c);
> 
> That is, if it's unimportant to know whether the read of X, Y, or Z
> caused the MCA, you can amortize the cost of iochk_barrier() over 3
> reads.

I'm also doubtful, I know it too costs... but I don't have any other
better idea. As far as I can figure out, using iochk_barrier() style
has difficulty like that:
  - pain for driver maintainers.
    They should be careful to make exact argument for barrier.
  - arch-specific.
    It will go against the spirit of iochk, "generic" interface.
  - unenforceable.
    You could forget it.
  - it would be in form:
    {
       iocookie cookie;
       iochk_clear(cookie, dev);
       for(i=0;i<count;i++)
	 buf++ = readb(addr);
       iochk_barrier(***);
       iochk_read(cookie);
    }
    so it seems that iochk_barrier() is kind of something that should be
    include in iochk_read(), but it would be a difficult hack.

In case of ppc64, their eeh_readX() already have nervous error check,
by comparing its result to -1 in every single operation. In fact,
I didn't mind the cost so seriously because there is a precedent.

However, I think such cycle-saving would be possible in "string version",
such as ioreadX_rep(). I'd like to postpone it as a future optimization.

> I'd probably make iochk_barrier() an out-of-line no-op assembly
> routine.  The cost of two branches compared to stalling for hundreds
> of cycles is rather trivial.

Of course I agree to have such routine in proper header file, but it
would not help us to save CPU cycles if we don't have any other idea...
Or I'll just replace ia64_poison_check() to ia64_mca_barrier() or so.

Thanks,
H.Seto

