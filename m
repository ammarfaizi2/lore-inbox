Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVF3Lpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVF3Lpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVF3Lpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:45:36 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57503 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262947AbVF3LpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:45:18 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] deinline sleep/delay functions
Date: Thu, 30 Jun 2005 14:44:51 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua> <200506301410.43524.vda@ilport.com.ua> <1120130573.3181.42.camel@laptopd505.fenrus.org>
In-Reply-To: <1120130573.3181.42.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506301444.51463.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 14:22, Arjan van de Ven wrote:
> 
> > An if(usec > 2000) { printk(..); dump_stack(); } will do.
> 
> that's runtime not compile time.
> The old situation was a compile time check which is far more powerful.

Ok I like compile checks too, it will stay.

But it won't help on accidental mdelay(some math) == mdelay(-1)
== mdelay(4 000 000 000), so we _also_ will have an if() inside
udelay(), ok?

On Thursday 30 June 2005 14:21, Russell King wrote:
> Yes.  udelay() has overflow issues - if you pass too large a number
> to udelay() you get a randomised delay because you've lost the top
> bits.

Thus [umn]delay may fail in unpredictable ways with non-const
parameter which is too big. And this is good exactly why?

I'm ok with making it fail, but _predictably_. With printk(),
trace, whatever.

> The maximum delay is dependent on the architecture implementation,
> and it depends on bogomips.  There is no one single value for it.
> Architectures have to decide this from the way that they do the
> math and the expected range of bogomips.

In example I posted these limitations are lifted. Granted these
limitations were not critical, but removing them can't do harm,
I guess?

> Please - leave asm-*/delay.h alone.

Let's see what udelay(const) will compile down to on ppc:

asm-ppc/delay.h
===============
extern unsigned long loops_per_jiffy;
extern void __delay(unsigned int loops);
...
#define __MAX_UDELAY    (226050910UL/HZ)        /* maximum udelay argument */
#define __MAX_NDELAY    (4294967295UL/HZ)       /* maximum ndelay argument */

extern __inline__ void __udelay(unsigned int x)
{
        unsigned int loops;

        __asm__("mulhwu %0,%1,%2" : "=r" (loops) :
                "r" (x), "r" (loops_per_jiffy * 226));
        __delay(loops);
}

extern __inline__ void __ndelay(unsigned int x)
{
        unsigned int loops;

        __asm__("mulhwu %0,%1,%2" : "=r" (loops) :
                "r" (x), "r" (loops_per_jiffy * 5));
        __delay(loops);
}

extern void __bad_udelay(void);         /* deliberately undefined */
extern void __bad_ndelay(void);         /* deliberately undefined */

#define udelay(n) (__builtin_constant_p(n)? \
        ((n) > __MAX_UDELAY? __bad_udelay(): __udelay((n) * (19 * HZ))) : \
        __udelay((n) * (19 * HZ)))

#define ndelay(n) (__builtin_constant_p(n)? \
        ((n) > __MAX_NDELAY? __bad_ndelay(): __ndelay((n) * HZ)) : \
        __ndelay((n) * HZ))

Thus:

	udelay(const) = loops_per_jiffy * 5; mulhwu thing; call to __delay()

While with proposed code:

	udelay(const) = call to udelay()

Which is smaller.
--
vda

